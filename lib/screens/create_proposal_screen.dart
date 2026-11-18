import 'package:flutter/material.dart';
import '../models/proposal.dart';
import '../models/proposal_validation.dart';
import '../widgets/common_widgets.dart';

class CreateProposalScreen extends StatefulWidget {
  const CreateProposalScreen({super.key});
  @override
  State<CreateProposalScreen> createState() => _CreateProposalScreenState();
}

class _CreateProposalScreenState extends State<CreateProposalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _neighborhood = TextEditingController();
  final _description = TextEditingController();
  ProposalCategory? _category;
  bool _attempted = false;

  @override
  void dispose() {
    _title.dispose();
    _neighborhood.dispose();
    _description.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _attempted = true);
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Revise os campos destacados para enviar sua proposta.',
          ),
        ),
      );
      return;
    }
    final proposal = Proposal(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      title: _title.text.trim(),
      category: _category!,
      neighborhood: _neighborhood.text.trim(),
      description: _description.text.trim(),
      status: ProposalStatus.analysis,
      isMine: true,
    );
    // Retorna um objeto para a tela anterior: exemplo de retorno entre rotas.
    Navigator.of(context).pop(proposal);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Criar proposta')),
    body: SafeArea(
      child: Form(
        key: _formKey,
        autovalidateMode: _attempted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: PageContent(
          children: [
            const PageHeading(
              'Toda mudança\ncomeça com uma ideia.',
              'Conte o que pode melhorar no seu bairro. Todos os campos são obrigatórios.',
            ),
            const DemoNotice(
              text:
                  'Proposta demonstrativa, salva apenas nesta sessão. Não informe nomes, documentos, telefones ou outros dados pessoais.',
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: const ValueKey('proposal-title'),
              controller: _title,
              validator: ProposalValidation.title,
              maxLength: 90,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Título da proposta',
                helperText: 'De 8 a 90 caracteres. Seja direto.',
                prefixIcon: Icon(Icons.lightbulb_outline_rounded),
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<ProposalCategory>(
              key: const ValueKey('proposal-category'),
              initialValue: _category,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Categoria',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: ProposalCategory.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _category = value),
              validator: (value) =>
                  value == null ? 'Selecione uma categoria.' : null,
            ),
            const SizedBox(height: 22),
            TextFormField(
              key: const ValueKey('proposal-neighborhood'),
              controller: _neighborhood,
              validator: ProposalValidation.neighborhood,
              maxLength: 60,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Bairro',
                helperText: 'De 3 a 60 caracteres.',
                prefixIcon: Icon(Icons.place_outlined),
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              key: const ValueKey('proposal-description'),
              controller: _description,
              validator: ProposalValidation.description,
              maxLength: 1000,
              minLines: 4,
              maxLines: 7,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                alignLabelWithHint: true,
                helperText: 'De 30 a 1.000 caracteres.',
                hintText: 'Qual é o problema e como sua ideia pode ajudar?',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                key: const ValueKey('save-proposal'),
                onPressed: _submit,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Salvar proposta'),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Após salvar, sua proposta entra em Em análise. Os status são ilustrativos e não avançam automaticamente.',
            ),
          ],
        ),
      ),
    ),
  );
}
