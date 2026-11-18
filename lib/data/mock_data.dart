import '../models/proposal.dart';
import '../models/public_service.dart';

/// Cada chamada cria objetos novos: nenhuma alteração sobrevive ao reinício.
List<Proposal> createMockProposals() => [
  Proposal(
    id: 'p1',
    title: 'Mais luz no caminho de casa',
    category: ProposalCategory.infrastructure,
    neighborhood: 'Jardim Ângela',
    description:
        'Propor uma avaliação comunitária da iluminação no entorno da praça e dos pontos de ônibus. A ideia é identificar trechos escuros e reunir prioridades de quem passa por ali todos os dias.',
    status: ProposalStatus.voting,
    votes: 128,
  ),
  Proposal(
    id: 'p2',
    title: 'Uma praça para todas as pessoas',
    category: ProposalCategory.accessibility,
    neighborhood: 'Capão Redondo',
    description:
        'Mapear barreiras de acesso à praça e propor caminhos acessíveis, bancos e espaços de convivência. Moradores poderão compartilhar suas necessidades em uma consulta demonstrativa.',
    status: ProposalStatus.analysis,
    votes: 46,
  ),
  Proposal(
    id: 'p3',
    title: 'Horta comunitária do bairro',
    category: ProposalCategory.environment,
    neighborhood: 'Jardim Ângela',
    description:
        'Organizar um espaço de cultivo e educação ambiental com participação voluntária dos moradores. Esta proposta fictícia representa um exemplo de decisão comunitária já aprovada.',
    status: ProposalStatus.approved,
    votes: 203,
  ),
  Proposal(
    id: 'p4',
    title: 'Livros que circulam',
    category: ProposalCategory.education,
    neighborhood: 'Jardim São Luís',
    description:
        'Criar um ponto comunitário de troca de livros e rodas de leitura. Neste cenário fictício, o espaço foi organizado e a comunidade já pode acompanhar a conclusão da iniciativa.',
    status: ProposalStatus.completed,
    votes: 87,
  ),
  Proposal(
    id: 'p5',
    title: 'Informação de saúde mais perto',
    category: ProposalCategory.health,
    neighborhood: 'Capão Redondo',
    description:
        'Propor encontros comunitários de orientação sobre como buscar informações de saúde nos canais responsáveis. A iniciativa é ilustrativa e não oferece consulta ou atendimento médico.',
    status: ProposalStatus.voting,
    votes: 64,
  ),
];

const mockServices = [
  PublicService(
    title: 'Orientação sobre atenção básica',
    category: ServiceCategory.health,
    summary:
        'Entenda como buscar informações sobre cuidados de saúde no território.',
    steps: [
      'Identifique a unidade de referência do seu endereço nos canais oficiais do município.',
      'Consulte diretamente a unidade sobre cadastro, horários e formas de atendimento.',
      'Confirme documentos e orientações antes de se deslocar.',
    ],
    preparation:
        'Pergunte à unidade quais documentos são necessários. O app não faz agendamento e não informa disponibilidade.',
  ),
  PublicService(
    title: 'Informações sobre vacinação',
    category: ServiceCategory.health,
    summary: 'Prepare suas dúvidas antes de procurar uma unidade de saúde.',
    steps: [
      'Separe seu histórico ou carteira de vacinação, se tiver.',
      'Confirme no canal de saúde responsável as orientações para sua faixa etária.',
      'Verifique na unidade o atendimento e os documentos solicitados.',
    ],
    preparation:
        'Não há calendário ou estoque de vacinas em tempo real neste aplicativo.',
  ),
  PublicService(
    title: 'Orientação sobre matrícula escolar',
    category: ServiceCategory.education,
    summary: 'Saiba o que conferir ao buscar uma vaga na rede de ensino.',
    steps: [
      'Identifique se a rede responsável é municipal ou estadual.',
      'Consulte a secretaria de educação sobre período de matrícula e critérios.',
      'Confirme a documentação e acompanhe o pedido pelo canal indicado.',
    ],
    preparation:
        'Prazos e critérios variam conforme a rede. Não há vagas ou inscrições disponíveis pelo app.',
  ),
  PublicService(
    title: 'Acesso a cursos e capacitação',
    category: ServiceCategory.education,
    summary: 'Organize a busca por oportunidades de aprendizagem.',
    steps: [
      'Defina a área e os horários em que você pode estudar.',
      'Procure editais e comunicados em canais institucionais oficiais.',
      'Leia os requisitos e confirme a instituição antes de fornecer dados.',
    ],
    preparation:
        'Não são oferecidas inscrições nem garantidas oportunidades neste ambiente demonstrativo.',
  ),
  PublicService(
    title: 'Orientação sobre documentos pessoais',
    category: ServiceCategory.documents,
    summary: 'Planeje sua busca por emissão ou atualização de documentos.',
    steps: [
      'Identifique o documento e o órgão emissor responsável.',
      'Consulte o canal oficial do órgão sobre agendamento, taxas e documentos.',
      'Confirme endereço e instruções antes de comparecer.',
    ],
    preparation:
        'O app não emite documentos, não cobra taxas e não coleta dados pessoais.',
  ),
  PublicService(
    title: 'Organização de documentos',
    category: ServiceCategory.documents,
    summary: 'Um guia simples para preparar seu atendimento.',
    steps: [
      'Liste quais documentos o órgão responsável pediu.',
      'Confira a validade e se é necessário apresentar original ou cópia.',
      'Guarde protocolos com segurança para acompanhar solicitações.',
    ],
    preparation:
        'Nunca envie fotos de documentos por canais cuja identidade você não confirmou.',
  ),
  PublicService(
    title: 'Orientação sobre assistência social',
    category: ServiceCategory.benefits,
    summary: 'Entenda como buscar informações sobre proteção social.',
    steps: [
      'Identifique a unidade de assistência social de referência nos canais do município.',
      'Pergunte sobre serviços, cadastro e critérios aplicáveis à sua situação.',
      'Confirme documentos e como acompanhar eventuais solicitações.',
    ],
    preparation:
        'A elegibilidade é definida pelo órgão competente. O app não concede benefícios nem garante atendimento.',
  ),
  PublicService(
    title: 'Informações sobre cadastro social',
    category: ServiceCategory.benefits,
    summary: 'Prepare dúvidas sobre cadastro e atualização de informações.',
    steps: [
      'Procure o canal oficial responsável pelo cadastro em seu município.',
      'Confirme como solicitar ou atualizar informações e quais documentos levar.',
      'Acompanhe o processo diretamente pelo canal informado pelo órgão.',
    ],
    preparation:
        'Nenhum cadastro é realizado aqui. Não há consulta de situação, renda ou benefício.',
  ),
];
