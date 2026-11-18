import 'package:flutter/material.dart';
import '../models/public_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.service});
  final PublicService service;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Serviços e direitos')),
    body: SafeArea(
      child: PageContent(
        children: [
          const SizedBox(height: 16),
          Icon(serviceIcon(service.category), size: 48, color: AppColors.green),
          const SizedBox(height: 20),
          PageHeading(service.title, service.summary),
          const DemoNotice(
            text:
                'Orientação demonstrativa, sem vínculo com serviço público. O app não realiza solicitações ou agendamentos.',
          ),
          const SectionTitle('Por onde começar'),
          for (var i = 0; i < service.steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.mint,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: AppColors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      service.steps[i],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          const SectionTitle('Antes de sair de casa'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(service.preparation),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Voltar aos serviços'),
            ),
          ),
        ],
      ),
    ),
  );
}
