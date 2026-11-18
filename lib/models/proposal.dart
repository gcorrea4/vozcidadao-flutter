enum ProposalStatus {
  analysis('Em análise', 'A ideia foi recebida para avaliação demonstrativa.'),
  voting('Em votação', 'A comunidade pode demonstrar seu apoio.'),
  approved('Aprovada', 'A proposta avançou nesta simulação acadêmica.'),
  completed('Concluída', 'A melhoria foi concluída no cenário fictício.');

  const ProposalStatus(this.label, this.description);
  final String label;
  final String description;
}

enum ProposalCategory {
  infrastructure('Infraestrutura'),
  health('Saúde'),
  education('Educação'),
  environment('Meio ambiente'),
  accessibility('Acessibilidade');

  const ProposalCategory(this.label);
  final String label;
}

class Proposal {
  Proposal({
    required this.id,
    required this.title,
    required this.category,
    required this.neighborhood,
    required this.description,
    required this.status,
    this.votes = 0,
    this.isMine = false,
  });

  final String id;
  final String title;
  final ProposalCategory category;
  final String neighborhood;
  final String description;
  final ProposalStatus status;
  final bool isMine;
  int votes;
  bool hasSupported = false;

  bool get canSupport => status == ProposalStatus.voting && !hasSupported;

  /// Um apoio por proposta nesta sessão; não representa uma votação oficial.
  bool support() {
    if (!canSupport) return false;
    votes++;
    hasSupported = true;
    return true;
  }
}
