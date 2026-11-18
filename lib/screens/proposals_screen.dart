import 'package:flutter/material.dart';
import '../data/search.dart';
import '../models/proposal.dart';
import '../widgets/common_widgets.dart';
import '../widgets/proposal_card.dart';

class ProposalsScreen extends StatefulWidget {
  const ProposalsScreen({
    super.key,
    required this.proposals,
    required this.onCreate,
    required this.onOpen,
    required this.onSupport,
  });
  final List<Proposal> proposals;
  final VoidCallback onCreate;
  final ValueChanged<Proposal> onOpen;
  final ValueChanged<Proposal> onSupport;
  @override
  State<ProposalsScreen> createState() => _ProposalsScreenState();
}

class _ProposalsScreenState extends State<ProposalsScreen> {
  ProposalStatus? _status;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final items = widget.proposals
        .where(
          (p) =>
              (_status == null || p.status == _status) &&
              normalizeSearch(
                '${p.title} ${p.neighborhood} ${p.category.label}',
              ).contains(normalizeSearch(_query)),
        )
        .toList();
    return PageContent(
      children: [
        const PageHeading(
          'Ideias que nos unem.',
          'Conheça as propostas do bairro e apoie as mudanças que fazem sentido para você.',
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: widget.onCreate,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Criar proposta'),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          onChanged: (value) => setState(() => _query = value),
          decoration: const InputDecoration(
            labelText: 'Buscar proposta ou bairro',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: const Text('Todas'),
              selected: _status == null,
              onSelected: (_) => setState(() => _status = null),
            ),
            for (final status in ProposalStatus.values)
              ChoiceChip(
                label: Text(status.label),
                selected: _status == status,
                onSelected: (_) => setState(() => _status = status),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text('${items.length} propostas encontradas'),
        const SizedBox(height: 14),
        if (items.isEmpty)
          const EmptyState(
            title: 'Nenhuma proposta por aqui',
            description: 'Altere os filtros ou compartilhe uma nova ideia.',
          ),
        for (final proposal in items)
          ProposalCard(
            proposal: proposal,
            onOpen: () => widget.onOpen(proposal),
            onSupport: () => widget.onSupport(proposal),
          ),
        const DemoNotice(
          text:
              'Apoios são demonstrativos: um por proposta nesta sessão, apenas quando o status é Em votação.',
        ),
      ],
    );
  }
}
