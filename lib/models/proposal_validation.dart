abstract final class ProposalValidation {
  static String? title(String? value) => _length(value, 'título', 8, 90);
  static String? neighborhood(String? value) => _length(value, 'bairro', 3, 60);
  static String? description(String? value) =>
      _length(value, 'descrição', 30, 1000);

  static String? _length(String? value, String field, int min, int max) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Preencha o campo $field.';
    }
    if (text.length < min) {
      return 'Use pelo menos $min caracteres no campo $field.';
    }
    if (text.length > max) {
      return 'Use no máximo $max caracteres no campo $field.';
    }
    return null;
  }
}
