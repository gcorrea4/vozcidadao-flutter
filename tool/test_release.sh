#!/usr/bin/env bash
set -euo pipefail

mkdir -p evidence
adb install -r downloaded/vozcidada.apk | tee evidence/instalacao.txt
adb shell dumpsys package br.com.fiap.vozcidadao > evidence/pacote-instalado.txt
adb logcat -c

# O emulador permanece sem Wi-Fi e sem dados durante todos os fluxos.
adb shell svc wifi disable
adb shell svc data disable
adb shell dumpsys connectivity > evidence/rede-do-emulador.txt

finish() {
  local result=$?
  adb logcat -d > evidence/logcat.txt || true
  adb exec-out screencap -p > evidence/tela-final.png || true
  if [ "$result" -ne 0 ]; then
    timeout 20s adb shell uiautomator dump /sdcard/vozcidada-ui.xml || true
    adb pull /sdcard/vozcidada-ui.xml evidence/hierarquia.xml || true
    python3 - <<'PY' || true
from pathlib import Path
import xml.etree.ElementTree as ET
p = Path('evidence/hierarquia.xml')
if p.exists():
    print('--- Elementos visiveis no Android apos a falha ---')
    for node in ET.fromstring(p.read_text()).iter('node'):
        a = node.attrib
        values = {k: a[k] for k in ['text', 'content-desc', 'bounds', 'enabled'] if a.get(k)}
        if a.get('text') or a.get('content-desc'):
            print(values)
PY
  fi
  return "$result"
}
trap finish EXIT

maestro --version | tee evidence/maestro-version.txt
maestro test --test-output-dir evidence --format junit --output evidence/results.xml .maestro/release.yaml
