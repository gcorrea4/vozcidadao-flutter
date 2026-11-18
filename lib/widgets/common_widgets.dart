import 'package:flutter/material.dart';
import '../models/proposal.dart';
import '../models/public_service.dart';
import '../theme/app_theme.dart';

IconData serviceIcon(ServiceCategory category) => switch (category) {
  ServiceCategory.health => Icons.health_and_safety_outlined,
  ServiceCategory.education => Icons.school_outlined,
  ServiceCategory.documents => Icons.badge_outlined,
  ServiceCategory.benefits => Icons.volunteer_activism_outlined,
};

IconData proposalIcon(ProposalCategory category) => switch (category) {
  ProposalCategory.infrastructure => Icons.lightbulb_outline_rounded,
  ProposalCategory.health => Icons.health_and_safety_outlined,
  ProposalCategory.education => Icons.menu_book_rounded,
  ProposalCategory.environment => Icons.eco_outlined,
  ProposalCategory.accessibility => Icons.accessible_forward_rounded,
};

class PageContent extends StatelessWidget {
  const PageContent({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
    children: [
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    ],
  );
}

class PageHeading extends StatelessWidget {
  const PageHeading(this.title, this.subtitle, {super.key});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(subtitle),
      ],
    ),
  );
}

class DemoNotice extends StatelessWidget {
  const DemoNotice({
    super.key,
    this.text =
        'Ambiente demonstrativo • dados temporários, sem vínculo com órgãos públicos.',
  });
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFE9EFF5),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline_rounded, color: AppColors.navy, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

class StatusBadge extends StatelessWidget {
  const StatusBadge(this.status, {super.key});
  final ProposalStatus status;
  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (status) {
      ProposalStatus.analysis => (
        const Color(0xFFFFEFCC),
        const Color(0xFF73500B),
      ),
      ProposalStatus.voting => (
        const Color(0xFFE5EFFB),
        const Color(0xFF20558C),
      ),
      ProposalStatus.approved => (AppColors.mint, AppColors.green),
      ProposalStatus.completed => (const Color(0xFFE8ECF0), AppColors.navy),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 12),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
      ],
    ),
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, required this.description});
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 12),
    child: Center(
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 44,
            color: AppColors.muted,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
