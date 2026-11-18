# Validação da versão v1.0.0

O pipeline do GitHub Actions concluiu com sucesso em 18/11/2026 para o commit `34ef6e3`, identificado pela tag `v1.0.0`.

| Verificação | Resultado |
| --- | --- |
| Instalação de dependências | Aprovada |
| Formatação Dart | Aprovada |
| Análise estática Flutter | Aprovada, sem problemas |
| Testes automatizados | 10 aprovados |
| Compilação Android em modo release | APK gerado, 49,9 MB |
| Artifact do Actions | `vozcidada-apk` disponibilizado |
| GitHub Release | Publicada com `vozcidada.apk` |

Os testes automatizados cobrem as regras de apoio único, bloqueio de votos fora da etapa de votação, independência entre sessões, validações de campos, busca sem diferenciação de acentos, navegação, detalhes de serviços, cadastro, acompanhamento e layout de boas-vindas com texto ampliado.

- [Workflow aprovado](https://github.com/gcorrea4/vozcidadao-flutter/actions/runs/44239530452)
- [Release v1.0.0](https://github.com/gcorrea4/vozcidadao-flutter/releases/tag/v1.0.0)
- [APK Android](https://github.com/gcorrea4/vozcidadao-flutter/releases/download/v1.0.0/vozcidada.apk)
