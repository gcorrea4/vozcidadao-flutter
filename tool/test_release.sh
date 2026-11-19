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
  adb logcat -d > evidence/logcat.txt || true
  adb exec-out screencap -p > evidence/tela-final.png || true
}
trap finish EXIT

maestro --version | tee evidence/maestro-version.txt
maestro test --test-output-dir evidence --format junit --output evidence/results.xml .maestro/release.yaml
