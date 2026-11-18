import 'package:flutter/material.dart';
import '../models/proposal.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ProposalDetailScreen extends StatefulWidget {
  const ProposalDetailScreen({
    super.key,
    required this.proposal,
    required this.onSupport,
  });
  // Passagem explícita de objeto e callback pela rota MaterialPageRoute.
  final Proposal proposal;
  final bool Function(Proposal) onSupport;
  @override
  State<ProposalDetailScreen> createState() => _ProposalDetailScreenState();
}

class _ProposalDetailScreenState extends State<ProposalDetailScreen> {
  void _support() {
    final accepted = widget.onSupport(widget.proposal);
    if (accepted) setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          accepted
              ? 'Apoio registrado nesta sessão. Sua voz faz a diferença!'
              : 'Esta proposta não pode receber outro apoio nesta sessão.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.proposal;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da proposta')),
      body: SafeArea(
        child: PageContent(
          children: [
            const SizedBox(height: 12),
            StatusBadge(p.status),
            const SizedBox(height: 22),
            Text(p.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              children: [
                Text(
                  p.category.label,
                  style: const TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('Bairro: ${p.neighborhood}'),
                if (p.isMine) const Text('Criada por você nesta sessão'),
              ],
            ),
            const SectionTitle('A ideia'),
            Text(p.description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_alt_outlined,
                      color: AppColors.green,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              '${p.votes} apoios',
                              key: const ValueKey('detail-votes'),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const Text(
                            'Participação demonstrativa da comunidade',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (p.status == ProposalStatus.voting)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  key: const ValueKey('detail-support'),
                  onPressed: p.canSupport ? _support : null,
                  icon: Icon(
                    p.hasSupported
                        ? Icons.check_circle_outline
                        : Icons.thumb_up_outlined,
                  ),
                  label: Text(
                    p.hasSupported
                        ? 'Você já apoiou esta proposta'
                        : 'Apoiar esta proposta',
                  ),
                ),
              )
            else
              Text(
                'Apoios disponíveis apenas na etapa Em votação. Status atual: ${p.status.label}.',
              ),
            const SectionTitle('Caminho da proposta'),
            for (final status in ProposalStatus.values)
              _timelineStep(context, status, p.status),
            const SizedBox(height: 18),
            const DemoNotice(
              text:
                  'Este é um cenário acadêmico. Apoios e status não são oficiais. Dados criados e votos reiniciam ao reabrir o aplicativo.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _timelineStep(
    BuildContext context,
    ProposalStatus step,
    ProposalStatus current,
  ) {
    final reached = step.index <= current.index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            reached
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: reached ? AppColors.green : AppColors.muted,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${step.index + 1}. ${step.label}${step == current ? ' • Etapa atual' : ''}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(step.description),
                if (!reached)
                  const Text(
                    'Próxima etapa ilustrativa',
                    style: TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
