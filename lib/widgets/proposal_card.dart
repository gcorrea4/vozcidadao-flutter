import 'package:flutter/material.dart';
import '../models/proposal.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class ProposalCard extends StatelessWidget {
  const ProposalCard({
    super.key,
    required this.proposal,
    required this.onOpen,
    required this.onSupport,
  });
  final Proposal proposal;
  final VoidCallback onOpen;
  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusBadge(proposal.status),
                if (proposal.isMine)
                  const Text(
                    'Sua proposta',
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.mint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    proposalIcon(proposal.category),
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proposal.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${proposal.category.label} • ${proposal.neighborhood}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              proposal.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Semantics(
                  liveRegion: true,
                  child: Text(
                    '${proposal.votes} apoios',
                    key: ValueKey('votes-${proposal.id}'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onOpen,
                  child: const Text('Ver detalhes'),
                ),
                if (proposal.status == ProposalStatus.voting)
                  OutlinedButton.icon(
                    key: ValueKey('support-${proposal.id}'),
                    onPressed: proposal.canSupport ? onSupport : null,
                    icon: Icon(
                      proposal.hasSupported
                          ? Icons.check_rounded
                          : Icons.thumb_up_outlined,
                      size: 18,
                    ),
                    label: Text(proposal.hasSupported ? 'Apoiado' : 'Apoiar'),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
