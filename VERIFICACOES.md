# Verificações reais — 18/11/2026

**Situação atual:** v1.0.0 publicada. Análise, dez testes e build Android aprovados no GitHub Actions, com o APK anexado à Release. A instalação manual desse APK em Android ainda está pendente. Os registros seguintes preservam o diagnóstico inicial e as correções, seguidos da confirmação final da publicação.

## Registro inicial no ambiente restrito

Ambiente: Windows, Flutter 3.44.9, Dart 3.12.2 e Java 21. Foi usada uma cópia do SDK em pasta temporária gravável, com dependências recuperadas do cache local; a instalação original não foi alterada. Os comandos abaixo foram executados no projeto.

| Verificação | Resultado observado |
| --- | --- |
| `flutter pub get --offline` | Dependências resolvidas; saída `Got dependencies!`. As versões e hashes do lockfile foram preservados. |
| `dart format lib test tool` | 23 arquivos verificados, zero alterações necessárias. |
| `flutter analyze --no-pub` | **Aprovado: No issues found!**, código de saída 0, após corrigir cinco avisos do script auxiliar. |
| `dart tool/check_domain.dart` | **Aprovado**, saída 0. Apoio único, bloqueio fora de votação, independência entre sessões, limites de validação, busca sem acentos e dados iniciais. |
| `flutter test --no-pub --reporter expanded` | **Bloqueado/falhou antes de carregar os testes.** As três suítes não carregaram; zero testes foram executados. O `flutter_tester` não conseguiu conectar a `127.0.0.1`, SocketException/erro Windows 10057. Não há aprovação da suíte Flutter. |
| `flutter build apk --release --no-pub` | **Falhou:** `Could not connect to the Gradle daemon`. O daemon chegou a iniciar, mas a comunicação local não funcionou. Não foi produzido APK confirmado. |
| Android/emulador | `adb devices` não conseguiu iniciar/conectar ao servidor ADB. A lista de AVDs contém `Medium_Phone` e `Pixel_8`, mas nenhuma execução do aplicativo em Android foi confirmada. |
| Workflow | YAML interpretado com sucesso e dependência `release -> build` conferida. Isso verifica estrutura, não execução no GitHub. |
| `tool/publicar.ps1` | Sintaxe validada pelo parser PowerShell. A execução depende do acesso à API do GitHub; a publicação não foi confirmada. |
| Git | `git diff --check` sem problemas. Histórico incremental local preservado, sem reescrita ou trailers de coautoria de IA. |
| Autenticação/rede | A conta `gcorrea4` está registrada no GitHub CLI, mas `gh api user` falhou com `error connecting to api.github.com`. O comando `gh auth status` reportou token inválido enquanto essa conexão estava indisponível; isso não comprova, isoladamente, que o login feito pelo usuário esteja incorreto. |

Os testes criados cobrem domínio, boas-vindas, navegação, busca de serviço, detalhes, voto e prevenção de repetição, formulário inválido/válido, cadastro, acompanhamento e boas-vindas em tela pequena com texto ampliado. Sua existência não significa que passaram: falta executá-los em um ambiente que permita a comunicação local exigida pelo Flutter.

## Como concluir fora deste ambiente restrito

Em um terminal próprio, na pasta do projeto:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

Depois de todos passarem, testar em Android e usar `tool/publicar.ps1` para publicar. O script também exige que o CI remoto passe antes de enviar a tag e criar a Release. Não é necessário transmitir tokens ao ChatGPT.

Se `gh api user` também falhar no seu próprio terminal, confira conexão, proxy ou firewall; se o GitHub responder com erro de autenticação, refaça `gh auth login`. O bloqueio observado aqui foi de conexão. Não foram criados repositório, push, tag ou Release confirmados.

O grupo ainda precisa preencher os dados de identificação, gravar o vídeo narrado em Android, publicar no YouTube como não listado, adicionar o professor e enviar o TXT no Portal FIAP. Consulte o README e o roteiro.

## Atualização após execução no terminal do usuário

O usuário confirmou a abertura do aplicativo em emulador Android por captura de tela. O GitHub público foi criado e o push da `main` foi concluído. Isso atualiza as limitações observadas no ambiente restrito descritas acima; não comprova todos os fluxos manuais nem a compilação do APK release.

O workflow `44238330370` foi consultado diretamente no GitHub: instalação, formatação e análise passaram; sete testes passaram e três falharam. O build de APK não chegou a executar. As falhas foram:

- O helper `pageBack()` buscou o botão por uma identificação incompatível com a interface localizada. O teste agora toca no widget `BackButton` da tela.
- O teste de votação tocou em “Ver detalhes” antes de renderizar o novo posicionamento após a rolagem. Foi adicionado um helper que centraliza o alvo e aguarda `pumpAndSettle()` antes de tocar. Toques que não atingirem o alvo agora falham imediatamente nos testes de fluxo.
- A marca na tela de boas-vindas excedeu a largura em 320 pixels com fonte ampliada. O texto da marca agora ocupa um `Expanded`, permitindo quebra dentro da largura disponível sem reduzir a escala de acessibilidade.

Depois desses ajustes, a formatação passou e `flutter analyze --no-pub` voltou a concluir com `No issues found!`. Naquele momento, a suíte corrigida ainda dependia de confirmação no CI, pois a comunicação local de `flutter test` permaneceu restrita neste ambiente. Nenhum teste foi removido ou ignorado e o requisito de sucesso antes da Release foi preservado.

## Confirmação da versão publicada

O script executado no terminal do usuário confirmou o workflow `44239530452` aprovado para a tag `v1.0.0`. Os jobs e logs dessa execução foram consultados diretamente no GitHub e confirmaram:

| Etapa | Evidência |
| --- | --- |
| Dependências, formatação e análise | Etapas concluídas com `success` |
| Testes | `00:03 +10: All tests passed!` |
| Compilação release | `Built build/app/outputs/flutter-apk/app-release.apk (49.9MB)` |
| Artifact | `vozcidada-apk` disponibilizado com sucesso |
| Publicação | Job `Publicar APK da versão` concluído com `success`, com o APK anexado à Release |

- Código da versão: commit `34ef6e3`, tag `v1.0.0`.
- Workflow aprovado: https://github.com/gcorrea4/vozcidadao-flutter/actions/runs/44239530452
- Release: https://github.com/gcorrea4/vozcidadao-flutter/releases/tag/v1.0.0
- APK: https://github.com/gcorrea4/vozcidadao-flutter/releases/download/v1.0.0/vozcidada.apk

A abertura do aplicativo durante o desenvolvimento foi demonstrada pelo usuário no emulador Android. Isso não substitui baixar, instalar e conferir o APK da Release. Permanecem pendentes essa conferência manual, identificação dos integrantes, vídeo narrado, acesso do professor e envio pelo Portal FIAP.
