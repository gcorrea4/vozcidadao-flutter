import 'package:flutter/material.dart';
import '../models/proposal.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({
    super.key,
    required this.proposals,
    required this.onOpen,
    required this.onCreate,
  });
  final List<Proposal> proposals;
  final ValueChanged<Proposal> onOpen;
  final VoidCallback onCreate;
  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  bool _mineOnly = false;
  @override
  Widget build(BuildContext context) {
    final items = widget.proposals
        .where((p) => !_mineOnly || p.isMine)
        .toList();
    return PageContent(
      children: [
        const PageHeading(
          'Cada passo conta.',
          'Acompanhe o caminho das ideias, do cadastro à conclusão.',
        ),
        const DemoNotice(
          text:
              'Andamento ilustrativo. Os status não são atualizados por órgãos públicos e não representam compromissos de execução.',
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: const Text('Toda a comunidade'),
              selected: !_mineOnly,
              onSelected: (_) => setState(() => _mineOnly = false),
            ),
            ChoiceChip(
              label: const Text('Minhas propostas'),
              selected: _mineOnly,
              onSelected: (_) => setState(() => _mineOnly = true),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (items.isEmpty) ...[
          const EmptyState(
            title: 'Sua primeira ideia pode estar aqui',
            description:
                'Crie uma proposta para acompanhar o andamento nesta sessão.',
          ),
          Center(
            child: FilledButton.icon(
              onPressed: widget.onCreate,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Criar proposta'),
            ),
          ),
        ],
        for (final p in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () => widget.onOpen(p),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          StatusBadge(p.status),
                          if (p.isMine) const Chip(label: Text('Sua proposta')),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        p.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(p.neighborhood),
                      const SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: (p.status.index + 1) / 4,
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(8),
                        backgroundColor: const Color(0xFFE7EDF1),
                        semanticsLabel:
                            'Etapa ${p.status.index + 1} de 4: ${p.status.label}',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Etapa ${p.status.index + 1} de 4 • ${p.status.description}',
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Consultar andamento →',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
