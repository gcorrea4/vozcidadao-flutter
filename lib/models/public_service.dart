enum ServiceCategory {
  health('Saúde'),
  education('Educação'),
  documents('Documentos'),
  benefits('Benefícios');

  const ServiceCategory(this.label);
  final String label;
}

class PublicService {
  const PublicService({
    required this.title,
    required this.category,
    required this.summary,
    required this.steps,
    required this.preparation,
  });
  final String title;
  final ServiceCategory category;
  final String summary;
  final List<String> steps;
  final String preparation;
}
