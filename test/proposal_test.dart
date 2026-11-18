import 'package:flutter_test/flutter_test.dart';
import 'package:vozcidadao/data/mock_data.dart';
import 'package:vozcidadao/data/search.dart';
import 'package:vozcidadao/models/proposal.dart';
import 'package:vozcidadao/models/proposal_validation.dart';

void main() {
  test('aceita um apoio, bloqueia repetição e mantém outras propostas', () {
    final proposals = createMockProposals();
    final proposal = proposals.first;
    expect(proposal.support(), isTrue);
    expect(proposal.votes, 129);
    expect(proposal.hasSupported, isTrue);
    expect(proposal.support(), isFalse);
    expect(proposal.votes, 129);
    expect(proposals[1].votes, 46);
  });

  test('somente propostas em votação recebem apoio', () {
    for (final p in createMockProposals().where(
      (p) => p.status != ProposalStatus.voting,
    )) {
      final before = p.votes;
      expect(p.support(), isFalse);
      expect(p.votes, before);
    }
  });

  test('dados são independentes entre sessões', () {
    final firstSession = createMockProposals();
    firstSession.first.support();
    final newSession = createMockProposals();
    expect(newSession.first.votes, 128);
    expect(newSession.first.hasSupported, isFalse);
  });

  test('validadores rejeitam vazio, espaços e limites incorretos', () {
    expect(ProposalValidation.title('   '), isNotNull);
    expect(ProposalValidation.title('Curto'), isNotNull);
    expect(ProposalValidation.title('x' * 91), isNotNull);
    expect(ProposalValidation.neighborhood('AB'), isNotNull);
    expect(ProposalValidation.description('Breve'), isNotNull);
    expect(ProposalValidation.description('x' * 1001), isNotNull);
    expect(ProposalValidation.title('Iluminação na praça'), isNull);
    expect(ProposalValidation.neighborhood('  Jardim Ângela  '), isNull);
    expect(
      ProposalValidation.description(
        'Uma proposta detalhada para melhorar o bairro e a convivência.',
      ),
      isNull,
    );
  });

  test('busca ignora caixa e acentos em português', () {
    expect(normalizeSearch('  Saúde e EDUCAÇÃO '), 'saude e educacao');
  });
}
