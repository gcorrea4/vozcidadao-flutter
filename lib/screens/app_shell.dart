import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/proposal.dart';
import '../theme/app_theme.dart';
import 'create_proposal_screen.dart';
import 'dashboard_screen.dart';
import 'proposal_detail_screen.dart';
import 'proposals_screen.dart';
import 'services_screen.dart';
import 'tracking_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // Fonte única dos dados da sessão, compartilhada por parâmetros e callbacks.
  final List<Proposal> _proposals = createMockProposals();
  int _selectedIndex = 0;
  int _creationCount = 0;

  void _navigate(int index) => setState(() => _selectedIndex = index);

  bool _support(Proposal proposal, {bool feedback = true}) {
    if (!proposal.canSupport) return false;
    setState(() => proposal.support());
    if (feedback) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Apoio registrado! Este voto é demonstrativo e vale nesta sessão.',
          ),
        ),
      );
    }
    return true;
  }

  void _open(Proposal proposal) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProposalDetailScreen(
          proposal: proposal,
          onSupport: (p) => _support(p, feedback: false),
        ),
      ),
    );
  }

  Future<void> _create() async {
    final proposal = await Navigator.of(context).push<Proposal>(
      MaterialPageRoute(builder: (_) => const CreateProposalScreen()),
    );
    if (!mounted || proposal == null) return;
    setState(() {
      _proposals.insert(0, proposal);
      _creationCount++;
      _selectedIndex = 2;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Proposta salva! Ela já aparece na comunidade e no acompanhamento.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.spatial_audio_off_rounded, color: AppColors.green),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              'VozCidadã',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Tooltip(
            message: 'Dados demonstrativos, sem acesso à internet',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.mint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 19,
                color: AppColors.green,
              ),
            ),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          DashboardScreen(
            proposals: _proposals,
            onNavigate: _navigate,
            onCreate: _create,
            onOpen: _open,
            onSupport: _support,
          ),
          const ServicesScreen(),
          // Reinicia filtros após cadastrar para tornar a nova proposta visível.
          ProposalsScreen(
            key: ValueKey(_creationCount),
            proposals: _proposals,
            onCreate: _create,
            onOpen: _open,
            onSupport: _support,
          ),
          TrackingScreen(
            proposals: _proposals,
            onOpen: _open,
            onCreate: _create,
          ),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _navigate,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.widgets_outlined),
          selectedIcon: Icon(Icons.widgets_rounded),
          label: 'Serviços',
        ),
        NavigationDestination(
          icon: Icon(Icons.forum_outlined),
          selectedIcon: Icon(Icons.forum_rounded),
          label: 'Propostas',
        ),
        NavigationDestination(
          icon: Icon(Icons.route_outlined),
          selectedIcon: Icon(Icons.route_rounded),
          label: 'Acompanhar',
        ),
      ],
    ),
  );
}
