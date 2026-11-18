# Verificações reais — 18/11/2026

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
