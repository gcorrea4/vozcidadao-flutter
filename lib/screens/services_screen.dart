import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../data/search.dart';
import '../models/public_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'service_detail_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  ServiceCategory? _category;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = normalizeSearch(_query);
    final services = mockServices
        .where(
          (s) =>
              (_category == null || s.category == _category) &&
              normalizeSearch(
                '${s.title} ${s.summary} ${s.category.label}',
              ).contains(query),
        )
        .toList();
    return PageContent(
      children: [
        const PageHeading(
          'Seus direitos, mais perto.',
          'Orientações simples para encontrar o caminho até os serviços públicos.',
        ),
        TextField(
          key: const ValueKey('service-search'),
          onChanged: (value) => setState(() => _query = value),
          decoration: const InputDecoration(
            labelText: 'Buscar serviço',
            hintText: 'Saúde, matrícula, documentos...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: const Text('Todos'),
              selected: _category == null,
              onSelected: (_) => setState(() => _category = null),
            ),
            for (final category in ServiceCategory.values)
              ChoiceChip(
                label: Text(category.label),
                selected: _category == category,
                onSelected: (_) => setState(() => _category = category),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          '${services.length} orientações encontradas',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        if (services.isEmpty)
          const EmptyState(
            title: 'Nenhum serviço encontrado',
            description: 'Tente outro termo ou selecione outra categoria.',
          ),
        for (final service in services)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ServiceDetailScreen(service: service),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.mint,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          serviceIcon(service.category),
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.category.label.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                color: AppColors.green,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              service.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(service.summary),
                            const SizedBox(height: 10),
                            const Text(
                              'Consultar orientação →',
                              style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        const DemoNotice(
          text:
              'Conteúdo ilustrativo. Confirme regras, documentos, horários e disponibilidade diretamente com o órgão responsável. Nenhum link ou atendimento oficial é oferecido aqui.',
        ),
      ],
    );
  }
}
