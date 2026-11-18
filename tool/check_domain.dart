// Verificação executável sem o motor Flutter, útil em ambientes restritos.
// Não substitui flutter test nem os testes de widgets.
import 'dart:io';
import 'package:vozcidadao/data/mock_data.dart';
import 'package:vozcidadao/data/search.dart';
import 'package:vozcidadao/models/proposal.dart';
import 'package:vozcidadao/models/proposal_validation.dart';

void check(bool condition, String message) {
  if (!condition) throw StateError(message);
}

void main() {
  final proposals = createMockProposals();
  check(
    proposals.first.support() && proposals.first.votes == 129,
    'Primeiro apoio',
  );
  check(
    !proposals.first.support() && proposals.first.votes == 129,
    'Apoio duplicado',
  );
  for (final p in proposals.where((p) => p.status != ProposalStatus.voting)) {
    check(!p.support(), 'Bloqueio de apoio fora de votação');
  }
  check(createMockProposals().first.votes == 128, 'Isolamento entre sessões');
  check(ProposalValidation.title('   ') != null, 'Título obrigatório');
  check(ProposalValidation.title('Curto') != null, 'Título mínimo');
  check(ProposalValidation.title('x' * 91) != null, 'Título máximo');
  check(ProposalValidation.neighborhood('ab') != null, 'Bairro mínimo');
  check(
    ProposalValidation.description('Muito breve') != null,
    'Descrição mínima',
  );
  check(ProposalValidation.description('x' * 1001) != null, 'Descrição máxima');
  check(ProposalValidation.title('Calçada acessível') == null, 'Título válido');
  check(
    ProposalValidation.neighborhood('Jardim Ângela') == null,
    'Bairro válido',
  );
  check(
    ProposalValidation.description(
          'Mapear barreiras e propor melhorias para todas as pessoas do bairro.',
        ) ==
        null,
    'Descrição válida',
  );
  check(
    normalizeSearch(' Saúde e EDUCAÇÃO ') == 'saude e educacao',
    'Busca com acentos',
  );
  check(mockServices.length == 8 && proposals.length == 5, 'Dados iniciais');
  stdout.writeln(
    'Verificações de domínio concluídas: votos, sessão, validações, busca e dados iniciais.',
  );
}
