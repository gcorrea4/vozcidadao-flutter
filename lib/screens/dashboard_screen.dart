import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/proposal.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/proposal_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.proposals,
    required this.onNavigate,
    required this.onCreate,
    required this.onOpen,
    required this.onSupport,
  });
  final List<Proposal> proposals;
  final ValueChanged<int> onNavigate;
  final VoidCallback onCreate;
  final ValueChanged<Proposal> onOpen;
  final ValueChanged<Proposal> onSupport;

  @override
  Widget build(BuildContext context) {
    final open = proposals
        .where((p) => p.status == ProposalStatus.voting)
        .length;
    final active = proposals
        .where((p) => p.status != ProposalStatus.completed)
        .length;
    return PageContent(
      children: [
        const Text(
          'OLÁ, CIDADÃO 👋',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 8),
        const PageHeading(
          'Vamos cuidar\ndo nosso bairro?',
          'Pequenas ideias. Mudanças que aproximam.',
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.forum_outlined,
                color: Color(0xFF89DFC0),
                size: 34,
              ),
              const SizedBox(height: 16),
              const Text(
                'Sua voz tem lugar aqui.',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 24,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Uma rua melhor, uma praça acessível, mais oportunidades. Qual é a sua ideia?',
                style: TextStyle(color: Color(0xFFD1E0EA), height: 1.5),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                key: const ValueKey('dashboard-create'),
                onPressed: onCreate,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Criar uma proposta'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns =
                constraints.maxWidth < 350 ||
                    MediaQuery.textScalerOf(context).scale(1) > 1.3
                ? 1
                : 3;
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _metric(
                  context,
                  '${mockServices.length}',
                  'Orientações de serviços',
                  Icons.widgets_outlined,
                  () => onNavigate(1),
                  (constraints.maxWidth - (columns - 1) * 10) / columns,
                ),
                _metric(
                  context,
                  '$active',
                  'Propostas ativas',
                  Icons.campaign_outlined,
                  () => onNavigate(2),
                  (constraints.maxWidth - (columns - 1) * 10) / columns,
                ),
                _metric(
                  context,
                  '$open',
                  'Votações abertas',
                  Icons.how_to_vote_outlined,
                  () => onNavigate(2),
                  (constraints.maxWidth - (columns - 1) * 10) / columns,
                ),
              ],
            );
          },
        ),
        SectionTitle(
          'Participe da comunidade',
          action: 'Ver propostas',
          onAction: () => onNavigate(2),
        ),
        for (final proposal
            in proposals
                .where((p) => p.status == ProposalStatus.voting)
                .take(2))
          ProposalCard(
            proposal: proposal,
            onOpen: () => onOpen(proposal),
            onSupport: () => onSupport(proposal),
          ),
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(18),
            leading: const Icon(Icons.route_outlined, color: AppColors.green),
            title: const Text('Da ideia à transformação'),
            subtitle: const Text('Veja o andamento das propostas.'),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () => onNavigate(3),
          ),
        ),
        const SizedBox(height: 24),
        const DemoNotice(),
      ],
    );
  }

  Widget _metric(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    VoidCallback onTap,
    double width,
  ) => SizedBox(
    width: width,
    child: Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.green, size: 22),
              const SizedBox(height: 10),
              Text(value, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
