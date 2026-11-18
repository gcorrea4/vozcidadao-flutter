# VozCidadã

Aplicativo Flutter de serviços, direitos e participação comunitária para a **Global Solution FIAP 2026/2 — CitizenTech**.

Moradores de comunidades urbanas enfrentam dificuldade para localizar informações sobre serviços públicos e acompanhar demandas do bairro. O VozCidadã reúne orientações demonstrativas e um espaço para propor melhorias, apoiar ideias e consultar seu andamento.

## Funcionalidades

Oito telas completas e conectadas:

1. **Boas-vindas:** apresentação e acesso sem cadastro.
2. **Início:** saudação, contadores de serviços, propostas ativas e votações abertas, criação e atalhos.
3. **Serviços e direitos:** oito orientações, busca sem diferenciação de caixa/acentos e filtro por saúde, educação, documentos e benefícios.
4. **Detalhes do serviço:** orientação, preparação e retorno à lista; recebe um objeto por parâmetro.
5. **Propostas da comunidade:** busca por título, bairro ou categoria, filtro por status, votos e detalhes.
6. **Criar proposta:** título, categoria, bairro e descrição obrigatórios, validação e confirmação visual.
7. **Detalhes da proposta:** descrição, apoio demonstrativo e linha de etapas; recebe objeto e callback por parâmetro.
8. **Acompanhamento:** comunidade ou apenas propostas criadas na sessão, status e indicador de progresso.

Novas propostas aparecem imediatamente na comunidade e no acompanhamento, inicialmente **Em análise**. É permitido um apoio por proposta durante a sessão, somente no status **Em votação**. O apoio atualiza as contagens no início, na listagem e nos detalhes.

**Dados fictícios e temporários:** funciona offline, sem backend, banco, Firebase, conta ou integração governamental. As alterações vivem na memória do processo: trocar de tela preserva os dados; encerrar completamente o processo e abrir novamente reinicia propostas e votos. Colocar o app em segundo plano não garante reinicialização. Os status iniciais são exemplos e não avançam automaticamente. O app não envia propostas a órgãos públicos, agenda serviços ou comprova elegibilidade para benefícios. Não informe dados pessoais nos campos demonstrativos.

## Tecnologias e organização

Flutter **3.44.9**, Dart **3.12.2**, Material Design 3 e componentes nativos. Interface em português brasileiro, cores azul-escuro e verde, conteúdo rolável, botões com áreas de toque amplas e status identificados por texto e cor. Sem arquitetura complexa ou pacotes de gerenciamento de estado.

| Caminho | Responsabilidade |
| --- | --- |
| `lib/main.dart` | Aplicação, localização e entrada na navegação |
| `lib/models/` | Serviço, proposta, categorias, status e validações |
| `lib/data/` | Oito serviços, cinco propostas iniciais e busca |
| `lib/screens/` | Oito telas e shell com navegação inferior |
| `lib/widgets/` | Cards, avisos, cabeçalhos, estados vazios e ilustração |
| `lib/theme/` | Tema Material 3 e cores |
| `test/` | Testes de domínio e de fluxos com widgets |
| `tool/check_domain.dart` | Verificação adicional das regras em Dart puro |
| `.github/workflows/flutter-build.yml` | Análise, testes, APK, artifact e Release |

O shell é um `StatefulWidget` e mantém a lista da sessão. `setState()` atualiza abas, cadastro e votos. As telas recebem objetos e callbacks pelos construtores. `Navigator.push` abre detalhes e formulário; `Navigator.pop(proposal)` devolve a proposta validada ao shell. Filtros locais também usam `StatefulWidget`/`setState()`. O formulário utiliza `Form`, `TextFormField`, `GlobalKey<FormState>` e `SnackBar` de erro ou sucesso. Os controllers são descartados em `dispose()`.

## ODS relacionados

- **ODS 10 — Redução das desigualdades:** informação e participação sem cadastro.
- **ODS 11 — Cidades e comunidades sustentáveis:** propostas sobre infraestrutura, acessibilidade e espaços comunitários.
- **ODS 16 — Paz, justiça e instituições eficazes:** participação cidadã e acompanhamento transparente de demandas.

## Instalação e execução

Pré-requisitos: Flutter 3.44.9 no PATH, Android Studio/SDK Android, Java 21 e emulador ou dispositivo Android habilitado para desenvolvimento. A instalação das ferramentas e dependências precisa de internet; o app compilado funciona offline.

```powershell
git clone https://github.com/gcorrea4/vozcidadao-flutter.git
cd vozcidadao-flutter
flutter doctor
flutter pub get
flutter devices
flutter run -d ID_DO_ANDROID
```

Substitua `ID_DO_ANDROID` pelo identificador de `flutter devices`. Se o SDK solicitar licenças, execute `flutter doctor --android-licenses` e leia os termos.

```powershell
dart format --output=none --set-exit-if-changed lib test tool
flutter analyze
flutter test
dart run tool/check_domain.dart
flutter build apk --release
```

APK local: `build/app/outputs/flutter-apk/app-release.apk`.

## APK e publicação automatizada

**Versão v1.0.0 publicada em 18/11/2026.** Dependências, formatação, análise, **10 testes automatizados**, compilação Android e publicação do APK foram aprovados no GitHub Actions. A versão corresponde ao commit `34ef6e3`. Resultados em `VERIFICACOES.md`.

- Repositório: https://github.com/gcorrea4/vozcidadao-flutter
- Actions: https://github.com/gcorrea4/vozcidadao-flutter/actions
- Release: https://github.com/gcorrea4/vozcidadao-flutter/releases/tag/v1.0.0
- Download do APK: https://github.com/gcorrea4/vozcidadao-flutter/releases/download/v1.0.0/vozcidada.apk
- Execução aprovada da versão: https://github.com/gcorrea4/vozcidadao-flutter/actions/runs/44239530452

O workflow executa em pushes na `main`, pull requests, execução manual e tags `v*`. Configura Java 21 e Flutter 3.44.9, instala dependências, confere formatação, analisa, testa e compila. Só depois disponibiliza `vozcidada-apk` como artifact por 14 dias. Em uma tag cuja versão corresponda ao `pubspec.yaml`, um segundo job publica o mesmo APK na Release. Uma falha nas verificações impede a publicação.

Para instalar, abra a Release no Android, baixe `vozcidada.apk`, permita instalação pelo aplicativo utilizado para abrir o arquivo e confirme. O APK acadêmico usa modo release com assinatura de depuração gerada no build. Não é publicação na Play Store. Builds de ambientes diferentes podem exigir desinstalar a versão anterior; distribuição contínua exige chave própria fora do Git. Não há credenciais no código; a publicação usa o `GITHUB_TOKEN` fornecido pelo Actions.


## Equipe

| Integrante | RM | Turma |
| --- | --- | --- |
| Kayque Duarte | 567980 | 2TDSPB |
| Eric Maciel | 567398 | 2TDSPB |
| Gabriel Correa | 567903 | 2TDSPB |

Nome do grupo: **Grupo Global**.
