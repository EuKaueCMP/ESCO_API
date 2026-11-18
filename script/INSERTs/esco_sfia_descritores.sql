-- gerado por /tmp/opencode/sfia9_generator.py — descritores oficiais SFIA 9 (PT-BR do site sfia-online.org/pt)
BEGIN;

-- tabela de descritores por habilidade x nivel (faixa SFIA real da skill)
CREATE TABLE IF NOT EXISTS esco_dataset.nivel_habilidade_descritor
(
	habilidade_id INTEGER NOT NULL,
	nivel SMALLINT NOT NULL,
	descricao TEXT NOT NULL,
	descricao_en TEXT,
	CONSTRAINT nivel_habilidade_descritor_pkey PRIMARY KEY (habilidade_id, nivel),
	CONSTRAINT nivel_habilidade_descritor_habilidade_id_fkey FOREIGN KEY (habilidade_id)
		REFERENCES esco_dataset.habilidade (habilidade_id) ON DELETE CASCADE,
	CONSTRAINT nivel_habilidade_descritor_nivel_fkey FOREIGN KEY (nivel)
		REFERENCES esco_dataset.nivel_habilidade (nivel) ON DELETE CASCADE
);

-- niveis de responsabilidade: nomes e descricoes oficiais PT
UPDATE esco_dataset.nivel_habilidade AS nh SET nome = v.nome, descricao = v.descricao FROM (VALUES
(1, 'Segue', 'Executa tarefas de rotina sob supervisão rigorosa, segue instruções e precisa de orientação para concluir seu trabalho. Aprende e aplica habilidades e conhecimentos básicos. Níveis de responsabilidade: Nível 1 - Segue Essência do nível: Executa tarefas de rotina sob supervisão rigorosa, segue instruções e precisa de orientação para concluir seu trabalho. Aprende e aplica habilidades e conhecimentos básicos.'),
(2, 'Auxilia', 'Presta assistência a outras pessoas, trabalha sob supervisão rotineira e usa critérios próprios para resolver problemas rotineiros. Aprende ativamente por meio de treinamento e experiências no trabalho. Níveis de responsabilidade: Nível 2 - Auxilia Essência do nível: Presta assistência a outras pessoas, trabalha sob supervisão rotineira e usa critérios próprios para resolver problemas rotineiros. Aprende ativamente por meio de treinamento e experiências no trabalho.'),
(3, 'Aplica', 'Executa tarefas variadas, às vezes complexas e não rotineiras, usando métodos e procedimentos padrão. Trabalha sob direção geral, possui alguma liberdade e gerencia seu próprio trabalho dentro dos prazos. Aprimora proativamente as habilidades e o impacto no local de trabalho. Níveis de responsabilidade: Nível 3 - Aplica Essência do nível: Executa tarefas variadas, às vezes complexas e não rotineiras, usando métodos e procedimentos padrão. Trabalha sob direção geral, possui alguma liberdade e gerencia seu próprio trabalho dentro dos prazos. Aprimora proativamente as habilidades e o impacto no local de trabalho.'),
(4, 'Possibilita', 'Realiza diversas atividades complexas, apoia e orienta outras pessoas, delega tarefas quando apropriado, trabalha de forma autônoma sob orientação geral e contribui com conhecimentos especializados para atingir os objetivos da equipe. Níveis de responsabilidade: Nível 4 - Possibilita Essência do nível: Realiza diversas atividades complexas, apoia e orienta outras pessoas, delega tarefas quando apropriado, trabalha de forma autônoma sob orientação geral e contribui com conhecimentos especializados para atingir os objetivos da equipe.'),
(5, 'Garante', 'Fornece orientação autorizada em seu campo e trabalha sob ampla direção. Responsável pela entrega de resultados significativos do trabalho, desde a análise, passando pela execução, até a avaliação. Níveis de responsabilidade: Nível 5 - Garante, aconselha Essência do nível: Fornece orientação autorizada em seu campo e trabalha sob ampla direção. Responsável pela entrega de resultados significativos do trabalho, desde a análise, passando pela execução, até a avaliação.'),
(6, 'Inicia', 'tem influência organizacional significativa, toma decisões de alto nível, molda políticas, demonstra liderança, promove a colaboração organizacional e aceita a responsabilidade em áreas-chave. Níveis de responsabilidade: Nível 6 - Inicia, influencia Essência do nível: tem influência organizacional significativa, toma decisões de alto nível, molda políticas, demonstra liderança, promove a colaboração organizacional e aceita a responsabilidade em áreas-chave.'),
(7, 'Define', 'Opera no mais alto nível organizacional, determina a visão e a estratégia organizacional geral e assume a responsabilidade pelo sucesso geral. Níveis de responsabilidade: Nível 7 - Define estratégia, inspira, mobiliza Essência do nível: Opera no mais alto nível organizacional, determina a visão e a estratégia organizacional geral e assume a responsabilidade pelo sucesso geral.')) AS v(nivel, nome, descricao) WHERE nh.nivel = v.nivel;

-- skills novas (sfia://): nome e descricao oficiais em PT
UPDATE esco_dataset.habilidade SET nome = 'Acessibilidade e Inclusão', descricao = 'Promoção da acessibilidade e inclusão em serviços e produtos.' WHERE habilidade_id = 15222;
UPDATE esco_dataset.habilidade SET nome = 'Classificação analítica e codificação', descricao = 'Interpretação de informações e atribuição de classificações ou rótulos com base em conhecimentos, padrões e diretrizes específicos de domínio para permitir análise e uso de dados.' WHERE habilidade_id = 15224;
UPDATE esco_dataset.habilidade SET nome = 'Desenvolvimento de animações', descricao = 'Projeto e desenvolvimento de sistemas animados e interativos, como jogos, simulações e ambientes virtuais.' WHERE habilidade_id = 15225;
UPDATE esco_dataset.habilidade SET nome = 'Suporte a aplicações', descricao = 'Fornecimento de serviços técnicos, administrativos e de gestão para suportar e manter aplicações em produção.' WHERE habilidade_id = 15226;
UPDATE esco_dataset.habilidade SET nome = 'Gerenciamento da disponibilidade', descricao = 'Garantia de que os serviços forneçam níveis pré-estabelecidos de disponibilidade para atender às necessidades atuais e futuras do negócio.' WHERE habilidade_id = 15227;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de benefícios', descricao = 'Prever, planejar e monitorar o surgimento e a realização efetiva dos benefícios esperados de projetos e programas.' WHERE habilidade_id = 15228;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de cotações e propostas', descricao = 'Gerenciamento da preparação e apresentação de cotações e propostas para contratos, concessões, projetos ou serviços.' WHERE habilidade_id = 15229;
UPDATE esco_dataset.habilidade SET nome = 'Orçamento e previsão', descricao = 'Desenvolver e gerenciar orçamentos e previsões financeiras para permitir a tomada de decisões e a atribuição de recursos eficazes.' WHERE habilidade_id = 15230;
UPDATE esco_dataset.habilidade SET nome = 'Administração de negócios', descricao = 'Gerenciamento e execução de serviços e tarefas administrativas para permitir que indivíduos, equipes e organizações sejam bem sucedidas em seus objetivos.' WHERE habilidade_id = 15231;
UPDATE esco_dataset.habilidade SET nome = 'Modelagem de negócios', descricao = 'Criação de modelos abstratos ou destilados de cenários de negócios, representando processos, dados e funções para apoiar a tomada de decisão e análise.' WHERE habilidade_id = 15232;
UPDATE esco_dataset.habilidade SET nome = 'Gestão da capacidade', descricao = 'Garantia de que os componentes de serviços tenham capacidade e desempenho para atender às necessidades de negócio atuais e futuras.' WHERE habilidade_id = 15233;
UPDATE esco_dataset.habilidade SET nome = 'Operação de esquemas de certificação', descricao = 'Projeto, desenvolvimento e operação de esquemas de certificação e acreditação, incluindo credenciais ou crachás digitais.' WHERE habilidade_id = 15234;
UPDATE esco_dataset.habilidade SET nome = 'Controle de mudanças', descricao = 'Avaliação dos riscos associados às mudanças propostas e garantia de que as mudanças nos produtos, serviços ou sistemas sejam controladas e coordenadas.' WHERE habilidade_id = 15235;
UPDATE esco_dataset.habilidade SET nome = 'Avaliação de competências', descricao = 'Avaliação de conhecimentos, habilidades, competências e comportamentos por qualquer meio, seja formal ou informal, em relação a frameworks como o SFIA.' WHERE habilidade_id = 15236;
UPDATE esco_dataset.habilidade SET nome = 'Gestão da configuração', descricao = 'Planejamento, identificação, controle, prestação de contas e auditoria de itens de configuração (ICs) e suas inter-relações.' WHERE habilidade_id = 15237;
UPDATE esco_dataset.habilidade SET nome = 'Criação e desenho de conteúdo', descricao = 'Planejamento, projeto e criação de conteúdo que atenda às necessidades organizacionais e centradas no usuário, abrangendo informações textuais, conteúdo gráfico e elementos multimídia.' WHERE habilidade_id = 15238;
UPDATE esco_dataset.habilidade SET nome = 'Publicação de conteúdo', descricao = 'Gerenciar processos para coletar, montar e publicar conteúdo em vários canais para atender às necessidades organizacionais e do público.' WHERE habilidade_id = 15239;
UPDATE esco_dataset.habilidade SET nome = 'Gestão da continuidade', descricao = 'Desenvolvimento, implementação e teste de uma estrutura de continuidade de negócios.' WHERE habilidade_id = 15240;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de contratos', descricao = 'Gestão e operação de contratos formais, endereçando as necessidades de fornecedores e clientes em produtos e na prestação de serviços.' WHERE habilidade_id = 15241;
UPDATE esco_dataset.habilidade SET nome = 'Engajamento e fidelidade do cliente', descricao = 'Desenvolvimento e execução de estratégias para atrair, engajar e reter clientes através de comunicações direcionadas e iniciativas de fidelização.' WHERE habilidade_id = 15242;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de dados', descricao = 'Desenvolve e implementa planos, políticas e práticas que controlem, protejam e otimizem o valor dos ativos de dados.' WHERE habilidade_id = 15243;
UPDATE esco_dataset.habilidade SET nome = 'Modelagem e design de dados', descricao = 'Desenvolve modelos e diagramas para representar e comunicar requisitos de dados e ativos de dados.' WHERE habilidade_id = 15244;
UPDATE esco_dataset.habilidade SET nome = 'Gestão da demanda', descricao = 'Analisar e gerenciar proativamente a demanda dos negócios por novos serviços ou modificações em características ou volumes de serviços existentes.' WHERE habilidade_id = 15245;
UPDATE esco_dataset.habilidade SET nome = 'Forense digital', descricao = 'Recuperação e investigação de material encontrado em dispositivos digitais.' WHERE habilidade_id = 15246;
UPDATE esco_dataset.habilidade SET nome = 'Monitoramento de tecnologias emergentes', descricao = 'Identificar e avaliar tecnologias, produtos, serviços, métodos e técnicas novas e emergentes.' WHERE habilidade_id = 15247;
UPDATE esco_dataset.habilidade SET nome = 'Experiência do colaborador', descricao = 'Melhoria no envolvimento dos colaboradores e nas formas de trabalho, empoderando os colaboradores e apoiando sua saúde e bem-estar.' WHERE habilidade_id = 15248;
UPDATE esco_dataset.habilidade SET nome = 'Arquitetura corporativa e de negócios', descricao = 'Alinhar a estratégia de tecnologia da organização com sua missão, estratégia e processos de negócio, documentando isso por meio de modelos arquiteturais.' WHERE habilidade_id = 15249;
UPDATE esco_dataset.habilidade SET nome = 'Avaliação de viabilidade', descricao = 'Definição, avaliação e descrição de opções de mudança de negócios, visando viabilidade financeira, técnica e de negócios e alinhamento estratégico.' WHERE habilidade_id = 15250;
UPDATE esco_dataset.habilidade SET nome = 'Pesquisa formal', descricao = 'Criação sistemática de novos conhecimentos por meio de coleta de dados, inovação, experimentação, avaliação e disseminação.' WHERE habilidade_id = 15251;
UPDATE esco_dataset.habilidade SET nome = 'Testes funcionais', descricao = 'Avaliação de requisitos e características funcionais específicos ou não especificados de produtos, sistemas e serviços através de investigação e testes.' WHERE habilidade_id = 15252;
UPDATE esco_dataset.habilidade SET nome = 'Projeto de hardware', descricao = 'Especificar e projetar sistemas e componentes de hardware para atender aos requisitos definidos, seguindo princípios e padrões de design acordados.' WHERE habilidade_id = 15253;
UPDATE esco_dataset.habilidade SET nome = 'Computação de alto desempenho', descricao = 'Uso de sistemas computacionais avançados e técnicas especiais de programação para resolver problemas computacionais complexos.' WHERE habilidade_id = 15254;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de identidades e acessos', descricao = 'Gerencia a verificação de identidade e as permissões de acesso a sistemas e ambientes organizacionais.' WHERE habilidade_id = 15255;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de incidentes', descricao = 'Coordenar respostas a uma variedade de incidentes para minimizar impactos negativos e restaurar rapidamente os serviços.' WHERE habilidade_id = 15256;
UPDATE esco_dataset.habilidade SET nome = 'Informação e conformidade de dados', descricao = 'Implementar e promover o cumprimento da legislação de gestão de informações e dados.' WHERE habilidade_id = 15257;
UPDATE esco_dataset.habilidade SET nome = 'Garantia da informação', descricao = 'Proteção e gerenciamento de riscos relacionados ao uso, armazenamento e transmissão de dados e sistemas de informação.' WHERE habilidade_id = 15258;
UPDATE esco_dataset.habilidade SET nome = 'Coordenação de sistemas de informação', descricao = 'Coordenar estratégias de informação e tecnologia quando a adoção de uma abordagem comum traria benefícios para a organização.' WHERE habilidade_id = 15259;
UPDATE esco_dataset.habilidade SET nome = 'Projeto de infraestrutura', descricao = 'Projetar infraestrutura tecnológica para atender aos requisitos de negócios, garantindo escalabilidade, confiabilidade, segurança e alinhamento com objetivos estratégicos.' WHERE habilidade_id = 15260;
UPDATE esco_dataset.habilidade SET nome = 'Operações de infraestrutura', descricao = 'Provisionamento, implantação, configuração, operação e otimização de infraestrutura tecnológica em ambientes físicos, virtuais e baseados na nuvem.' WHERE habilidade_id = 15261;
UPDATE esco_dataset.habilidade SET nome = 'Gestão da Inovação', descricao = 'Identifica, prioriza, fomenta e explora oportunidades proporcionadas pelas tecnologias de informação, comunicação e digitais.' WHERE habilidade_id = 15262;
UPDATE esco_dataset.habilidade SET nome = 'Análise e desenho de cargos, funções e perfis', descricao = 'Planejar, analisar e projetar funções e estruturas de trabalho para se alinhar com requisitos, objetivos e cultura organizacionais.' WHERE habilidade_id = 15263;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de treinamento e desenvolvimento', descricao = 'Prestação de serviços de gestão, assessoria e administração para apoiar o desenvolvimento de conhecimentos, habilidades e competências.' WHERE habilidade_id = 15264;
UPDATE esco_dataset.habilidade SET nome = 'Entrega de ensino', descricao = 'Transferência de conhecimento, desenvolvimento de habilidades e mudança de comportamentos usando uma variedade de técnicas, recursos e mídias.' WHERE habilidade_id = 15265;
UPDATE esco_dataset.habilidade SET nome = 'Planejamento e desenvolvimento de ensino', descricao = 'Projeto e desenvolvimento de recursos para transferência de conhecimento, desenvolvimento de habilidades e mudança de comportamentos.' WHERE habilidade_id = 15266;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de campanhas de marketing', descricao = 'Execução, monitoramento e otimização de campanhas de marketing em vários canais para envolver o público-alvo e atingir os resultados desejados.' WHERE habilidade_id = 15267;
UPDATE esco_dataset.habilidade SET nome = 'Medições', descricao = 'Desenvolvimento e operação de capacidades de medição para apoiar as necessidades de informação organizacional acordadas.' WHERE habilidade_id = 15268;
UPDATE esco_dataset.habilidade SET nome = 'Métodos e ferramentas', descricao = 'Liderar a adoção, gestão e otimização de métodos e ferramentas, garantindo uso eficaz e alinhamento com objetivos organizacionais.' WHERE habilidade_id = 15269;
UPDATE esco_dataset.habilidade SET nome = 'Suporte à redes', descricao = 'Prestação de serviços de manutenção e suporte à redes de comunicação.' WHERE habilidade_id = 15270;
UPDATE esco_dataset.habilidade SET nome = 'Testes não funcionais', descricao = 'Avaliar sistemas e serviços para avaliar desempenho, segurança, escalabilidade e outras qualidades não funcionais em relação aos requisitos ou padrões esperados.' WHERE habilidade_id = 15271;
UPDATE esco_dataset.habilidade SET nome = 'Análise numérica', descricao = 'Criação, análise, implementação, teste e aprimoramento de algoritmos para a resolução numérica de problemas matemáticos.' WHERE habilidade_id = 15272;
UPDATE esco_dataset.habilidade SET nome = 'Operações cibernéticas ofensivas', descricao = 'Planeja, executa e gerencia operações de cibersegurança ofensiva, incluindo definição de alvos e análise pós-operacional.' WHERE habilidade_id = 15273;
UPDATE esco_dataset.habilidade SET nome = 'Planejamento e implementação organizacional', descricao = 'Planejamento, projeto e implementação de uma estrutura e cultura organizacional integradas.' WHERE habilidade_id = 15277;
UPDATE esco_dataset.habilidade SET nome = 'Desenvolvimento de capacidade organizacional', descricao = 'Liderança, aconselhamento e suporte à implementação para avaliar as capacidades organizacionais e identificar, priorizar e implementar melhorias.' WHERE habilidade_id = 15274;
UPDATE esco_dataset.habilidade SET nome = 'Facilitação de mudança organizacional', descricao = 'Facilita a mudança cultural e comportamental, permitindo que indivíduos e equipes incorporem novas formas de trabalhar e se adaptem às mudanças.' WHERE habilidade_id = 15275;
UPDATE esco_dataset.habilidade SET nome = 'Facilitação organizacional', descricao = 'Apoio a grupos para implementar princípios e práticas de trabalho eficazes em equipe, através dos limites organizacionais e especialidades profissionais.' WHERE habilidade_id = 15276;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de portfólio', descricao = 'Desenvolvimento e aplicação de uma estrutura de gestão para definir e entregar um portfólio de programas, projetos e/ou serviços em andamento.' WHERE habilidade_id = 15278;
UPDATE esco_dataset.habilidade SET nome = 'Suporte a portfólios, programas e projetos', descricao = 'Fornecimento de suporte e orientações sobre processos, procedimentos, ferramentas e técnicas de gerenciamento de portfólio, programas e projetos.' WHERE habilidade_id = 15279;
UPDATE esco_dataset.habilidade SET nome = 'Testes de processo', descricao = 'Avaliar fluxos de processos documentados e não documentados dentro de um produto, sistema ou serviço em relação às necessidades de negócios através de investigação e testes.' WHERE habilidade_id = 15280;
UPDATE esco_dataset.habilidade SET nome = 'Programação/desenvolvimento de software', descricao = 'Desenvolvimento de componentes de software para entregar valor às partes interessadas.' WHERE habilidade_id = 15281;
UPDATE esco_dataset.habilidade SET nome = 'Engenharia de radiofrequência', descricao = 'Projeto, instalação e manutenção de dispositivos e softwares baseados em radiofrequência (RF).' WHERE habilidade_id = 15282;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de liberação', descricao = 'Gerenciar o lançamento de serviços novos e atualizados para a produção, garantindo a alinhamento com os objetivos de negócios e padrões de conformidade.' WHERE habilidade_id = 15283;
UPDATE esco_dataset.habilidade SET nome = 'Definição e gerenciamento de requisitos', descricao = 'Gerenciamento de requisitos durante todo o ciclo de vida operacional e de entrega.' WHERE habilidade_id = 15284;
UPDATE esco_dataset.habilidade SET nome = 'Avaliação de segurança', descricao = 'Avaliação de sistemas de software e hardware relacionados à segurança, para determinar a conformidade com os padrões e os níveis necessários de integridade de segurança.' WHERE habilidade_id = 15285;
UPDATE esco_dataset.habilidade SET nome = 'Suporte a vendas', descricao = 'Aconselhamento e apoio à força de vendas, clientes e parceiros de vendas.' WHERE habilidade_id = 15286;
UPDATE esco_dataset.habilidade SET nome = 'Aceitação de serviços', descricao = 'Gerenciamento do processo de obtenção da confirmação formal de que os critérios de aceitação de um serviço foram atendidos.' WHERE habilidade_id = 15287;
UPDATE esco_dataset.habilidade SET nome = 'Gerenciamento do catálogo de serviços', descricao = 'Fornecimento de uma fonte de informações consistentes sobre serviços e produtos disponíveis para clientes e usuários.' WHERE habilidade_id = 15288;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de nível de serviço', descricao = 'Acordo de metas para níveis de serviço e avaliação, monitoramento e gerenciamento da entrega de serviços em relação a metas.' WHERE habilidade_id = 15289;
UPDATE esco_dataset.habilidade SET nome = 'Configuração de software', descricao = 'Projeto e implantação de configurações de produtos de software em ambientes ou plataformas de software.' WHERE habilidade_id = 15290;
UPDATE esco_dataset.habilidade SET nome = 'Consultoria especializada', descricao = 'Fornecer aconselhamento confiável e orientação profissional especializada em uma área específica.' WHERE habilidade_id = 15291;
UPDATE esco_dataset.habilidade SET nome = 'Gestão de armazenamento de dados', descricao = 'Provisionamento, configuração e otimização de soluções de armazenamento em local e baseadas na nuvem, garantindo disponibilidade de dados, segurança e alinhamento com objetivos de negócios.' WHERE habilidade_id = 15292;
UPDATE esco_dataset.habilidade SET nome = 'Desenvolvimento de conteúdo programático', descricao = 'Especificação, projeto e desenvolvimento de conteúdos programáticos dentro de um ambiente educacional estruturado e sistemático.' WHERE habilidade_id = 15293;
UPDATE esco_dataset.habilidade SET nome = 'Administração de software de sistema', descricao = 'Instalar, gerenciar e manter sistemas operacionais, gerenciamento de dados, automação de escritórios e software de utilidades em vários ambientes de infraestrutura.' WHERE habilidade_id = 15297;
UPDATE esco_dataset.habilidade SET nome = 'Projeto de sistemas', descricao = 'Projeto de sistemas para atender aos requisitos especificados e arquiteturas de sistemas pré-estabelecidas.' WHERE habilidade_id = 15294;
UPDATE esco_dataset.habilidade SET nome = 'Instalação e remoção de sistemas', descricao = 'Instalação e teste, ou desativação e remoção de sistemas ou componentes de sistema.' WHERE habilidade_id = 15295;
UPDATE esco_dataset.habilidade SET nome = 'Integração e construção de sistemas', descricao = 'Planejar, implementar e controlar atividades para integrar elementos de sistema, subsistemas e interfaces para criar sistemas operacionais, produtos ou serviços.' WHERE habilidade_id = 15296;
UPDATE esco_dataset.habilidade SET nome = 'Gerenciamento de serviços de tecnologia', descricao = 'Gerenciamento da prestação de serviços baseados em tecnologia para atender necessidades organizacionais definidas.' WHERE habilidade_id = 15299;
UPDATE esco_dataset.habilidade SET nome = 'Teste de aceitação do usuário', descricao = 'Validação de sistemas, produtos, processos comerciais ou serviços para determinar se os critérios de aceitação foram atendidos.' WHERE habilidade_id = 15300;
UPDATE esco_dataset.habilidade SET nome = 'Análise da experiência do usuário', descricao = 'Compreensão do contexto de uso de sistemas, produtos e serviços e especificação de requisitos de experiência do usuário e objetivos de projeto.' WHERE habilidade_id = 15301;
UPDATE esco_dataset.habilidade SET nome = 'Design da experiência do usuário', descricao = 'Produção de conceitos de projeto e protótipos para interações com o usuário e experiências com um produto, sistema ou serviço.' WHERE habilidade_id = 15302;
UPDATE esco_dataset.habilidade SET nome = 'Avaliação da experiência do usuário', descricao = 'Validar sistemas, produtos ou serviços em relação a metas, métricas e objetivos de experiência do usuário.' WHERE habilidade_id = 15303;
UPDATE esco_dataset.habilidade SET nome = 'Avaliação de vulnerabilidades', descricao = 'Identificação e classificação de vulnerabilidades de segurança em redes, sistemas e aplicativos e mitigação ou eliminação do seu impacto.' WHERE habilidade_id = 15304;
UPDATE esco_dataset.habilidade SET nome = 'Pesquisa de vulnerabilidades', descricao = 'Condução de pesquisas aplicadas para identificar, avaliar e mitigar vulnerabilidades e fraquezas de segurança novas ou desconhecidas.' WHERE habilidade_id = 15305;
UPDATE esco_dataset.habilidade SET nome = 'Planejamento da força de trabalho', descricao = 'Projeção estratégica da demanda por pessoas e habilidades e planejamento proativo da oferta de mão de obra para atender às necessidades organizacionais.' WHERE habilidade_id = 15306;

-- descritores especificos por habilidade x nivel (texto oficial PT)
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(15222, 2, 'Ajuda com testes básicos de acessibilidade e coleta de informações para revisões de acessibilidade.
Dá suporte aos membros da equipe na execução de testes de acessibilidade predefinidos.
Documenta testes de resultados e contribui para relatórios de auditoria de acessibilidade.', 'Assists with basic accessibility testing and gathering information for accessibility reviews.
Supports team members in executing predefined accessibility tests.
Documents test results and contributes to accessibility audit reports.'),
(15222, 3, 'Analisa requisitos de acessibilidade e informações técnicas.
Desenvolve e executa testes de acessibilidade sob orientação. Relata as conclusões de forma estruturada e faz recomendações iniciais de conformidade.
Suporta revisões e auditorias de acessibilidade.
Escala questões complexas para colegas seniores.', 'Analyses accessibility requirements and technical information.
Designs and executes accessibility tests under direction. Reports findings in a structured way and makes initial recommendations for compliance.
Supports accessibility reviews and audits.
Escalates complex issues to senior colleagues.'),
(15222, 4, 'Interage com as partes interessadas para explicar os fatores de acessibilidade.
Influenciar projetos para melhorar a acessibilidade. Fornece análises de acessibilidade detalhadas para informar decisões ao longo do ciclo de vida do produto ou serviço.
Planeja e gerencia testes de acessibilidade para atender aos padrões acordados.
Avalia o cumprimento das regulamentações de acessibilidade. Avalia riscos com base nos resultados dos testes.', 'Engages with stakeholders to explain accessibility factors.
Influences designs to improve accessibility. Provides detailed accessibility analysis to inform decisions throughout the product or service lifecycle.
Plans and manages accessibility testing to meet agreed standards.
Evaluates compliance with accessibility regulations. Assesses risks based on test outcomes.'),
(15222, 5, 'Conduz atividades de governança e garantia de acessibilidade.
Interpreta sistemas complexos para identificar oportunidades de melhorar a acessibilidade. Proporciona aconselhamento especializado para impulsionar a conformidade de acessibilidade em produtos, serviços e projetos.
Define abordagens de testes de acessibilidade organizacional alinhadas com regulamentos e padrões.
Promover a conscientização sobre acessibilidade e princípios de inclusão.', 'Leads accessibility governance and assurance activities.
Interprets complex systems to identify opportunities for improved accessibility. Provides expert advice to drive accessibility compliance across products, services and projects.
Defines organisational accessibility testing approaches, aligned with regulations and standards.
Promotes awareness of accessibility and inclusion principles.'),
(15222, 6, 'Define a direção estratégica da organização para a acessibilidade e inclusão em produtos e serviços.
Define e supervisionar processos de governança para garantir a conformidade. Conduz o desenvolvimento de políticas, normas e diretrizes de acessibilidade.
Colabora com organismos da indústria e especialistas para desenvolver e implementar boas práticas de trabalho.
Promove uma cultura de utilização proativa da acessibilidade no projeto e desenvolvimento. Assegura recursos e habilidades adequados para a garantia de acessibilidade.', 'Sets the organisation''s strategic direction for accessibility and inclusion in products and services.
Defines and oversees governance processes to ensure compliance. Leads the development of accessibility policies, standards and guidelines.
Engages with industry bodies and experts to develop and implement good working practices.
Drives a culture of proactive accessibility consideration in design and development. Ensures adequate resources and skills for accessibility assurance.'),
(15224, 2, 'Atribui, com precisão, classificações / rótulos a informações de baixa complexidade sob supervisão.
Compreende e aplica sistemas de classificação / rotulagem relevantes, padrões e diretrizes.
Participa em atividades de garantia de qualidade, como revisão por pares ou verificações por supervisores.', 'Accurately assigns classifications/labels to low complexity information under supervision.
Understands and applies relevant classification/labelling systems, standards and guidelines.
Participates in quality assurance activities such as peer review or supervisor checks.'),
(15224, 3, 'Atribui, de forma independente, classificações / rótulos precisos a uma ampla gama de informações.
Interpreta informações complexas e escolhe classificações / rótulos apropriados.
Participa em iniciativas de melhoria da qualidade da equipe.
Assegura e orienta os outros sobre práticas de classificação / rótulo.', 'Independently assigns accurate classifications/labels to a broad range of information.
Interprets complex information and chooses appropriate classifications/labels.
Participates in team quality improvement initiatives.
Advises and guides others on classification/labelling practices.'),
(15224, 4, 'Atribui classificações / rótulos a informações altamente complexas.
Realiza verificações de garantia de qualidade sobre o trabalho de outras pessoas. Investiga e corrige erros complexos de classificação / rotulagem.
Fornece treinamento para membros da equipe.
Contribui para o desenvolvimento de processos e diretrizes de classificação / rotulagem.', 'Assigns classifications/labels to highly complex information.
Performs quality assurance checks on the work of others. Investigates and corrects complex classification/labelling errors.
Delivers training to team members.
Contributes to the development of classification/labelling processes and guidelines.'),
(15224, 5, 'Lidera a equipe de garantia de qualidade e treinamento para classificação / rotulagem de informações.
Desenvolve e implementa metodologias de auditoria para avaliar a precisão e consistência de classificação e rotulagem.
Colabora com especialistas para aprimorar a qualidade das informações de origem. Analisa e emite relatórios sobre a qualidade de classificação / rotulagem.
Contribui para a estratégia de classificação / rotulagem de informações organizacionais.', 'Leads team quality assurance and training for information classification/labelling.
Develops and implements audit methodologies for assessing classification and labelling accuracy and consistency.
Collaborates with subject matter experts to improve source information quality. Analyses and reports on classification/labelling quality.
Contributes to organisational information classification/labelling strategy.'),
(15224, 6, 'Define padrões, políticas e procedimentos de classificação / rotulagem de informações organizacionais.
Planeja e supervisiona programas de auditoria de qualidade.
Lida com intervenções estratégicas para melhorar a classificação / rotulagem de informações.
Interage com organismos da indústria e colabora para definir e melhorar padrões e práticas de trabalho.', 'Sets organisational information classification/labelling standards, policies and procedures.
Designs and oversees quality audit programmes.
Leads strategic interventions to improve information classification/labelling.
Engages with industry bodies and collaborates to define and improve standards and working practices.'),
(15225, 2, 'Ajuda na criação de componentes básicos visuais e de áudio para animações sob supervisão de rotina.
Segue procedimentos e diretrizes estabelecidos e contribui para o desenvolvimento de animações simples utilizando ferramentas padrão.
Ajuda a criar e manter documentação.', 'Assists in the creation of basic visual and audio components for animations under routine supervision.
Follows established procedures and guidelines and contributes to the development of simple animations using standard tools.
Helps create and maintain documentation.'),
(15225, 3, 'Constrói componentes visuais e de áudio usando softwares de animação.
Utiliza ferramentas de projeto para desenvolver protótipos rápidos de sistemas interativos e interfaces de usuário.
Utiliza ferramentas de projeto visual e técnicas de modelagem orgânica para criar e animar personagens virtuais dentro de um jogo ou projeto de sistema', 'Builds visual and audio components using animation software.
Uses design tools to evolve rapid prototypes of interactive systems and user interfaces.
Uses visual design tools and organic modelling techniques to create and animate virtual characters within a game or system design.'),
(15225, 4, 'Constrói componentes visuais e de áudio e os integra à estrutura do sistema.
Utiliza ferramentas de projeto para desenvolver protótipos rápidos e avaliar a viabilidade de conceitos de projeto para sistemas interativos e interfaces de usuário.
Utiliza ferramentas complexas de projeto visual e técnicas de modelagem orgânica para criar e animar personagens virtuais dentro de um projeto de jogo ou sistema.', 'Builds visual and audio components and integrates them into the system structure.
Uses design tools to evolve rapid prototypes and assess the viability of design concepts for interactive systems and user interfaces.
Uses complex visual design tools and organic modelling techniques to create and animate virtual characters within a game or system design.'),
(15225, 5, 'Gerencia iterações de projeto de nível e narrativa, documentando o fluxo global e a arquitetura de um jogo ou sistema similar.
Desenvolve estruturas conceituais em planos de projeto para criar estruturas de alto nível e arquiteturas de tempo de execução para sites e ambientes virtuais.
Supervisiona a integração de animações com a lógica do jogo, a física e os sistemas de inteligência artificial.', 'Manages iterations of level design and storytelling, documenting the overall flow and architecture of a game or similar system.
Develops conceptual structures into design blueprints to create high-level structures and runtime architectures for websites and virtual environments.
Oversees the integration of animations with game logic, physics and artificial intelligence systems.'),
(15225, 6, 'Fornece orientação criativa global na concepção e projeto de produtos de animação, como jogos e simulações.
Estabelece estratégias de desenvolvimento de animação, pipelines e processos de garantia de qualidade.
Adapta ou desenvolve novos métodos e capacidades organizacionais e impulsiona a adoção e adesão de políticas e normas.', 'Provides overall creative direction in the conception and design of animation products such as games and simulations.
Establishes animation development strategies, pipelines and quality assurance processes.
Adapts or develops new methods and organisational capabilities and drives adoption of, and adherence to, policies and standards.'),
(15226, 2, 'Auxilia nos procedimentos de manutenção especificados.
Auxilia na investigação e resolução de problemas relacionados a aplicações.', 'Assists with specified maintenance procedures.
Assists in the investigation and resolution of issues relating to applications.'),
(15226, 3, 'Segue os procedimentos acordados para identificar e resolver problemas com aplicações.
Utiliza softwares e ferramentas de gerenciamento de aplicações para coletar estatísticas de desempenho pré-estabelecidas.
Executa tarefas pré-estabelecidas de manutenção de aplicações.', 'Follows agreed procedures to identify and resolve issues with applications.
Uses application management software and tools to collect agreed performance statistics.
Carries out agreed applications maintenance tasks.'),
(15226, 4, 'Mantém os processos de suporte a aplicações e verifica se todas as solicitações de suporte são tratadas de acordo com os procedimentos acordados.
Utiliza softwares e ferramentas de gerenciamento de aplicações para investigar problemas, coletar estatísticas de desempenho e produzir relatórios.', 'Maintains application support processes and checks that all requests for support are dealt with according to agreed procedures.
Uses application management software and tools to investigate issues, collect performance statistics and create reports.'),
(15226, 5, 'Garante que todas as solicitações de suporte sejam tratadas de acordo com os padrões e procedimentos estabelecidos.
Elabora e mantém procedimentos e documentação para suporte a aplicações.
Gerencia aprimoramentos de aplicações para melhorar o desempenho do negócio.
Fornece aconselhamento sobre segurança de aplicações, licenciamento, atualizações, backups e necessidades de recuperação de desastres.', 'Ensures all requests for support are dealt with according to set standards and procedures.
Drafts and maintains procedures and documentation for applications support, incorporating security considerations.
Manages application enhancements to improve business performance.
Advises on application security, licensing, upgrades, backups and disaster recovery needs.'),
(9610, 2, 'Utiliza procedimentos previamente acordados para criar e manter um registro preciso de ativos.
Desempenha atividades relacionadas à administração de ativos.
Produz relatórios de rotina para auxiliar as atividades de gestão de ativos e a tomada de decisões.', 'Uses agreed procedures to create and maintain an accurate register of assets.
Performs activities related to the administration of assets.
Produces routine reports to assist asset management activities and decision-making.'),
(9610, 3, 'Aplica ferramentas, técnicas e processos para criar e manter um registro de ativos preciso.
Produz relatórios e análises para apoiar as atividades de gestão de ativos e auxiliar a tomada de decisões.', 'Applies tools, techniques and processes to create and maintain an accurate asset register.
Produces reports and analysis to support asset management activities and aid decision-making.'),
(9610, 4, 'Controla ativos em uma ou mais áreas significativas, garantindo que a administração do ciclo de vida completo dos ativos seja realizada.
Produz e analisa registros e históricos de ativos autorizados e verifica se todos esses ativos estão em estado e localização conhecidos.
Atua para destacar e resolver possíveis situações de ativos não autorizados.', 'Controls assets in one or more significant areas ensuring administration of full lifecycle of assets is carried out.
Produces and analyses registers and histories of authorised assets and verifies that all of these assets are in a known state and location.
Acts to highlight and resolve potential instances of unauthorised assets.'),
(9610, 5, 'Gerencia e mantém a conformidade do serviço de TI e dos ativos de serviço em alinhamento com os requisitos do negócio e requisitos regulatórios.
Identifica, avalia e comunica os riscos associados.
Garante que os controladores de ativos, as equipes de infraestrutura e de negócios coordenem e otimizem o valor, mantenham o controle e a conformidade legal apropriada.', 'Manages and maintains the service compliance of IT and service assets in line with business and regulatory requirements.
Identifies, assesses and communicates associated risks.
Ensures asset controllers, infrastructure teams and the business co-ordinate and optimise value, maintain control and maintain appropriate legal compliance.'),
(9610, 6, 'Define a estratégia de gerenciamento de ativos em toda a organização.
Comunica a política, governança, escopo e funções envolvidas no gerenciamento de ativos.
Promove a conscientização e o compromisso do papel da gestão de ativos na contínua prestação de serviços econômica e eficaz. Fornece informações e aconselhamento sobre questões complexas de gerenciamento de ativos.
Inicia a avaliação de impacto resultante de decisões para obter, alterar ou manter a posse ou uso de um ativo, sistema ou serviço.', 'Sets the strategy for asset management across the organisation.
Communicates the policy, governance, scope and roles involved in asset management.
Promotes awareness of and commitment to the role of asset management in the continuing economic and effective provision of services. Provides information and advice on complex asset management issues.
Initiates impact assessment arising from decisions to obtain, change or continue the possession or use of an asset, system or service.'),
(8048, 2, 'Ajuda na coleta de evidências e na realização de atividades de auditoria sob supervisão rotineira.
Mantém documentação e rastreio de auditoria.
Ajuda a identificar e reportar problemas e discrepâncias.', 'Assists in collecting evidence and conducting audit activities under routine supervision.
Maintains documentation and audit trails.
Helps identify and report issues and discrepancies.'),
(8048, 3, 'Adota uma abordagem estruturada para executar e documentar as atividades de campo de auditoria, seguindo padrões acordados.
Mantém a integridade dos registros para dar suporte e atender as trilhas de auditoria.
Identifica indicadores de risco típicos e explica medidas de prevenção.', 'Adopts a structured approach to executing and documenting audit fieldwork, following agreed standards.
Maintains integrity of records to support and satisfy audit trails.
Identifies typical risk indicators and explains prevention measures.'),
(8048, 4, 'Contribui para o planejamento e execução de auditoria baseada nos riscos dos processos, produtos, sistemas e serviços existentes e planejados.
Identifica e documenta riscos em detalhes.
Identifica a causa raiz dos problemas durante uma auditoria e os comunica efetivamente como insights de risco.
Reúne evidências sobre a interpretação e implementação de medidas de controle. Prepara e comunica relatórios às partes interessadas, fornecendo uma base real para os resultados.', 'Contributes to planning and executing of risk-based audit of existing and planned processes, products, systems and services.
Identifies and documents risks in detail.
Identifies the root cause of issues during an audit and communicates these effectively as risk insights.
Collates evidence regarding the interpretation and implementation of control measures. Prepares and communicates reports to stakeholders, providing a factual basis for findings.'),
(8048, 5, 'Planeja, organiza e conduz auditorias de áreas de domínios complexas, áreas multifuncionais e em toda a cadeia de suprimentos.
Confirma o escopo e os objetivos das atividades específicas de auditoria com a administração. Alinha-se com o escopo do programa de auditoria e as políticas organizacionais.
Determina os métodos apropriados de investigação para atingir os objetivos da auditoria. Apresenta os resultados da auditoria à administração, descrevendo a eficácia e eficiência dos mecanismos de controle.
Fornece aconselhamento geral e específico sobre auditoria. Colabora com profissionais de especialidades relacionadas para desenvolver e integrar resultados.', 'Plans, organises and conducts audits of complex domains areas, cross-functional areas and across the supply chain.
Confirms the scope and objectives of specific audit activities with management. Aligns with the scope of the audit programme and organisational policies.
Determines appropriate methods of investigation to achieve the audit objectives. Presents audit findings to management describing the effectiveness and efficiency of control mechanisms.
Provides general and specific audit advice. Collaborates with professionals in related specialisms to develop and integrate findings.'),
(8048, 6, 'Lidera e gerencia auditorias complexas e programas de atividades de auditoria.
Obtém e gerencia o conhecimento especializado apropriado para contribuir com conhecimentos técnicos e experiência altamente especializados.
Desenvolve políticas organizacionais, normas e diretrizes para a condução de auditorias. Garante a objetividade e imparcialidade dos processos de auditoria.
Identifica áreas de risco e especifica programas de auditoria. Garante que a amplitude da auditoria seja suficiente para fornecer ao negócio a garantia de adequação e integridade. Autoriza a emissão de relatórios formais à administração sobre a eficácia e eficiência dos mecanismos de controle.', 'Leads and manages complex audits and programmes of audit activity.
Obtains and manages appropriate specialist expertise to contribute highly specialised technical knowledge and experience.
Develops organisational policies, standards and guidelines for the conduct of audits. Ensures the objectivity and impartiality of the audit process.
Identifies areas of risk and specifies audit programmes. Ensures audit coverage is sufficient to provide the business with assurance of adequacy and integrity. Authorises the issue of formal reports to management on the effectiveness and efficiency of control mechanisms.'),
(8048, 7, 'Dirige a definição e implementação da função de auditoria da organização e supervisiona a sua comunicação às partes interessadas.
Define a estratégia de auditoria, planeja ciclos de auditoria e garante a cobertura adequada em toda a organização. Garante que a função de auditoria agregue valor. Faz a ligação com as partes interessadas para garantir que a cobertura da auditoria seja relevante e compreendida.
Direciona o uso da análise de risco para identificar áreas para revisão. Garante que recursos apropriados estejam disponíveis para atender aos requisitos organizacionais para auditorias.
Reporta ao nível mais alto sobre descobertas, relevância e recomendações para melhoria da atividade de auditoria.', 'Directs the definition and implementation of the organisation''s audit function, and oversees its communication to stakeholders.
Defines audit strategy, plans audit cycles and ensures appropriate coverage across the organisation. Ensures the audit function adds value. Liaises with stakeholders to ensure audit coverage is relevant and understood.
Directs use of risk analysis to identify areas for review. Ensures appropriate resources are available to deliver organisational requirements for audits.
Reports to the most senior level on findings, relevance and recommendations for improvement of audit activity.'),
(15227, 3, 'Executa tarefas definidas de gerenciamento de disponibilidade, como monitoramento de rotina e coleta de dados.
Teste procedimentos de recuperação de desastre sob orientação e contribui para a documentação dos planos de recuperação.
Ajuda com o funcionamento de ferramentas e processos de gerenciamento de disponibilidade.
Monitora componentes de serviço em relação aos padrões de desempenho acordados e reporta quaisquer desvios.', 'Performs defined availability management tasks, such as routine monitoring and data collection.
Tests disaster recovery procedures under direction and contributes to the documentation of recovery plans.
Assists with the operation of availability management tools and processes.
Monitors service components against agreed performance standards and reports any deviations.'),
(15227, 4, 'Analisa a disponibilidade, confiabilidade e facilidade de manutenção de serviços e componentes.
Contribui para o processo de gerenciamento de disponibilidade e sua operação.
Monitora e mantém serviços e componentes para garantir a conformidade contínua com os objetivos de desempenho e níveis de serviço acordados.
Implementa arranjos de recuperação de desastres e documenta procedimentos de recuperação. Realiza testes de procedimentos de recuperação.', 'Analyses service and component availability, reliability, maintainability and serviceability.
Contributes to the availability management process and its operation.
Monitors and maintains services and components to ensure ongoing compliance with agreed performance targets and service levels.
Implements disaster recovery arrangements and documents recovery procedures. Conducts testing of recovery procedures.'),
(15227, 5, 'Oferece aconselhamento e orientação sobre o planejamento, projeto e melhoria do serviço e disponibilidade de componentes.
Investiga todas as violações de metas de disponibilidade e indisponibilidade de serviço e inicia atividades corretivas.
Desenvolve planos para recuperação de desastres, juntamente com processos de suporte.
Gerencia o teste de planos de recuperação de desastres.', 'Provides advice and guidance on the planning, design and improvement of service and component availability.
Investigates all breaches of availability targets and service non-availability and initiates remedial activities.
Develops plans for disaster recovery together with supporting processes.
Manages the testing of disaster recovery plans.'),
(15227, 6, 'Define políticas e desenvolve estratégias, planos e processos para garantir que os serviços entreguem os níveis de disponibilidade pré-estabelecidos.
Desenvolve e implementa novas ferramentas e técnicas de disponibilidade.', 'Sets policy and develops strategies, plans and processes to ensure services deliver agreed levels of availability.
Develops and implements new availability tools and techniques.'),
(15228, 3, 'Apoia a identificação e o acompanhamento de benefícios para projetos e programas.
Coleta dados para medir a realização dos benefícios.', 'Supports the identification and tracking of benefits for projects and programmes.
Collects data to measure benefits realisation.'),
(15228, 4, 'Contribui para o desenvolvimento e implementação de planos de gestão de benefícios para projetos e programas.
Engaja-se com as partes interessadas para identificar e quantificar benefícios e para estabelecer métricas e mecanismos de acompanhamento da realização dos benefícios.
Monitora e relata o progresso em direção à realização dos benefícios.
Identifica riscos e problemas que possam impactar a entrega dos benefícios e os escala conforme apropriado. Apoia a incorporação das práticas de gestão de benefícios em toda a organização.', 'Contributes to the development and implementation of benefits management plans for projects and programmes.
Engages with stakeholders to identify and quantify benefits and to establish metrics and mechanisms for tracking benefits realisation.
Monitors and reports on progress towards benefits realisation.
Identifies risks and issues that may impact benefits delivery and escalates as appropriate. Supports the embedding of benefits management practices across the organisation.'),
(15228, 5, 'Lidera as atividades necessárias para a realização dos benefícios de cada parte do programa de mudança.
Identifica métricas e mecanismos específicos para medir os benefícios e planeja a ativação desses mecanismos no momento adequado. Monitora os benefícios em relação ao previsto no caso de negócio.
Garante que todos os participantes estejam envolvidos ao longo do programa de mudança e totalmente preparados para aproveitar o novo ambiente operacional.
Apoia os gerentes operacionais para assegurar que todos os planos, pacotes de trabalho e entregas estejam alinhados com os benefícios esperados.', 'Leads activities required in the realisation of the benefits of each part of the change programme.
Identifies specific metrics and mechanisms to measure benefits and plans to activate these mechanisms at the required time. Monitors benefits against what was predicted in the business case.
Ensures all participants are engaged throughout the change programme and fully prepared to exploit the new operational business environment.
Supports operational managers to ensure all plans, work packages and deliverables are aligned with the expected benefits.'),
(15228, 6, 'Trabalha com gerentes operacionais para garantir que os melhores níveis de melhorias sejam feitos à medida que grupos de projetos entreguem os seus produtos em uso operacional.
Comunica a visão do programa de mudança aos colaboradores em todos os níveis da organização, mantendo o foco nos objetivos do negócio.
Mantém o caso de negócio para o financiamento do programa e confirma, em intervalos regulares, a viabilidade contínua do programa para a organização.', 'Works with operational managers to ensure maximum improvements are made as groups of projects deliver their products into operational use.
Communicates the change programme vision to staff at all levels of the business and keeps a focus on business objectives.
Maintains the business case for funding the programme and confirms continuing business viability of the programme at regular intervals.'),
(15229, 3, 'Apoia o desenvolvimento de propostas por meio da análise de documentos e revisão interna.
Compreende e analisa documentos e requisitos de propostas, prepara projetos de resposta inicial que estejam alinhados com as capacidades da organização e as necessidades das partes interessadas.
Comunica-se com as partes interessadas internas para reunir as informações necessárias e esclarecer os requisitos de propostas.
Assegura que as respostas de propostas atendam aos padrões básicos de conformidade e estejam alinhadas com os requisitos especificados e as capacidades organizacionais.', 'Supports the development of proposals by engaging in document analysis and internal review.
Understands and analyses bid documents and requirements, preparing initial response drafts that align with the organisation''s capabilities and stakeholder needs.
Communicates with internal stakeholders to gather necessary information and clarify proposal requirements.
Ensures proposal responses meet basic compliance standards and align with the specified requirements and organisational capabilities.'),
(15229, 4, 'Lidera a criação de propostas de pequeno a médio porte, integrando análise técnica a um contexto mais amplo.
Coordena esforços da equipe, molda a estrutura de propostas e aborda aspectos financeiros, incluindo orçamento e estratégias de preços.
Identifica e gerencia os riscos das propostas, garantindo o cumprimento oportuno das expectativas das partes interessadas.
Engaja-se com as partes interessadas e molda a estrutura e o conteúdo da proposta com base em discussões detalhadas e feedback.', 'Leads the creation of small to medium proposals, integrating technical analysis and broader context.
Coordinates team efforts, shapes the proposal structure and addresses financial aspects including budgeting and pricing strategies.
Identifies and manages proposal risks, ensuring timely compliance with stakeholder expectations.
Engages with stakeholders and shapes proposal structure and content based on in-depth discussions and feedback.'),
(15229, 5, 'Dirige a formulação e execução de propostas significativas, gerencia o processo desde a avaliação inicial até a apresentação final.
Supervisiona propostas significativas, alinha-as com estratégias organizacionais e gerencia o processo do início à apresentação.
Colabora com stakeholders de alto nível, negocia com stakeholders-chave e garante parcerias vantajosas.
Refina e otimiza o processo de desenvolvimento de propostas para eficiência e eficácia.', 'Leads the formulation and execution of significant proposals, managing the process from initial evaluation to final submission.
Oversees significant proposals, aligning them with organisational strategies and managing the process from inception to submission.
Collaborates with high-level stakeholders, negotiates with key stakeholders and secures advantageous partnerships.
Refines and optimises the proposal development process for efficiency and effectiveness.'),
(15229, 6, 'Dirige grandes iniciativas de propostas, concebe estratégias de engajamento e promove a excelência nas práticas de propostas em toda a organização.
Influencia políticas e estratégias organizacionais na gestão de propostas, estabelecendo padrões e expectativas.', 'Directs major proposal initiatives, devising engagement strategies and promoting excellence in proposal practices throughout the organisation.
Influences organisational policies and strategies in proposal management, setting standards and expectations.'),
(9363, 4, 'Contribui para o desenvolvimento e implementação de elementos e diretrizes de identidade de marca.
Apoia a pesquisa e análise de marca.
Assegura a aplicação consistente de padrões de marca em todos os projetos atribuídos.
Monitora métricas de desempenho de marca e reporta as principais descobertas.', 'Contributes to the development and implementation of brand identity elements and guidelines.
Supports brand research and analysis.
Ensures consistent application of brand standards across assigned projects.
Monitors brand performance metrics and reports on key findings.'),
(9363, 5, 'Lidera o desenvolvimento e execução de estratégias e planos de marca.
Define posicionamento de marca, valores e proposição de valor. Aplica princípios de arquitetura de marca para gerenciar o portfólio de marca.
Realiza análises de desempenho de marca em profundidade e fornece recomendações estratégicas.
Usa abordagens criativas para diferenciar a marca. Colabora com partes interessadas internas e externas para alinhar as iniciativas de marca com os objetivos de negócio.', 'Leads the development and execution of brand strategies and plans.
Defines brand positioning, values and value proposition. Applies principles of brand architecture to manage brand portfolio.
Conducts in-depth brand performance analysis and provides strategic recommendations.
Uses creative approaches to differentiate the brand. Collaborates with internal and external stakeholders to align brand initiatives with business objectives.'),
(9363, 6, 'Estabelece a visão global, a estratégia e a governança da marca da organização.
Supervisiona a pesquisa, análise e planejamento estratégico da marca.
Avalia o desempenho e a equidade da marca, tomando decisões para melhorar o valor da marca e os resultados organizacionais. Assegura o alinhamento da estratégia da marca com os objetivos organizacionais e a dinâmica do mercado.
Governa a aplicação da identidade visual e dos ativos distintivos da marca em toda a organização.', 'Establishes the overall brand vision, strategy and governance for the organisation.
Oversees brand research, analysis and strategic planning.
Evaluates brand performance and equity, making decisions to enhance brand value and organisational outcomes. Ensures alignment of brand strategy with organisational goals and market dynamics.
Governs the application of visual identity and distinctive brand assets across the organisation.'),
(15230, 2, 'Auxilia na coleta de dados financeiros e preparação de modelos básicos de orçamento sob supervisão.
Apoia o processo de orçamento e previsão completando tarefas atribuídas.', 'Assists in gathering financial data and preparing basic budget templates under supervision.
Supports the budgeting and forecasting process by completing assigned tasks.'),
(15230, 3, 'Realiza tarefas específicas no processo de orçamento e previsão, incluindo análise de dados e preparação de relatórios, utilizando métodos padrão.
Identifica e resolve problemas rotineiros de orçamento e previsão.
Comunica informações de orçamento e previsão às partes interessadas relevantes.', 'Performs specified tasks in the budgeting and forecasting process, including data analysis and report preparation, using standard methods.
Identifies and resolves routine budgeting and forecasting issues.
Communicates budget and forecast information to relevant stakeholders.'),
(15230, 4, 'Contribui para a elaboração de orçamentos e previsões para áreas específicas de responsabilidade.
Coleta e analisa dados financeiros e prepara modelos de orçamento e relatórios.
Apoia a comunicação e colaboração entre as partes interessadas no processo de orçamento e previsão.', 'Contributes to the development of budgets and forecasts for specific areas of responsibility.
Gathers and analyses financial data and prepares budget templates and reports.
Supports stakeholder communication and collaboration in the budgeting and forecasting process.'),
(15230, 5, 'Lidera o desenvolvimento de orçamentos e previsões para um departamento ou função.
Fornece aconselhamento e orientação especializada sobre práticas de orçamento e previsão. Seleciona e aplica metodologias e ferramentas apropriadas para orçamento e previsão.
Incorpora o planejamento de cenários, a análise de sensibilidade e a avaliação de riscos no processo de orçamento e previsão.
Colabora com as partes interessadas para alinhar orçamentos e previsões aos objetivos organizacionais e métricas de negócio.', 'Leads the development of budgets and forecasts for a department or function.
Provides authoritative advice and guidance on budgeting and forecasting practices. Selects and applies appropriate budgeting and forecasting methodologies and tools.
Incorporates scenario planning, sensitivity analysis and risk assessment into the budgeting and forecasting process.
Collaborates with stakeholders to align budgets and forecasts with organisational objectives and business metrics.'),
(15230, 6, 'Desenvolve e implementa estratégias, políticas e processos de orçamento e previsão alinhados aos objetivos gerais da organização e métricas de negócio.
Promove a adoção de boas práticas de trabalho em toda a organização.
Supervisiona o desenvolvimento de modelos financeiros complexos e análises de cenários para apoiar a tomada de decisões estratégicas. Fornece percepções e recomendações para otimizar investimentos e alocação de recursos.
Colabora com líderes seniores para garantir que os orçamentos e previsões sustentem os objetivos organizacionais de longo prazo e impulsionem a criação de valor. Define a visão e a direção para as práticas de orçamento e previsão.', 'Develops and implements budgeting and forecasting strategies, policies and processes aligned with overall organisational objectives and business metrics.
Drives the adoption of good working practices across the organisation.
Oversees the development of complex financial models and scenario analyses to support strategic decision-making. Provides insights and recommendations to optimise investments and resource allocation.
Collaborates with senior leaders to ensure budgets and forecasts support long-term organisational goals and drive value creation. Sets the vision and direction for budgeting and forecasting practices.'),
(15231, 1, 'Executa tarefas administrativas de rotina em um ambiente estruturado.
Segue procedimentos claros. Utiliza softwares de escritório e equipamentos comuns.
Organiza e mantém informações seguindo procedimentos acordados.
Auxilia em atividades básicas de coordenação.', 'Performs routine administrative tasks in a structured environment.
Follows clear procedures. Uses common office software and equipment.
Organises and maintains information following agreed procedures.
Assists with basic coordination activities.'),
(15231, 2, 'Auxilia uma equipe em tarefas administrativas.
Mantém sistemas para organizar informações e documentos.
Coordena atividades da equipe e atua como ponto de contato para contatos internos e externos.
Utiliza ferramentas e plataformas digitais relevantes.', 'Assists with administrative tasks for a team.
Maintains systems for organising information and documents.
Coordinates team activities and acts as a point of contact for internal and external contacts.
Uses relevant digital tools and platforms.'),
(15231, 3, 'Fornece suporte administrativo a equipes e reuniões.
Participa ativamente nas discussões da equipe.
Estabelece e mantém sistemas de organização de informações e documentos. Compila e distribui relatórios.
Fornece orientação sobre software administrativo, procedimentos, processos, ferramentas e técnicas.', 'Provides administrative support function to teams and meetings.
Takes an active part in team discussions.
Sets up and maintains systems for organising information and documents. Compiles and distributes reports.
Provides guidance on administrative software, procedures, processes, tools and techniques.'),
(15231, 4, 'Auxilia as equipes e os gerentes a garantir que tenham as informações e os recursos necessários para apoiar os processos em curso.
Auxilia no planejamento de reuniões. Estabelece contatos e os organiza entre funções.
Configura e fornece orientações detalhadas sobre software, procedimentos, processos, ferramentas e técnicas para administração e produtividade no escritório.
Contribui para o desenvolvimento e manutenção de políticas, procedimentos e documentação organizacionais.', 'Assists the teams and managers in ensuring they have the information and resources needed to support ongoing processes.
Assists in planning for meetings. Liaises and organises across functions.
Sets up and provides detailed guidance on software, procedures, processes, tools and techniques for administration and workplace productivity.
Contributes to the development and maintenance of organisational policies, procedures and documentation.'),
(15231, 5, 'Gerencia a entrega de serviços de administração de negócios.
Gerencia e prioriza a agenda diária e a comunicação de gerentes sênior e equipes de liderança para garantir o uso eficiente do tempo e de recursos.
Lida com informações sensíveis e confidenciais.
Garante que os gerentes tenham as informações e os recursos necessários para apoiar os processos em andamento e suportar os processos em andamento e as mudanças em processos.', 'Manages the delivery of business administration services.
Manages and prioritises the schedules and communication of senior managers and leadership teams to ensure efficient use of time and resources.
Handles sensitive, confidential information.
Ensures managers have the information and resources needed to support ongoing processes and changes in processes.'),
(15231, 6, 'Lidera e coordena iniciativas estratégicas que atuam além das fronteiras departamentais ou funcionais.
Projeta, planeja e coordena reuniões e eventos de alto nível, garantindo o alinhamento com os objetivos estratégicos e os resultados desejados.
Fornece orientação e recebe atualizações de progresso dos membros de uma equipe executiva. Reúne-se coletiva ou individualmente com membros de uma equipe de gerenciamento de liderança para acompanhar pontos de ação, questões e riscos. Relata o progresso e resolve problemas.
Gerencia questões e informações altamente sensíveis e confidenciais.', 'Leads and coordinates strategic initiatives working across departmental or functional boundaries.
Designs, plans and coordinates high-level meetings and events, ensuring alignment with strategic objectives and desired outcomes.
Provides direction and receives progress updates from members of an executive team. Meets collectively or individually with members of a leadership management team to follow up on action points, issues and risks. Reports on progress and resolves issues.
Manages highly sensitive and confidential issues and information.'),
(1080, 2, 'Auxilia na criação de relatórios regulares de inteligência de negócios, utilizando ferramentas padrão.
Dá suporte à preparação de dados a partir de fontes existentes.', 'Assists with the creation of regular business intelligence reports using standard tools.
Supports data preparation from existing sources.'),
(1080, 3, 'Fornece e preparar dados para análise e executar atividades de análise padronizadas de inteligência de negócios.
Verifica a integridade e a validade das fontes de dados. Cria e entrega relatórios padrão de acordo com as necessidades das partes interessadas e em conformidade com os padrões pré-definidos.
Investiga a necessidade da análise de nova ou revisada, inteligência de negócios.
Contribui para a recomendação de melhorias. Envolve-se com as partes interessadas sob direção.', 'Sources and prepares data for analysis and performs standard business intelligence analysis activities.
Checks the integrity and validity of data sources. Creates and delivers standard reports in accordance with stakeholder needs and conforming to agreed standards.
Investigates the need for new or revised business intelligence analysis.
Contributes to the recommendation of improvements. Engages with stakeholders under direction.'),
(1080, 4, 'Suporta as necessidades de inteligência de negócios em processos específicos de gestão, governança ou em áreas operacionais.
Verifica a necessidade de relatórios e análises de inteligência de negócios em situações de alguma complexidade e ambiguidade.
Seleciona e aplicar ferramentas e técnicas de inteligência de negócios não convencionais para fornecer insights e auxiliar na tomada de decisões. Seleciona, adquire e integra dados para análise e verificar a qualidade e integridade dos dados.
Identificar oportunidades para digitalizar e simplificar o manuseio de dados operacionais e otimizar os recursos de inteligência de negócios.', 'Supports business intelligence needs of specific management or governance processes or operational areas.
Investigates the need for business intelligence reporting and analysis where there is some complexity and ambiguity.
Selects and applies non-standard business intelligence tools and techniques to provide insights and aid decision-making. Selects, acquires and integrates data for analysis and verifies the data''s quality and integrity.
Identifies opportunities to digitise and streamline operational data handling and optimise business intelligence capabilities.'),
(1080, 5, 'Planeja e gerencia atividades de inteligência de negócios.
Assegura que os processos, procedimentos e práticas de inteligência de negócios sejam robustos, eficientes e adequados ao propósito, com foco na automação, controles-chave e qualidade de dados. Aconselha sobre os padrões, procedimentos, métodos, ferramentas e técnicas disponíveis.
Gerencia revisões dos benefícios e valor das técnicas e ferramentas de inteligência de negócios e recomenda melhorias.
Contribui para o desenvolvimento de políticas, padrões e diretrizes de análise.', 'Plans and manages business intelligence activities.
Ensures business intelligence processes, procedures and practices are robust, efficient and fit for purpose, focusing on automation, key controls and data quality. Advises on the available standards, procedures, methods, tools and techniques.
Manages reviews of the benefits and value of business intelligence techniques and tools and recommends improvements.
Contributes to the development of analytics policies, standards and guidelines.'),
(15232, 2, 'Ajuda a criar modelos para cenários de negócios simples e bem definidos sob orientação.
Utiliza técnicas estabelecidas, de acordo com orientações, para modelar áreas de assunto simples com limites claramente definidos.
Apoia atividades de modelagem mais complexas sob a orientação de outros, organizando informações e ajudando a aplicar técnicas relevantes.', 'Assists in creating models for simple, well-defined business scenarios under guidance.
Uses established techniques, as directed, to model simple subject areas with clearly-defined boundaries.
Supports more complex modelling activities under the guidance of others by organising information and helping to apply relevant techniques.'),
(15232, 3, 'Produzir modelos para cenários de negócios simples com limites claros, selecionando técnicas adequadas para atender aos objetivos atribuídos.
Interage com especialistas em assuntos para garantir que os modelos sejam precisos e atendam aos requisitos de negócios. Aplica técnicas estabelecidas para atender aos objetivos, modelando processos de negócios, funções e dados.
Colabora com as partes interessadas para resolver problemas e garantir que os modelos forneçam clareza e insights.
Teste modelos e faz melhorias conforme necessário, garantindo precisão e relevância para o contexto de negócios.', 'Produces models for straightforward business scenarios with clear boundaries, selecting suitable techniques to meet assigned objectives.
Engages with subject matter experts to ensure models are accurate and meet business requirements. Applies established techniques to meet objectives, modelling business processes, roles and data.
Collaborates with stakeholders to address issues and ensure models provide clarity and insight.
Tests models and makes improvements as needed, ensuring accuracy and relevance to the business context.'),
(15232, 4, 'Desenvolve modelos para cenários de negócios complexos e ambíguos.
Seleciona técnicas e abordagens apropriadas para garantir que os modelos captem os elementos de negócios necessários. Planeia de forma independente atividades de modelagem, garantindo a alinhamento com objetivos de negócios.
Colabora com as partes interessadas operacionais para validar e refinar modelos com base em feedback, e para obter acordo sobre os resultados de modelagem e suas implicações.
Aconselha as partes interessadas a interpretar e aplicar modelos para a tomada de decisões e melhorias de negócios.', 'Develops models for complex and ambiguous business scenarios.
Selects appropriate techniques and approaches to ensure models capture the necessary business elements. Independently plans modelling activities, ensuring alignment with business objectives.
Collaborates with operational stakeholders to validate and refine models based on feedback, and to gain agreement on modelling results and their implications.
Advises stakeholders interpreting and applying models for decision-making and business improvements.'),
(15232, 5, 'Gerencia o desenvolvimento de modelos que suportam objetivos de negócios estratégicos.
Trabalha em cenários complexos e ambíguos, aplicando técnicas e métodos avançados. Cria modelos personalizados para contextos não padronizados e assegura que estejam alinhados com a estratégia de negócios global.
Assegura a qualidade do trabalho de modelagem de negócios.
Engage e colabora com uma ampla gama de partes interessadas, fornecendo orientação sobre a seleção e aplicação de técnicas de modelagem apropriadas. Influencia a tomada de decisão apresentando modelos que destacam insights de negócios-chave.', 'Manages the development of models that support strategic business objectives.
Works on complex and ambiguous scenarios, applying advanced techniques and methods. Creates bespoke models for non-standard contexts and ensures their alignment with overall business strategy.
Ensures the quality of business modelling work.
Engages and collaborates with a wide range of stakeholders providing guidance on selecting and applying appropriate modelling techniques. Influences decision-making by presenting models that highlight key business insights.'),
(15232, 6, 'Define padrões organizacionais para modelagem de negócios, garantindo que os modelos estejam alinhados com objetivos estratégicos de negócios.
Supervisiona a criação e manutenção de modelos em múltiplas funções e departamentos, garantindo que sejam usados de forma eficaz.
Lidera iniciativas em toda a organização para melhorar a modelagem de negócios, introduzindo novas técnicas quando necessário.
Engaja-se com as partes interessadas seniores para obter concordância sobre modelos estratégicos e as decisões que eles informam.', 'Defines organisational standards for business modelling, ensuring models align with strategic business objectives.
Oversees the creation and maintenance of models across multiple functions and departments, ensuring they are used effectively.
Leads organisation-wide initiatives to improve business modelling, introducing new techniques where necessary.
Engages with senior stakeholders to gain agreement on strategic models and the decisions they inform.'),
(8231, 2, 'Ajuda na coleta de dados e documentação de processos de negócios atuais sob supervisão de rotina.
Participa em exercícios de mapeamento de processos e ajuda a identificar áreas para melhorias potenciais.
Ajuda na criação de documentação de processos.
Apoia a implementação de pequenas mudanças e melhorias de processo.', 'Assists in gathering data and documenting current business processes under routine supervision.
Participates in process mapping exercises and helps identify areas for potential improvement.
Assists in creating process documentation.
Supports the implementation of minor process changes and improvements.'),
(8231, 3, 'Aplica técnicas padrão para analisar processos de negócios existentes e identifica oportunidades de melhoria.
Colabora com as partes interessadas para garantir que as mudanças de processos estejam alinhadas com os objetivos de negócios. Propõe e implementa melhorias de processos que aumentam a eficiência, a eficácia e a qualidade.
Desenvolve e mantém a documentação de processos.
Apoia a adoção de novas tecnologias e ferramentas para permitir a automação e otimização de processos.', 'Applies standard techniques to analyse existing business processes and identifies opportunities for improvement.
Collaborates with stakeholders to ensure process changes align with business objectives. Proposes and implements process improvements that enhance efficiency, effectiveness and quality.
Develops and maintains process documentation.
Supports the adoption of new technologies and tools to enable process automation and optimisation.'),
(8231, 4, 'Analisa e desenha processos de negócios para identificar soluções alternativas para melhorar a eficiência, eficácia e explorar novas tecnologias e automação.
Desenvolve modelos gráficos de processos de negócios para facilitar a compreensão e tomada de decisão.
Recomenda abordagens de implementação para iniciativas de melhoria de processos.', 'Analyses and designs business processes to identify alternative solutions to improve efficiency, effectiveness and exploit new technologies and automation.
Develops graphical models of business processes to facilitate understanding and decision-making.
Recommends implementation approaches for process improvement initiatives.'),
(8231, 5, 'Gerencia a execução de melhorias de processos de negócios.
Avalia a viabilidade de mudanças de processos de negócios e recomenda abordagens alternativas.
Seleciona, adapta e implementa métodos e ferramentas para melhorar processos de negócios a nível de programa, projeto ou equipe.
Contribui para a definição de políticas organizacionais, padrões e diretrizes para a melhoria de processos de negócios.', 'Manages the execution of business process improvements.
Assesses the feasibility of business process changes and recommends alternative approaches.
Selects, tailors and implements methods and tools for improving business processes at programme, project or team level.
Contributes to the definition of organisational policies, standards and guidelines for business process improvement.'),
(8231, 6, 'Planeja e conduz atividades de melhoria de processos de negócios para programas estratégicos, grandes e complexos, alinhados com a automação ou a exploração de tecnologias novas ou existentes.
Desenvolve políticas organizacionais, normas e diretrizes para melhoria de processos de negócios.
Orienta a introdução de técnicas, metodologias e ferramentas para atender aos requisitos dos negócios, garantindo a consistência em todos os grupos de usuários.
Orienta o desenvolvimento de capacidades organizacionais para a melhoria dos processos de negócios e garante a adoção e a adesão a políticas e normas.', 'Plans and leads strategic, large and complex business process improvement activities aligned with automation, or exploiting existing or new technologies.
Develops organisational policies, standards and guidelines for business process improvement.
Leads the introduction of techniques, methodologies and tools to meet business requirements, ensuring consistency across all user groups.
Leads the development of organisational capabilities for business process improvement and ensures adoption and adherence to policies and standards.'),
(8231, 7, 'Direciona a identificação, avaliação e a adoção de tecnologias novas ou existentes para a melhoria dos processos de negócios.
Alinha estratégias de negócios, transformação empresarial e estratégias de tecnologia.
Incorpora as melhorias dos processos de negócios estratégicos na governança e liderança da organização.
Orienta a criação e a revisão de uma abordagem e de uma cultura multifuncional em toda a empresa, visando adotar o gerenciamento dos processos de negócios.', 'Directs the identification, evaluation and adoption of new or existing technologies to improve business processes.
Aligns business strategies, enterprise transformation and technology strategies.
Embeds strategic business process improvement into the governance and leadership of the organisation.
Directs the creation and review of a cross-functional, enterprise-wide approach and culture for embracing business process management.'),
(5457, 2, 'Ajuda na investigação de situações de negócios para ajudar a identificar e analisar problemas e oportunidades, sob supervisão de rotina.
Ajuda a coletar e organizar dados e informações para apoiar recomendações.', 'Assists in investigating business situations to help identify and analyse problems and opportunities, under routine supervision.
Helps collect and organise data and information to support recommendations.'),
(5457, 3, 'Investiga situações de negócios diretas para identificar e analisar problemas e oportunidades.
Contribui para a recomendação de melhorias.
Segue padrões e técnicas acordados para investigar, analisar e documentar situações de negócios.
Envolve-se com as partes interessadas sob direção.', 'Investigates straightforward business situations to identify and analyse problems and opportunities.
Contributes to the recommendation of improvements.
Follows agreed standards and techniques to investigate, analyse and document business situations.
Engages with stakeholders under direction.'),
(5457, 4, 'Investiga situações de negócios onde há alguma complexidade e ambiguidade.
Adota visão holística para identificar e analisar problemas e oportunidades.
Contribui para a seleção da abordagem e técnicas a serem utilizadas para a análise da situação do negócio.
Conduz análise de causa raiz e identifica recomendações para melhorias. Engaja e colabora com stakeholders operacionais.', 'Investigates business situations where there is some complexity and ambiguity.
Adopts holistic view to identify and analyse problems and opportunities.
Contributes to the selection of the approach and techniques to be used for business situation analysis.
Conducts root cause analysis and identifies recommendations for improvements. Engages and collaborates with operational stakeholders.'),
(5457, 5, 'Planeja, gerencia e investiga a análise da situação empresarial onde há ambiguidade e complexidade significativas.
Aconselha sobre a abordagem e as técnicas a serem usadas para análise da situação empresarial. Garante a visão holística adotada para identificar e analisar problemas e oportunidades abrangentes.
Envolve e colabora com uma ampla gama de partes interessadas, incluindo aquelas no nível de gestão. Obtém concordância das partes interessadas com conclusões e recomendações.
Contribui para a definição de padrões e diretrizes organizacionais para análise da situação empresarial.', 'Plans, manages and investigates business situation analysis where there is significant ambiguity and complexity.
Advises on the approach and techniques to be used for business situation analysis. Ensures holistic view adopted to identify and analyse wide-ranging problems and opportunities.
Engages and collaborates with a wide range of stakeholders, including those at the management level. Gains agreement from stakeholders to conclusions and recommendations.
Contributes to definition of organisational standards and guidelines for business situation analysis.'),
(5457, 6, 'Inicia e lidera análise da situação de negócios onde há extensa ambiguidade, complexidade e impactos potencialmente significativos na organização.
Estabelece e promove a necessidade de análise holística da situação do negócio, antes do início do programa de mudança.
Envolve-se com as partes interessadas em nível executivo e aconselha sobre as iniciativas de mudança recomendadas.
Define políticas organizacionais, padrões e técnicas para a análise da situação dos negócios.', 'Initiates and leads business situation analysis where there is extensive ambiguity, complexity and potentially significant organisational impacts.
Establishes and promotes the need for holistic business situation analysis prior to change programme initiation.
Engages with stakeholders at executive level and advises on recommended change initiatives.
Defines organisational policies, standards and techniques for business situation analysis.'),
(15233, 2, 'Ajuda a monitorar a capacidade e o desempenho dos componentes de serviço sob orientação e supervisão de rotina.
Recolhe e reporta dados sobre utilização de recursos e métricas de capacidade.
Apoia a implementação de procedimentos e práticas de gerenciamento de capacidade.', 'Assists in monitoring service component capacity and performance under routine guidance and supervision.
Collects and reports data on resource utilisation and capacity metrics.
Supports the implementation of capacity management procedures and practices.'),
(15233, 3, 'Monitoriza a capacidade e o desempenho dos componentes de serviço, identificando problemas potenciais e escalando conforme necessário.
Aplica procedimentos padrão para gerenciar demanda e capacidade.
Participa em atividades de modelagem e previsão de capacidade, fornecendo insights e recomendações.
Apoia a implementação de ferramentas e técnicas de gerenciamento de capacidade.', 'Monitors service component capacity and performance, identifying potential issues and escalating as necessary.
Applies standard procedures to manage demand and capacity.
Participates in capacity modelling and forecasting activities, providing input and recommendations.
Supports the implementation of capacity management tools and techniques.'),
(15233, 4, 'Monitoriza a capacidade dos componentes de serviço e inicia ações para resolver quaisquer deficiências, de acordo com procedimentos acordados.
Aplica técnicas para controlar a demanda sobre um determinado recurso ou serviço.
Contribui para a modelagem e planejamento de capacidade.
Suporta ou design da capacidade dos componentes de serviço.', 'Monitors service component capacity and initiates actions to resolve any shortfalls according to agreed procedures.
Applies techniques to control the demand upon a particular resource or service.
Contributes to capacity modelling and planning using data-driven insights.
Supports the design of service component capacity.'),
(15233, 5, 'Gerencia as atividades de modelagem e previsão de capacidade.
Revisa proativamente as informações em conjunto com os acordos de nível de serviço para identificar quaisquer problemas de capacidade e especifica as alterações necessárias. Fornece aconselhamento para apoiar o design de componentes de serviço, incluindo o design de capacidade flexível e escalável.
Trabalha com representantes de empresas para acordar e implementar modificações de curto e médio prazo na capacidade.
Elabora e mantém padrões e procedimentos para gerenciamento de capacidade de componentes de serviço. Garante a correta implementação de normas e procedimentos.', 'Manages capacity modelling and forecasting activities, using data-driven insights.
Proactively reviews information in conjunction with service level agreements to identify any capacity issues and specifies any required changes. Provides advice to support the design of service components, including designing in flexible and scalable capacity.
Works with business representatives to agree and implement short- and medium-term modifications to capacity.
Drafts and maintains standards and procedures for service component capacity management. Ensures the correct implementation of standards and procedures.'),
(15233, 6, 'Liderar o desenvolvimento e implementação de políticas e estratégias para gestão de capacidade e desempenho para atender às necessidades de negócios.
Liderar a modelagem e previsão de capacidade ao longo do ciclo de planejamento ou orçamento da organização usando insights orientados por dados. Toma em consideração fatores externos e tendências da indústria.
Assegura que as políticas e padrões para gestão de capacidade sejam adequados ao propósito, atuais e implementados corretamente. Promove a melhoria contínua das práticas de gestão de capacidade, com foco na rentabilidade e otimização de recursos.
Revisa novas propostas de negócios e fornece aconselhamento especializado sobre questões de capacidade.', 'Leads the development and implementation of policy and strategies for capacity and performance management to meet business needs.
Leads capacity modelling and forecasting over the organisation’s planning or budgeting cycle using data-driven insights. Considers external factors and industry trends.
Ensures policies and standards for capacity management are fit for purpose, current and correctly implemented. Drives continuous improvement in capacity management practices, focusing on cost-effectiveness and resource optimisation.
Reviews new business proposals and provides specialist advice on capacity issues.'),
(15234, 2, 'Processa solicitações de certificação.
Registra reclamações.
Auxilia na preparação e organização de materiais de credenciais.
Suporta a criação e manutenção de credenciais ou certificados e ajuda a resolver problemas rotineiros durante o ciclo de vida da certificação.', 'Processes applications for certification.
Logs complaints.
Assists with the preparation and organisation of credential materials.
Supports the creation and maintenance of credentials or certificates and helps resolve routine problems during the certification lifecycle.'),
(15234, 3, 'Emite certificações ou credenciais e mantém registros de certificação.
Mantém informações sobre o esquema de certificação e uma descrição geral do processo de certificação.
Desenha, cria, desenvolve, personaliza e mantém credenciais ou certificados.
Responde a pedidos de informação pública. Analisa e toma medidas em relação a reclamações ou problemas.', 'Issues certifications or credentials and maintains and retains certification records.
Maintains information on the certification scheme and a general description of the certification process.
Designs, creates, develops, customises and maintains credentials or certificates.
Responds to public information requests. Analyses and acts on complaints or issues.'),
(15234, 4, 'Documenta instruções para todo o pessoal envolvido em certificação, incluindo acordos legalmente válidos com quaisquer terceiros envolvidos no processo.
Identifica ameaças à imparcialidade analisando, mitigando ou eliminando potenciais conflitos de interesses decorrentes das atividades de certificação.
Implementa procedimentos de certificação de pessoas para a entrega de treinamento.
Determina os méritos das eventuais reclamações e quaisquer ações corretivas necessárias.', 'Documents instructions for all personnel involved in certification, including legally enforceable agreements with any third parties involved in the process.
Identifies threats to impartiality by analysing, mitigating or eliminating potential conflict of interests arising from certification activities.
Implements the procedures for certification of individuals for the delivery of training.
Determines the merits of complaints and any remedial actions required.'),
(15234, 5, 'Define um esquema de certificação ou credenciamento, incluindo a estrutura organizacional, os deveres, responsabilidades e autoridades.
Determina a competência necessária para desempenhar as funções de certificação. Desenha e implementa o processo de seleção e aprovação dos examinadores ou avaliadores.
Monitora o desempenho e as avaliações e obtém acordos sobre ações corretivas. Planeja e fornece instalações, equipamentos e recursos adequados.
Documenta políticas e procedimentos para manutenção e liberação de informações, incluindo a consideração de quaisquer acordos de confidencialidade.', 'Defines a certification or accreditation scheme, including organisation structure, duties, responsibilities and authorities.
Determines necessary competence to perform certification functions. Designs and implements the examiner or assessor selection and approval process.
Monitors performance and judgements, and agrees corrective actions. Plans and provides adequate premises, equipment and resources.
Documents policies and procedures for maintenance and release of information, including consideration of any legal agreements for confidentiality.'),
(15234, 6, 'Definir políticas e padrões para a operação de esquemas de certificação, incluindo segregação de funções e abordagem de imparcialidade.
Desenvolve e mantém uma descrição do código de ética e práticas profissionais exigidas.
Alinha esquemas de certificação com padrões externos, estruturas como o SFIA, e com as melhores práticas relevantes.
Obtém a aprovação dos proprietários de esquemas de credenciamento ou órgãos de governança.', 'Sets policies and standards for the operation of a certification scheme, including segregation of duties and addressing impartiality.
Develops and maintains a description of the code of ethics and professional practices required.
Aligns certification schemes with relevant external standards, frameworks such as SFIA and established industry practices.
Obtains approval from accreditation scheme owners or governance bodies.'),
(15235, 2, 'Administra, rastreia, registra e emite relatórios sobre solicitações de mudança, usando ferramentas, técnicas e processos apropriados.
Fornece assistência para implementar mudanças padrão de baixo risco, de acordo com procedimentos definidos de controle de mudança.', 'Administers, tracks, logs, reports on change requests, using appropriate tools, techniques and processes.
Provides assistance to implement standard low-risk changes, in accordance with defined change control procedures.'),
(15235, 3, 'Desenvolve, documenta e implementa mudanças com base em solicitações de mudança.
Aplica procedimentos de controle de mudanças.
Aplica ferramentas, técnicas e processos para gerenciar e reportar solicitações de mudança.', 'Develops, documents and implements changes based on requests for change.
Applies change control processes and procedures.
Applies tools, techniques and processes to manage and report on change requests.'),
(15235, 4, 'Avalia, analisa, desenvolve, documenta e implementa mudanças com base em requisições de mudança.
Garante que os processos operacionais estejam em vigor para um controle eficaz de mudanças.
Desenvolve, configura e mantém ferramentas para gerenciar e reportar o ciclo de vida das requisições de mudança.
Identifica problemas e questões e recomenda ações corretivas.', 'Assesses, analyses, develops, documents and implements changes based on requests for change.
Ensures operational processes and procedures are in place for effective change control.
Develops, configures and maintains tools to manage and report on the lifecycle of change requests.
Identifies problems and issues and recommend corrective actions.'),
(15235, 5, 'Conduz a avaliação, análise, desenvolvimento, documentação e a implementação de mudanças.
Desenvolve planos de implementação para solicitações complexas de mudanças.
Revisa as implementações propostas e avalia os riscos para a integridade do ambiente de produtos e serviços. Garante que mudanças adequadas e aprovadas sejam efetivamente aplicadas.
Revisa a eficácia da implementação das mudanças. Identifica, avalia e gerencia a adoção de ferramentas, técnicas e processos adequados para o controle de mudanças.', 'Leads the assessment, analysis, development, documentation and implementation of changes.
Develops implementation plans for complex requests for change.
Reviews proposed implementations and evaluates the risks to the integrity of the product and service environment. Ensures appropriate change approval is applied to changes.
Reviews the effectiveness of change implementation. Identifies, evaluates and manages the adoption of appropriate tools, techniques and processes for change control.'),
(15235, 6, 'Define a política da organização para o gerenciamento de mudanças em serviços em ambientes de produção e testes.
Garante o controle e o tratamento efetivo dos riscos.
Conduz o desenvolvimento de novos métodos e ferramentas para o controle de mudanças.
Realiza a medição, monitora a aderência aos padrões e garante a execução consistente do processo em toda a organização.', 'Sets the organisation''s policy for the management of change in live services and test environments.
Ensures effective control and treatment of risk.
Leads the development of new and improved practices for change control.
Measures and monitors adherence to standards and ensures consistent execution of the process across the organisation.'),
(15236, 2, 'Auxilia na administração de avaliações de competência usando ferramentas e procedimentos padrão sob supervisão rotineira.
Apoia a coleta e organização de dados e resultados de avaliação usando métodos e ferramentas especificados.
Ajuda a criar e manter documentação.', 'Assists in the administration of competency assessments using standard tools and procedures under routine supervision.
Supports the collection and organisation of assessment data and results using specified methods and tools.
Helps create and maintain documentation.'),
(15236, 3, 'Realiza avaliações rotineiras de conhecimentos, habilidades, competências ou comportamentos usando ferramentas e métodos especificados.
Suporta a coleta, organização e revisão de dados de avaliação para manter registros precisos.', 'Performs routine assessments of knowledge, skills, competencies, or behaviours using specified tools and methods.
Supports the collection, organisation, and review of assessment data to maintain accurate records.'),
(15236, 4, 'Realiza avaliações rotineiras e não rotineiras de conhecimento, habilidade, competência ou comportamento, usando métodos especificados.
Oferece orientação e aconselhamento para apoiar a adoção de métodos e ferramentas de avaliação.
Modera as avaliações realizadas por outros.
Revisa e melhora o uso e aplicação de métodos e ferramentas de avaliação.', 'Performs routine and non-routine assessments of knowledge, skill, competency or behaviour using specified methods.
Provides advice and guidance to support the adoption of assessment methods and tools.
Moderates assessments conducted by other assessors.
Reviews and improves usage and application of assessment methods and tools.'),
(15236, 5, 'Oferece orientação e aconselhamento sobre a definição, adoção e adaptação de métodos, ferramentas e técnicas de avaliação.
Planeja avaliações com base no contexto da avaliação e em como os resultados serão utilizados.
Gerencia a execução de avaliações para garantir que forneçam os resultados necessários com qualidade aceitável. Monitora e modera as análises realizadas por outros.
Gerencia revisões dos benefícios e o valor dos métodos e ferramentas de avaliação. Identifica e recomenda melhorias nos métodos e ferramentas de avaliação.', 'Provides advice and guidance on selecting, adopting and adapting assessment methods, tools and techniques.
Plans assessments based on the context of the assessment and how assessment results will be used.
Manages execution of assessments to ensure they deliver the required outcomes with acceptable quality. Monitors and moderates reviews performed by other assessors.
Manages reviews of the benefits and value of assessment methods and tools. Identifies and recommends improvements to assessment methods and tools.'),
(15236, 6, 'Defende a importância e o valor de métodos, ferramentas e técnicas de avaliação apropriados.
Desenvolve políticas, normas e diretrizes organizacionais para avaliações.
Orienta a introdução e uso de metodologias e ferramentas de avaliação. Estabelece uma prática de avaliação e um grupo de avaliadores dentro da organização.
Estabelece garantia de qualidade para assegurar a consistência e confiabilidade interna e/ou externa dos resultados da avaliação. Garante a qualidade das avaliações em diferentes grupos de usuários.', 'Champions the importance and value of assessment and appropriate assessment methods, tools and techniques.
Develops organisational policies, standards and guidelines for assessments.
Leads in the introduction and use of assessment methodologies and tools. Establishes an assessment practice and pool of assessors within the organisation.
Establishes quality assurance to ensure internal and/or external consistency and reliability of assessment outcomes. Ensures the quality of assessments across different user groups.'),
(15237, 2, 'Aplica ferramentas, técnicas e processos para administrar, rastrear, registrar, relatar e corrigir itens de configuração, componentes e alterações.
Auxilia nas auditorias para verificar a precisão das informações e realiza qualquer ação corretiva necessária sob orientação.', 'Applies tools, techniques and processes to administer, track, log, report on and correct configuration items, components and changes.
Assists with audits to check the accuracy of the information and undertakes any necessary corrective action under direction.'),
(15237, 3, 'Aplica ferramentas, técnicas e processos para rastrear, registrar e corrigir informações relacionadas aos itens de configuração.
Verifica e aprova as alterações, garantindo a proteção de ativos e componentes contra alterações não autorizadas, desvios e uso inadequado.
Garante que os usuários cumpram os padrões de identificação para tipos de objetos, ambientes, processos, ciclos de vida, documentação, versões, formatos, linhas de base, versões e modelos.
Realiza auditorias para verificar a exatidão das informações e realiza qualquer ação corretiva necessária sob orientação.', 'Applies tools, techniques and processes to track, log and correct information related to configuration items.
Verifies and approves changes to protect assets and components from unauthorised change, diversion and inappropriate use.
Supports user compliance with identification standards for object types, environments, processes, lifecycles, documentation, versions, formats, baselines, releases and templates.
Performs audits to check the accuracy of the information and undertakes any necessary corrective action under direction.'),
(15237, 4, 'Propõe e garante concordância de que os itens de configuração (ICs) sejam identificados de forma exclusiva, com convenções de nomenclatura.
Implementa processos operacionais para configuração segura, classificação e gerenciamento de ICs e para verificação e auditoria de registros de configuração.
Desenvolve, configura e mantém ferramentas (incluindo automação) para identificar, rastrear, registrar e manter informações precisas, completas e atuais.
Emite relatórios sobre o status do gerenciamento de configuração. Identifica problemas e questões e recomenda ações corretivas.', 'Proposes and agrees the configuration items (CIs) to be uniquely identified with naming conventions.
Puts in place operational processes for secure configuration, classification and management of CIs and for verifying and auditing configuration records.
Develops, configures and maintains tools (including automation) to identify, track, log and maintain accurate, complete and current information.
Reports on the status of configuration management. Identifies problems and issues and recommend corrective actions.'),
(15237, 5, 'Planeja a captura e o gerenciamento de ICs e informações relacionadas.
Garante acordos sobre o escopo dos processos de gerenciamento da configuração, os itens de configuração (ICs) e as informações relacionadas a serem controladas.
Identifica, avalia e gerencia a adoção de ferramentas, técnicas e processos apropriados (incluindo automação) para o gerenciamento da configuração.
Contribui para o desenvolvimento de estratégias, políticas, normas e diretrizes para o gerenciamento da configuração.', 'Plans the capture and management of CIs and related information.
Agrees scope of configuration management processes and the configuration items (CIs) and related information to be controlled.
Identifies, evaluates and manages the adoption of appropriate tools, techniques and processes (including automation) for configuration management.
Contributes to the development of configuration management strategies, policies, standards and guidelines.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(15237, 6, 'Desenvolve estratégias, políticas, padrões e diretrizes para o gerenciamento da configuração.
Defende a importância e o valor do gerenciamento da configuração e desenvolve novos métodos e recursos organizacionais (incluindo automação) para o gerenciamento da configuração.
Fornece recursos para impulsionar a adoção e adesão a políticas e padrões relacionados com o tema.
Realiza a medição, monitora a aderência aos padrões e garante a execução consistente do processo em toda a organização.', 'Develops configuration management strategies, policies, standards and guidelines.
Champions the importance and value of configuration management and develops new methods and organisational capabilities (including automation) for configuration management.
Provides resources to drive adoption of, and adherence to, policies and standards.
Measures and monitors adherence to standards and ensures consistent execution of the process across the organisation.'),
(2196, 4, 'Assume a responsabilidade por elementos específicos de um compromisso de consultoria dentro de um âmbito definido.
Colabora com os clientes como parte de compromissos de consultoria formais ou informais. Entende as necessidades dos clientes através da coleta de dados e entrega de análises.
Assegura que as soluções propostas sejam compreendidas corretamente e aplicadas de forma eficaz.
Apoia o compromisso de consultoria mais amplo, contribuindo com ideias e ajudando na resolução de problemas, sempre dentro dos limites de responsabilidade estabelecidos.', 'Takes responsibility for specific elements of a consulting engagement within a defined scope.
Collaborates with clients as part of formal or informal consultancy engagements. Understands client requirements by collecting data and delivering analysis.
Ensures proposed solutions are correctly understood and effectively applied.
Supports the broader consultancy engagement by contributing insights and assisting with problem-solving, always within the established boundaries of responsibility.'),
(2196, 5, 'Assume toda a responsabilidade pela compreensão dos requisitos do cliente, incluindo a coleta de dados, análise e resolução de problemas.
Gerencia o escopo e a entrega de compromissos de consultoria para atingir os objetivos acordados. Identifica, avalia e recomenda opções.
Colabora e facilita grupos de interessados, como parte de acordos de consultoria formais ou informais. Procura atender plenamente às necessidades do cliente e implementa soluções, se necessário.
Melhora as capacidades e a eficácia dos clientes, garantindo que as soluções propostas sejam totalmente compreendidas e utilizadas adequadamente.', 'Takes full responsibility for understanding client requirements including data collection, analysis and resolving issues.
Manages the scope and delivery of consultancy engagements to meet agreed objectives. Identifies, evaluates and recommends options.
Collaborates with, and facilitates, stakeholder groups, as part of formal or informal consultancy agreements. Seeks to fully address client needs and implements solutions if required.
Enhances the capabilities and effectiveness of clients by ensuring proposed solutions are fully understood and appropriately exploited.'),
(2196, 6, 'Dirige e gerencia a prestação de serviços de consultoria e/ou uma equipe de consultores.
Fornece aconselhamento e orientação especializada em áreas de especialização próprias para consultores e clientes.
Interage com clientes a nível estratégico, estabelecendo acordos ou contratos de consultoria e mantendo relações de longo prazo. Gerencia a conclusão de compromissos, garante o alinhamento estratégico com as necessidades dos clientes e supervisiona a transição da entrega de consultoria para a adoção operacional.
Supervisiona o desenvolvimento e a entrega dos serviços de consultoria dentro do quadro estratégico acordado.', 'Leads and manages the provision of consultancy services and/or a team of consultants.
Provides expert advice and guidance in own areas of expertise to both consultants and clients.
Engages with clients at a strategic level, establishing consultancy agreements or contracts and maintaining long-term relationships. Manages the completion of engagements, ensuring strategic alignment with client needs and overseeing the transition from consultancy delivery to operational adoption.
Oversees the development and delivery of consultancy services within the agreed strategic framework.'),
(2196, 7, 'Orienta a direção estratégica e as operações de uma prática de consultoria significativa.
Engaja-se com as principais partes interessadas nos mais altos níveis para garantir que os serviços de consultoria impulsionem os resultados estratégicos.
Gerencia as relações globais com os clientes e o desenvolvimento de parcerias de consultoria de longo prazo, mantendo altos padrões de prestação de serviços e prática ética.
Supervisiona o desenvolvimento de práticas, propostas, vendas, gerenciamento de contas e a prestação de serviços de consultoria em diversos temas.', 'Directs the strategic direction and operations of a significant consultancy practice.
Engages with key stakeholders at the highest levels to ensure consultancy services drive strategic outcomes.
Manages overall client relationships and the development of long-term consultancy partnerships, maintaining high standards of service delivery and ethical practice.
Oversees practice development, proposals, sales, account management and the delivery of consultancy services across diverse topics.'),
(15238, 1, 'Contribui, sob instrução, para a geração de conteúdo e configuração de itens e arquivos de conteúdo.
Executa atividades de teste pré-planejadas sob supervisão e registra as descobertas.', 'Contributes, under instruction, to the generation of content and the configuration of content items and files.
Executes pre-planned testing activities under supervision and records findings.'),
(15238, 2, 'Trabalha com colegas e partes interessadas para entender as necessidades do público e assimilar o material original.
Cria rascunhos de conteúdo para atender aos requisitos do público da maneira mais clara, simples e rápida possível.
Aplica diretrizes e padrões para moderar o conteúdo de terceiros, escalando quando apropriado.', 'Works with colleagues and stakeholders to understand audience needs and to assimilate source material.
Creates draft content to meet the requirements of the audience as clearly, simply and quickly as possible.
Applies guidelines and standards to moderate content from others, escalating where appropriate.'),
(15238, 3, 'Produz artefatos de informação que são precisos, atuais, relevantes e facilmente compreensíveis pelo público-alvo.
Esclarece requisitos de conteúdo detalhados com clientes e representantes do público-alvo.
Projeta, cria, controla e avalia assuntos moderadamente complexos.
Toma decisões sobre a melhor maneira de apresentar informações a um determinado público. Aplica processos de moderação e edição ao conteúdo fornecido por terceiros.', 'Produces information artefacts that are accurate, current, relevant and easily understood by the intended audience.
Clarifies detailed content requirements with clients and representatives of the intended audience.
Designs, creates, controls and evaluates moderately complex subject matter.
Makes informed decisions about the best way to present information to an audience. Applies moderation and editing processes to content supplied by others.'),
(15238, 4, 'Projeta o conteúdo e a aparência de artefatos de informação complexos.
Controla, monitora e avalia o conteúdo para garantir a qualidade, consistência e acessibilidade das mensagens e o uso ideal da mídia escolhida. Entende e gerencia os riscos associados à publicação de conteúdo.
Modera o conteúdo e garante que o conteúdo possa ser reutilizado adequadamente.
Revisa o trabalho de terceiros e assume a responsabilidade de garantir a publicação apropriada.', 'Designs the content and appearance of complex information artefacts.
Controls, monitors and evaluates content to ensure quality, consistency and accessibility of messages and optimal use of chosen media. Understands and manages risks associated with publishing content.
Moderates content and ensures content can be re-purposed appropriately.
Reviews work of others and takes responsibility for ensuring appropriate publication.'),
(15238, 5, 'Fornece controle editorial geral em toda a equipe ou equipes de projetistas de conteúdo e autores.
Aconselha sobre formatos e mídias de conteúdo apropriados.
Desenvolve e mantém planos de conteúdo mostrando como as necessidades do público identificadas serão atendidas.
Supervisiona a revisão e aprovação de materiais para permitir que os requisitos sejam satisfeitos.', 'Provides overall editorial control across the team or teams of content designers and authors.
Advises on appropriate content formats and mediums.
Develops and maintains content plans showing how the identified audience needs will be met.
Oversees the review and approval of materials to enable requirements to be satisfied.'),
(15238, 6, 'Obtém o compromisso organizacional com políticas, normas e estratégias para criar o conteúdo necessário.
Especifica padrões e métodos de projeto para atender aos objetivos organizacionais para criação de conteúdo.
Planeja e lidera a criação de conteúdo para programas estratégicos, grandes e complexos.', 'Obtains organisational commitment to policies, standards and strategies to create required content.
Specifies design standards and methods to meet organisational objectives for content creation.
Plans and leads content creation for strategic, large and complex programmes.'),
(15239, 1, 'Contribui, sob instrução, para atividades de apoio à publicação.
Dá suporte à coleta de dados.
Utiliza processos de publicação estabelecidos de acordo com diretrizes apropriadas.', 'Contributes, under instruction, to publication support activities.
Supports the collation of data.
Uses established publishing processes and procedures following appropriate guidelines.'),
(15239, 2, 'Utiliza conceitos, ferramentas e métodos técnicos de publicação para publicar conteúdo seguindo procedimentos e diretrizes acordados.
Prepara e formata conteúdo para atender às necessidades do público-alvo e da plataforma.
Obtém e analisa dados de uso e os apresenta de forma eficaz.
Aplica princípios de usabilidade e acessibilidade às informações publicadas.', 'Uses technical publication concepts, tools, and methods to publish content following agreed procedures and guidelines.
Prepares and formats content to meet the needs of the target audience and platform.
Obtains and analyses usage data and presents it effectively.
Applies principles of usability and accessibility to published information.'),
(15239, 3, 'Coordena processos e procedimentos de gerenciamento de conteúdo para atender às necessidades dos usuários.
Utiliza sistemas de publicação de conteúdo para gerenciar conteúdo publicado em vários canais.
Ajuda a identificar e trabalhar com criadores de conteúdo.
Considera todas as questões legais relacionadas à publicação.', 'Coordinates content management processes and procedures to meet the needs of users.
Uses content publishing systems to manage published content across different channels.
Assists in identifying and working with content creators.
Considers all legal issues related to publishing.'),
(15239, 4, 'Aplica diretrizes organizacionais e utiliza ferramentas e técnicas apropriadas para oferecer interfaces de publicação para plataformas e aplicativos novos ou existentes.
Mantém e atualiza os processos de gerenciamento de conteúdo para atender às necessidades dos usuários. Seleciona os canais apropriados através dos quais o conteúdo deve ser publicado.
Colabora e fornece orientação aos criadores de conteúdo. Fornece aconselhamento aos usuários e autores de conteúdo para alavancar os recursos dos canais e ferramentas relevantes usados.
Identifica as implicações legais associadas à publicação de conteúdo.', 'Applies organisational guidelines and uses appropriate tools and techniques to provide publishing interfaces to new or existing platforms and applications.
Maintains and updates content management processes and practices to meet the needs of users. Selects appropriate channels through which content should be published.
Collaborates with and provides guidance to content creators. Provides advice to users and content authors to leverage the features of the relevant channels and tools used.
Identifies the legal implications associated with publishing.'),
(15239, 5, 'Planeja e gerencia atividades e atribuições de publicação de conteúdo.
Desenvolve padrões, processos e práticas para publicação consistente de conteúdo em uma ou mais plataformas/canais. Aconselha sobre a abordagem e técnicas a serem usadas para publicação de conteúdo.
Aconselha sobre abordagens para publicação de conteúdo e colaborações de criadores. Assegura o projeto da estrutura e estilo geral do conteúdo.
Assegura que os processos de publicação estejam em conformidade com as políticas e estratégias acordadas e os requisitos legais.', 'Plans and manages content publishing activities and assignments.
Develops standards, processes and practices for consistent content publishing across one or more platforms/channels. Advises on the approach and techniques to be used for content publishing.
Advises on approaches for content publishing and creator collaborations. Assures design of the overall content structure and style.
Ensures publication processes comply with agreed policies and strategies and legal requirements.'),
(15239, 6, 'Obtém compromisso organizacional e recursos para garantir a qualidade apropriada do material publicado pela organização, ou em seu nome.
Define políticas organizacionais, normas e técnicas para publicação de conteúdo.
Planeja e conduz atividades de publicação de conteúdo para programas estratégicos, grandes e complexos.
Garante que as políticas sejam implementadas e quaisquer questões legais relacionadas à publicação de conteúdo sejam gerenciadas adequadamente.', 'Obtains organisational commitment and resources to ensure the appropriate quality of material published by or on behalf of the organisation.
Defines organisational policies, standards, processes and practices for content publishing, including creator partnerships.
Plans and leads content publishing activities for strategic, large and complex programmes.
Ensures policies are implemented and any legal issues related to publishing are adequately managed.'),
(15240, 2, 'Mantém registros de todos os testes e treinamentos relacionados e garante a disponibilidade de toda a documentação.
Registra as ações tomadas e as consequências após um incidente ou o teste prático de um plano de continuidade para um relatório de lições aprendidas.', 'Maintains records of all related testing and training and ensures the availability of all documentation.
Records the actions taken and the consequences following an incident or live testing of a continuity plan for a lessons-learned report.'),
(15240, 3, 'Aplica uma abordagem estruturada para desenvolver e documentar os detalhes de um plano de continuidade.
Mantém a documentação dos planos de continuidade de negócios e de recuperação de desastres.
Apoia o desenvolvimento de um plano de testes e a implementação de exercícios de gestão da continuidade.', 'Applies a structured approach to develop and document the detail for a continuity plan.
Maintains documentation of business continuity and disaster recovery plans.
Supports the development of a test plan and implementation of continuity management exercises.'),
(15240, 4, 'Contribui para o desenvolvimento de planos de gestão de continuidade.
Identifica os sistemas de informação e comunicação que suportam os processos críticos do negócio.
Coordena a análise de impacto ao negócio e a avaliação de riscos.
Coordena o planejamento, projeto e teste de planos de contingência.', 'Contributes to the development of continuity management plans.
Identifies information and communication systems that support critical business processes.
Coordinates the business impact analysis and the assessment of risks.
Coordinates the planning, designing and testing of contingency plans.'),
(15240, 5, 'Gerencia o desenvolvimento, implementação e teste de planos de gestão da continuidade.
Gerencia o relacionamento com pessoas e equipes que têm autoridade para processos críticos de negócios e sistemas de suporte.
Avalia os riscos críticos e identifica áreas prioritárias para melhoria.
Testa os planos e procedimentos de gestão da continuidade para garantir que abordem a exposição ao risco e que os níveis acordados de continuidade possam ser mantidos.', 'Manages the development, implementation and testing of continuity management plans.
Manages the relationship with individuals and teams who have authority for critical business processes and supporting systems.
Evaluates the critical risks and identifies priority areas for improvement.
Tests continuity management plans and procedures to ensure they address exposure to risk and that agreed levels of continuity can be maintained.'),
(15240, 6, 'Define a estratégia para a gestão da continuidade em toda a organização.
Garante o compromisso organizacional, financiamento e recursos para a gestão da continuidade.
Lidera os exercícios de gestão da continuidade.
Comunica a política, governança, escopo e funções envolvidas na gestão da continuidade. Detém autoridade e responsabilidade definidas para as ações e decisões relacionadas a gestão da continuidade.', 'Sets the strategy for continuity management across the organisation.
Secures organisational commitment, funding and resources for continuity management.
Leads continuity management exercises.
Communicates the policy, governance, scope and roles involved in continuity management. Has defined authority and accountability for the actions and decisions for continuity management'),
(15241, 2, 'Auxilia na coleta de dados de desempenho de contratos.
Produz relatórios padrão sobre o desempenho de contratos sob supervisão rotineira.', 'Assists in collecting contract performance data.
Produces standard reports on contract performance under routine supervision.'),
(15241, 3, 'Atua como um ponto de contato habitual entre a organização e as contrapartes no que diz respeito à gestão de contratos.
Suporta a coleta de dados de desempenho dos contratos.
Cria relatórios padrão sobre o desempenho dos mesmos.', 'Acts as a routine contact point between the organisation and counterparties concerning contract management.
Supports the collection of contract performance data.
Creates standard reports on contract performance.'),
(15241, 4, 'Fornece e coleta dados de desempenho de contratos (como valores e custos da cadeia de suprimentos) e monitora o seu desempenho em relação aos principais indicadores de desempenho.
Monitora o progresso em relação aos objetivos de negócio especificados no caso de negócio (business case). Monitora o cumprimento dos termos e condições e toma as medidas apropriadas para abordar o não cumprimento.
Identifica e reporta desempenho insatisfatório e desenvolve oportunidades de melhoria. Monitora o progresso em relação aos objetivos de negócio especificados nos casos de negócio (business cases).
Identifica mudanças necessárias e planeja variações. Em consulta com as partes interessadas, garante que os protocolos de gerenciamento de mudanças sejam implementados.', 'Sources and collects contract performance data (such as pricing and supply chain costs), and monitors performance against key performance indicators.
Monitors progress against business objectives specified in the business case. Proactively manages risk and reward mechanisms in the contract.
Identifies and reports under-performance and develops opportunities for improvement. Monitors compliance with terms and conditions and takes appropriate steps to address non-compliance.
Identifies where change is required and plans for variations. Ensures, in consultation with stakeholders, that change management protocols are implemented.'),
(15241, 5, 'Supervisiona e executa a medição do cumprimento das obrigações contratuais.
Utiliza indicadores de desempenho para monitorar e verificar o desempenho e identificar oportunidades de melhoria contínua. Desenvolve estratégias para lidar com falhas de desempenho e conformidade, incluindo a aplicação de termos contratuais.
Identifica mudanças necessárias, avalia o impacto e aconselha as partes interessadas sobre implicações e consequências. Negocia variações e solicita as devidas autorizações.
Apoia e se envolve ativamente com especialistas e partes interessadas para garantir que melhorias contínuas sejam identificadas, por meio de processos de revisão e benchmarking. Desenvolve e implementa protocolos de gerenciamento de mudanças.', 'Oversees and measures the fulfilment of contractual obligations.
Uses key performance indicators to monitor and challenge performance and identify opportunities for continual improvement. Develops strategies to address under-performance and compliance failures, including the application of contract terms.
Identifies where changes are required, evaluates the impact, and advises stakeholders about the implications and consequences. Negotiates variations and seeks appropriate authorisation.
Actively supports and engages with experts and stakeholders to ensure continual improvements are identified through review and benchmarking processes. Develops and implements change management protocols.'),
(15241, 6, 'Negocia e resolve questões contratuais, incluindo o descumprimento de obrigações contratuais.
Promove processos de controle de mudanças e lidera negociações de variações quando necessário. Lidera programas de melhoria contínua, desenvolvendo conjuntamente estratégias e incentivos para melhoria de desempenho. Realiza avaliações financeiras abrangentes.
Assegura a diligência devida e verificação legal que sustenta todos os processos de aquisição, confirmando a avaliação de risco e o cumprimento nos compromissos contratuais. Assegura que as lições aprendidas das revisões sejam documentadas e promovidas a todas as partes interessadas.
Lidera o avanço e a aplicação de práticas eficazes de gerenciamento de contratos dentro de um domínio ou categoria de negócios específica.', 'Negotiates and resolves contractual issues, including failure to meet contractual obligations.
Promotes change control processes and leads variation negotiations when necessary. Champions continual improvement programmes, jointly developing strategies and incentives to enhance performance. Undertakes comprehensive financial evaluations.
Ensures due diligence and legal vetting underpin all procurement processes, affirming risk assessment and compliance in contractual engagements. Ensures lessons learned from reviews are documented and promoted to all stakeholders.
Leads the advancement and application of effective contract management practices within a specific business domain or category.'),
(15241, 7, 'Lidera a direção estratégica e a governança dos processos de gerenciamento de contratos em toda a organização.
Consulta a liderança executiva sobre riscos e estratégias de gerenciamento de contratos. Implementa estratégias de gerenciamento de contratos alinhadas com objetivos organizacionais e dinâmicas de mercado, incluindo supervisão de contratos significativos e riscos legais associados. Atua como ponto de escalada para disputas importantes.
Promove excelência operacional na gerenciamento de contratos, impulsiona melhorias na contratação da cadeia de suprimentos e inovação.
Estabelece parcerias estratégicas, alinha objetivos organizacionais e de fornecedores. Representa a organização em negociações-chave, garantindo resultados estratégicos e alinhados com a conformidade.', 'Leads the strategic direction and governance of contract management processes across the organisation.
Advises executive leadership on contract management risks and strategies. Implements contract management strategies aligned with organisational goals and market dynamics, including oversight of significant contracts and associated legal risks. Acts as the escalation point for major disputes.
Promotes operational excellence in contract management, driving supply chain contracting improvements and innovation.
Establishes strategic partnerships, aligning organisational and supplier goals. Represents the organisation in key negotiations, ensuring strategic, compliant outcomes.'),
(6887, 2, 'Ajuda na coleta de dados de custos e preparação de relatórios básicos de custos sob supervisão.
Apoia o processo de gestão de custos completando tarefas atribuídas e procurando orientação quando necessário.', 'Assists in gathering cost data and preparing basic cost reports under supervision.
Supports the cost management process by completing assigned tasks and seeking guidance when needed.'),
(6887, 3, 'Aplica técnicas e processos padrão de gestão de custos para monitorar e relatar os custos em uma área específica de responsabilidade.
Identifica e reporta variações de custos, apoiando a implementação de iniciativas de redução de custos.
Colabora com as partes interessadas para coletar dados de custos e fornecer relatórios.', 'Applies standard cost management techniques and processes to monitor and report on costs within a specific area of responsibility.
Identifies and escalates cost variances and supports the implementation of cost-saving initiatives.
Collaborates with stakeholders to gather cost data and provide reports.'),
(6887, 4, 'Desenvolve e implementa processos e procedimentos de gestão de custos para um departamento ou função.
Monitora o desempenho real em relação ao orçamento e identifica variações.
Analisa custos, identifica tendências e recomenda ações corretivas.
Fornece orientação e aconselhamento sobre técnicas e ferramentas de gestão de custos.', 'Develops and implements cost management processes and procedures for a department or function.
Monitors actual performance against budget and identifies variances.
Analyses costs, identifies trends and recommends corrective actions.
Provides guidance and advice on cost management techniques and tools.'),
(6887, 5, 'Lidera o desenvolvimento e implementação de estratégias, políticas e procedimentos de gestão de custos para uma área significativa da organização.
Fornece aconselhamento e orientação autorizados sobre técnicas de otimização de custos e boas práticas reconhecidas.
Supervisiona o desenvolvimento de modelos de custos complexos e quadros de relatórios. Apresenta percepções de gestão de custos para as partes interessadas seniores e facilita a tomada de decisões orientadas por dados.
Promove uma cultura de conscientização de custos e melhoria contínua.', 'Leads the development and implementation of cost management strategies, policies and procedures for a significant area of the organisation.
Provides authoritative advice and guidance on cost optimisation techniques and recognised good practices.
Oversees the development of complex cost models and reporting frameworks. Presents cost management insights to senior stakeholders and facilitates data-driven decision-making.
Promotes a culture of cost consciousness and continuous improvement.'),
(6887, 6, 'Define e lidera a abordagem global da organização para a gestão de custos, alinhando-a com objetivos estratégicos e metas financeiras.
Desenvolve e implementa políticas, normas e processos de gestão de custos em toda a organização.
Colabora com líderes seniores para identificar e impulsionar iniciativas de otimização de custos. Fornece percepções estratégicas e recomendações para otimizar o desempenho de custos e impulsionar a criação de valor a longo prazo.
Estabelece a visão e a direção para a gestão de custos em toda a organização.', 'Defines and leads the organisation''s overall approach to cost management, aligning it with strategic objectives and financial goals.
Develops and implements enterprise-wide cost management policies, standards and processes.
Collaborates with senior leaders to identify and drive cost optimisation initiatives. Provides strategic insights and recommendations to optimise cost performance and drive long-term value creation.
Sets the vision and direction for cost management across the organisation.'),
(15242, 3, 'Auxilia na implementação de iniciativas de engajamento e fidelização de clientes.
Utiliza tecnologias de marketing para tarefas de engajamento de clientes. Configura campanhas em ferramentas de gerenciamento de ciclo de vida.
Coleta e analisa dados de clientes para suportar comunicações personalizadas.
Monitora e reporta métricas de engajamento de clientes.', 'Assists in implementing customer engagement and loyalty initiatives.
Uses marketing technologies for customer engagement tasks. Sets up campaigns in lifecycle management tools.
Collects and analyses customer data to support personalised communications.
Monitors and reports on customer engagement metrics.'),
(15242, 4, 'Desenvolve e executa iniciativas de engajamento e fidelização de clientes.
Cria e administra programas de fidelização.
Analisa dados de clientes para apoiar comunicações direcionadas e experiências. Desenvolve abordagens de segmentação de clientes.
Aplica tecnologias de marketing apropriadas para apoiar iniciativas. Elabora métricas e relatórios sobre a eficácia dos esforços de engajamento e fidelização.', 'Develops and executes customer engagement and loyalty initiatives.
Creates and manages loyalty programmes.
Analyses customer data to inform targeted communications and experiences. Develops customer segmentation approaches.
Applies appropriate marketing technologies to support initiatives. Measures and reports on the effectiveness of engagement and loyalty efforts.'),
(15242, 5, 'Dirige o desenvolvimento e implementação de planos abrangentes de engajamento e fidelização de clientes.
Supervisiona a criação e gestão de programas e iniciativas de fidelização. Desenvolve planos abrangentes para a comunicação com o cliente em todas as fases do ciclo de vida.
Utiliza análises avançadas para otimizar experiências personalizadas de clientes. Fornece recomendações com base em engajamento de clientes e insights de fidelização.
Colabora com equipes multifuncionais para melhorar a retenção e satisfação do cliente. Avalia e recomenda tecnologias de marketing para engajamento do cliente.', 'Leads the development and implementation of comprehensive customer engagement and loyalty plans.
Oversees the creation and management of loyalty programmes and initiatives. Develops comprehensive plans for customer communications across all lifecycle stages.
Uses advanced analytics to optimise personalised customer experiences. Provides recommendations based on customer engagement and loyalty insights.
Collaborates with cross-functional teams to improve customer retention and satisfaction. Evaluates and recommends marketing technologies for customer engagement.'),
(15242, 6, 'Define a visão e a estratégia organizacional para engajamento e fidelização do cliente.
Direciona a inovação no desenvolvimento e implementação de programas de fidelidade. Alinha estratégias de engajamento de clientes com os objetivos globais do negócio.
Lidera a avaliação e adoção de tecnologias de marketing avançadas. Dirige o desenvolvimento de jornadas do cliente e estratégias de gerenciamento de bancos de dados.
Assegura a integração de iniciativas de engajamento de clientes em todas as funções do negócio.', 'Defines organisational vision and strategy for customer engagement and loyalty.
Drives innovation in loyalty programme development and implementation. Aligns customer engagement strategies with overall business objectives.
Leads the assessment and adoption of advanced marketing technologies. Directs the development of customer journeys and database management strategies.
Ensures integration of customer engagement initiatives across all business functions.'),
(4105, 2, 'Auxilia na criação de mapas das viagens do cliente e identifica pontos de contato importantes para melhoria.
Segue procedimentos estabelecidos para documentar o feedback do cliente e dá suporte à implementação de pequenas melhorias..', 'Assists in the creation of customer journey maps and identifies key touchpoints for improvement.
Follows established procedures to document customer feedback and support the implementation of minor improvements.'),
(4105, 3, 'Analisa pesquisas para reunir insights detalhados sobre as necessidades e preferências dos clientes.
Utiliza ferramentas e métodos apropriados para coleta de dados. Participa do projeto e otimização das viagens dos clientes.
Colabora com membros da equipe para implementar melhorias na experiência do cliente.
Documenta os resultados e apoia o processo de análise.', 'Analyses research to gather detailed insights into customer needs and preferences.
Uses appropriate tools and methods for data collection. Participates in the design and optimisation of customer journeys.
Collaborates with team members to implement customer experience improvements.
Documents findings and supports the analysis process.'),
(4105, 4, 'Utiliza os resultados da pesquisa do cliente para obter uma compreensão abrangente das necessidades e expectativas do cliente.
Permite a criação de representações visuais das viagens do cliente para melhorar a colaboração interfuncional. Projeta e refinar as viagens do cliente, trabalhando com equipes interfuncionais para melhorar pontos de contato e interações.
Desenvolve e implementar projetos para melhorar a experiência do cliente. Recomendar e aplica tecnologias apropriadas e insights de segmentação para melhorar as experiências do cliente.
Monitora métricas e realizar feedback para avaliar a eficácia e impulsionar a melhoria contínua.', 'Uses customer research findings to gain a comprehensive understanding of customer needs and expectations.
Enables the creation of visual representations of customer journeys to enhance cross-functional collaboration. Designs and refines customer journeys, working with cross-functional teams to enhance touchpoints and interactions.
Develops and implements designs to improve customer experience. Recommends and applies appropriate technologies and segmentation insights to enhance customer experiences.
Monitors metrics and feedback to assess effectiveness and drive continuous improvement.'),
(4105, 5, 'Planeja e supervisiona iniciativas de experiência do cliente.
Assegura o alinhamento com objetivos de negócios e expectativas do cliente.
Estabelece quadros para monitorar e medir a experiência do cliente. Utiliza insights baseados em dados para orientar melhorias.
Assegura que os projetos de experiência do cliente aproveitem insights do cliente e tecnologias emergentes para experiências personalizadas. Trabalha com as partes interessadas de alto nível para desenvolver e implementar estratégias de experiência do cliente. Promove a colaboração entre as equipes para garantir uma experiência consistente.', 'Plans and oversees customer experience initiatives.
Ensures alignment with business goals and customer expectations.
Establishes frameworks for monitoring and measuring customer experience. Uses data-driven insights to guide improvements.
Ensures customer experience designs leverage customer insights and emerging technologies for personalised experiences. Works with senior stakeholders to develop and implement customer experience strategies. Drives collaboration across teams to ensure a consistent experience.'),
(4105, 6, 'Promove a experiência do cliente em nível organizacional.
Lidera iniciativas estratégicas para melhorar a experiência do cliente, incluindo a avaliação e adoção de tecnologias e abordagens inovadoras. Alinha esforços com objetivos de negócios e necessidades do cliente.
Monitora tendências e inovações da indústria na experiência do cliente.
Desenvolve políticas e normas para orientar as práticas de experiência do cliente. Assegura a adoção de boas práticas e melhoria contínua dentro da organização.', 'Champions customer experience at an organisational level.
Leads strategic initiatives to enhance customer experience, including the evaluation and adoption of innovative technologies and approaches. Aligns efforts with business objectives and customer needs.
Monitors industry trends and innovations in customer experience.
Develops policies and standards to guide customer experience practices. Ensures adoption of good practices and continuous improvement within the organisation.'),
(1161, 1, 'Recebe e trata consultas e solicitações de clientes de rotina, seguindo procedimentos estabelecidos.
Regista com precisão as interações com os clientes e mantém registros relevantes.
Escala questões complexas para membros da equipe ou departamentos apropriados.', 'Receives and handles routine customer inquiries and requests, following established procedures.
Accurately records customer interactions and maintains relevant records.
Escalates complex issues to appropriate team members or departments.'),
(1161, 2, 'Responde a solicitações comuns de atendimento ao cliente, fornecendo informações para permitir o cumprimento ou resolução.
Atribui chamadas, solicitações ou problemas não resolvidos a funções apropriadas.
Contribui para a manutenção de bases de conhecimento e documentação de atendimento ao cliente.
Ajuda a monitorar métricas de satisfação do cliente.', 'Responds to common customer service requests, providing information to enable fulfilment or resolution.
Allocates unresolved calls, requests, or issues to appropriate functions.
Contributes to the maintenance of customer service knowledge bases and documentation.
Assists in monitoring customer satisfaction metrics.'),
(1161, 3, 'Funciona como um ponto de contato de rotina para os clientes, lidando com uma ampla gama de consultas e solicitações de serviço.
Realiza investigação inicial e diagnóstico de problemas do cliente, resolvendo-os quando possível ou escalando conforme necessário.
Contribui para o desenvolvimento de padrões e procedimentos de serviço.
Ajuda a analisar dados de desempenho do serviço e identificar áreas para melhoria.', 'Acts as a routine contact point for customers, handling a wide range of inquiries and service requests.
Performs initial investigation and diagnosis of customer issues, resolving them where possible or escalating as needed.
Contributes to the development of service standards and procedures.
Assists in analysing service performance data and identifying areas for improvement.'),
(1161, 4, 'Monitora a entrega de serviços através de vários canais e analisa dados de desempenho.
Contribui para o desenvolvimento e implementação de padrões e procedimentos de serviço. Fornece orientação técnica e processual aos membros da equipe.
Identifica tendências nas consultas de clientes e questões de serviço, recomenda melhorias de processos.
Colabora com outros departamentos para melhorar a experiência global do cliente.', 'Monitors service delivery across multiple channels and analyses performance data.
Contributes to the development and implementation of service standards and procedures. Provides technical and procedural guidance to team members.
Identifies trends in customer inquiries and service issues, recommending process improvements.
Collaborates with other departments to enhance the overall customer experience.'),
(1161, 5, 'Gerencia as operações diárias da função de atendimento ao cliente, incluindo planejamento de recursos e alocação de tarefas.
Desenvolve e implementa padrões, políticas e procedimentos de serviço. Analisa métricas de serviço e feedback do cliente para impulsionar iniciativas de melhoria contínua.
Assegura que o catálogo de serviços seja abrangente, atualizado e alinhado com os objetivos organizacionais.
Desenvolve abordagens para melhorar a satisfação do cliente.', 'Manages day-to-day operations of the customer service function, including resource planning and work allocation.
Develops and implements service standards, policies and procedures. Analyses service metrics and customer feedback to drive continuous improvement initiatives.
Ensures the service catalogue is comprehensive, up-to-date and aligned with organisational goals.
Develops approaches to enhance customer satisfaction.'),
(1161, 6, 'Define a direção estratégica para o atendimento ao cliente em toda a organização.
Define os canais de serviço, os níveis de serviço, os padrões e o processo de monitoramento para o atendimento ao cliente ou o pessoal da central de serviço. Lidera a cultura de serviço necessária para entregar resultados organizacionais.
Lidera o desenvolvimento e implementação de frameworks organizacionais para reclamações, padrões de serviço e acordos operacionais.
Assume a responsabilidade pela continuidade dos negócios e pela conformidade legal, regulatória e contratual.', 'Shapes the strategic direction for customer service across the organisation.
Defines service channels, service levels, standards and the monitoring process for customer service or service desk staff. Champions the service culture required to deliver organisational outcomes.
Leads the development and implementation of organisational frameworks for complaints, service standards and operational agreements.
Takes responsibility for business continuity and legal, regulatory and contractual compliance.'),
(947, 2, 'Oferece assistência em investigações de cibercrime sob supervisão rotineira.
Apoia a coleta de evidências relacionadas com investigações de cibercrime.
Participa no monitoramento de atividades suspeitas.
Ajuda a manter a integridade das evidências e auxilia em entrevistas preliminares. Segue protocolos e diretrizes estabelecidos.', 'Assists in cybercrime investigations under routine supervision.
Supports the collection of evidence related to cybercrime investigations.
Participates in monitoring suspicious activities.
Helps maintain evidence integrity and assists in preliminary interviews. Follows established protocols and guidelines.'),
(947, 3, 'Realiza investigações de cibercrime usando procedimentos padronizados.
Recolhe e preserva várias formas de evidência em casos de cibercrime. Avalia a credibilidade e verifica a conformidade com os padrões de investigação relevantes.
Analisa ameaças e incidentes básicos de cibersegurança e prepara relatórios de investigação. Identifica incidentes que possam ter implicações legais.
Realiza entrevistas e auxilia em interrogatórios.', 'Conducts cybercrime investigations using standard procedures.
Collects and preserves various forms of evidence in cybercrime cases. Assesses credibility and checks for compliance with relevant investigative standards.
Analyses basic cyber threats and incidents, and prepares investigative reports. Identifies incidents that may have legal implications.
Conducts interviews and assists in interrogations.'),
(947, 4, 'Supervisiona as investigações de nível médio, coordena a coleta de evidências e análises forenses.
Avalia vulnerabilidades e impactos operacionais de incidentes cibernéticos.
Fornece relatórios abrangentes e análises de peritos para as partes interessadas.
Realiza entrevistas e interrogatórios, identifica possíveis implicações legais e colabora com profissionais jurídicos.', 'Oversees mid-level investigations, coordinating evidence collection and forensic analyses.
Assesses target vulnerabilities and operational impacts of cyber incidents.
Provides comprehensive reports and expert analysis for stakeholders.
Conducts interviews and interrogations, identifying potential legal implications and collaborating with legal professionals.'),
(947, 5, 'Gerencia investigações complexas de cibercrime, supervisionando todas as etapas, desde a detecção até a resolução.
Avalia incidentes envolvendo ameaças avançadas ou violações significativas.
Desenvolve e implementa procedimentos para manipulação de evidências e documentação. Colabora com equipes jurídicas para garantir que as evidências apoiem potenciais processos legais.
Lidera o desenvolvimento de estratégias de resposta, avaliação de vulnerabilidades e capacidades operacionais. Supervisiona a implementação de ferramentas e automação para aperfeiçoar os processos de investigação.', 'Manages complex cybercrime investigations, overseeing all stages from detection to resolution.
Evaluates incidents involving advanced threats or significant breaches.
Develops and implements procedures for evidence handling and documentation. Collaborates with legal teams to ensure evidence supports potential legal proceedings.
Leads the development of response strategies, assessing vulnerabilities and operational capabilities. Oversees the implementation of tools and automation to enhance investigative processes.'),
(947, 6, 'Define a estratégia organizacional para investigações de cibercrime.
Estabelece políticas e padrões para tratar diversas formas de evidências em casos de cibercrime, incluindo a adoção e integração de ferramentas e automação para aperfeiçoar a eficiência e precisão.
Supervisiona investigações de alto risco ou sensíveis, gerencia equipes interdisciplinares. Realiza entrevistas e interrogatórios de alto nível, fornecendo insights estratégicos sobre ameaças e vulnerabilidades de cibersegurança.
Engaja-se com partes interessadas externas, incluindo órgãos regulatórios e entidades legais, para garantir conformidade com padrões legais e éticos.', 'Defines the organisational strategy for cybercrime investigations.
Establishes policies and standards for handling various forms of evidence in cybercrime cases, including the adoption and integration of tools and automation to improve efficiency and accuracy.
Oversees high-risk or sensitive investigations, managing cross-disciplinary teams. Conducts high-level interviews and interrogations, providing strategic insights on cybersecurity threats and vulnerabilities.
Engages with external stakeholders, including regulatory bodies and legal entities, to ensure compliance with legal and ethical standards.'),
(8349, 2, 'Auxilia na preparação e nas atividades de análise de dados sob orientação.
Processa e valida dados para dar suporte à análise.
Gera relatórios e insights padrão usando ferramentas e métodos estabelecidos.', 'Assists in data preparation and analysis activities under direction.
Processes and validates data to support analytics.
Generates standard reports and insights using established tools and methods.'),
(8349, 3, 'Oferece suporte à análise de dados reunindo e preparando dados de várias fontes.
Aplica métodos analíticos e estatísticos e ferramentas de software para analisar dados e desenvolver relatórios.
Auxilia na identificação de tendências, padrões e insights que informam decisões de negócios.
Colabora com membros da equipe para refinar técnicas de análise e manter a qualidade dos dados.', 'Supports data analytics by gathering and preparing data from multiple sources.
Applies analytical and statistical methods and software tools to analyse data and develop reports.
Assists in identifying trends, patterns and insights that inform business decisions.
Collaborates with team members to refine analysis techniques and maintain data quality.'),
(8349, 4, 'Conduzir análise de dados de ponta a ponta, define requisitos de dados e garante a integridade dos dados.
Aplica técnicas analíticas e estatísticas avançadas para extrair insights significativos e desenvolve modelos preditivos.
Comunica descobertas complexas para as partes interessadas de forma compreensível.
Contribui para o desenvolvimento de processos e padrões de análise de dados. Identifica oportunidades para melhorar as práticas de análise de dados.', 'Conducts end-to-end data analysis, defining data requirements and ensuring data integrity.
Applies advanced analytical and statistical techniques to extract meaningful insights and develop predictive models.
Communicates complex findings to stakeholders in an understandable manner.
Contributes to the development of data analytics processes and standards. Identifies opportunities for improving data analytics practices.'),
(8349, 5, 'Gerencia atividades de análise de dados, estabelecendo frameworks e metodologias alinhadas com objetivos de negócios e políticas de governança de dados.
Conduzir a implementação de soluções de análise de dados. Transformar necessidades de negócios em requisitos de análise e identifica soluções orientadas por dados.
Guiar a seleção e aplicação de técnicas de análise avançadas.
Comunicar insights e recomendações para as partes interessadas seniores, influenciando decisões estratégicas.', 'Manages data analytics activities, establishing frameworks and methodologies aligned with business objectives and data governance policies.
Leads the implementation of data analytics solutions. Translates business needs into analytics requirements and identifies data-driven solutions.
Guides the selection and application of advanced analytical techniques.
Communicates insights and recommendations to senior stakeholders, influencing strategic decisions.'),
(8349, 6, 'Desenvolve estratégias organizacionais e roteiros para análise de dados.
Define políticas, normas e práticas recomendadas para o uso de dados e técnicas de análise de dados.
Lidera iniciativas para construir capacidades de análise de dados e desenvolver uma cultura orientada por dados.
Supervisiona a entrega de projetos e programas de análise. Promove o uso ético de dados e análise de dados.', 'Develops organisational strategies and roadmaps for data analytics.
Sets policies, standards and recommended practices for the use of data and data analytical techniques.
Leads initiatives to build data analytics capabilities and develop a data-driven culture.
Oversees the delivery of analytics projects and programmes. Promotes the ethical use of data and data analytics.'),
(8349, 7, 'Direciona a criação e revisão de uma abordagem e cultura cross-funcional, em toda a empresa, para gerar valor a partir de análise de dados e ciência de dados.
Dirige a identificação, avaliação e adoção de capacidades de análise de dados e ciência de dados para transformar o desempenho organizacional. Dirige o fornecimento de capacidades de análise de dados e ciência de dados da organização.
Assegura que a aplicação estratégica de análise de dados e ciência de dados esteja incorporada na governança e liderança da organização.
Alinha estratégias de negócios, transformação empresarial e análise de dados e estratégias de ciência de dados.', 'Directs the creation and review of a cross-functional, enterprise-wide approach and culture for generating value from data analytics and data science.
Drives the identification, evaluation and adoption of data analytics and data science capabilities to transform organisational performance. Leads the provision of the organisation’s data analytics and data science capabilities.
Ensures the strategic application of data analytics and data science is embedded in the governance and leadership of the organisation.
Aligns business strategies, enterprise transformation and data analytics and data science strategies.'),
(3962, 2, 'Auxilia no desenvolvimento e implementação de pipelines e armazenamento de dados.
Executa tarefas administrativas para fornecer acessibilidade, recuperação, segurança e proteção de dados.
Dá suporte ao monitoramento das operações de pipeline de dados, identifica problemas e escala se necessário.
Participa de tarefas de migração e conversão de dados sob supervisão de rotina.', 'Assists in developing and implementing data pipelines and data stores.
Performs administrative tasks to provide data accessibility, retrievability, security and protection.
Supports the monitoring of data pipeline operations, identifying issues and escalating as needed.
Participates in data migration and conversion tasks under routine supervision.'),
(3962, 3, 'Segue abordagens padrão e os padrões de projeto estabelecidos para criar e implementar pipelines de dados simples e o armazenamento de dados para obter e preparar dados.
Aplica padrões e ferramentas de engenharia de dados para criar e manter pipelines de dados e executar processos de extração, transformação e carga (ETL), incorporando práticas de segurança e integridade de dados.
Contribui para projetos de migração e conversão de dados, garantindo a integridade e a consistência de dados.
Realiza verificações e correções rotineiras da qualidade dos dados.', 'Follows standard approaches and established design patterns to create and implement simple data pipelines and data stores to acquire and prepare data.
Applies data engineering standards and tools to create and maintain data pipelines and perform extract, transform and load (ETL) processes, incorporating security and data integrity practices.
Contributes to data migration and conversion projects, ensuring data integrity and consistency.
Conducts routine data quality checks and remediation.'),
(3962, 4, 'Projeta, implementa e mantém soluções complexas de engenharia de dados para obter e preparar dados.
Cria e mantém pipelines de dados para conectar o armazenamentos de dados, aplicações e organizações. Desenvolve em conformidade com a governança de dados e padrões de segurança.
Dá suporte ao desenvolvimento de práticas de integração e implantação contínuas. Monitora e otimiza o desempenho e a escalabilidade dos pipelines.
Realiza verificação da qualidade de dados complexos e a correção de problemas. Conduz atividades de migração de dados e conversão de dados.', 'Designs, implements and maintains complex data engineering solutions to acquire and prepare data.
Creates and maintains data pipelines to connect data across data stores, applications and organisations. Builds in compliance with data governance and security standards.
Supports the development of continuous integration and deployment practices. Monitors and optimises pipeline performance and scalability.
Conducts complex data quality checking and remediation. Leads data migration and data conversion activities.'),
(3962, 5, 'Planeja e impulsiona o desenvolvimento de soluções de engenharia de dados, equilibrando requisitos funcionais e não funcionais.
Monitora a aplicação de padrões de dados, arquiteturas e segurança, garantindo a conformidade e escalabilidade.
Desenvolve e promove práticas contínuas de integração, implantação e monitoramento.
Contribui para políticas organizacionais, padrões e diretrizes para engenharia de dados.', 'Plans and drives the development of data engineering solutions, balancing functional and non-functional requirements.
Monitors application of data standards, architectures and security, ensuring compliance and scalability.
Develops and promotes continuous integration, deployment and monitoring practices.
Contributes to organisational policies, standards and guidelines for data engineering.'),
(3962, 6, 'Orienta a seleção e desenvolvimento de métodos, ferramentas e técnicas de engenharia de dados.
Desenvolve políticas, padrões e diretrizes organizacionais para o desenvolvimento e operação segura de serviços e produtos de dados.
Garante a adesão a estratégias e arquiteturas técnicas.
Planeja e lidera a engenharia de dados para programas estratégicos, de alto impacto, grandes e complexos, garantindo o alinhamento com os objetivos organizacionais e as práticas do setor.', 'Leads the selection and development of data engineering methods, tools and techniques.
Develops organisational policies, standards and guidelines for the development and secure operation of data services and products.
Ensures adherence to technical strategies and architectures.
Plans and leads data engineering for strategic, high-impact, large and complex programmes ensuring alignment with organisational objectives and industry practices.'),
(15243, 2, 'Ajuda na implementação de atividades de gerenciamento de dados sob orientação próxima e supervisão.
Ajuda a criar e a manter a documentação das atividades de gerenciamento de dados.
Ajuda a identificar e reportar problemas e discrepâncias.', 'Assists in implementing data management activities under close guidance and supervision.
Helps create and maintain documentation of data management activities.
Helps identify and report issues and discrepancies.'),
(15243, 3, 'Implementa práticas padrão de gerenciamento de dados com base em requisitos organizacionais detalhados.
Monitora e mantém a qualidade dos dados através de revisões e verificações de validação regulares.
Comunica os detalhes dos procedimentos de gerenciamento de dados para outras pessoas, ajudando-as a compreender e cumprir.', 'Implements standard data management practices based on detailed organisational requirements.
Monitors and maintains data quality through regular reviews and validation checks.
Communicates the details of data management procedures to others, helping with their understanding and compliance.'),
(15243, 4, 'Desenvolve e implementa a governança de dados e processos de gerenciamento de dados mestres para subconjuntos específicos de dados.
Avalia a integridade dos dados de várias fontes.
Aconselha sobre a transformação de dados entre formatos ou mídia. Mantém e implementa procedimentos de gerenciamento de dados.
Permite a disponibilidade, integridade e busca de dados através de estruturas de dados e metadados formais e respectivas medidas de proteção.', 'Devises and implements data governance and master data management processes for specific subsets of data.
Assesses the integrity of data from multiple sources.
Advises on transformation of data between formats or media. Maintains and implements data handling procedures.
Enables data availability, integrity and searchability through formal data and metadata structures and protection measures.'),
(15243, 5, 'Desenvolve e implementa a governança de dados e processos de gerenciamento de dados mestres.
Deriva estruturas de gerenciamento de dados e metadados para suportar a recuperação, integração, análise, reconhecimento de padrões e interpretação de dados consistentes em toda a organização.
Valida de forma independente informações externas de múltiplas fontes. Planeja práticas eficazes de armazenamento, compartilhamento e publicação de dados dentro da organização.
Identificar e abordar questões que impeçam o uso ótimo de ativos de informação. Fornece aconselhamento especializado para maximizar o valor de ativos de dados, garantindo a qualidade de dados e sua conformidade.', 'Devises and implements data governance and master data management processes.
Derives data management structures and metadata to support consistent data retrieval, integration, analysis, pattern recognition and interpretation across the organisation.
Independently validates external information from multiple sources. Plans effective data storage, sharing and publishing practices within the organisation.
Identifies and addresses issues preventing optimal use of information assets. Provides expert advice to maximise data asset value, ensuring data quality and compliance.'),
(15243, 6, 'Conduz a direção estratégica para a gestão e a governança de dados, estabelecendo políticas e estruturas que estejam alinhadas com os requisitos de negócios e regulamentação.
Deriva uma estratégia global de gerenciamento de dados mestre que apoie o desenvolvimento e operação segura de dados e serviços digitais.
Cria políticas organizacionais, normas e diretrizes para a gestão de dados, garantindo a aplicação de princípios éticos.
Planeja, estabelece e gerencia processos para acesso regular e consistente a fontes de dados externas, garantindo a sua validação e integração.', 'Leads the strategic direction for data management and data governance, establishing policies and frameworks that align with business and regulatory requirements.
Derives an overall strategy of master data management that supports the development and secure operation of data and digital services.
Creates organisational policies, standards and guidelines for data management, ensuring ethical principles are applied.
Plans, establishes and manages processes for regular and consistent access to external data sources, ensuring their validation and integration.'),
(15244, 2, 'Estabelece, modifica ou mantém estruturas de dados simples e componentes associados.
Utiliza técnicas específicas de modelagem e projeto de dados sob orientação.', 'Establishes, modifies or maintains simple data structures and associated components.
Uses specific data modelling and design techniques under guidance.'),
(15244, 3, 'Aplica técnicas padrão de modelagem e projeto de dados, com base em uma compreensão detalhada dos requisitos.
Estabelece, modifica e mantém estruturas de dados e componentes associados.
Comunicar e explicar os detalhes das estruturas de dados e componentes para outras pessoas.', 'Applies standard data modelling and design techniques based upon a detailed understanding of organisational requirements.
Establishes, modifies and maintains data structures and associated components.
Communicates and explain the details of data structures and components to others.'),
(15244, 4, 'Investiga os requisitos de dados corporativos onde há alguma complexidade e ambiguidade.
Planeja atividades de modelagem e projeto de dados, selecionando técnicas e níveis de detalhes apropriados para atender aos objetivos atribuídos.
Fornece aconselhamento e orientação a outras pessoas usando as estruturas de dados e componentes associados.', 'Investigates enterprise data requirements where there is some complexity and ambiguity.
Plans data modelling and design activities, selecting appropriate techniques and levels of detail to meet objectives.
Provides advice and guidance to others using the data structures and associated components.'),
(15244, 5, 'Define padrões para ferramentas e técnicas de modelagem e projeto de dados, informa sobre sua aplicação e garante a conformidade.
Gerencia a investigação dos requisitos de dados corporativos com base em uma compreensão detalhada dos requisitos de informações.
Coordena a aplicação de técnicas de análise, projeto e modelagem para estabelecer, modificar ou manter estruturas de dados e seus componentes associados.
Gerencia a iteração, revisão e manutenção de requisitos e modelos de dados.', 'Sets standards for data modelling and design tools and techniques, advises on their application and ensures compliance.
Manages the investigation of enterprise data requirements based on a detailed understanding of information requirements.
Coordinates the application of analysis, design and modelling techniques to establish, modify or maintain data structures and their associated components.
Manages the iteration, review and maintenance of data requirements and data models.'),
(12900, 2, 'Sob supervisão de rotina, aplica aos dados especificados, técnicas de ciência de dados.
Analisa e reporta descobertas e resolve problemas simples, usando algoritmos incluídos em frameworks e ferramentas de software padrão.', 'Under routine supervision, applies specified data science techniques to data.
Analyses and reports findings and addresses simple issues, using algorithms included within standard software frameworks and tools.'),
(12900, 3, 'Aplica técnicas de ciência de dados padrão a novos problemas e conjuntos de dados usando técnicas de programação especializadas.
Identifica e seleciona as fontes de dados apropriadas e prepara os dados a serem utilizados pelos modelos de ciência de dados.
Avalia os resultados e o desempenho dos modelos de ciência de dados. Identifica e implementar oportunidades para treinar e melhorar modelos e os dados que eles utilizam.
Publica e apresenta relatórios sobre os resultados dos modelos para atender às necessidades do cliente e estar em conformidade com os padrões acordados.', 'Applies standard data science techniques to new problems and datasets using specialised programming techniques.
Identifies and selects appropriate data sources and prepares data to be used by data science models.
Evaluates the outcomes and performance of data science models. Identifies and implements opportunities to train and improve models and the data they use.
Publishes and reports on model outputs to meet customer needs and conform to agreed standards.'),
(12900, 4, 'Investiga problemas e conjunto de dados para avaliar a utilidade de soluções de ciência de dados.
Aplica uma grande variedade de técnicas de ciência de dados e linguagens de programa especializadas. Compreende e aplica regras e diretrizes específicas para a indústria e negócios e antecipa riscos e outras implicações da modelagem.
Seleciona, adquire e integra dados para análise. Formula hipóteses e avalia modelos de ciência de dados. Aconselha sobre a eficácia de técnicas específicas com base em descobertas por análise e pesquisa.
Contribui para o desenvolvimento, avaliação, monitoramento e implantação de soluções de ciência de dados.', 'Investigates problems and datasets to assess the usefulness of data science solutions.
Applies diverse data science techniques and specialised programming languages. Understands and applies rules and guidelines specific to the industry and business, and anticipates risks and other implications of modelling.
Selects, acquires and integrates data for analysis. Formulates hypotheses and evaluates data science models. Advises on the effectiveness of specific techniques based on analysis findings and research.
Contributes to the development, evaluation, monitoring and deployment of data science solutions.'),
(12900, 5, 'Planeja, coordena e conduz todos os estágios do desenvolvimento de soluções de ciência de dados.
Oferece consultoria especializada para avaliar os problemas a serem resolvidos e a necessidade de soluções de ciência de dados. Identificar e justificar quais fontes de dados a serem utilizadas ou adquiridas.
Especifica e aplica técnicas de ciência de dados apropriadas e linguagens de programação especializadas.
Analisa criticamente os benefícios e o valor das técnicas e ferramentas de ciência de dados e recomenda melhorias. Contribui para o desenvolvimento de políticas, normas e diretrizes para desenvolver, avaliar, monitorar e implantar soluções de ciência de dados.', 'Plans, coordinates and drives all stages of the development of data science solutions.
Provides expert advice to evaluate the problems to be solved and the need for data science solutions. Identifies and justifies what data sources to use or acquire.
Specifies and applies appropriate data science techniques and specialised programming languages.
Critically reviews the benefits and value of data science techniques and tools and recommends improvements. Contributes to developing policy, standards and guidelines for developing, evaluating, monitoring and deploying data science solutions.'),
(12900, 6, 'Defende e lidera a introdução e o uso da ciência de dados para impulsionar a inovação e o valor comercial.
Desenvolve e impulsiona a adoção e a aderência a políticas, normas, diretrizes e métodos organizacionais para ciência de dados.
Define a direção e lidera a introdução e o uso de técnicas, metodologias e ferramentas de ciência de dados. Lidera o desenvolvimento de capacidades organizacionais para ciência de dados.
Planeja e lidera iniciativas estratégicas, grandes e complexas de ciência de dados para gerar insights, criar valor e impulsionar a tomada de decisões.', 'Champions and leads the introduction and use of data science to drive innovation and business value.
Develops and drives adoption of and adherence to organisational policies, standards, guidelines and methods for data science.
Sets direction and leads in the introduction and use of data science techniques, methodologies and tools. Leads the development of organisational capabilities for data science.
Plans and leads strategic, large and complex data science initiatives to generate insights, create value and drive decision-making.'),
(14703, 2, 'Cria visualizações de dados padrão usando produtos, ferramentas e técnicas estabelecidas, sob supervisão de rotina.
Auxilia na atualização e refinamento de visualizações de dados existentes para manter a representação eficaz de conceitos, ideias e fatos.', 'Creates standard data visuals using established products, tools and techniques, under routine supervision.
Assists in updating and refining existing data visualisations to maintain effective representation of concepts, ideas and facts.'),
(14703, 3, 'Utiliza produtos de visualização, conforme orientado, para projetar e criar visualizações de dados.
Seleciona técnicas de visualização apropriadas das opções disponíveis.
Interagir com o usuário alvo para prototipar e refinar visualizações especificadas.
Auxilia a desenvolver narrativas em torno de conjuntos de dados para apoiar a compreensão e a tomada de decisões.', 'Uses visualisation products, as guided, to design and create data visuals.
Selects appropriate visualisation techniques from the options available.
Engages with the target user to prototype and refine specified visualisations.
Assists in developing narratives around data sets to support understanding and decision-making.'),
(14703, 4, 'Aplica uma variedade de técnicas de visualização e projeta o conteúdo e a aparência da visualização de dados.
Operacionaliza e automatiza atividades para produção eficiente e oportuna da visualização de dados.
Seleciona a abordagem de visualização apropriada de uma variedade de opções aplicáveis. Desenvolve narrativas em torno de conjuntos de dados para orientar processos de tomada de decisão e melhorar a compreensão de insights importantes.
Contribui para a exploração e experimentação na visualização de dados.', 'Applies a variety of visualisation techniques and designs the content and appearance of data visuals.
Operationalises and automates activities for efficient and timely production of data visuals.
Selects appropriate visualisation approaches from a range of applicable options. Develops narratives around data sets to guide decision-making processes and enhance understanding of key insights.
Contributes to exploration and experimentation in data visualisation.'),
(14703, 5, 'Conduz a exploração de novas abordagens para visualização de dados.
Estabelece o propósito e os parâmetros da visualização de dados. Supervisionar o uso de ferramentas e técnicas de visualização de dados.
Comunica os resultados usando métodos apropriados para o público-alvo. Assessora sobre o uso de abordagens de visualização de dados para diferentes fins e contextos para atender aos requisitos. Desenvolve planos para atender às necessidades dos usuários.
Colabora com as partes interessadas para identificar insights-chave e criar narrativas convincentes que comunicam efetivamente a história por trás dos dados para impulsionar processos de tomada de decisão.', 'Leads exploration of new approaches for data visualisation.
Establishes the purpose and parameters of the data visualisation. Oversees the use of data visualisation tools and techniques.
Communicates results using appropriate methods for the target audience. Advises on the use of data visualisation approaches for different purposes and contexts to satisfy requirements. Develops plans to meet user needs.
Collaborates with stakeholders to identify key insights and create compelling narratives that effectively communicate the story behind the data to drive decision-making processes.'),
(14861, 2, 'Executa procedimentos operacionais e scripts de automação e realiza manutenção e monitoramento rotineiro em bancos de dados.
Ajusta tarefas de automação de acordo com as instruções para atender aos padrões operacionais dos bancos de dados.
Emite relatórios sobre o desempenho dos bancos de dados, resolve problemas diretamente quando possível ou escala para resolução.', 'Executes operational procedures, runs automation scripts and performs routine maintenance and monitoring of databases.
Adjusts automation tasks as instructed to meet operational standards for databases.
Reports on database performance, addresses issues directly when possible, or escalates to others for resolution.'),
(14861, 3, 'Fornece, instala, configura e garante a manutenção e confiabilidade de bancos de dados.
Monitora a carga em bancos de dados, bem como o desempenho e eventos de segurança. Reporta métricas e resolve problemas operacionais.
Executa procedimentos operacionais padronizados, incluindo backups e restaurações de bancos de dados.
Automatiza tarefas rotineiras de administração de bancos de dados usando scripts e ferramentas padrão.', 'Provisions, installs, configures and ensures the maintenance and reliability of databases.
Monitors databases for load, performance and security events. Reports metrics and resolves operational issues.
Executes standard operational procedures, including database backups and restorations.
Automates routine database administration tasks to specifications using standard scripts and tools.'),
(14861, 4, 'Aplica conhecimentos técnicos para manter e otimizar bancos de dados, executar atualizações e empregar ferramentas de automação.
Configura ferramentas e/ou cria scripts para automatizar tarefas de bancos de dados. Mantém procedimentos operacionais e verifica se eles são seguidos, incluindo a conformidade com as políticas de segurança. Utiliza ferramentas de gerenciamento de bancos de dados para monitorar estatísticas de carga e desempenho.
Investiga e permite a resolução de problemas operacionais e de segurança de bancos de dados. Fornece relatórios e proposições de melhoria para as partes interessadas.
Contribui para o planejamento e implementação de manutenção e atualizações de bancos de dados. Implementa mudanças e rotinas de manutenção de bancos de dados acordadas.', 'Applies technical expertise to maintain and optimise databases, executing updates and employing automation tools.
Configures tools and/or creates scripts to automate database tasks. Maintains operational procedures and checks that they are followed, including compliance with security policies. Uses database management tools to monitor load and performance statistics.
Investigates and enables the resolution of database operational and security issues. Provides reports and proposals for improvement to stakeholders.
Contributes to the planning and implementation of database maintenance and updates. Implements agreed database changes and maintenance routines.'),
(14861, 5, 'Oferece liderança técnica para otimizar o desempenho dos bancos de dados.
Direciona a adoção de ferramentas e processos automatizados para gerenciamento e entrega eficazes de bancos de dados.
Supervisiona o planejamento, instalação, manutenção e aceitação de componentes de bancos de dados novos e atualizados e serviços baseados em bancos de dados. Assegura o alinhamento com expectativas de serviço, requisitos de segurança e outros padrões de qualidade.
Assegura que os procedimentos operacionais e a documentação de bancos de dados sejam atuais e eficazes, rastreia e resolve problemas operacionais e emite relatórios para as partes interessadas.', 'Provides technical leadership to optimise the performance of databases.
Drives the adoption of tools and automated processes for effective database management and delivery.
Oversees the planning, installation, maintenance and acceptance of new and updated database components and database-based services. Ensures alignment to service expectations, security requirements and other quality standards.
Ensures database operational procedures and documentation are current and effective, tracks and addresses operational issues and reports to stakeholders.'),
(14850, 2, 'Ajuda a criar e documentar projetos de banco de dados detalhados sob supervisão de rotina.
Segue procedimentos e diretrizes estabelecidos.
Ajuda a criar e manter a documentação.', 'Assists in creating and documenting detailed database designs under routine supervision.
Follows established procedures and guidelines.
Helps create and maintain documentation.'),
(14850, 3, 'Interpreta os padrões de instalação para atender as necessidades de projeto e produzir especificações de componentes de banco de dados ou data warehouse.
Desenvolve bancos de dados físicos apropriados ou elementos de projeto de data warehouse, de acordo com as políticas definidas, para atender os requisitos de dados.', 'Interprets installation standards to meet project needs and produces database or data warehouse component specifications.
Develops physical database or data warehouse design elements, within set policies, to meet data requirements.'),
(14850, 4, 'Implementa projetos de banco de dados físicos para dar suporte aos requisitos de dados transacionais de desempenho e disponibilidade.
Desenvolve e mantém conhecimento especializado de conceitos de bancos de dados e data warehouse, princípios de projeto, arquiteturas, software e instalações.
Avalia alterações propostas para estruturas de objetos/dados e também opções alternativas.
Implementa projetos de data warehouse que atendam às demandas de inteligência de negócios (BI) e análise de dados.', 'Implements physical database designs to support transactional data requirements for performance and availability.
Develops and maintains specialist knowledge of database and data warehouse concepts, design principles, architectures, software and facilities.
Assesses proposed changes to object/data structures and evaluates alternative options.
Implements data warehouse designs that support business intelligence and data analytics.'),
(14850, 5, 'Oferece conhecimento especializado em relação a características de projeto de sistemas de gerenciamento de bancos de dados ou produtos/serviços de data warehouse.
Oferece orientação especializada na seleção, fornecimento e uso de arquiteturas, softwares e instalações de banco de dados e data warehouse.
Garante que as políticas de projeto otimizem os sistemas de dados transacionais para desempenho e disponibilidade, ao mesmo tempo em que atendem às necessidades de plataformas de inteligência empresarial e analítica.', 'Provides specialist expertise in the design characteristics of database management systems or data warehouse products/services.
Provides expert guidance in the selection, provision and use of database and data warehouse architectures, software and facilities.
Ensures design policies optimise transactional data systems for performance and availability while meeting the needs of business intelligence and analytics platforms.'),
(14947, 3, 'Gerencia a rotina de entrega de pequenos produtos ou serviços, ou partes específicas de um produto ou serviço maior.
Segue metodologias de entrega, ferramentas e processos de qualidade. Monitora a adesão da equipe a essas práticas.
Coordena os processos de planejamento da equipe com base nas prioridades estabelecidas dos itens de trabalho. Rastreia e reporta sobre o progresso de entrega, riscos e problemas.
Apoia um ambiente de trabalho colaborativo e produtivo, demonstrando comportamentos apropriados. Contribui para a melhoria contínua dos processos de entrega dentro da equipe.', 'Manages the routine delivery of small products or services, or specific parts of a larger product or service.
Follows delivery methodologies, tools, and quality processes. Monitors the team’s adherence to these practices.
Coordinates team planning processes based on the established priorities of work items. Tracks and reports on delivery progress, risks and issues.
Supports a collaborative and productive working environment, demonstrating appropriate behaviours. Contributes to continuous improvement of delivery processes within the team.'),
(14947, 4, 'Gerencia a entrega de produtos ou serviços para iniciativas de pequeno a médio porte.
Aplica metodologias e ferramentas de entrega apropriadas. Estabelece e lidera equipes de entrega, criando um ambiente de trabalho colaborativo e produtivo.
Gerencia a priorização de itens de trabalho, lidera processos de planejamento de iterações e garante que o valor seja entregue progressivamente ao longo do ciclo de entrega. Comunica o progresso, riscos e questões de entrega aos partes interessadas.
Assegura a qualidade das entregas. Participa em revisões e contribui para a melhoria contínua dos processos de entrega dentro do escopo da equipe ou iniciativa.', 'Manages the delivery of products or services for small to medium-sized initiatives.
Applies appropriate delivery methodologies and tools. Establishes and leads delivery teams, creating a collaborative and productive working environment.
Manages the prioritisation of work items, leads iteration planning processes and ensures value is delivered incrementally throughout the delivery cycle. Communicates delivery progress, risks and issues to stakeholders.
Ensures the quality of deliverables. Participates in reviews and contributes to the continuous improvement of delivery processes within the scope of the team or initiative.'),
(14947, 5, 'Lidera a entrega de produtos ou serviços para iniciativas grandes ou complexas.
Adapta abordagens de entrega com base no contexto e complexidade da iniciativa. Fornece liderança e orientação a várias equipes de entrega. Colabora com as partes interessadas para alinhar objetivos de entrega com objetivos de negócios. Gerencia proativamente riscos, dependências e mudanças que podem impactar a entrega.
Assegura a alocação ideal de recursos e habilidades entre as equipes. Monitora métricas de entrega-chave, garantindo transparência e visibilidade.
Conduz a melhoria contínua dos processos e práticas de entrega em toda a organização', 'Leads delivery of products or services for large or complex initiatives.
Adapts delivery approaches based on the context and complexity of the initiative. Provides leadership and guidance to multiple delivery teams. Collaborates with stakeholders to align delivery objectives with business goals. Proactively manages risks, dependencies and changes that may impact delivery.
Ensures optimal allocation of resources and skills across teams. Monitors key delivery metrics, ensuring transparency and visibility.
Drives the continuous improvement of delivery processes and practices across the organisation.'),
(14947, 6, 'Define e supervisiona a estratégia de entrega para vários produtos ou serviços.
Alinha a estratégia de entrega com os objetivos organizacionais e com as necessidades dos clientes. Assegura a atribuição eficaz de recursos e orçamento.
Monitora e reporta o desempenho da entrega de produtos e serviços, garantindo a alinhamento com os objetivos. Identifica e mitiga os riscos e problemas sistêmicos.
Define a direção e os padrões para a gestão de entrega em toda a organização. Lidera o desenvolvimento de uma cultura focada na melhoria contínua e no foco no cliente.', 'Defines and oversees the delivery strategy for multiple products or services.
Aligns delivery strategy with organisational goals and customer needs. Ensures effective allocation of resources and budget.
Monitors and reports on performance of product and service delivery, ensuring alignment with objectives. Identifies and mitigates systemic risks and issues.
Sets the direction and standards for delivery management across the organisation. Leads the development of a culture focused on continuous improvement and customer-centricity.'),
(15245, 4, 'Realiza análises de gerenciamento de demanda e atividades de planejamento dentro de uma área de negócios ou operacionais específicas.
Monitora padrões de demanda e identifica insights e propostas para melhorar o valor de negócios.
Identifica e avalia oportunidades para priorizar ou melhorar o alinhamento entre a demanda de negócios e a capacidade de entregar.
Engaja as partes interessadas para comunicar insights, planos e decisões relacionadas à demanda de negócios.', 'Performs demand management analysis and planning activities within a specific business or operational area.
Monitors patterns of demand and identifies insights and proposals to improve business value.
Identifies and assesses opportunities to prioritise or improve alignment between business demand and capacity to deliver.
Engages stakeholders to communicate insights, plans and decisions regarding business demand.'),
(15245, 5, 'Implementa atividades de análise e planejamento de gestão de demanda.
Fornece orientações para ajudar as partes interessadas a adotar e aderir à abordagem de gestão de demanda acordada. Gerencia o processo de integração da gestão da demanda com processos complementares estratégicos, operacionais e de gestão de mudanças.
Mantém um registro de solicitações de negócios e encaminha solicitações para o lugar adequado. Emite relatórios sobre o status de cada solicitação.
Analisa novas propostas de negócios e fornece assessoria em questões de demanda. Trabalha com representantes de negócios para estabelecer e implementar modificações de curto e médio prazo na demanda.', 'Implements demand management analysis and planning activities.
Provides advice to help stakeholders adopt and adhere to the agreed demand management approach. Manages the process of integrating demand management with complementary strategic, operational and change management processes.
Maintains a register of business requests and routes requests to the right place. Reports on the status of each request.
Reviews new business proposals and provides advice on demand issues. Works with business representatives to agree and implement short-term and medium-term modifications to demand.'),
(15245, 6, 'Define a abordagem e estabelece políticas para a descoberta, análise, planejamento, controle e documentação da demanda de serviços e produtos.
Organiza o escopo e a definição de prioridades de negócios para mudanças estratégicas, envolvendo formuladores de políticas de negócios e direcionadores estratégicos.
Envolve-se e influencia as partes interessadas seniores para aprimorar o valor do negócio fornecido por serviços e produtos novos ou existentes.
Lidera o desenvolvimento de recursos de gerenciamento de demanda. Conduz a integração da gestão de demanda com processos complementares de gestão estratégica, operacional e de mudanças.', 'Defines the approach and sets policies for discovering, analysing, planning, controlling and documenting demand for services and products.
Organises scoping and business priority setting for strategic business changes involving business policymakers and direction setters.
Engages with and influences senior stakeholders to improve the business value delivered from new or existing services and products.
Leads the development of demand management capabilities. Leads the integration of demand management with complementary strategic, operational and change management processes.'),
(1598, 2, 'Auxilia na implantação de liberações de software e atualizações sob supervisão rotineira.
Executa processos e procedimentos de implantação definidos usando ferramentas e técnicas de implantação.
Monitora aplicativos implementados e reporta problemas.
Ajuda a reverter as implantações quando necessário.', 'Assists in deploying software releases and updates under routine supervision.
Executes defined deployment processes and procedures using deployment tools and techniques.
Monitors deployed applications and reports issues.
Assists in rolling back deployments when necessary.'),
(1598, 3, 'Implanta versões de software e atualizações em ambientes de produção.
Utiliza ferramentas e técnicas para garantir implantações consistentes. Monitora e resolve problemas nos processos de implantação.
Executa planos de retorno (rollbacks) de implantações em caso de problemas ou falhas.
Colabora com equipes de gerenciamento de liberações e de operações.', 'Deploys software releases and updates to production environments.
Uses deployment tools and techniques to ensure consistent deployments. Monitors and troubleshoots deployment processes.
Performs rollbacks of deployments in case of issues or failures.
Collaborates with release management and operations teams.'),
(1598, 4, 'Planeja e executa implantações novas e atualizações de software complexos.
Gerencia a implantação contínua usando ferramentas e técnicas de automação. Desenvolve e mantém processos de implantação, procedimentos e scripts.
Monitora e otimiza os processos de implantação para eficiência e confiabilidade. Assegura a disponibilidade, o desempenho e a segurança dos aplicativos implantados.
Colabora com equipes interfuncionais.', 'Plans and executes deployments of complex software releases and updates.
Manages continuous deployment using automation tools and techniques. Develops and maintains deployment processes, procedures and scripts.
Monitors and optimises deployment processes for efficiency and reliability. Ensures the availability, performance and security of deployed applications.
Collaborates with cross-functional teams.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(1598, 5, 'Desenha e implementa abordagens de implantação, processos e ferramentas de automação para a organização.
Supervisiona a implantação de softwares críticos e de grande escala. Assegura que os processos de implantação estejam alinhados com os padrões organizacionais e práticas recomendadas.
Melhora continuamente os processos de implantação e as capacidades de automação.
Define estratégias de monitoramento e alertas para aplicações implantadas.', 'Designs and implements deployment approaches, processes and automation tools for the organisation.
Oversees the deployment of critical and large-scale software. Ensures deployment processes align with organisational standards and recommended practices.
Continuously improves deployment processes and automation capabilities.
Defines monitoring and alert strategies for deployed applications.'),
(1598, 6, 'Define estratégias, políticas e padrões de implantação organizacionais.
Alinha as práticas de implantação com os objetivos gerais de operações e prestação de serviços.
Assegura a disponibilidade de recursos e ferramentas para implantações eficazes.
Direciona a adoção de novas técnicas e tecnologias de implantação. Colabora com as partes interessadas sênior para garantir que as implantações atendam às estratégias e objetivos de negócios.', 'Defines organisational deployment strategies, policies and standards.
Aligns deployment practices with overall operations and service delivery goals.
Ensures the availability of resources and tools for effective deployment.
Drives the adoption of new deployment techniques and technologies. Collaborates with senior stakeholders to ensure deployments meet business strategies and objectives.'),
(15246, 2, 'Auxilia em investigações forenses digitais sob supervisão rotineira.
Apoia a recuperação de dados danificados, excluídos ou ocultos em dispositivos digitais.
Ajuda a coletar e preservar informações e evidências digitais de acordo com protocolos estabelecidos.', 'Assists with digital forensic investigations under routine supervision.
Supports the recovery of damaged, deleted or hidden data from digital devices.
Helps collect and preserve digital information and evidence according to established protocols.'),
(15246, 3, 'Aplica ferramentas e técnicas forenses padronizadas para examinar dispositivos digitais.
Recupera e analisa dados danificados, excluídos ou ocultos em várias fontes e dispositivos digitais.
Mantém a integridade das evidências digitais e garante que sua coleta esteja aderente aos padrões de admissibilidade legal.', 'Applies standard forensic tools and techniques to examine digital devices.
Recovers and analyses damaged, deleted or hidden data from various digital sources and devices.
Maintains the integrity of digital evidence and ensures its collection adheres to legal admissibility standards.'),
(15246, 4, 'Projeta e executa exames forenses digitais complexos.
Especifica os requisitos para ferramentas e recursos forenses especializados. Fornece orientação sobre técnicas avançadas de recuperação de dados e análise de artefatos.
Processa e analisa evidências digitais de acordo com políticas organizacionais e padrões da indústria. Desenvolve procedimentos para lidar com tecnologias emergentes em contextos forenses.
Contribui com relatórios forenses detalhando descobertas técnicas.', 'Designs and executes complex digital forensic examinations.
Specifies requirements for specialised forensic tools and resources. Provides guidance on advanced data recovery techniques and artefact analysis.
Processes and analyses digital evidence in line with organisational policies and industry standards. Develops procedures for handling emerging technologies in forensic contexts.
Contributes to forensic reports detailing technical findings.'),
(15246, 5, 'Conduz investigações para coletar, analisar e apresentar corretamente as descobertas, incluindo provas digitais, tanto para o público corporativo quanto jurídico.
Agrupa conclusões e recomendações e apresenta os resultados forenses às partes interessadas.
Planeja e gerencia atividades forenses digitais dentro da organização. Oferece consultoria especializada em perícia digital.
Contribui para o desenvolvimento de políticas, normas e diretrizes forenses digitais. Avalia e seleciona ferramentas e técnicas forenses digitais.', 'Leads investigations to correctly gather, analyse and present findings, including digital evidence, to both business and legal audiences.
Collates conclusions and recommendations and presents forensic findings to stakeholders.
Plans and manages digital forensics activities within the organisation. Provides expert advice on digital forensics.
Contributes to the development of digital forensics policies, standards and guidelines. Evaluates and selects digital forensics tools and techniques.'),
(15246, 6, 'Planeja e lidera a abordagem da organização para a perícia digital.
Define políticas, padrões e diretrizes sobre como a organização conduz investigações forenses digitais.
Lidera e gerencia investigações forenses digitais de alto risco, grandes ou abrangentes, incluindo especialistas adicionais, se necessário.
Autoriza a divulgação de relatórios forenses formais. Envolve-se com partes interessadas externas em questões forenses.', 'Plans and leads the organisation’s approach to digital forensics.
Sets policies, standards and guidelines for how the organisation conducts digital forensic investigations.
Leads and manages high risk, large or wide-ranging digital forensics investigations engaging additional specialists if required.
Authorises the release of formal forensic reports. Engages with external stakeholders on forensic matters.'),
(6359, 2, 'Executa tarefas básicas de marketing digital sob supervisão rotineira.
Auxilia na implementação de campanhas de marketing digital em várias plataformas.
Coleta e organiza dados básicos de desempenho de atividades de marketing digital.
Contribui para a criação e distribuição de conteúdo de marketing digital de acordo com diretrizes estabelecidas.', 'Performs basic digital marketing tasks under routine supervision.
Assists in the implementation of digital marketing campaigns across various platforms.
Collects and organises basic performance data from digital marketing activities.
Contributes to the creation and distribution of digital marketing content following established guidelines.'),
(6359, 3, 'Implementa atividades de marketing digital em múltiplos canais.
Monitora o desempenho de campanhas e executa otimizações básicas.
Auxilia no desenvolvimento de conteúdos de marketing digital. Segue procedimentos para cumprir os requisitos regulatórios e políticas de plataformas.
Contribui para a análise de métricas de marketing e elabora relatórios. Apoia o planejamento e execução de iniciativas de melhoria do desempenho de marketing.', 'Implements digital marketing activities across multiple channels.
Monitors campaign performance and makes basic optimisations.
Assists in the development of digital marketing content. Follows procedures to comply with regulatory requirements and platform policies.
Contributes to the analysis of marketing metrics and prepares reports. Supports the planning and execution of marketing performance improvement initiatives.'),
(6359, 4, 'Planeja e executa atividades de marketing digital em várias plataformas.
Analisa dados de marketing detalhados para obter insights e melhorar o desempenho de campanhas. Recomenda e implementa melhorias para atividades de marketing digital com base em dados de desempenho.
Gerencia relações com fornecedores de marketing digital e representantes de plataformas.
Lidera a implementação de processos de automação de marketing. Aplica diretrizes organizacionais e utiliza ferramentas apropriadas para garantir que as atividades de marketing digital respeitem as regulamentações e políticas relevantes da plataforma.', 'Plans and executes digital marketing activities across various platforms.
Analyses detailed marketing data to derive insights and improve campaign performance. Recommends and implements improvements to digital marketing activities based on performance data.
Manages relationships with digital marketing vendors and platform representatives.
Leads the implementation of marketing automation processes. Applies organisational guidelines and uses appropriate tools to ensure digital marketing activities adhere to relevant regulations and platform policies.'),
(6359, 5, 'Dirige o desenvolvimento e implementação de planos de marketing digital abrangentes.
Supervisiona a integração com objetivos amplos de marketing e negócios. Gerencia orçamentos e recursos para iniciativas de marketing digital.
Fornece orientação sobre boas práticas reconhecidas de marketing digital e tendências emergentes para as partes interessadas em toda a organização. Avalia e recomenda novas tecnologias e abordagens de marketing digital. Estabelece e mantém relações estratégicas com fornecedores de marketing digital e representantes da plataforma.
Desenvolve padrões e procedimentos para práticas de marketing digital compatíveis.', 'Leads the development and implementation of comprehensive digital marketing plans.
Oversees the integration with broader marketing and business objectives. Manages budgets and resources for digital marketing initiatives.
Provides guidance on recognised good practices for digital marketing and emerging trends to stakeholders across the organisation. Evaluates and recommends new digital marketing technologies and approaches. Establishes and maintains strategic relationships with digital marketing vendors and platform representatives.
Develops standards and procedures for compliant digital marketing practices.'),
(15247, 4, 'Apoia o monitoramento do ambiente externo e a avaliação de tecnologias emergentes.
Contribui para a criação de relatórios, desenvolvimento de roteiros tecnológicos e compartilhamento de conhecimentos e percepções.', 'Supports monitoring of the external environment and assessment of emerging technologies.
Contributes to the creation of reports, technology roadmapping and the sharing of knowledge and insights.'),
(15247, 5, 'Monitora o ambiente externo para coletar informações sobre tecnologias emergentes.
Avalia e documenta os impactos, ameaças e oportunidades para a organização.
Cria relatórios e roteiros tecnológicos, compartilhando conhecimentos e insights com outros.', 'Monitors the external environment to gather intelligence on emerging technologies.
Assesses and documents the impacts, threats and opportunities to the organisation.
Creates reports and technology roadmaps and shares knowledge and insights with others.'),
(15247, 6, 'Planeja e lidera a identificação e avaliação de tecnologias emergentes, bem como a análise de impactos, ameaças e oportunidades potenciais.
Cria roteiros tecnológicos que alinham os planos organizacionais com soluções tecnológicas emergentes. Envolve e influencia as partes interessadas relevantes para obter o comprometimento da organização com os roteiros tecnológicos.
Desenvolve diretrizes organizacionais para o monitoramento de tecnologias emergentes.
Colabora com partes internas e externas para facilitar a coleta de informações.', 'Plans and leads the identification and assessment of emerging technologies and the evaluation of potential impacts, threats and opportunities.
Creates technology roadmaps that align organisational plans with emerging technology solutions. Engages with, and influences, relevant stakeholders to obtain organisational commitment to technology roadmaps.
Develops organisational guidelines for monitoring emerging technologies.
Collaborates with internal and external parties to facilitate intelligence gathering.'),
(15248, 4, 'Apoia colegas de trabalho designados, fornecendo orientação sobre áreas como contatos organizacionais, canais de comunicação, processos, expectativas de trabalho e relações com gestores.
Auxilia os indivíduos a navegar em áreas de incerteza, oferecendo conselhos práticos e conectando-os com os recursos apropriados quando necessário.', 'Supports assigned co-workers by providing guidance on areas such as organisational contacts, communication channels, processes, job expectations and manager relations.
Helps individuals navigate areas of uncertainty, offering practical advice and connecting them with the appropriate resources when needed.'),
(15248, 5, 'Implementa práticas de trabalho que motivem os colaboradores e apoiem sua saúde e bem-estar.
Fornece orientação aos indivíduos sobre metas de desenvolvimento de longo prazo e oportunidades de carreira, considerando os pontos fortes e as preferências individuais.
Comunica os direcionamentos, políticas e propósitos do negócio que possam incentivar ou afetar o engajamento dos colaboradores. Garante a clara comunicação das tarefas delegadas e oferece autonomia suficiente para motivar e empoderar os indivíduos.
Promove a conscientização do bem-estar físico e emocional dos colaboradores e fornece aconselhamento quando necessário.', 'Implements working practices that motivate employees and support their health and wellbeing.
Provides guidance to individuals on long-term development goals and career opportunities, considering an individual''s strengths and preferences.
Communicates business direction, policy and purpose where these may drive or affect employee engagement. Ensures clear communication of delegated tasks and provides sufficient autonomy to motivate and empower individuals.
Maintains awareness of the physical and emotional welfare of employees, and provides counselling when required.'),
(15248, 6, 'Orienta a implementação de estratégias organizacionais para o engajamento dos colaboradores.
Garante que os gestores ofereçam um ambiente de trabalho produtivo que motive os colaboradores e apoie sua saúde e bem-estar.
Inicia práticas de trabalho produtivas para o trabalho remoto, virtual e presencial, garantindo a disponibilidade de suporte para os colaboradores.
Comunica e promove políticas de saúde e bem-estar para os colaboradores.', 'Leads on the implementation of organisational strategies for employee engagement.
Ensures managers provide a productive working environment that motivates employees and supports their health and wellbeing.
Initiates productive working practices for remote, virtual and onsite working and ensures the availability of support for employees.
Communicates and promotes policies for employee health and wellbeing.'),
(15249, 5, 'Desenvolve modelos e planos para conduzir a execução da estratégia de negócios, aproveitando oportunidades para melhorar o desempenho organizacional.
Contribui para a criação e revisão de uma estratégia de capacidade de sistemas que atenda aos requisitos estratégicos do negócio.
Cria e mantém roteiros para orientar a execução da estratégia de negócios e melhorias de capacidade.
Define requisitos e especifica processos empresariais eficazes, por meio de melhorias em tecnologia, práticas de informação ou dados, estrutura organizacional, funções, procedimentos e equipamentos.', 'Develops models and plans to drive the execution of the business strategy, taking advantage of opportunities to improve business performance.
Contributes to creating and reviewing a systems capability strategy which meets the business''s strategic requirements.
Creates and maintains roadmaps to guide the execution of business strategy and capability improvements.
Determines requirements and specifies effective business processes, through improvements in technology, information or data practices, organisation, roles, procedures and equipment.'),
(15249, 6, 'Desenvolve a arquitetura e os processos corporativos para incorporar a gestão de mudanças estratégicas na organização.
Lidera a criação e revisão de uma estratégia de capacidades de sistemas alinhada aos requisitos do negócio. Desenvolve roteiros para arquitetura corporativa e iniciativas, garantindo o comprometimento das partes interessadas.
Captura e prioriza tendências de mercado e ambientais, estratégias de negócios e objetivos, identificando estratégias alternativas. Elabora casos de negócio para aprovação, financiamento e priorização de iniciativas de alto nível.
Define estratégias, políticas, normas e práticas para garantir a conformidade entre estratégias de negócios, estratégias tecnológicas e atividades de transformação corporativa.', 'Develops enterprise-wide architecture and processes to embed strategic change management within the organisation.
Leads the creation and review of a systems capability strategy aligned with business requirements. Develops roadmaps for enterprise architecture and initiatives, ensuring stakeholder buy-in.
Captures and prioritises market and environmental trends, business strategies and objectives, identifying alternative strategies. Develops business cases for approval, funding and prioritisation of high-level initiatives.
Sets strategies, policies, standards and practices to ensure compliance between business strategies, technology strategies and enterprise transformation activities.'),
(15249, 7, 'Direciona o desenvolvimento da arquitetura corporativa e dos processos para integrar a aplicação estratégica de mudanças na gestão da organização.
Dirige a criação e revisão de uma estratégia de capacidades corporativas para apoiar os requisitos estratégicos do negócio. Supervisiona a criação e implementação de roteiros para orientar a transformação corporativa de longo prazo e o alinhamento estratégico.
Identifica os benefícios comerciais de estratégias alternativas.
Garante a conformidade entre as estratégias de negócios, atividades de transformação corporativa e direcionamentos tecnológicos, definindo estratégias, políticas, normas e práticas.', 'Directs the development of enterprise-wide architecture and processes to embed the strategic application of change in the management of the organisation.
Directs the creation and review of an enterprise capability strategy to support the strategic requirements of the business. Oversees the creation and implementation of roadmaps to guide long-term enterprise transformation and strategic alignment.
Identifies the business benefits of alternative strategies.
Ensures compliance between business strategies, enterprise transformation activities and technology directions, setting strategies, policies, standards and practices.'),
(10622, 2, 'Assiste com as tarefas relacionadas à concessão, monitoramento e relatório de controles de acesso físico sob supervisão rotineira.
Siga procedimentos estabelecidos e diretrizes para apoiar a manutenção do ambiente físico.
Ajuda a criar e manter a documentação.', 'Assists with the tasks related to granting, monitoring and reporting on physical access controls under routine supervision.
Follows established procedures and guidelines to support the maintenance of the physical environment.
Helps create and maintain documentation.'),
(10622, 3, 'Monitora a conformidade em relação a processos pré-determinados e investiga, avalia e resolve incidentes de não conformidade, escalando quando necessário.
Concede aos usuários os acessos físicos requeridos, monitora e emite relatórios sobre ou controle geral de acesso.', 'Monitors compliance against agreed processes and investigates, assesses and resolves incidents of non-compliance, escalating where necessary.
Processes physical access requests, monitors access control systems and reports on access-related activities.'),
(10622, 4, 'Usa ferramentas de gerenciamento de data center para produzir informações gerenciais sobre energia, refrigeração e espaço e investiga problemas quando necessário.
Realiza auditorias e verificações de rotina para garantir a aderência às políticas e procedimentos.
Facilita a implementação de testes de segurança elétrica obrigatórios.', 'Uses data centre management tools to produce management information on power, cooling and space and investigate issues where necessary.
Carries out routine audit and checks to ensure adherence to policies and procedures.
Facilitates the implementation of mandatory electrical safety testing.'),
(10622, 5, 'Desenvolve e mantém padrões, processos e documentação para data centers.
Otimiza a eficiência na utilização do espaço do data center. Garante a adesão a todas as políticas e processos relevantes.
Utiliza ferramentas de gerenciamento de data center para planejar, registrar e gerenciar a infraestrutura instalada e os recursos de energia, espaço e refrigeração.
Monitora o uso e as ações para atingir as metas de sustentabilidade.', 'Develops and maintains the standards, processes and documentation for data centres.
Optimises efficiency in the population of data centre space. Ensures adherence to all relevant policies and processes.
Uses data centre management tools to plan, record and manage installed infrastructure, power, space and cooling capabilities.
Monitors usage and actions to meet sustainability targets.'),
(10622, 6, 'Define políticas organizacionais para gerenciar a propriedade de TI, garantindo a alinhamento com práticas reconhecidas da indústria.
Desenvolve estratégias para prever e cumprir os requisitos futuros de espaço do data center.
Assume a responsabilidade global pelo cumprimento das regulamentações de saúde e segurança e políticas de segurança elétrica.
Identifica e implementa práticas reconhecidas da indústria para alinhar planos futuros com metas de sustentabilidade corporativas.', 'Sets organisational policies for managing the IT estate, ensuring alignment with recognised industry practices.
Develops strategies to forecast and fulfil future data centre space requirements.
Takes overall responsibility for adherence to health and safety regulations and electrical safety policies.
Identifies and implements recognised industry practices to align future plans with corporate sustainability targets.'),
(15250, 2, 'Auxilia nas tarefas de avaliação de viabilidade sob supervisão de rotina.
Ajuda a reunir informações necessárias para avaliações de viabilidade.
Suporta a identificação e documentação de opções para a mudança de negócios.', 'Assists in feasibility assessment tasks under routine supervision.
Helps gather information required for feasibility assessments.
Supports the identification and documentation of options for business change.'),
(15250, 3, 'Suporta identificação de opções e a avaliação de viabilidade.
Seleciona e emprega técnicas padrão para obter as informações necessárias para avaliações de viabilidade.
Dá suporte à identificação de custos e benefícios tangíveis e o desenvolvimento de casos de negócios.', 'Supports option identification and feasibility assessment.
Selects and employs standard techniques to get the information required for feasibility assessment.
Supports identification of tangible costs and benefits, and development of business cases.'),
(15250, 4, 'Seleciona abordagens e técnicas de avaliação de viabilidade relevantes.
Identifica a gama de opções possíveis. Realiza a pré-seleção de opções e a avaliação de viabilidade.
Envolve as partes interessadas internas e externas para obter as informações necessárias para avaliações de viabilidade.
Oferece suporte à preparação de casos de negócios, incluindo análises de custo/benefício, impacto e risco para cada opção.', 'Selects relevant feasibility assessment approaches and techniques.
Identifies the range of possible options. Undertakes short-listing of options and feasibility assessment.
Engages with internal and external stakeholders to get the information required for feasibility assessment.
Supports preparation of business cases including cost/benefit, impact and risk analysis for each option.'),
(15250, 5, 'Gerencia o trabalho investigativo para permitir avaliações de viabilidade.
Colabora com as partes interessadas e especialistas para obter as informações necessárias para avaliações de viabilidade.
Orienta na seleção de abordagens e técnicas de avaliação de viabilidade relevantes para a situação e opções do negócio.
Prepara casos de negócios, incluindo análises de custo/benefício, impacto e risco para cada opção.', 'Manages investigative work to enable feasibility assessments.
Collaborates with stakeholders and specialists to get the information required for feasibility assessment.
Advises on the selection of feasibility assessment approaches and techniques relevant to the business situation and options.
Prepares business cases, including cost/benefit, impact and risk analysis for each option.'),
(15250, 6, 'Estabelece um framework organizacional e padrões para avaliação de viabilidade e desenvolvimento de casos de negócios.
Dirige e lidera avaliações de viabilidade para iniciativas que terão um impacto significativo na organização.
Envolve-se com as partes interessadas seniores para esclarecer o contexto estratégico das opções de investimento. Direciona e lidera a seleção de abordagens e técnicas de avaliação de viabilidade que sejam relevantes para a situação e as opções do negócio.
Apresenta avaliações de viabilidade e casos de negócios para as partes interessadas sênior e apoia a tomada de decisões sobre opções de investimento.', 'Establishes an organisational framework and standards for feasibility assessment and business case development.
Directs and leads feasibility assessments for initiatives that will have a significant impact on the organisation.
Engages with senior stakeholders to clarify the strategic context for investment options. Directs and leads the selection of feasibility assessment approaches and techniques that are relevant to the business situation and options.
Presents feasibility assessments and business cases to senior stakeholders and supports decision-making regarding investment options.'),
(8433, 2, 'Auxilia na coleta e organização de dados financeiros e na preparação de relatórios básicos sob supervisão.
Apoia o processo de análise financeira concluindo tarefas atribuídas e buscando orientação quando necessário.', 'Assists in collecting and organising financial data and preparing basic reports under supervision.
Supports the financial analysis process by completing assigned tasks and seeking guidance when needed.'),
(8433, 3, 'Aplica técnicas e processos estabelecidos de análise financeira para realizar tarefas específicas, como análise detalhada de dados, geração de relatórios e interpretação de métricas financeiras.
Contribui para o desenvolvimento de percepções acionáveis para a tomada de decisões.
Comunica os resultados de análise financeira às partes interessadas relevantes.', 'Applies established financial analysis techniques and processes to carry out specific tasks such as detailed data analysis, report generation and interpretation of financial metrics.
Contributes to the development of actionable insights for decision-making.
Communicates financial analysis findings to relevant stakeholders.'),
(8433, 4, 'Realiza análises financeiras para áreas específicas, usando técnicas e ferramentas padrão.
Prepara relatórios e fornece percepções para apoiar a tomada de decisões. Conduz análises de custo-benefício e apoia a colaboração entre as partes interessadas no processo de gestão de custos.
Colabora com as partes interessadas para entender os requisitos e fornecer análises relevantes.
Apoia o desenvolvimento e manutenção de modelos financeiros.', 'Performs financial analysis for specific areas, using standard techniques and tools.
Prepares reports and provides insights to support decision-making. Conducts cost-benefit analyses and supports stakeholder collaboration in the cost management process.
Collaborates with stakeholders to understand requirements and deliver relevant analysis.
Supports the development and maintenance of financial models.'),
(8433, 5, 'Dirige atividades de análise financeira para um departamento ou função, aplicando técnicas e ferramentas avançadas.
Desenvolve e mantém modelos financeiros complexos. Realiza planejamento de cenários e análise de sensibilidade para apoiar a tomada de decisões.
Fornece aconselhamento e orientação autorizados sobre práticas recomendadas de análise financeira.
Presenta conclusões e recomendações para as partes interessadas superiores, vinculando o desempenho financeiro aos resultados de negócios. Colabora com as partes interessadas para alinhar a análise com os objetivos organizacionais.', 'Leads financial analysis activities for a department or function, applying advanced techniques and tools.
Develops and maintains complex financial models. Conducts scenario planning and sensitivity analysis to support decision-making.
Provides authoritative advice and guidance on recommended financial analysis practices.
Presents findings and recommendations to senior stakeholders, linking financial performance to business outcomes. Collaborates with stakeholders to align analysis with organisational objectives.'),
(8433, 6, 'Define e lidera a abordagem da organização para análise financeira, alinhando-a com objetivos estratégicos e criação de valor para o negócio.
Desenvolve e implementa políticas, normas e processos de análise financeira em toda a organização.
Promove uma cultura de tomada de decisões orientada em dados e melhoria contínua na gestão financeira.
Fornece percepções e recomendações estratégicas com base em análise financeira abrangente, vinculando o desempenho à estratégia de negócios.', 'Defines and leads the organisation''s approach to financial analysis, aligning it with strategic objectives and business value creation.
Develops and implements enterprise-wide financial analysis policies, standards and processes.
Drives a culture of data-driven decision-making and continuous improvement in financial management.
Provides strategic insights and recommendations based on comprehensive financial analysis, linking performance to business strategy.'),
(4555, 4, 'Monitora e mantém registros financeiros para garantir o cumprimento das exigências de conformidade e auditoria.
Oferece suporte geral no planejamento financeiro e na elaboração de orçamentos, compilando e relatando dados financeiros.
Apoia a tomada de decisões ao reunir e resumir informações financeiras em nível estratégico.
Colabora com as unidades de negócio para coletar dados financeiros e compreender as necessidades operacionais.', 'Monitors and maintains financial records to ensure compliance and audit requirements are met.
Provides general support in financial planning and budgeting by compiling and reporting on financial data.
Supports decision-making by collating and summarising financial information at a high level.
Collaborates with business units to gather financial data and understand operational needs.'),
(4555, 5, 'Fornece aconselhamento e orientação gerais sobre planejamento financeiro, orçamentação e contabilidade usando práticas e padrões reconhecidos.
Elabora planos e previsões financeiras de alto nível para orientar as estratégias e planos organizacionais.
Monitora as despesas para garantir o alinhamento com os objetivos orçamentários.
Contribui para estruturas de controle financeiro e apoia a tomada de decisões estratégicas, resumindo tendências e variações de despesas.', 'Provides general advice and guidance on financial planning, budgeting and accounting using recognised practices and standards.
Develops high-level financial plans and forecasts to guide organisational strategies and plans.
Monitors expenditure to ensure alignment with budgetary goals.
Contributes to financial control frameworks and supports strategic decision-making by summarising expenditure trends and variances.'),
(4555, 6, 'Desenvolve políticas, normas e diretrizes organizacionais para a gestão financeira visando apoiar os objetivos estratégicos do negócio.
Promove a governança financeira e incentiva a adesão às políticas e normas financeiras. Colabora com líderes seniores e chefes de unidades de negócio para garantir que as estratégias financeiras apoiem os objetivos gerais da organização.
Supervisiona a definição e gestão de orçamentos e metas financeiras em nível estratégico.
Lidera revisões de alto nível do desempenho financeiro e implementa melhorias para alinhar o uso do orçamento com as prioridades da organização.', 'Develops organisational policies, standards and guidelines for financial management to support strategic business goals.
Promotes financial governance and drives adherence to financial policies and standards. Collaborates with senior leaders and business unit heads to ensure financial strategies support overall business objectives.
Oversees the setting and management of financial budgets and targets at a strategic level.
Leads high-level reviews of financial performance and implements improvements to align budget usage with organisational priorities.'),
(15251, 2, 'Dentro dos objetivos de pesquisa estabelecidos, auxilia na seleção e revisão de recursos confiáveis e credíveis.
Busca material relevante em sites especializados e fontes confiáveis, lê artigos pertinentes para atualizar o conhecimento na área.
Relata o trabalho realizado e pode contribuir com seções de material em nível de publicação.
Mantém, sob orientação, uma coleção pessoal de material relevante.', 'Within given research goals, assists in selection and review of credible and reliable resources.
Searches for relevant material using specialised websites and sources, reads relevant articles to update knowledge of the relevant field.
Reports on work carried out and may contribute sections of publication-quality material.
Curates, under guidance, a personal collection of relevant material.'),
(15251, 3, 'Dentro dos objetivos de pesquisa estabelecidos, desenvolve e aprimora ideias preliminares adequadas para a pesquisa, incluindo avaliação, desenvolvimento, demonstração e implementação.
Aplica métodos padrão para coletar e analisar dados quantitativos e qualitativos. Cria relatórios de pesquisa para comunicar metodologia, resultados e conclusões.
Contribui com seções de material em nível de publicação.
Utiliza recursos disponíveis para atualizar o conhecimento em áreas relevantes e mantém uma coleção pessoal de material pertinente. Participa de comunidades de pesquisa.', 'Within given research goals, builds on and refines appropriate outline ideas for research, including evaluation, development, demonstration and implementation.
Applies standard methods to collect and analyse quantitative and qualitative data. Creates research reports to communicate research methodology, findings and conclusions.
Contributes sections of publication-quality material.
Uses available resources to update knowledge of any relevant field and curates a personal collection of relevant material. Participates in research communities.'),
(15251, 4, 'Desenvolve e aprimora ideias preliminares apropriadas para a avaliação, desenvolvimento, demonstração e implementação de pesquisas.
Contribui para os objetivos de pesquisa e propostas de financiamento. Coleta e analisa dados qualitativos e quantitativos conforme necessário.
Contribui para os planos de pesquisa e identifica oportunidades adequadas para publicação e disseminação dos resultados da pesquisa. Contribui ativamente para comunidades de pesquisa.
Apresenta trabalhos em conferências, contribui com seções significativas de material em nível de publicação e apresenta relatórios a clientes.', 'Builds on and refines appropriate outline ideas for the evaluation, development, demonstration and implementation of research.
Contributes to research goals and funding proposals. Collects and analyses qualitative and quantitative data as required.
Contributes to research plans and identifies appropriate opportunities for publication and dissemination of research findings. Makes an active contribution to research communities.
Presents papers at conferences, contributes significant sections of publication-quality material and presents reports to clients.'),
(15251, 5, 'Define objetivos e métodos de pesquisa e executa projetos para gerar ideias originais.
Atrai e gerencia financiamentos externos para pesquisa. Mantém uma sólida rede externa dentro de sua área de especialização.
Fornece orientação sobre a realização de pesquisas. Seleciona e adapta ferramentas e técnicas de coleta de dados. Desenvolve, revisa e critica construtivamente a pesquisa e as ideias de outros. Compartilha demonstrações dos resultados da pesquisa.
Participa de atividades profissionais fora de sua organização empregadora. Apresenta artigos em conferências importantes, escreve para periódicos especializados e apresenta relatórios às principais partes interessadas.', 'Agrees research goals and methods and performs projects to generate original ideas.
Attracts and manages external research funding. Maintains a strong external network within own area of specialism.
Provides advice on performing research. Selects and adapts data collection tools and techniques. Develops, reviews and constructively criticises the research and ideas of others. Shares demonstrations of research findings.
Takes part in professional activities outside own employing organisation. Presents papers at significant conferences, writes articles for specialist journals and presents reports to key stakeholders.'),
(15251, 6, 'Desenvolve a política de pesquisa da organização e supervisiona o trabalho das funções de pesquisa.
Promove atividades externamente, atrai e gerencia portfólios significativos de financiamento para pesquisa.
Define metas de pesquisa e autoriza propostas de pesquisa. Lidera projetos de pesquisa estratégicos e/ou interdisciplinares. Mantém uma sólida rede externa que vai além de sua área imediata de especialização.
Desempenha um papel de liderança em atividades profissionais fora de sua organização empregadora. Apresenta palestras principais em grandes conferências, escreve artigos para periódicos de alto impacto e apresenta relatórios a clientes importantes.', 'Develops the organisation''s research policy and supervises the work of research functions.
Promotes activities externally, attracts and manages significant portfolios of research funding.
Sets research goals and authorises research proposals. Leads strategic and/or interdisciplinary research projects. Maintains a strong external network reaching beyond own immediate area of specialism.
Takes a leading part in professional activities outside own employing organisation. Presents keynote papers at major conferences, writes articles for high impact journals and presents reports to major clients.'),
(15252, 1, 'Executa scripts de teste de funções manuais sob supervisão para verificar as capacidades básicas do software.
Configura ambientes de teste, usa ferramentas automatizadas básicas para verificação de funcionalidades, registra resultados e reporta problemas.', 'Executes given manual functional test scripts under supervision to verify basic software capabilities.
Configures test environments, uses basic automated tools for functionality verification, records results and reports issues.'),
(15252, 2, 'Ajuda na concepção de casos de teste funcionais e criação de scripts de teste.
Suporta a preparação de dados de teste para testes funcionais sob supervisão.
Configura ambientes de teste para refletir casos de uso realistas.
Executa e registra testes funcionais manuais e automatizados, analisa resultados e reporta sobre descobertas, problemas e riscos.', 'Assists in designing functional test cases and creating test scripts.
Supports the preparation of test data for functional testing under supervision.
Configures test environments to reflect realistic use cases.
Executes and records manual and automated functional tests, analysing results and reporting on findings, issues and risks.'),
(15252, 3, 'Desenha casos de teste funcionais detalhados e scripts, cobrindo vários cenários e valores de limite.
Participa ativamente em revisões de requisitos e design, refinando planos de teste com base em insights obtidos.
Realiza testes exploratórios estruturados para investigar e verificar a funcionalidade.
Prepara dados de teste, configura ambientes e automatiza testes repetíveis. Executa testes, registra defeitos com informações detalhadas e analisa resultados para avaliar a funcionalidade do sistema.', 'Designs detailed functional test cases and scripts, covering various scenarios and boundary values.
Actively participates in requirement and design reviews, refining test plans based on insights gained.
Undertakes structured exploratory testing to investigate and verify functionality.
Prepares test data, configures environments and automates repeatable tests. Executes tests, logs defects with detailed information and analyses results to assess system functionality.'),
(15252, 4, 'Seleciona abordagens adequadas de testes funcionais, considerando o risco, a criticalidade e a complexidade.
Desenvolve, automatiza e executa planos e casos de testes abrangentes.
Configura ambientes para refletir o uso real, colabora com as partes interessadas para refinar os requisitos e gerencia frameworks de testes automatizados escaláveis.
Identifica e mitiga riscos durante testes, fornece análise detalhada e relatórios sobre atividades e resultados de testes funcionais, incluindo o trabalho realizado por outras pessoas.', 'Selects appropriate functional testing approaches, considering risk, criticality and complexity.
Develops, automates and executes comprehensive test plans and cases.
Configures environments to mirror real-world usage, collaborates with stakeholders to refine requirements and manages scalable automated testing frameworks.
Identifies and mitigates risks during testing, provides detailed analysis and reports on functional test activities and results, including work done by others.'),
(15252, 5, 'Dirige os esforços de testes funcionais em todas as fases de desenvolvimento, garantindo o alinhamento com os requisitos funcionais e focando na priorização baseada em risco.
Fornece aconselhamento autorizado sobre métodos, ferramentas e frameworks de testes.
Monitora e melhora a cobertura de testes, colabora com equipes para enfrentar desafios e garantir a conformidade com as normas.
Lida os esforços para melhorar a eficiência e a confiabilidade dos testes funcionais. Identifica melhorias e contribui para as políticas, padrões e diretrizes organizacionais para testes funcionais.', 'Leads functional testing efforts across all development stages, ensuring alignment with functional requirements and focusing on risk-based prioritisation.
Provides authoritative advice on testing methods, tools and frameworks.
Monitors and improves test coverage, collaborates with teams to address challenges and ensures compliance with standards.
Leads efforts to improve the efficiency and reliability of functional testing. Identifies improvements and contributes to organisational policies, standards and guidelines for functional testing.'),
(15252, 6, 'Desenvolve políticas, padrões e diretrizes organizacionais para testes funcionais, garantindo que estejam alinhados com a estratégia de negócios e incorporem uma abordagem baseada em risco.
Planeia e dirige iniciativas de testes complexos, garantindo a alinhamento com objetivos estratégicos e incorporando uma abordagem baseada em risco.
Gerencia riscos e oportunidades, coordena com outras atividades de testes e impulsiona melhorias nas capacidades de testes funcionais.
Promove uma cultura de qualidade em testes funcionais, impulsiona a adesão às normas organizacionais e a mitigação proativa dos riscos.', 'Develops organisational policies, standards and guidelines for functional testing, ensuring they align with business strategy and incorporate a risk-based approach.
Plans and leads complex testing initiatives, ensuring alignment with strategic objectives and incorporating a risk-based approach.
Manages risks and opportunities, coordinates with other testing activities and drives improvements in functional testing capabilities.
Promotes a culture of quality in functional testing, driving adherence to organisational standards and proactive risk mitigation.'),
(8469, 6, 'Implementa a estrutura de governança para permitir que as atividades de governança sejam conduzidas.
Dentro de uma área definida de responsabilidade, determina os requisitos para uma governança apropriada, refletindo os valores, a ética e as estruturas de governança mais amplas da organização. Comunica autoridade delegada, benefícios, oportunidades, custos e riscos.
Conduz revisões de práticas de governança com independência adequada e suficiente da atividade de gestão.
Atua como o contato da organização para as autoridades reguladoras relevantes e garante relacionamentos adequados entre a organização e as partes interessadas externas.', 'Implements the governance framework to enable governance activity to be conducted.
Within a defined area of accountability, determines the requirements for appropriate governance reflecting the organisation''s values, ethics, risk appetite and wider governance frameworks. Communicates delegated authority, benefits, opportunities, costs and risks.
Leads reviews of governance practices with appropriate and sufficient independence from management activity.
Acts as the organisation''s contact for relevant regulatory authorities and ensures proper relationships between the organisation and external stakeholders.'),
(8469, 7, 'Dirige a definição, implementação e monitoramento da estrutura de governança para atender às obrigações da organização sob regulamentação, legislação ou contratos.
Fornece liderança, direção e supervisão para as atividades de governança. Integra a gestão de riscos nos frameworks, alinhando-se aos objetivos estratégicos e ao apetite por risco.
Garante os recursos necessários para executar as atividades e alcançar os objetivos de governança da organização com transparência efetiva.
Fornece garantia às partes interessadas de que a organização pode cumprir suas obrigações com um equilíbrio acordado entre benefícios, oportunidades, custos e riscos.', 'Directs the definition, implementation and monitoring of the governance framework to meet organisational obligations under regulation, law, or contracts.
Provides leadership, direction and oversight for governance activities. Integrates risk management into frameworks, aligning with strategic objectives and risk appetite.
Secures resources required to execute activities to achieve the organisation’s governance goals with effective transparency.
Provides assurance to stakeholders that the organisation can deliver its obligations with an agreed balance of benefits, opportunities, costs and risks.'),
(7027, 1, 'Cria elementos visuais simples sob supervisão.
Aplica princípios básicos de design. Utiliza software de design para produzir gráficos simples. Apoia a manutenção de ativos de design e bibliotecas.
Participa em revisões de design e incorpora feedback.
Ajuda com tarefas de rotina, como redimensionamento de imagens, preparação de arquivos para uso impresso ou digital e organização de ativos de design.', 'Creates simple visual elements under supervision.
Applies basic design principles. Uses design software to produce simple graphics. Supports the maintenance of design assets and libraries.
Participates in design reviews and incorporates feedback.
Helps with routine tasks such as resizing images, preparing files for print or digital use and organising design assets.'),
(7027, 2, 'Assiste na produção de elementos visuais e layouts para mídia digital e impressa, sob supervisão frequente.
Aplica princípios de design para produzir visualizações consistentes e eficazes. Utiliza software de design para criar e editar gráficos, preparar mock-ups e protótipos. Segue as diretrizes da marca e especificações do projeto.
Responde ao feedback e aos resultados de pesquisas para revisar os designs.
Participa em atividades de pesquisa para informar decisões de design e entender as necessidades do usuário.', 'Assists the creation of visual elements and layouts for digital and print media under routine supervision.
Applies design principles to produce consistent and effective visuals. Uses design software to create and edit graphics, preparing mock-ups and prototypes. Conforms to brand guidelines and assignment specifications.
Responds to feedback and research findings to revise designs.
Participates in research activities to inform design decisions and understand user needs.'),
(7027, 3, 'Desenha conceitos e layouts visuais para uma variedade de mídias.
Trabalha com as partes interessadas para entender os requisitos de design.
Produz gráficos e elementos visuais de alta qualidade usando software de design. Desenvolve protótipos e iterações com base em feedback. Aplica diretrizes da marca e especificações do projeto.
Contribui para o desenvolvimento de padrões e boas práticas de design.', 'Designs visual concepts and layouts for a range of media.
Works with stakeholders to understand design requirements.
Produces high-quality graphics and visual elements using design software. Develops prototypes and iterates based on feedback. Applies brand guidelines and assignment specifications.
Contributes to the development of design standards and recognised good practices.'),
(7027, 4, 'Desenha conceitos visuais e projetos abrangentes para tarefas complexas.
Interage com clientes e as partes interessadas para obter e documentar requisitos e objetivos de design. Gerencia tarefas de design desde o conceito até a entrega final.
Cria mock-ups detalhados e protótipos interativos de design. Revisa e aprova o trabalho de design, garantindo a alinhamento com padrões da marca e práticas baseadas em evidências.
Desenvolve e implementa processos, diretrizes e boas práticas reconhecidas para melhorar a qualidade e eficácia do design.', 'Designs visual concepts and comprehensive designs for complex assignments.
Engages with clients and stakeholders to elicit and document design requirements and goals. Manages design assignments from concept to final delivery.
Creates detailed design mock-ups and interactive prototypes. Reviews and approves design work, ensuring alignment with brand standards and evidence-based practices.
Develops and implements design processes, guidelines and recognised good practices to enhance design quality and effectiveness.'),
(7027, 5, 'Gerencia atividades de design gráfico para a organização, garantindo que os designs sejam orientados pela pesquisa e alinhados com os objetivos de negócios.
Supervisiona várias iniciativas de design, garantindo resultados consistentes e de alta qualidade. Interage com as principais partes interessadas para alinhar os objetivos de design com os objetivos de negócios e as necessidades dos usuários.
Desenvolve soluções visuais baseadas em pesquisa para fortalecer a identidade da marca e a experiência do usuário.
Lida a criação e adoção de padrões de design, processos e boas práticas reconhecidas. Fornece aconselhamento autorizado sobre tendências de design visual e práticas baseadas em evidências, garantindo que os designs atendam todas as especificações e diretrizes requeridas pela marca.', 'Manages graphic design activities for the organisation, ensuring designs are research-driven and aligned with business objectives.
Oversees multiple design initiatives, ensuring high-quality, consistent output. Engages with senior stakeholders to align design goals with business objectives and user needs.
Develops research-informed visual solutions to strengthen brand identity and user experience.
Leads the creation and adoption of design standards, processes and recognised good practices. Provides authoritative advice on visual design trends and evidence-based practices, ensuring designs meet all required specifications and brand guidelines.'),
(15253, 2, 'Ajuda a projetar componentes de hardware simples ou subsistemas sob orientação.
Siga os princípios de design estabelecidos, padrões e metodologias de acordo com as instruções. Participa na tradução de projetos lógicos para implementações físicas.
Teste componentes de hardware ou subsistemas com base em especificações fornecidas e resultados de documentos. Contribui para a documentação de projetos de hardware usando padrões, métodos e ferramentas necessários.
Busca orientação e apoio para desvios das práticas padrão ou quando se enfrenta a cenários desconhecidos.', 'Assists in designing simple hardware components or subsystems under guidance.
Follows established design principles, patterns and methodologies as directed. Participates in translating logical designs into physical implementations.
Tests hardware components or subsystems against provided specifications and documents results. Contributes to the documentation of hardware designs using required standards, methods and tools.
Seeks guidance and support for deviations from standard practices or when facing unfamiliar scenarios.'),
(15253, 3, 'Segue abordagens padrão e padrões de design selecionados para projetas componentes de hardware simples.
Busca orientação ao desviar de padrões de design estabelecidos. Considera os requisitos finais ambientais, de desempenho, segurança, confiança e sustentabilidade.
Converte designs lógicos em designs físicos. Testa o desempenho de protótipos e dos resultados da produção em relação às especificações.
Envia projetos de hardware para aprovação. Documenta todo o trabalho usando as normas, métodos e ferramentas necessárias', 'Follows selected standard approaches and design patterns to design simple hardware components.
Seeks guidance when deviating from established design patterns. Takes account of target environment, performance, security, safety, reliability and sustainability requirements.
Translates logical designs into physical designs. Tests the performance of prototypes and production output against specification.
Submits hardware designs for approval. Documents all work using required standards, methods and tools.'),
(15253, 4, 'Projeta componentes de hardware, levando em consideração os requisitos de ambiente, desempenho, segurança, confiabilidade e sustentabilidade.
Traduz projetos lógicos em projetos físicos e entrega protótipos técnicos de componentes propostos para aprovação e produção.
Projeta os testes para medir o desempenho de protótipos e saída de produção em relação à especificação e reporta o desenvolvimento iterativo.', 'Designs hardware components, taking account of target environment, performance, security, safety, reliability and sustainability requirements.
Translates logical designs into physical designs and delivers technical prototypes of proposed components for approval and production.
Designs the tests to measure the performance of prototypes and production output against specification and inform iterative development.'),
(15253, 5, 'Especifica e projeta componentes/sistemas de hardware complexos.
Seleciona padrões, métodos e ferramentas de design apropriados, consistentes com as políticas corporativas pré-estabelecidas e garante que sejam aplicados de forma eficaz.
Analisa impacto nas principais opções de projeto. Avalia e gerencia os riscos associados. Garante que os projetos de hardware equilibrem requisitos funcionais, de qualidade, de segurança, de proteção, de gerenciamento de sistemas, de confiabilidade e de sustentabilidade.
Revisa os projetos de outras equipes/profissionais para garantir a seleção de tecnologia apropriada, uso eficiente de recursos e integração eficaz de vários sistemas e tecnologias. Contribui para a política de seleção de componentes.', 'Specifies and designs complex hardware components/systems.
Selects appropriate design standards, methods and tools, consistent with agreed policies and ensures they are applied effectively.
Undertakes impact analysis on major design options. Assesses and manages associated risks. Ensures hardware designs balance functional, quality, safety, security, systems management, reliability and sustainability requirements.
Reviews designs created by others to ensure selection of appropriate technology, efficient use of resources and effective integration of multiple systems and technology. Contributes to policy for selection of components.'),
(15253, 6, 'Fornece direção geral e liderança na prática de design de hardware dentro de uma empresa.
Influencia modelos baseados na indústria para o desenvolvimento de novas tecnologias e componentes.
Desenvolve estratégias de compras eficazes, consistentes com as necessidades do negócio.
Impulsiona a adoção e garante a adesão às políticas, estratégias e padrões organizacionais para design de hardware.', 'Provides overall direction and leadership in the hardware design practice within an organisation.
Influences industry-based models for the development of new technology and components.
Develops effective procurement strategies, consistent with business needs.
Develops, drives adoption and ensures adherence to organisational policies, strategies and standards for hardware design.'),
(15254, 4, 'Desenvolve soluções moderadamente complexas que usam ambientes de computação de alto desempenho para resolver problemas do mundo real.
Aplica uma gama de técnicas de computação de alto desempenho com sensibilidade às limitações das técnicas.
Usa informações e feedback de especialistas, conforme apropriado.
Analisa a complexidade, escalabilidade e desempenho de algoritmos, incluindo implementações massivamente paralelas, e implementa ou recomenda melhorias.', 'Develops moderately complex solutions that use high-performance computing environments to address real-world problems.
Applies a range of high-performance computing techniques with sensitivity to the limitations of the techniques.
Uses input and feedback from experts as appropriate.
Analyses the complexity, scalability and performance of algorithms, including massively parallel implementations, and makes or recommends improvements.'),
(15254, 5, 'Cria, testa e aprimora soluções complexas de computação de alto desempenho para resolver problemas do mundo real.
Trabalha com as partes interessadas para garantir que as soluções de computação de alto desempenho sejam eficazes para resolver seus problemas.
Orienta as equipes de desenvolvimento no uso adequado e eficaz de recursos de computação de alto desempenho.', 'Creates, tests and improves complex high-performance computing solutions to address real-world problems.
Collaborates with stakeholders to ensure high-performance computing solutions are effective at addressing their problems.
Guides development teams in the appropriate and effective use of high-performance computing resources'),
(15254, 6, 'Inicia a criação, teste, melhoria e aplicação de algoritmos que resolvem problemas do mundo real em ambientes de computação de alto desempenho.
Define padrões e estratégias para o uso de computação de alto desempenho.
Orienta a implementação de recursos organizacionais para garantir o uso apropriado, consistente e eficaz da computação de alto desempenho.', 'Initiates the creation, testing, improvement and application of algorithms that solve real-world problems in high-performance computing environments.
Sets standards and strategies for the use of high-performance computing.
Leads the implementation of organisational capabilities to ensure appropriate, consistent and effective usage of high-performance computing.'),
(15254, 7, 'Direciona a criação e revisão de uma abordagem e cultura multifuncional e corporativa para computação de alto desempenho.
Conduz o desenvolvimento dos recursos de computação de alto desempenho da organização e defende seu uso na solução de problemas do mundo real.', 'Directs the creation and review of a cross-functional, enterprise-wide approach and culture for high-performance computing.
Leads the development of the organisation’s high-performance computing capabilities and champions its use in solving real-world problems.'),
(15255, 1, 'Executa tarefas básicas de gerenciamento de identidades e acessos, incluindo o gerenciamento do ciclo de vida de conta de usuário, sob supervisão.
Mantém registros precisos e segue protocolos de gerenciamento de identidades e acessos estabelecidos.', 'Performs basic identity and access management tasks, including user account lifecycle management, under supervision.
Maintains accurate records and follows established identity and access management protocols.'),
(15255, 2, 'Fornece assistência para operações de gerenciamento de identidades e acessos, incluindo atribuição automática de funções e gerenciamento de controle de acessos.
Participa na gestão do ciclo de vida da identidade do usuário, incluindo criação e exclusão de contas.
Facilita a operação de ferramentas de gerenciamento de identidades e acessos e portais de auto-serviço.', 'Provides assistance for identity and access management operations, including automated role allocation and access control management.
Engages in user identity lifecycle management, including account creation and deletion.
Facilitates operation of identity and access management tools and self-service portals.'),
(15255, 3, 'Administra serviços padrão de gerenciamento de identidades e acessos, implementa políticas e resolve problemas relacionados.
Gerencia monitoramento, auditorias e logs de sistemas de gerenciamento de identidades e acessos. Investiga falhas de segurança menores de acordo com procedimentos estabelecidos relacionados com gerenciamento de identidades e acessos.
Auxilia os usuários a definir seus direitos e privilégios de acesso.
Projeta e implementa soluções simples de gerenciamento de identidades e acessos, aumentando a segurança de acesso do usuário. Contribui para a melhoria e otimização dos processos e sistemas de gerenciamento de identidades e acessos existentes.', 'Administers standard identity and access management services, implementing policies and resolving related issues.
Manages monitoring, audits and logging for identity and access management systems. Investigates minor security breaches in accordance with established procedures related to identity and access management.
Assists users in defining their access rights and privileges.
Designs and implements simple identity and access management solutions, enhancing user access security. Contributes to the enhancement and optimisation of existing identity and access management processes and systems.'),
(15255, 4, 'Desenha e implementa soluções complexas de gerenciamento de identidades e acessos, com foco em controle de acesso automatizado e atribuição de funções.
Supervisiona a integração de serviços de gerenciamento de identidades e acessos com novas tecnologias.
Fornece suporte especializado para operações complexas de gerenciamento de identidades e acessos e apoia a implementação de políticas e padrões.
Colabora com as partes interessadas para alinhar o gerenciamento de identidades e acessos com objetivos do negócio e tendências emergentes em segurança.', 'Designs and implements complex identity and access management solutions, focusing on automated access control and role allocation.
Oversees the integration of identity and access management services with new technologies.
Provides specialised support for complex identity and access management operations and supports implementation of policies and standards.
Collaborates with stakeholders to align identity and access management with business objectives and emerging security trends.'),
(15255, 5, 'Oferece aconselhamento autorizado sobre gerenciamento de identidades e acessos, garantindo que os serviços estejam alinhados e apoiem as necessidades do negócio e protocolos de segurança em evolução.
Gerencia iniciativas de gerenciamento de identidades e acessos em grande escala e supervisiona a integração de serviços de gerenciamento de identidades e acessos com novas tecnologias, aumentando a segurança e a eficiência operacional.
Lidera o planejamento operacional para gerenciamento de identidades e acessos, antecipa tendências futuras e prepara a organização para crescimento escalável.
Assegura a conformidade de sistemas de gerenciamento de identidades e acessos e supervisiona processos avançados de monitoramento e auditoria.', 'Offers authoritative advice on identity and access management, ensuring services align with and support evolving business needs and security protocols.
Manages large-scale identity and access management initiatives and oversees the integration of identity and access management services with new technologies, enhancing security and operational efficiency.
Leads operational planning for identity and access management, anticipating future trends and preparing the organisation for scalable growth.
Ensures compliance of identity and access management systems and oversees advanced monitoring and audit processes.'),
(15255, 6, 'Modela e define políticas de gerenciamento de identidades e acessos em toda organização, garantindo alinhamento com as estratégias do negócio e requisitos de segurança.
Defende boas práticas, advogando soluções robustas e inovadoras de gerenciamento de identidades e acessos em toda organização.
Influi e orienta a governança organizacional, integrando tecnologias emergentes e conformidade regulatória em estratégias de gerenciamento de identidades e acessos.
Revisa e fornece aconselhamento sobre aspectos e implicações de gerenciamento de identidades e acessos em novas iniciativas de negócios.', 'Shapes and defines organisation-wide identity and access management policies, ensuring alignment with business strategies and security requirements.
Champions good practices, advocating for robust and innovative identity and access management solutions across the organisation.
Influences and guides organisational governance, integrating emerging technologies and regulatory compliance into identity and access management strategies.
Reviews and advises on identity and access management aspects and implications of new business initiatives.'),
(15256, 1, 'Segue procedimentos acordados para identificar, registrar e categorizar incidentes.
Utiliza ferramentas e tecnologias fornecidas para apoiar o processo de gerenciamento de incidentes.
Recolhe informações conforme instruído para ajudar na resolução de incidentes e atribui incidentes conforme instruído.
Ajuda a monitorar filas de incidentes e escala problemas de acordo com procedimentos.', 'Follows agreed procedures to identify, register and categorise incidents.
Uses provided tools and technologies to support the incident management process.
Collects information as instructed to assist in incident resolution and allocates incidents as directed.
Assists in monitoring incident queues and escalates issues according to procedures.'),
(15256, 2, 'Fornece investigação de primeira linha.
Reúne informações para habilitar a resolução de incidentes e atribui incidentes de acordo com procedimentos estabelecidos. Escala incidentes quando necessário.
Informa as pessoas relevantes sobre as ações tomadas. Comunica com usuários e stakeholders para fornecer atualizações sobre o status de incidentes.
Ajuda na manutenção de registros e documentação relacionados a incidentes.', 'Provides first line investigation.
Gathers information to enable incident resolution and allocates incidents according to established procedures. Escalates incidents as necessary.
Advises relevant people of actions taken. Communicates with users and stakeholders to provide updates on incident status.
Assists in maintaining records and documentation related to incidents.'),
(15256, 3, 'Prioriza e diagnostica incidentes aplicando procedimentos e ferramentas acordados.
Investiga as causas dos incidentes e procura a resolução.
Escala incidentes não resolvidos para níveis mais altos ou equipes especializadas. Coordena com as partes interessadas para garantir a resolução oportuna.
Facilita a recuperação, após a resolução dos incidentes. Documenta, comunica resultados e fecha incidentes resolvidos.', 'Prioritises and diagnoses incidents applying agreed procedures and tools.
Investigates causes of incidents and seeks resolution.
Escalates unresolved incidents to higher levels or specialist teams. Coordinates with stakeholders to ensure timely resolution.
Facilitates recovery, following resolution of incidents. Documents, communicates outcomes and closes resolved incidents.'),
(15256, 4, 'Monitora e gerencia filas de incidentes para garantir que os incidentes sejam tratados de acordo com procedimentos e níveis de serviço.
Contribui para desenvolver, testar e melhorar procedimentos de gerenciamento de incidentes. Utiliza ferramentas de análise para rastrear tendências.
Assegura que os incidentes resolvidos sejam devidamente documentados e fechados.
Apoia os membros da equipe na utilização correta do processo de incidentes.', 'Monitors and manages incident queues to ensure incidents are handled according to procedures and service levels.
Contributes to developing, testing and improving incident management procedures. Uses analytics tools to track trends.
Ensures resolved incidents are properly documented and closed.
Supports team members in the correct use of the incident process.'),
(15256, 5, 'Responsável pela operação do processo de gerenciamento de incidentes.
Gerencia as comunicações de incidentes, garantindo que todas as partes estejam cientes de incidentes e seu papel no processo.
Liderar a revisão de incidentes importantes e informar os proprietários de serviços sobre os resultados. Assegura a resolução de incidentes dentro dos objetivos de serviço. Analisa métricas e relatórios sobre o desempenho do processo de gerenciamento de incidentes.
Desenvolve, mantém e testa políticas e procedimentos de gerenciamento de incidentes. Assegura o cumprimento dos requisitos regulatórios.', 'Responsible for the operation of the incident management process.
Manages incident communications, ensuring all parties are aware of incidents and their role in the process.
Leads the review of major incidents and informs service owners of outcomes. Ensures incident resolution within service targets. Analyses metrics and reports on the performance of the incident management process.
Develops, maintains and tests incident management policy and procedures. Ensures compliance with regulatory requirements.'),
(15256, 6, 'Forma e dirige a estratégia de gerenciamento de incidentes da organização.
Estabelece políticas e padrões para gerenciamento de incidentes alinhados com objetivos organizacionais.
Fornece liderança durante incidentes importantes, coordena equipes interfuncionais e parceiros externos. Faz decisões de alto nível para minimizar o impacto e garantir a recuperação rápida.
Lida com o desenvolvimento de capacidades organizacionais para gerenciamento de incidentes. Promove a colaboração organizacional e garante que os processos de gerenciamento de incidentes sejam compreendidos e adotados em toda a organização.', 'Shapes and directs the organisation''s incident management strategy.
Establishes policies and standards for incident management aligned with organisational goals.
Provides leadership during major incidents, coordinating cross-functional teams and external partners. Makes high-level decisions to minimise impact and ensure swift recovery.
Leads the development of organisational capabilities for incident management. Promotes organisational collaboration and ensures that incident management processes are understood and adopted across the organisation.'),
(15257, 4, 'Apoia a implementação de políticas, padrões e diretrizes relacionadas à legislação de informações e dados e requisitos de conformidade.
Monitora a implementação de controles eficazes para delegação interna, auditoria e controle relacionados à gestão da informação.
Relata o status consolidado dos controles de informação para orientar uma tomada de decisão eficaz.
Identifica riscos relacionados ao uso de informações e dados sujeitos a legislações específicas. Recomenda ações corretivas conforme necessário.', 'Supports the implementation of policy, standards and guidelines related to information and data legislation and compliance requirements.
Monitors the implementation of effective controls for internal delegation, audit and control relating to information management.
Reports on the consolidated status of information controls to inform effective decision-making.
Identifies risks around the use of information and data that is subject to specific legislation. Recommends remediation actions as required.'),
(15257, 5, 'Contribui para políticas, padrões e diretrizes para informações e conformidade de dados.
Fornece aconselhamento autorizado sobre a implementação de controles de conformidade em produtos, serviços e sistemas.
Investiga violações e recomenda melhorias de controle. Mantenha um inventário de dados legislativos, realiza avaliações de risco e especifica as mudanças necessárias.
Assegura que pedidos e reclamações formais sejam tratadas de acordo com procedimentos. Prepara e apresenta relatórios às autoridades relevantes, garantindo que todos os requisitos de conformidade sejam cumpridos.', 'Contributes to policies, standards and guidelines for information and data compliance.
Provides authoritative advice on implementing compliance controls in products, services and systems.
Investigates breaches and recommends control improvements. Maintains an inventory of legislated data, conducts risk assessments and specifies necessary changes.
Ensures formal requests and complaints are handled following procedures. Prepares and submits reports to relevant authorities, ensuring all compliance requirements are met.'),
(15257, 6, 'Desenvolve estratégias para o cumprimento da legislação de dados.
Garante que a política e os padrões de conformidade com a legislação de dados sejam adequados, atuais e corretamente implementados.
Atua como o contato da organização para as autoridades reguladoras.
Opera como um foco para a legislação de dados para a organização, trabalhando com especialistas para fornecer aconselhamento e orientações confiáveis.', 'Develops strategies for compliance with information and data legislation.
Ensures that the policy and standards for compliance with information and data legislation are fit for purpose, current and correctly implemented.
Acts as the organisation''s contact for the regulatory authorities.
Operates as a focus for information and data legislation for the organisation, working with specialists to provide authoritative advice and guidance.'),
(15258, 2, 'Ajuda com atividades de garantia de informação sob supervisão de rotina.
Ajuda a realizar avaliações básicas de risco e apoia a implementação de medidas de garantia de informação.
Ajuda na manutenção de registros e documentação relacionados à garantia de informação.', 'Assists with information assurance activities under routine supervision.
Helps perform basic risk assessments and supports the implementation of information assurance measures.
Assists in maintaining records and documentation related to information assurance.'),
(15258, 3, 'Segue as abordagens padrão para a avaliação técnica de sistemas de informação em relação às políticas de garantia das informações e objetivos de negócio.
Toma decisões de credenciamento de modo rotineiro. Reconhece as decisões que estão fora de seu escopo e nível de responsabilidade, direcionando-as adequadamente.
Revisa e realiza avaliações de riscos e planos de tratamento de riscos. Identifica indicadores típicos de riscos e explica as medidas de prevenção.
Mantém a integridade dos registros para dar suporte e justificar as decisões.', 'Follows standard approaches for the technical assessment of information systems against information assurance policies and business objectives.
Makes routine accreditation decisions. Recognises decisions that are beyond their scope and responsibility level and escalates according.
Reviews and performs risk assessments and risk treatment plans. Identifies typical risk indicators and explains prevention measures.
Maintains integrity of records to support and justify decisions.'),
(15258, 4, 'Realiza avaliações técnicas e/ou o credenciamento de sistemas de informações complexos ou de alto risco.
Identifica as medidas necessárias de mitigação dos riscos além das medidas padrão da organização ou do domínio.
Estabelece o requisito de comprovação de credenciamento aos parceiros de entrega e informa os requisitos de credenciamento às partes interessadas.
Contribui com o planejamento e organização de atividades de garantia e credenciamento das informações. Contribui para o desenvolvimento e implementação de processos de garantia das informações.', 'Performs technical assessments and/or accreditation of complex or higher-risk information systems.
Identifies risk mitigation measures required in addition to the standard organisation or domain measures.
Establishes the requirement for accreditation evidence from delivery partners and communicates accreditation requirements to stakeholders.
Contributes to planning and organisation of information assurance and accreditation activities. Contributes to development of and implementation of information assurance processes.'),
(15258, 5, 'Interpreta as políticas de garantia e segurança da informação e as aplica para gerenciar riscos.
Oferece assessoria e orientação para garantir a adoção e adesão a arquiteturas, estratégias, políticas, normas e diretrizes de garantia das informações.
Planeja, organiza e realiza a garantia e o credenciamento das informações de áreas de domínios complexos, áreas multifuncionais e ao longo de toda a cadeia de suprimento.
Contribui para o desenvolvimento de políticas, normas e diretrizes.', 'Interprets information assurance and security policies and applies these to manage risks.
Provides advice and guidance to ensure adoption of and adherence to information assurance architectures, strategies, policies, standards and guidelines.
Plans, organises and conducts information assurance and accreditation of complex domains areas, cross-functional areas and across the supply chain.
Contributes to the development of policies, standards and guidelines.'),
(15258, 6, 'Desenvolve políticas, normas e diretrizes de garantia de informações.
Contribui para o desenvolvimento de estratégias organizacionais que abordam o risco de negócios em evolução e os requisitos de controle de informações.
Impulsiona a adoção e a adesão a políticas e padrões. Garante que os princípios de arquitetura sejam seguidos, os requisitos sejam definidos e testes de segurança rigorosos sejam aplicados. Garante que os processos de credenciamento ofereçam suporte e viabilizem os objetivos organizacionais.
Monitora tendências ambientais e de mercado e avalia todos os impactos nas estratégias de negócios, benefícios e riscos.', 'Develops information assurance policy, standards and guidelines.
Contributes to the development of organisational strategies that address the evolving business risk and information control requirements.
Drives adoption of and adherence to policies and standards. Ensures architectural principles are followed, requirements are defined and rigorous security testing is applied. Ensures accreditation processes support and enable organisational objectives.
Monitors environmental and market trends and assesses any impact on organisational strategies, benefits and risks.'),
(15258, 7, 'Direciona a criação e revisão de uma estratégia de garantia de informações corporativas para dar suporte aos requisitos estratégicos do negócio.
Garante a conformidade entre as estratégias de negócios e a garantia da informação, definindo estratégias, políticas, padrões e práticas.
Lidera o fornecimento de expertise em garantia da informação, aconselhamento e orientação em todas as informações e sistemas de informação da organização.', 'Directs the creation and review of an enterprise information assurance strategy to support the strategic requirements of the business.
Ensures compliance between business strategies and information assurance by setting strategies, policies, standards and practices.
Leads the provision of information assurance expertise, advice and guidance across all of the organisation''s information and information systems.'),
(13643, 3, 'Apoia equipes e indivíduos na identificação e organização de ativos de informação e repositórios de acordo com políticas e práticas.
Realiza buscas rotineiras de informações não sensíveis necessárias para apoiar a tomada de decisões organizacionais.
Ajuda os usuários a localizar e acessar recursos de informação com base em suas necessidades e permissões aprovadas.', 'Supports teams and individuals to identify and organise information assets and repositories in line with policy and practices.
Conducts routine searches for non-sensitive information needed to support organisational decision making.
Supports users to find and access information resources based on their requirements and approved access.'),
(13643, 4, 'Permite que a organização estruture, controle e descubra ativos de informação.
Apoia a organização na identificação, catalogação e categorização de tipos de informação e repositórios de acordo com as estratégias e práticas de gestão da informação.
Facilita que os usuários encontrem informações por meio do uso adequado de metadados e ferramentas de busca.
Fornece aconselhamento e orientação para que boas práticas de gestão da informação sejam adotadas em toda a organização.', 'Enables the organisation to organise, control and discover information assets.
Supports the organisation to identify, catalogue and categorise information types and information repositories in line with information management strategies and practices.
Enables users to find information through appropriate use of metadata and search tools.
Provides advice and guidance to enable good information management practices to be adopted across the organisation.'),
(13643, 5, 'Garante a implementação de políticas, práticas e padrão de gestão da informação e de registros.
Comunica os benefícios e o valor da gestão da informação. Planeja o armazenamento, compartilhamento e publicação eficazes de informações dentro da organização.
Desenvolve a taxonomia organizacional para os ativos de informação. Fornece aconselhamento e orientação especializada para permitir que a organização obtenha o máximo valor de seus ativos de informação.
Avalia questões que possam impedir a organização de utilizar plenamente seus ativos de informação. Contribui para o desenvolvimento de políticas, normas e procedimentos para conformidade com a legislação relevante.', 'Ensures implementation of information and records management policies and standard practice.
Communicates the benefits and value of information management. Plans effective information storage, sharing and publishing within the organisation.
Develops organisational taxonomy for information assets. Provides expert advice and guidance to enable the organisation to get maximum value from its information assets.
Assesses issues that might prevent the organisation from making maximum use of its information assets. Contributes to the development of policy, standards and procedures for compliance with relevant legislation.'),
(13643, 6, 'Lidera e planeja atividades para comunicar e implementar estratégias e políticas de gerenciamento de informações.
Desenvolve políticas, normas e diretrizes organizacionais para gerenciamento de informações.
Assegura que as informações necessárias para apoiar a organização sejam definidas. Cria processos de gestão da informação.
Coordena recursos de informação internos e externos para atender a objetivos específicos de negócios.', 'Leads and plans activities to communicate and implement information management strategies and policies.
Develops organisational policies, standards and guidelines for information management.
Ensures the information required to support the organisation is defined. Creates information management processes.
Coordinates internal and externally sourced information resources to meet specific business objectives.'),
(13643, 7, 'Estabelece e comunica a estratégia de gestão da informação da organização.
Especifica, em nível estratégico, as informações necessárias para apoiar a estratégia e as funções de negócios.
Direciona os recursos de informação para gerar valor para as partes interessadas.
É responsável pela conformidade com regulamentos, normas e códigos de boas práticas relacionados a todos os aspectos da gestão da informação.', 'Establishes and communicates the organisation''s information management strategy.
Specifies at a strategic level the information needed to support the business strategy and business functions.
Directs information resources to create value for stakeholders.
Accountable for compliance with regulations, standards and codes of good practice relating to all aspects of information management.'),
(5729, 2, 'Ajuda a implementar e monitorar políticas e protocolos de segurança em diferentes sistemas.
Contribui para identificar e abordar riscos potenciais na governança de segurança e conformidade.
Apoia a análise de incidentes de segurança documentados, escalando quando apropriado.
Ajuda na revisão de controles de acesso e permissões, garantindo a adesão às políticas de segurança.', 'Assists with implementing and monitoring security policies and protocols across different systems.
Contributes to identifying and addressing potential risks in security governance and compliance.
Supports the analysis of documented security incidents, escalating where appropriate.
Assists in the review of access controls and permissions, ensuring adherence to security policies.'),
(5729, 3, 'Aplica e mantém controles específicos de segurança conforme exigido pelas avaliações de políticas organizacionais e avaliações de riscos locais.
Informa os riscos e problemas de segurança aos gerentes de negócio e outras pessoas. Realiza avaliações de riscos básicos para sistemas de informação de pequeno porte.
Contribui para a identificação de riscos decorrentes de arquiteturas potenciais de soluções técnicas. Sugere soluções alternativas ou medidas de resposta para mitigar os riscos. Define as configurações de sistemas seguros em conformidades com as arquiteturas pretendidas.
Dá suporte à investigação de suspeitas de ataques e violações de segurança.', 'Applies and maintains specific security controls as required by organisational policy and local risk assessments.
Communicates security risks and issues to business managers and others. Performs basic risk assessments for small information systems.
Contributes to the identification of risks that arise from potential technical solution architectures. Suggests alternate solutions or countermeasures to mitigate risks. Defines secure systems configurations in compliance with intended architectures.
Supports investigation of suspected attacks and security breaches.'),
(5729, 4, 'Fornece aconselhamento e orientação sobre a aplicação e operação de controles elementares físicos, processuais e de segurança técnica.
Explica o propósito dos controles de segurança e realiza análises de riscos de segurança e impacto nos negócios para sistemas de informação de complexidade média.
Identifica os riscos decorrentes de arquiteturas potenciais de soluções técnicas. Cria soluções alternativas ou medidas de resposta e garante que mitiguem os riscos identificados.
Investiga suspeitas de ataques e dá suporte à gestão de incidentes de segurança.', 'Provides guidance on the application and operation of elementary physical, procedural and technical security controls.
Explains the purpose of security controls and performs security risk and business impact analysis for medium complexity information systems.
Identifies risks that arise from potential technical solution architectures. Designs alternate solutions or countermeasures and ensures they manage identified risks.
Investigates suspected attacks and supports security incident management.'),
(5729, 5, 'Fornece aconselhamento e orientação sobre estratégias de segurança para gerenciar riscos identificados e garantir a adoção e adesão aos padrões.
Contribui para o desenvolvimento de políticas, normas e orientações de segurança da informação.
Obtém e atua sobre informações de vulnerabilidade e realiza avaliações de risco de segurança, análises de impacto ao negócio e credenciamento de sistemas de informação complexos. Investiga as principais violações de segurança e recomenda melhorias de controle apropriadas.
Desenvolve novas arquiteturas que mitigam os riscos propostos pelas novas tecnologias e práticas de negócios.', 'Provides advice and guidance on security strategies to manage identified risks and ensure adoption and adherence to standards.
Contributes to development of information security policy, standards and guidelines.
Obtains and acts on vulnerability information and conducts security risk assessments, business impact analysis and accreditation on complex information systems. Investigates major breaches of security and recommends appropriate control improvements.
Develops new architectures that manage the risks posed by new technologies and business practices.'),
(5729, 6, 'Desenvolve e comunica a política, normas e diretrizes de segurança da informação corporativa.
Garante que os princípios de arquitetura sejam aplicados durante o projeto para reduzir riscos. Impulsiona a adoção e a adesão a políticas, normas e diretrizes.
Contribui para o desenvolvimento de estratégias organizacionais que atendam aos requisitos de controle de informações. Identifica e monitora tendências de ambiente e de mercado e avalia, proativamente, o impacto nas estratégias de negócios, benefícios e riscos.
Conduz o fornecimento de aconselhamento e orientação autorizados sobre os requisitos para controles de segurança, em colaboração com especialistas no assunto.', 'Develops and communicates corporate information security policy, standards and guidelines.
Ensures architectural principles are applied during design to reduce risk. Drives adoption and adherence to policy, standards and guidelines.
Contributes to the development of organisational strategies that address information control requirements. Identifies and monitors environmental and market trends and proactively assesses impact on business strategies, benefits and risks.
Leads the provision of authoritative advice and guidance on the requirements for security controls in collaboration with subject matter experts.'),
(5729, 7, 'Orienta o desenvolvimento, implementação, entrega e suporte de uma estratégia de segurança da informação corporativa, alinhada à estratégia de negócios.
Garante a conformidade entre as estratégias de negócios e a segurança da informação.
Orienta o fornecimento de experiência em segurança da informação, orientação e sistemas necessários para executar planos estratégicos e operacionais.
Protege os recursos organizacionais para executar a estratégia de segurança da informação.', 'Directs the development, implementation, delivery and support of an enterprise information security strategy aligned with the business strategy.
Ensures compliance between business strategies and information security.
Leads the provision of information security expertise, guidance and systems needed to execute strategic and operational plans.
Secures organisational resources to execute the information security strategy.'),
(15259, 6, 'Mantém a conscientização sobre as necessidades globais da organização.
Promove os benefícios que uma abordagem comum para a implementação de tecnologia trará para toda a organização.
Coordena e colabora com outros na promoção, aquisição, desenvolvimento e implementação de sistemas e serviços de informação.', 'Maintains awareness of the global needs of the organisation.
Promotes the benefits that a common approach to technology deployment will bring to the entire organisation.
Coordinates and collaborates with others on the promotion, acquisition, development and implementation of information systems and services.'),
(15259, 7, 'Estabelece a estratégia da organização para a gestão da informação e comunica as políticas, normas, procedimentos e métodos necessários para implementar a estratégia.
Coordena todos os aspectos da gestão do ciclo de vida dos sistemas de informação.
Representa os interesses de toda a organização junto da direção geral e órgãos externos em assuntos relacionados à estratégia de informação.', 'Establishes the organisation''s strategy for managing information and communicates the policies, standards, procedures and methods necessary to implement the strategy.
Coordinates all aspects of management of the lifecycle of information systems.
Represents the interests of the entire organisation to general management and external bodies on matters relating to information strategy.'),
(15260, 2, 'Ajuda a desenvolver especificações preliminares de projeto de infraestrutura sob supervisão de rotina.
Utiliza padrões estabelecidos e protocolos de segurança para contribuir para atividades de projeto de infraestrutura.
Ajuda a redigir documentos de projeto e diagramas.
Documentos questões relacionadas ao projeto.', 'Assists in developing preliminary infrastructure design specifications under routine supervision.
Uses established standards and security protocols to contribute to infrastructure design activities.
Helps draft design documents and diagrams.
Documents design-related issues.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(15260, 3, 'Realiza tarefas de projeto de infraestrutura variadas, incluindo atribuições complexas e não rotineiras, usando métodos padrão.
Desenvolve especificações de projeto e diagramas para componentes de infraestrutura, integra hardware, software, elementos de rede e serviços em nuvem e aborda requisitos de segurança.
Colabora com outros para alinhar o projeto de infraestrutura com objetivos organizacionais e resolver problemas de projeto.
Sugere melhorias para melhorar o desempenho e a confiabilidade da infraestrutura.', 'Performs varied infrastructure design tasks, including complex and non-routine assignments, using standard methods.
Develops design specifications and diagrams for infrastructure components, integrating hardware, software, network elements, and cloud services, and addressing security requirements.
Collaborates with others to align infrastructure design with organisational objectives and resolve design issues.
Suggests improvements to enhance infrastructure performance and reliability.'),
(15260, 4, 'Lidera o design de sistemas de infraestrutura complexos para fornecer soluções de design abrangentes.
Desenvolve quadros arquitetônicos detalhados e garante a integração de todos os componentes de infraestrutura, incluindo serviços em nuvem.
Fornece orientação sobre práticas recomendadas e padrões de design. Revisa e valida especificações de projeto e documentação.
Verifica que os projetos são escaláveis, confiáveis e seguros, alinhados com requisitos de negócios e técnicos.', 'Leads the design of complex infrastructure systems to deliver comprehensive design solutions.
Develops detailed architectural frameworks and ensures integration of all infrastructure components, including cloud services.
Provides guidance on recommended practices and design standards. Reviews and validates design specifications and documentation.
Checks that designs are scalable, reliable and secure, aligning with business and technical requirements.'),
(15260, 5, 'Gerencia o design da infraestrutura, desde a análise até a execução e avaliação.
Responsável por alcançar os objetivos de design e garantir a alinhamento com os objetivos organizacionais e a integração eficaz dos componentes e sistemas de infraestrutura.
Fornece orientação autorizada sobre práticas e metodologias de design. Avalia novas tecnologias e sua aplicabilidade às necessidades da organização.
Desenvolve e aplica padrões de design e práticas recomendadas, garantindo resultados de design consistentes e de alta qualidade.', 'Manages the design of infrastructure from analysis to execution and evaluation.
Accountable for achieving design objectives and ensuring alignment with organisational goals and the effective integration of infrastructure components and systems.
Provides authoritative guidance on design practices and methodologies. Evaluates new technologies and their applicability to the organisation''s needs.
Develops and enforces design standards and recommended practices, ensuring consistent and high-quality design outcomes.'),
(15260, 6, 'Desenvolve e impulsiona a adoção e a adesão de políticas, padrões, diretrizes e métodos organizacionais para o projeto de infraestrutura.
Colabora com as partes interessadas seniores para alinhar projetos de projeto com objetivos organizacionais.
Fornece supervisão e orientação estratégica, garantindo que os projetos de infraestrutura sejam prospectivos, escaláveis e seguros.
Responsável pelo sucesso global das iniciativas de projeto de infraestrutura.', 'Develops and drives adoption of and adherence to organisational policies, standards, guidelines and methods for infrastructure design.
Collaborates with senior stakeholders to align design projects with organisational objectives.
Provides strategic oversight and guidance, ensuring infrastructure designs are forward-looking, scalable and secure.
Accountable for the overall success of infrastructure design initiatives.'),
(15261, 1, 'Suporta tarefas de infraestrutura de rotina e resolução de problemas básicos sob supervisão cuidadosa.
Monitora o estado da infraestrutura e relata o estado dos componentes para apoiar a continuidade operacional.', 'Supports routine infrastructure tasks and basic troubleshooting under close supervision.
Monitors infrastructure health and reports on component status to support operational continuity.'),
(15261, 2, 'Executa procedimentos operacionais, executa scripts de automação e realiza manutenção, instalação e monitoramento de rotina de componentes de infraestrutura.
Ajusta tarefas de automação de acordo com as instruções para atender aos padrões operacionais.
Relata sobre o desempenho da infraestrutura e eventos de segurança, resolvendo problemas diretamente quando possível ou escalando-os para outras pessoas para resolução.', 'Executes operational procedures, runs automation scripts and performs routine maintenance, installation and monitoring of infrastructure components.
Adjusts automation tasks as instructed to meet operational standards.
Reports on infrastructure performance and security events, addressing issues directly when possible or escalating them to others for resolution.'),
(15261, 3, 'Fornece, implanta e configura serviços e componentes de infraestrutura.
Monitora a infraestrutura para incidentes de carga, desempenho e segurança. Relata métricas e resolve problemas operacionais.
Executa procedimentos operacionais padrão, incluindo backups e restaurações.
Realiza tarefas de manutenção de software de sistema acordadas. Automatiza tarefas de administração de sistema de rotina para especificações usando ferramentas padrão e scripts básicos.', 'Provisions, deploys and configures infrastructure services and components.
Monitors infrastructure for load, performance and security events. Reports metrics and resolves operational issues.
Executes standard operational procedures, including backups and restorations.
Carries out agreed system software maintenance tasks. Automates routine system administration tasks to specifications using standard tools and basic scripting.'),
(15261, 4, 'Aplica conhecimentos técnicos para manter e otimizar a infraestrutura tecnológica, executar atualizações e empregar ferramentas de automação.
Configura ferramentas e/ou cria scripts para automatizar tarefas de infraestrutura. Mantém procedimentos operacionais e verifica que eles são seguidos, incluindo a adesão às políticas de segurança. Utiliza ferramentas de gerenciamento de infraestrutura para monitorar cargas, desempenho e métricas de segurança.
Investiga e permite a resolução de problemas operacionais e relacionados à segurança. Fornece relatórios e propostas de melhoria para as partes interessadas.
Contribui para o planejamento e implementação de manutenção e atualizações da infraestrutura. Implementa mudanças e rotinas de manutenção de infraestrutura acordadas.', 'Applies technical expertise to maintain and optimise technology infrastructure, executing updates and employing automation tools.
Configures tools and/or creates scripts to automate infrastructure tasks. Maintains operational procedures and checks that they are followed, including adherence to security policies. Uses infrastructure management tools to monitor load, performance, and security metrics.
Investigates and enables the resolution of operational and security-related issues. Provides reports and proposals for improvement to stakeholders.
Contributes to the planning and implementation of infrastructure maintenance and updates. Implements agreed infrastructure changes and maintenance routines.'),
(15261, 5, 'Fornece liderança técnica para otimizar o desempenho da infraestrutura tecnológica.
Impele a adoção de ferramentas e processos automatizados para gerenciamento e entrega operacionais eficazes.
Supervisiona o planejamento, instalação, manutenção e aceitação de componentes de infraestrutura novos e atualizados e serviços baseados em infraestrutura. Alinha com expectativas de serviço, requisitos de segurança e outros padrões de qualidade.
Assegura que os procedimentos operacionais e a documentação sejam atuais e eficazes, rastreia e resolve questões operacionais e reporta a partes interessadas.', 'Provides technical leadership to optimise the performance of the technology infrastructure.
Drives the adoption of tools and automated processes for effective operational management and delivery.
Oversees the planning, installation, maintenance and acceptance of new and updated infrastructure components and infrastructure-based services. Aligns to service expectations, security requirements and other quality standards.
Ensures operational procedures and documentation are current and effective, tracks and addresses operational issues and reports to stakeholders.'),
(15262, 5, 'Gerencia o ciclo de inovação e executa processos de inovação.
Desenvolve e adapta ferramentas, processos e infraestruturas de inovação para impulsionar o processo de inovação. Identifica recursos e capacidades necessárias para apoiar a inovação.
Incentiva e motiva comunidades de inovação, equipes e indivíduos a compartilhar ideias criativas e aprender com os fracassos.
Gerencia e facilita a comunicação e o fluxo aberto de ideias criativas entre as partes interessadas e a criação de redes e comunidades de inovação.', 'Manages the innovation pipeline and executes innovation processes.
Develops and adapts innovation tools, processes and infrastructures to drive the process of innovation. Identifies resources and capabilities needed to support innovation.
Encourages and motivates innovation communities, teams and individuals to share creative ideas and learn from failures.
Manages and facilitates the communication and open flow of creative ideas between interested parties and the set-up of innovation networks and communities.'),
(15262, 6, 'Obtém o comprometimento organizacional com a inovação.
Desenvolve capacidades organizacionais para impulsionar a inovação.
Lidera e planeja o desenvolvimento de competências de inovação e a implementação de processos, ferramentas e quadros de referência de inovação.
Conduz a comunicação e o fluxo aberto de ideias criativas entre as partes interessadas, além da criação de redes e comunidades de inovação.', 'Obtains organisational commitment to innovation.
Develops organisational capabilities to drive innovation.
Leads and plans the development of innovation capabilities and implementation of innovation processes, tools and frameworks.
Leads the communication and an open flow of creative ideas between interested parties and the set-up of innovation networks and communities.'),
(15262, 7, 'Lidera o desenvolvimento de uma cultura que incentiva a inovação, a tomada de riscos e a colaboração.
Incorpora processos de inovação em todas as unidades de negócio e conecta a execução da estratégia à inovação.
Alinha objetivos organizacionais e individuais, bem como métricas e recompensas, com a inovação.', 'Leads development of a culture that encourages innovation, risk-taking and collaboration.
Embeds innovation processes throughout business units and links strategy execution with innovation.
Aligns organisational and individual objectives, measures and rewards with innovation.'),
(10366, 4, 'Desenvolve e documenta avaliações de investimentos para uma variedade de projetos.
Identifica técnicas de avaliação adequadas com base nas características de um projeto.
Coleta as informações necessárias para criar uma avaliação de investimento em colaboração com partes interessadas internas e externas. Apresenta os resultados das avaliações de investimento às partes interessadas selecionadas.
Aperfeiçoa e mantém as avaliações de investimento.', 'Develops and documents investment appraisals for a range of different projects.
Identifies suitable appraisal techniques based on the characteristics of a project.
Collects the information required to create an investment appraisal in collaboration with internal and external stakeholders. Presents findings of investment appraisals to selected stakeholders.
Refines and maintains investment appraisals.'),
(10366, 5, 'Aconselha sobre abordagens de avaliação de investimentos e adapta os padrões organizacionais ao contexto de portfólios/programas.
Conduz a atividade de avaliação de investimentos para portfólios e programas simples e projetos complexos.', 'Advises on investment appraisal approaches and tailors organisational standards to the context of portfolios/programmes.
Leads investment appraisal activities for simple portfolios and programmes and complex projects.'),
(10366, 6, 'Desenvolve políticas, normas e diretrizes organizacionais para a avaliação de investimentos.
Lidera atividades para estabelecer avaliações consistentes entre os projetos e programas componentes de um portfólio.
Revisa avaliações de investimento para iniciativas de alto valor, assegurando sua qualidade.
Conduz atividades de avaliação de investimentos para programas de trabalho e portfólios complexos.', 'Develops organisational policies, standards and guidelines for investment appraisals.
Leads activities to establish consistent appraisal across the component projects and programmes within a portfolio.
Reviews investment appraisals for high-value initiatives to assure their quality.
Leads investment appraisal activities for complex programmes of work and portfolios.'),
(15263, 3, 'Coleta de dados sobre funções de trabalho e responsabilidades de várias fontes.
Ajuda a mapear tarefas e competências usando quadros baseados em habilidades estabelecidos. Contribui para a criação de descrições preliminares de trabalho e métricas de desempenho.
Trabalha sob orientação para alinhar funções de trabalho com estratégias organizacionais, práticas de trabalho e requisitos em evolução.
Fornece apoio na avaliação de mudanças de trabalho e seu impacto nos fluxos de trabalho e satisfação dos funcionários. Participa no processo de revisão da documentação de trabalho para refletir definições de funções e responsabilidades atualizadas.', 'Gathers data regarding job roles and responsibilities from various sources.
Assists in mapping tasks and competencies using established skills-based frameworks. Contributes to the creation of preliminary job descriptions and performance metrics.
Works under direction to align job roles with organisational strategies, workplace practices and evolving requirements.
Provides support in the assessment of job changes and their impact on workflows and employee satisfaction. Participates in the process of revising job documentation to reflect updated role definitions and responsibilities.'),
(15263, 4, 'Realiza análises de trabalho detalhadas, dividindo funções usando insights orientados por dados.
Cria ou revisa descrições de trabalho, levando em consideração as habilidades, competências e cultura organizacional necessárias.
Avalia o impacto das mudanças de funções nos fluxos de trabalho, envolvimento dos funcionários e práticas globais no local de trabalho.
Fornece insights para alinhar funções de trabalho com necessidades organizacionais emergentes, incluindo integração de tecnologia e estratégias adaptativas. Colabora com as partes interessadas para garantir que os projetos de funções sejam eficazes, respondam às necessidades de negócios em mudança e estejam alinhados com abordagens baseadas em habilidades.', 'Performs detailed job analyses, breaking down roles using data-driven insights.
Creates or revises job descriptions with consideration of required skills, competencies and organisational culture.
Evaluates the impact of job role changes on workflows, employee engagement and overall workplace practices.
Provides insights into aligning job roles with emerging organisational needs, including technology integration and adaptive strategies. Collaborates with stakeholders to ensure job designs are effective, responsive to changing business needs and aligned with skills-based approaches.'),
(15263, 5, 'Lidera a arquitetura de trabalho e as iniciativas de design, garantindo o alinhamento com as estratégias organizacionais e as práticas em evolução no local de trabalho.
Desenvolve definições abrangentes de funções que abrangem as habilidades, competências necessárias e o alinhamento com a cultura e os objetivos da organização.
Avalia e sugere modificações de funções existentes para melhorar a eficácia e enfrentar novos desafios.
Fornece aconselhamento autorizado sobre a adaptação da arquitetura de trabalho e do design de funções para refletir mudanças na estratégia organizacional, tecnologia, práticas no local de trabalho e abordagens baseadas em habilidades.', 'Leads job architecture and design initiatives, ensuring alignment with organisational strategies and evolving workplace practices.
Develops comprehensive role definitions that encompass necessary skills, competencies and alignment with the organisation''s culture and goals.
Assesses and suggests modifications to existing roles to improve effectiveness and address new challenges.
Provides authoritative advice on the adaptation of job architecture and job design to reflect changes in organisational strategy, technology, workplace practices and skills-based approaches.'),
(7369, 2, 'Mantém um banco de dados de gerenciamento de conhecimento.
Aproveita o conhecimento de uma especialidade para capturar e classificar o conteúdo, recebendo aconselhamento de especialistas quando necessário.', 'Maintains a knowledge management database.
Leverages knowledge of a specialism to capture and classify content, taking expert advice when required.'),
(7369, 3, 'Mantém sistemas de gerenciamento de conhecimento e conteúdo para atender às necessidades de negócios.
Oferece suporte a terceiros para capacitá-los a completar as atividades de gestão do conhecimento e formar hábitos de gestão do conhecimento. Apoia mudanças nas práticas de trabalho para permitir a captura e o uso do conhecimento.
Emite relatórios sobre o progresso das atividades de gestão do conhecimento.
Configura e desenvolve sistemas e normas de gestão do conhecimento.', 'Maintains knowledge management systems and content to meet business needs.
Supports others to enable them to complete knowledge management activities and form knowledge management habits. Supports changes to work practices to enable capture and use of knowledge.
Reports on the progress of knowledge management activities.
Configures and develops knowledge management systems and standards.'),
(7369, 4, 'Organiza ativos de conhecimento e supervisiona o ciclo de vida de identificação, captura, classificação, armazenamento e manutenção de ativos.
Facilita o compartilhamento, a colaboração e a comunicação do conhecimento. Implementa iniciativas específicas de gerenciamento de conhecimento.
Monitora o uso e o impacto do conhecimento.
Pesquisa o conteúdo de conhecimento existente para identificar problemas, riscos e oportunidades.', 'Organises knowledge assets and oversees the lifecycle of identifying, capturing, classifying, storing and maintaining assets.
Facilitates sharing, collaboration and communication of knowledge. Implements specific knowledge management initiatives.
Monitors the use and impact of knowledge.
Interrogates existing knowledge content to identify issues, risks and opportunities.'),
(7369, 5, 'Desenvolve e implementa processos, práticas e comportamentos de gestão do conhecimento.
Fornece aconselhamento, orientação e suporte para ajudar as pessoas a adotar e incorporar a gestão do conhecimento. Contribui para a definição de políticas, normas e diretrizes para a gestão do conhecimento.
Avalia e seleciona métodos e ferramentas de gestão do conhecimento. Promove tecnologias, processos e comportamentos colaborativos para facilitar o compartilhamento de ideias e conhecimento do trabalho.
Compartilha ideias e exemplos de práticas existentes. Implementa a gestão do conhecimento em nível de programa, projeto e equipe.', 'Develops and implements knowledge management processes, practices and behaviours.
Provides advice, guidance and support to help people to adopt and embed knowledge management. Contributes to the definition of policies, standards and guidelines for knowledge management.
Evaluates and selects knowledge management methods and tools. Promotes collaborative technologies, processes and behaviours to facilitate sharing of ideas and work-knowledge.
Shares ideas and examples of existing practices. Implements knowledge management at programme, project and team level.'),
(7369, 6, 'Desenvolve políticas organizacionais, normas e diretrizes para a gestão do conhecimento.
Defende e orienta o desenvolvimento de uma abordagem de gestão do conhecimento organizacional. Compartilha diferentes abordagens para compartilhamento de conhecimento entre comunidades de prática, unidades de negócios e redes.
Promove o compartilhamento de conhecimento por meio de processos e sistemas operacionais de negócios. Monitora e avalia iniciativas de compartilhamento de conhecimento.
Gerencia revisões dos benefícios e do valor da gestão do conhecimento. Identifica e recomenda melhorias.', 'Develops organisational policies, standards and guidelines for knowledge management.
Champions and leads in the development of an organisational knowledge management approach. Shares different approaches for knowledge sharing across communities of practice, business units and networks.
Promotes knowledge-sharing through operational business processes and systems. Monitors and evaluates knowledge-sharing initiatives.
Manages reviews of the benefits and value of knowledge management. Identifies and recommends improvements.'),
(7369, 7, 'Desenvolve uma estratégia de gestão do conhecimento em toda a organização e lidera a criação de uma cultura de gestão do conhecimento.
Incorpora a gestão do conhecimento em todas as unidades de negócios e desenvolve recursos estratégicos de gestão do conhecimento.
Reforça a importância do compartilhamento de conhecimento, alinhando objetivos e recompensas individuais e organizacionais.
Identifica oportunidades para relacionamentos estratégicos ou parcerias com clientes, fornecedores e parceiros.', 'Develops an organisation-wide knowledge management strategy and leads the creation of a knowledge management culture.
Embeds knowledge management across business units and develops strategic knowledge management capabilities.
Reinforces the importance of knowledge sharing by aligning individual and organisational objectives and rewards.
Identifies opportunities for strategic relationships or partnerships with customers, suppliers and partners.'),
(15264, 2, 'Apoia atividades de treinamento e desenvolvimento sob supervisão rotineira.
Ajuda a manter registros de treinamento e documentar atividades de treinamento e desenvolvimento.
Ajuda a organizar eventos de aprendizagem e acompanhar a participação.', 'Supports learning and development activities under routine supervision.
Assists in maintaining training records and documenting learning and development activities.
Helps organise learning events and track attendance.'),
(15264, 3, 'Contribui para a manutenção de registros de treinamento e o catálogo de recursos de treinamento e desenvolvimento.
Apoia a organização de eventos de aprendizagem, ajudando a coordenar a logística, horários e comunicação com os participantes.
Apoia a coleta e organização de dados sobre atividades de treinamento e desenvolvimento para ajudar a avaliar sua eficácia.', 'Contributes to the maintenance of training records and the catalogue of learning and development resources.
Supports the organisation of learning events by helping to coordinate logistics, schedules, and communication with attendees.
Supports the collection and organisation of data on learning and development activities to assist in evaluating their effectiveness.'),
(15264, 4, 'Contribui para o desenvolvimento e manutenção de um catálogo de recursos de treinamento e desenvolvimento.
Utiliza dados para analisar e avaliar a eficácia das atividades de aprendizagem / educação.
Agenda e organiza eventos de ensino.
Atualiza e controla registros de treinamento, incluindo obtenção de certificados e acreditações.', 'Contributes to the development and maintenance of a catalogue of learning and development resources.
Uses data to analyse and evaluate the effectiveness of learning/educational activities.
Books and organises learning events.
Updates and controls training records, including attainment of certificates and accreditations.'),
(15264, 5, 'Gerencia a oferta de treinamento e desenvolvimento, garantindo o uso ideal dos recursos.
Mantém, divulga e promove catálogo de atividades de treinamento e desenvolvimento. Garante que os cursos estejam atualizados e acreditados (quando necessário).
Organiza instalações e horários com provedores de treinamento e desenvolvimento, conforme pré-estabelecido.
Utiliza dados para avaliar e melhorar a eficácia da aprendizagem ou das atividades educacionais.', 'Manages the provision of learning and development, ensuring optimum use of resources.
Maintains, publicises and promotes a catalogue of learning and development activities. Ensures courses are up to date and accredited (when required).
Arranges facilities and schedules with learning and development providers as appropriate.
Uses data to assess and improve the effectiveness of learning or educational activities.'),
(15264, 6, 'Determina o programa de treinamento e desenvolvimento e os mecanismos de entrega necessários para ampliar as habilidades da equipe, de acordo com as necessidades do negócio.
Identifica os caminhos apropriados de acreditação e qualificação, aplicáveis a indivíduos dentro da organização.
Avalia os resultados da aprendizagem.
Gerencia o desenvolvimento e a oferta de toda a aprendizagem, levando em consideração os objetivos estratégicos da organização.', 'Determines the learning and development programme and delivery mechanisms needed to grow staff skills in line with business needs.
Identifies appropriate accreditation and qualification paths applicable to individuals within the organisation.
Evaluates learning outcomes.
Manages the development and provision of all learning, taking account of the strategic aims of the employing organisation.'),
(15264, 7, 'Dirige o desenvolvimento e a implementação de uma estratégia de treinamento e desenvolvimento para a organização, alinhada às necessidades do negócio.
Conduz o fornecimento de experiência em treinamento e desenvolvimento, orientação e sistemas necessários para executar planos estratégicos e operacionais.
Garante recursos organizacionais para executar a estratégia de treinamento e desenvolvimento.
Identifica oportunidades de relacionamento estratégico com fornecedores e parceiros.', 'Directs the development and implementation of a learning and development strategy for the organisation aligned to business needs.
Leads the provision of learning and development expertise, guidance and systems needed to execute strategic and operational plans.
Secures organisational resources to execute the learning and development strategy.
Identifies opportunities for strategic relationships with suppliers and partners.'),
(15265, 2, 'Realiza uma série de atividades de aprendizagem sob direção, para apoiar a entrega dos objetivos de ensino.
Auxilia na preparação de ambientes de aprendizagem.
Observa os alunos realizando atividades práticas e de trabalho, fornecendo assistência em dúvidas de rotina e escalando quando necessário.', 'Performs a range of learning activities under direction to support the delivery of learning objectives.
Assists in the preparation of learning environments.
Observes learners performing practical activities and work, providing assistance with routine enquiries and escalating where needed.'),
(15265, 3, 'Entrega atividades de ensino a vários públicos usando materiais alinhados com objetivos de aprendizagem estabelecidos.
Segue diretrizes estabelecidas para preparar o ambiente de aprendizagem. Auxilia no desenvolvimento e manutenção de exemplos e estudos de caso relevantes.
Utiliza uma série de técnicas de entrega para desenvolver habilidades e conhecimentos dos alunos.
Observa os alunos realizando atividades práticas e trabalho. Presta aconselhamento e assistência quando necessário. Fornece instruções detalhadas quando necessário e esclarece dúvidas, buscando aconselhamento em condições excepcionais além da própria experiência.', 'Delivers learning activities to various audiences using prepared materials aligned with established learning objectives.
Follows established guidelines to prepare the learning environment. Assists in developing and maintaining relevant examples and case studies.
Uses a range of delivery techniques to develop learner skills and knowledge.
Observes learners performing practical activities and work. Advises and assists where necessary. Provides detailed instruction where necessary and responds to questions, seeking advice in exceptional conditions beyond own experience.'),
(15265, 4, 'Prepara e fornece atividades de aprendizagem adaptadas a diferentes públicos e objetivos de ensino específicos.
Contribui para o planejamento e seleção de ambientes apropriados. Utiliza uma ampla gama de técnicas de entrega de ensino para desenvolver habilidades e conhecimentos do aluno. Desenvolve e atualiza exemplos e materiais de estudo de caso.
Observa e avalia o desempenho dos alunos, oferece orientação e instrução personalizada.
Ajusta abordagens e materiais de entrega para melhorar a experiência do aluno, responder a perguntas especializadas e garantir o cumprimento de metas.', 'Prepares and delivers learning activities tailored to various audiences and specific learning objectives.
Contributes to the design and selection of appropriate environments. Uses a broad range of learning delivery techniques to build learner skills and knowledge. Develops and updates examples and case study materials.
Observes and evaluates learner performance, offering guidance and tailored instruction.
Adjusts delivery approaches and materials to enhance learner experience, responding to specialised queries and ensuring objectives are met.'),
(15265, 5, 'Gerencia a oferta de programas de ensino para garantir que os objetivos de aprendizagem sejam alcançados.
Planeja e programa a entrega de atividades de aprendizagem. Orienta o planejamento e a seleção de ambientes apropriados para apoiar e aprimorar a experiência de aprendizagem. Personaliza as atividades de aprendizagem incorporando cenários relevantes e estudos de caso.
Oferece atividades de aprendizagem para públicos especializados que exigem a aplicação de princípios técnicos e profissionais avançados a situações imprevisíveis. Avalia e monitora o desempenho das atividades de oferta de ensino.
Oferece aconselhamento sobre as técnicas e opções de entrega de ensino.', 'Manages the delivery of programmes of learning to ensure learning objectives are met.
Plans and schedules the delivery of learning activities. Leads the design and selection of appropriate environments to support and enhance the learning experience. Customises learning activities incorporating relevant scenarios and case studies.
Delivers learning activities to specialist audiences requiring the application of advanced technical and professional principles to unpredictable situations. Advises others in learning delivery techniques and options.
Evaluates and monitors the performance of learning delivery activities.'),
(15266, 2, 'Auxilia em tarefas de design e desenvolvimento de aprendizagem sob supervisão rotineira.
Apoia a criação e manutenção de materiais e recursos de aprendizagem.
Ajuda a documentar e organizar conteúdos e ambientes de aprendizagem.', 'Assists with learning design and development tasks under routine supervision.
Supports the creation and maintenance of learning materials and resources.
Helps document and organise learning content and environments.'),
(15266, 3, 'Projeta, cria, desenvolve, personaliza e mantém materiais e recursos de aprendizagem para entregar os resultados acordados e atender aos requisitos de acreditação conforme apropriado.
Contribui para o planejamento, configuração e teste de ambientes de aprendizagem.', 'Designs, creates, customises and maintains learning materials and resources to deliver agreed outcomes, and meet accreditation requirements when appropriate.
Contributes to the design, configuration and testing of learning environments.'),
(15266, 4, 'Especifica o conteúdo e a estrutura dos materiais de treinamento e desenvolvimento.
Assume a responsabilidade pelo planejamento, criação, empacotamento e manutenção. Gerencia o desenvolvimento para entrega dos resultados acordados.
Sempre que necessário, projeta, configura e testa ambientes de aprendizagem.
Garante acreditações externas, conforme apropriado.', 'Specifies the content and structure of learning and development materials.
Takes responsibility for design, creation, packaging and maintenance. Manages development to deliver agreed outcomes.
Where required, designs, configures and tests learning environments.
Secures external accreditations as appropriate.'),
(15266, 5, 'Especifica soluções para uso em programas de treinamento e desenvolvimento corporativo ou em educação fundamental, complementar ou superior.
Comissiona o desenvolvimento de materiais de aprendizagem, aloca recursos para equipes e define os resultados de aprendizagem.
Lidera programas de aprendizagem, recomenda e especifica ações para planejamento, desenvolvimento e implantação de acordo com os resultados esperados.', 'Specifies solutions for use in learning and development programmes in the workplace or in compulsory, further or higher education.
Commissions the development of learning materials, allocates resources to learning teams and defines learning outcomes.
Leads learning programmes, recommends and specifies learning interventions for design, development and deployment according to agreed learning outcomes.'),
(3186, 2, 'Auxilia na preparação de dados, treinamento de modelos e tarefas de avaliação sob supervisão de rotina.
Utiliza frameworks e ferramentas padrão de machine learning para desenvolver modelos básicos para problemas bem definidos.
Documenta resultados e contribuir para a manutenção de soluções de machine learning.', 'Assists in data preparation, model training and evaluation tasks under routine supervision.
Uses standard machine learning frameworks and tools to develop basic models for well-defined problems.
Documents results and contributes to maintaining machine learning solutions.'),
(3186, 3, 'Aplica técnicas e algoritmos de aprendizado de máquina estabelecidos para resolver problemas de negócios.
Seleciona e prepara dados para treinamento e avaliação de modelos.
Treina, otimiza e valida modelos de aprendizado de máquina usando ferramentas e frameworks padrão.
Implementa modelos em produção e monitora seu desempenho. Comunica os resultados e as limitações para as partes interessadas.', 'Applies established machine learning techniques and algorithms to solve business problems.
Selects and prepares data for model training and evaluation.
Trains, optimises and validates machine learning models using standard tools and frameworks.
Deploys models into production and monitors their performance. Communicates results and limitations to stakeholders.'),
(3186, 4, 'Avalia a adequação do machine learning e projetos e desenvolve soluções para uma gama de problemas de negócios.
Seleciona e aplica técnicas e algoritmos apropriados com base em características de dados e requisitos de negócios. Fornece orientação para outras pessoas.
Engenheiros caracterizam e otimizam o desempenho do modelo. Implementa algoritmos e contribui para o desenvolvimento, avaliação, monitoramento e implantação. Aplica regras e diretrizes específicas para a indústria, antecipando riscos e implicações.
Colabora com equipes interfuncionais para integrar modelos de machine learning em sistemas de produção. Conduz análises de desempenho detalhadas e soluciona problemas.', 'Assesses the suitability of machine learning and designs and develops solutions for a range of business problems.
Selects and applies appropriate techniques and algorithms based on data characteristics and business requirements. Provides guidance to others.
Engineers features and optimises model performance. Implements algorithms and contributes to development, evaluation, monitoring and deployment. Applies industry-specific rules and guidelines, anticipating risks and implications.
Collaborates with cross-functional teams to integrate machine learning models into production systems. Conducts in-depth performance analysis and troubleshoots issues.'),
(3186, 5, 'Conduz para o desenvolvimento e implementação de soluções de aprendizado de máquina para problemas de negócios complexos e de alto impacto.
Arquiteta pipelines e sistemas de aprendizado de máquina de ponta a ponta, incorporando práticas de MLOps. Avalia e seleciona ferramentas, frameworks e infraestrutura para projetos de aprendizado de máquina.
Estabelece práticas e padrões para desenvolvimento e operações de aprendizado de máquina. Fornece aconselhamento e orientação especializados sobre técnicas e aplicações de aprendizado de máquina.
Colabora com as partes interessadas para alinhar iniciativas de aprendizado de máquina com objetivos organizacionais.', 'Leads the development and implementation of machine learning solutions for complex, high-impact business problems.
Architects end-to-end machine learning pipelines and systems, incorporating MLOps practices. Evaluates and selects tools, frameworks and infrastructure for machine learning projects.
Establishes practices and standards for machine learning development and operations. Provides expert advice and guidance on machine learning techniques and applications.
Collaborates with stakeholders to align machine learning initiatives with organisational goals.'),
(3186, 6, 'Define direção estratégica e o roteiro para a adoção e inovação do aprendizado de máquina dentro da organização.
Estabelece quadros de governança e protocolos recomendados para o desenvolvimento e uso responsável, ético e sustentável do aprendizado de máquina.
Conduz para o desenvolvimento de capacidades, políticas, normas e diretrizes organizacionais no aprendizado de máquina.
Colabora com as partes interessadas seniores para identificar oportunidades de alto impacto no aprendizado de máquina e impulsiona a sua implementação. Segue as tendências da pesquisa e da indústria e as integra nas práticas organizacionais.', 'Sets the strategic direction and roadmap for machine learning adoption and innovation within the organisation.
Establishes governance frameworks and recommended protocols for responsible, ethical and sustainable development and use of machine learning.
Leads the development of organisational capabilities, policies, standards and guidelines in machine learning.
Collaborates with senior stakeholders to identify high-impact opportunities for machine learning and drives their implementation. Follows research and industry trends and integrates them into organisational practices.'),
(7440, 3, 'Auxilia na concepção e execução de estudos de pesquisa de mercado.
Recolhe e analisa dados usando métodos e ferramentas padrão.
Contribui para a preparação de relatórios de pesquisa e apresentações.', 'Assists in the design and execution of market research studies.
Collects and analyses data using standard methods and tools.
Contributes to the preparation of research reports and presentations.'),
(7440, 4, 'Projeta e conduz estudos de pesquisa de mercado de forma independente.
Analisa dados de mercado para identificar tendências, oportunidades e desafios.
Segmenta mercados e identifica clientes-alvo com base nos resultados das pesquisas.
Prepara relatórios de pesquisa e apresentações para comunicar descobertas e recomendações.', 'Designs and conducts market research studies independently.
Analyses market data to identify trends, opportunities and challenges.
Segments markets and identifies target customers based on research findings.
Prepares research reports and presentations to communicate findings and recommendations.'),
(7440, 5, 'Lidera o design e execução de estudos de mercado complexos.
Analisa e sintetiza dados de mercado de várias fontes para gerar insights e recomendações.
Apresenta resultados de pesquisa e recomendações estratégicas para as partes interessadas. Assessora as partes interessadas sobre as implicações de resultados de pesquisa para a estratégia de negócios e tomada de decisões.
Contribui para o desenvolvimento de métodos e padrões de pesquisa de mercado organizacionais.', 'Leads the design and execution of complex market research studies.
Analyses and synthesises market data from multiple sources to generate insights and recommendations.
Presents research findings and strategic recommendations to stakeholders. Advises stakeholders on the implications of research findings for business strategy and decision-making.
Contributes to the development of organisational market research methods and standards.'),
(7440, 6, 'Define a direção e a estratégia geral para as pesquisas de mercado na organização.
Desenvolve políticas organizacionais, padrões e diretrizes para pesquisas de mercado. Assegura que as capacidades e recursos de pesquisa de mercado estejam alinhados com as necessidades e objetivos de negócios.
Comunica insights de alto nível sobre o mercado e implicações estratégicas para a liderança sênior e as partes interessadas.
Colabora com parceiros internos e externos para influenciar a estratégia organizacional e impulsionar a utilização eficaz da pesquisa de mercado na tomada de decisões e desenvolvimento de estratégia.', 'Sets the overall direction and strategy for market research in the organisation.
Develops organisational policies, standards and guidelines for market research. Ensures market research capabilities and resources are aligned with business needs and objectives.
Communicates high-level market insights and strategic implications to senior leadership and stakeholders.
Collaborates with internal and external partners to influence organisational strategy and drive the effective use of market research in decision-making and strategy development.'),
(15267, 3, 'Auxilia na execução de campanhas de marketing.
Utiliza ferramentas e canais selecionados para envolver o público-alvo.
Monitora o desempenho de campanhas e coleta dados para análise.
Participa em eventos e iniciativas de marketing.', 'Assists in the execution of marketing campaigns.
Uses selected tools and channels to engage target audiences.
Monitors campaign performance and collects data for analysis.
Participates in marketing events and initiatives.'),
(15267, 4, 'Planeja e executa campanhas de marketing em vários canais.
Seleciona ferramentas e plataformas apropriadas para atingir o público desejado.
Cria e distribui conteúdo e materiais de marketing envolventes. Escreve briefings de campanhas e contribui para avaliações criativas.
Analisa o desempenho de campanhas e emite recomendações para otimização.', 'Plans and executes marketing campaigns across multiple channels.
Selects appropriate tools and platforms to reach desired audiences.
Creates and distributes engaging marketing content and materials. Writes campaign briefs and contributes to creative evaluation.
Analyses campaign performance and makes recommendations for optimisation.'),
(15267, 5, 'Desenvolve e supervisiona estratégias complexas de campanhas de marketing multicanais.
Seleciona os canais, ferramentas e parceiros criativos ideais. Lidera briefings criativos e avalia conceitos.
Gerencia as partes interessadas e assegura a consistência da marca.
Monitora o desempenho de campanhas e ajusta táticas conforme necessário. Analisa os resultados de campanhas e reporta as principais métricas e resultados.', 'Develops and oversees complex, multi-channel marketing campaign strategies.
Selects optimal channels, tools and creative partners. Leads creative briefings and evaluates concepts.
Manages stakeholders and ensures brand consistency.
Monitors campaign performance and adjusts tactics as needed. Analyses campaign results and reports on key metrics and outcomes.'),
(5029, 4, 'Contribui para o desenvolvimento e execução de planos de marketing.
Aplica boas práticas reconhecidas para analisar a eficácia de marketing e retorno sobre o investimento (ROI).
Auxilia na definição de clientes-alvo e posicionamento de marca.
Implementa soluções para desafios de marketing dentro de diretrizes estabelecidas. Colabora com membros da equipe para executar atividades de marketing.', 'Contributes to the development and execution of marketing plans.
Applies recognised good practices to analyse marketing effectiveness and ROI.
Assists in defining target customers and brand positioning.
Implements solutions to marketing challenges within established guidelines. Collaborates with team members to execute marketing activities.'),
(5029, 5, 'Desenvolve e gerencia planos de marketing abrangentes alinhados com objetivos de negócio.
Implementa estratégias para maximizar a eficácia de marketing com base em objetivos organizacionais. Lidera a definição de clientes-alvo e posicionamento de marca.
Analisa dados complexos para informar decisões de marketing. Cria soluções inovadoras para desafios de marketing.
Coordena-se com outras equipes para executar abordagens de marketing integradas.', 'Develops and manages comprehensive marketing plans aligned with business objectives.
Implements strategies to maximise marketing effectiveness given organisational goals. Leads the definition of target customers and brand positioning.
Analyses complex data to inform marketing decisions. Creates innovative solutions to marketing challenges.
Coordinates with other teams to execute integrated marketing approaches.'),
(5029, 6, 'Define e supervisiona a execução de estratégias de marketing para alcançar objetivos organizacionais.
Assegura o alinhamento dos planos de marketing com objetivos de negócios e insights de mercado. Avalia e otimiza a eficácia de marketing e a alocação de orçamento para impulsionar os resultados.
Identifica e aborda necessidades de capacidade de marketing atuais e futuras.
Colabora com a liderança sênior para integrar estratégias de marketing com visão organizacional.', 'Defines and oversees the execution of marketing strategies to achieve organisational goals.
Ensures alignment of marketing plans with business objectives and market insights. Evaluates and optimises marketing effectiveness and budget allocation to drive outcomes.
Identifies and addresses current and future marketing capability needs.
Collaborates with senior leadership to integrate marketing strategies with organisational vision.'),
(5029, 7, 'Lidera a criação de estratégias de marketing de longo prazo alinhadas com a visão organizacional.
Dirige a função de marketing, garantindo a integração dos planos de marketing com os objetivos de negócio. Supervisiona a avaliação e otimização das atividades de marketing, garantindo o máximo impacto e eficiência.
Fornece aconselhamento estratégico para a liderança sênior sobre tendências e oportunidades de marketing.
Promove uma cultura de criatividade e melhoria contínua dentro da equipe de marketing. Assegura que a função de marketing se adapte às mudanças das condições de mercado e às necessidades de negócios.', 'Leads the creation of long-term marketing strategies aligned with organisational vision.
Directs the marketing function, ensuring integration of marketing plans with business goals. Oversees the evaluation and optimisation of marketing activities, ensuring maximum impact and efficiency.
Provides strategic advice to senior leadership on marketing trends and opportunities.
Promotes a culture of creativity and continuous improvement within the marketing team. Ensures the marketing function adapts to changing market conditions and business needs.'),
(15268, 2, 'Ajuda na coleta e manutenção de dados para fins de medição sob supervisão rotineira.
Utiliza procedimentos padrão para medir atributos de processos, produtos e serviços.
Ajuda a gerar e distribuir relatórios de medição.', 'Assists in the collection and maintenance of data for measurement purposes under routine supervision.
Uses standard procedures for measuring attributes of processes, products and services.
Helps generate and distribute measurement reports.'),
(15268, 3, 'Aplica técnicas padrão para apoiar a especificação de medidas e a coleta e manutenção de dados para medição.
Gera, produz e distribui relatórios.
Utiliza ferramentas de medição para análise de rotina de dados.
Identifica e implementa melhorias nos métodos de coleta de dados.', 'Applies standard techniques to support the specification of measures and the collection and maintenance of data for measurement.
Generates, produces and distributes reports.
Uses measurement tools for routine analysis of data.
Identifies and implements improvements to data collection methods.'),
(15268, 4, 'Identifica e prioriza medidas, escalas e metas apropriadas.
Apoia projetos, funções ou equipes no desenvolvimento de métodos de medição.
Especifica medidas básicas e derivadas que suportem as necessidades de informação acordadas. Especifica como coletar e armazenar os dados para cada medida necessária. Fornece orientação sobre a coleta de dados.
Elabora relatórios e formatos de relatórios.', 'Identifies and prioritises appropriate measures, scales and targets.
Supports projects, functions or teams in the development of measurement methods.
Specifies base and derived measures which support agreed information needs. Specifies how to collect and store the data for each required measure. Provides guidance on collection of data.
Designs reports and reporting formats.'),
(15268, 5, 'Estabelece objetivos de medição e o escopo de medição para funções, equipes e projetos.
Planeja e implementa melhorias nas capacidades de medição. Oferece aconselhamento e orientações para o uso eficaz de medidas e medições.
Seleciona medidas adequadas ao contexto e aos objetivos organizacionais. Revisa os mecanismos de coleta e armazenamento de dados para dar suporte a medições.
Contribui nas políticas organizacionais, normas e diretrizes para medição.', 'Establishes measurement objectives and the scope of measurement for functions, teams and projects.
Plans and implements improvements to measurement capability. Provides advice and guidance for effective use of measures and measurement.
Selects measures appropriate to the context and organisational objectives. Reviews data collection and storage mechanisms to support measurement.
Contributes to organisational policies, standards and guidelines for measurement.'),
(15268, 6, 'Lidera o desenvolvimento de capacidades organizacionais para medição (incluindo automação).
Cria a estrutura de medição e alinha os objetivos de medição com os objetivos de negócios.
Desenvolve políticas organizacionais, padrões, diretrizes para medição.
Fornece recursos para garantir a adoção e adesão a políticas e padrões.', 'Leads the development of organisational capabilities for measurement (including automation).
Creates the measurement framework and aligns measurement objectives with business objectives.
Develops organisational policies, standards and guidelines for measurement.
Provides resources to ensure adoption and adherence to policies and standards.'),
(15269, 2, 'Fornecer suporte de rotina usando diretrizes acordadas sobre o uso de métodos e ferramentas bem estabelecidas.
Auxilia na configuração e manutenção de métodos e ferramentas sob supervisão rotineira.
Apoia a criação e atualização de documentação relacionada a métodos e ferramentas.', 'Provide routine support using agreed guidelines on the use of well-established methods and tools.
Assists in configuring and maintaining methods and tools under routine supervision.
Supports the creation and updating of documentation related to methods and tools.'),
(15269, 3, 'Fornece suporte ao uso de métodos e ferramentas existentes.
Configura e mantém métodos e ferramentas dentro de um contexto conhecido.
Cria e atualiza a documentação de métodos e ferramentas.
Identifica e resolve problemas básicos relacionados ao uso de ferramentas.', 'Provides support on the use of existing methods and tools.
Configures and maintains methods and tools within a known context.
Creates and updates the documentation of methods and tools.
Identifies and resolves basic issues related to tool usage.'),
(15269, 4, 'Interage com as partes interessadas para entender os requisitos e recomenda soluções apropriadas.
Fornece conselhos e orientações para apoiar a adoção de métodos e ferramentas e a adesão às políticas e normas.
Adapta processos para atender a necessidades específicas, assegurando que estejam alinhados com as normas estabelecidas e sejam informados por avaliações de métodos e ferramentas.
Revisa e melhora o uso e aplicação de métodos e ferramentas.', 'Engages with stakeholders to understand requirements and recommends appropriate solutions.
Provides advice and guidance to support the adoption of methods and tools and adherence to policies and standards.
Tailors processes to meet specific needs while ensuring they align with established standards and are informed by evaluations of methods and tools.
Reviews and improves usage and application of methods and tools.'),
(15269, 5, 'Oferece orientação e liderança especializadas para promover a adoção de métodos e ferramentas e o cumprimento de políticas e padrões.
Avalia e seleciona métodos e ferramentas apropriados de acordo com as políticas e padrões acordados. Contribui para políticas, padrões e diretrizes organizacionais para métodos e ferramentas.
Implementa métodos e ferramentas nos níveis de programa, projeto e equipe, incluindo a seleção e adaptação conforme os padrões estabelecidos.
Gerencia revisões dos benefícios e do valor dos métodos e ferramentas. Identifica e recomenda melhorias que apoiem os objetivos mais amplos da organização.', 'Provides authoritative advice and leadership to promote adoption of methods and tools and adherence to policies and standards.
Evaluates and selects appropriate methods and tools in line with agreed policies and standards. Contributes to organisational policies, standards and guidelines for methods and tools.
Implements methods and tools at programme, project and team levels including selection and tailoring in line with agreed standards.
Manages reviews of the benefits and value of methods and tools. Identifies and recommends improvements that support broader organisational goals.'),
(15269, 6, 'Desenvolve políticas organizacionais, normas e diretrizes para métodos e ferramentas.
Define direção e lidera a introdução e uso de técnicas, metodologias e ferramentas, para atender aos requisitos do negócio.
Lidera o desenvolvimento de capacidades organizacionais em métodos e ferramentas para garantir a adoção consistente e aderência e inovação em métodos e ferramentas.
Garante o compromisso organizacional e os recursos para métodos e ferramentas. Promove a melhoria contínua e a inovação em métodos e ferramentas.', 'Develops organisational policies, standards and guidelines for methods and tools.
Sets direction and leads in the introduction and use of techniques, methodologies and tools, to meet business requirements.
Leads the development of organisational capabilities for methods and tools to ensure consistent adoption and adherence to policies and standards.
Secures organisational commitment and resources to methods and tools. Drives continuous improvement and innovation in methods and tools.'),
(10165, 2, 'Ajuda a definir configurações para redes e componentes de rede sob supervisão de rotina.
Siga as arquiteturas de rede estabelecidas, padrões e protocolos de segurança.
Ajuda a documentar configurações de rede e produzir especificações de rede detalhadas sob orientação, incorporando aspectos de segurança relevantes.', 'Assists with defining configurations for networks and network components under routine supervision.
Follows established network architectures, standards, and security protocols.
Assists in documenting network configurations and producing detailed network specifications under guidance, incorporating relevant security aspects.'),
(10165, 3, 'Especifica as configurações técnicas e os componentes necessários para uma rede de pequeno porte ou um segmento de rede em uma infraestrutura mais complexa.
Segue as arquiteturas e padrões organizacionais.', 'Specifies the technical configurations and components required for a small network or a network segment in a more complex infrastructure.
Follows organisational architectures, standards, and security guidelines.'),
(10165, 4, 'Projeta componentes de rede específicos usando arquiteturas, padrões de projeto, padrões e metodologia pactuados.
Converte designs lógicos em designs físicos que atendem aos parâmetros operacionais especificados de capacidade e desempenho.
Revisa e verifica projetos de rede em relação a requisitos não funcionais, incluindo procedimentos de validação e correção de erros, controles de acesso, segurança e auditoria.
Contribui para o desenvolvimento de rotinas de recuperação e procedimentos de contingência. Contribui para arquiteturas de rede, topologias de rede e opções de design alternativos.', 'Designs specific network components using agreed architectures, design standards, patterns and methodology.
Translates logical designs into physical designs that meet specified operational parameters for capacity and performance.
Reviews and verifies network designs against non-functional requirements, including validation and error correction procedures, access, security and audit controls.
Contributes to the development of recovery routines and contingency procedures. Contributes to alternative network architectures, networking topologies and design options.'),
(10165, 5, 'Produz ou aprova arquiteturas de rede, topologias e bancos de dados de configuração de provedores de rede dentro de sua área de responsabilidade.
Especifica parâmetros de projeto para conectividade de rede, capacidade, velocidade, interface, segurança e acesso, de acordo com os requisitos de negócios.
Avalia riscos relacionados à rede e especifica rotinas de recuperação e procedimentos de contingência.
Cria várias visualizações de design para atender às preocupações das diferentes partes interessadas e para lidar com requisitos funcionais e não funcionais.', 'Produces, or approves network providers'', network architectures, topologies and configuration databases for own area of responsibility.
Specifies design parameters for network connectivity, capacity, speed, interfacing, security and access, in line with business requirements.
Assesses network-related risks and specifies recovery routines and contingency procedures.
Creates multiple design views to address the different stakeholders'' concerns and to handle both functional and non-functional requirements.'),
(10165, 6, 'Assume a responsabilidade pelos principais aspectos da especificação de rede, padrões, tecnologias e modelos de design de rede global dentro da organização.
Produz políticas, princípios e critérios de design de rede que cobrem conectividade, capacidade, interface, segurança, resiliência, recuperação e acesso.
Desenvolve e impulsiona a adoção e adesão de políticas, padrões, diretrizes e métodos organizacionais para design de rede.', 'Takes responsibility for major aspects of network specification, standards, technologies and overall network design models within the organisation.
Produces network design policies, principles and criteria covering connectivity, capacity, interfacing, security, resilience, recovery and access.
Develops and drives adoption of and adherence to organisational policies, standards, guidelines and methods for network design.'),
(15270, 1, 'Suporta tarefas de rede de rotina sob supervisão estreita.
Monitora a saúde básica da rede e reporta o estado dos componentes da rede.
Ajuda com a solução de problemas direta e segue procedimentos estabelecidos para manter a continuidade operacional.
Escala os problemas conforme necessário para níveis de suporte mais elevados', 'Supports routine network tasks under close supervision.
Monitors basic network health and reports on the status of network components.
Assists with straightforward troubleshooting and follows established procedures to maintain operational continuity.
Escalates issues as necessary to higher levels of support'),
(15270, 2, 'Ajuda na configuração operacional de componentes de rede e na investigação e resolução de problemas de rede.
Ajuda na implementação de scripts básicos e ferramentas de automação para simplificar tarefas de suporte de rede.
Ajuda com procedimentos de manutenção especificados e segue padrões de segurança, segurança e qualidade estabelecidos.
Fornece suporte e orientação de primeira linha para usuários de rede, escalando problemas conforme necessário.', 'Assists in the operational configuration of network components and the investigation and resolution of network problems.
Assists in the implementation of basic scripting and automation tools to streamline network support tasks.
Assists with specified maintenance procedures and follows established safety, security and quality standards.
Provides first-line support and guidance to network users, escalating issues as necessary.'),
(15270, 3, 'Executa tarefas de manutenção de rede acordadas e configuração operacional especificada de componentes de rede.
Identifica e diagnostica problemas/erros de rede usando as ferramentas de solução de problemas necessárias e software de gerenciamento de rede, incluindo solução de problemas relacionados à segurança.
Implementa e mantém scripts, ferramentas de automação e plataformas de orquestração para otimizar processos de suporte de rede.
Coleta estatísticas de desempenho e tráfego e colabora com outras pessoas para garantir a eficácia da rede e resolver problemas', 'Executes agreed network maintenance tasks and specified operational configuration of network components.
Identifies and diagnoses network problems/faults using the required troubleshooting tools and network management software, including addressing security-related issues.
Implements and maintains scripts, automation tools and orchestration platforms to optimise network support processes.
Collects performance and traffic statistics and collaborates with others to ensure network effectiveness and resolve issues'),
(15270, 4, 'Aplica conhecimentos técnicos para manter e otimizar a infraestrutura de rede, executar atualizações e empregar ferramentas de automação.
Utiliza ferramentas de gerenciamento de rede para monitorar estatísticas de carga, desempenho e segurança. Investiga e permite a resolução de problemas operacionais e de segurança relacionados à rede. Configura ferramentas e/ou cria scripts para automatizar tarefas de rede.
Mantenha procedimentos operacionais e verifica se eles são seguidos. Fornece relatórios e sugestões para melhorias para as partes interessadas.
Contribui para o planejamento e implementação de manutenção de rede, atualizações e melhorias de segurança. Implementa mudanças e rotinas de manutenção de rede acordadas.', 'Applies technical expertise to maintain and optimise network infrastructure, executing updates and employing automation tools.
Uses network management tools to monitor load, performance, and security statistics. Investigates and enables the resolution of network-related operational and security issues. Configures tools and/or creates scripts to automate network tasks.
Maintains operational procedures and checks that they are followed. Provides reports and proposals for improvement to stakeholders.
Contributes to the planning and implementation of network maintenance, updates, and security enhancements. Implements agreed network changes and maintenance routines.'),
(15270, 5, 'Lidera as operações de rede para otimizar o desempenho.
Supervisiona o planejamento, instalação, manutenção e aceitação de componentes e serviços de rede, alinhando-os com expectativas de serviço, padrões e requisitos de segurança.
Assegura que as solicitações de suporte de rede sejam tratadas de acordo com padrões e procedimentos definidos.
Impulsiona a adoção de ferramentas e processos para uma gestão e entrega operacionais eficazes, garantindo que considerações de segurança sejam atendidas. Mantém procedimentos e documentação. Investiga e resolve problemas complexos de rede. Acompanha problemas operacionais e reporta às partes interessadas.', 'Leads network operations to optimise performance.
Oversees planning, installation, maintenance, and acceptance of network components and services, aligning with service expectations, standards, and security requirements.
Ensures network support requests are handled according to set standards and procedures.
Drives the adoption of tools and processes for effective operational management and delivery, ensuring security considerations are addressed. Maintains procedures and documentation. Investigates and resolves complex network problems. Tracks operational issues and reports to stakeholders.'),
(15271, 1, 'Executa scripts de teste não funcionais sob supervisão, com foco em qualidades e características do sistema, como desempenho.
Configure ambientes de teste básicos e use ferramentas padrão para executar testes prescritos.
Registre resultados e relate problemas.', 'Executes given non-functional test scripts under supervision, focusing on system qualities and characteristics such as performance.
Sets up basic test environments and uses standard tools to execute prescribed tests.
Records results and reports issues.'),
(15271, 2, 'Ajuda a projetar casos de teste não-funcionais e criar scripts de teste.
Suporta a preparação de dados de teste para testes não-funcionais sob supervisão. Configura ambientes de teste. Executa testes não-funcionais manuais e automatizados.
Implementa ferramentas de teste apropriadas com base em requisitos ou especificações não-funcionais dados. Define condições de teste para requisitos não-funcionais dados.
Análises e relatórios sobre atividades de teste, resultados, problemas e riscos.', 'Assists in designing non-functional test cases and creating test scripts.
Supports the preparation of test data for non-functional testing under supervision. Configures test environments. Executes both manual and automated non-functional testing.
Implements appropriate test tools based on given non-functional requirements or specifications. Defines test conditions for given non-functional requirements.
Analyses and reports on test activities, results, issues and risks.'),
(15271, 3, 'Desenha casos e scripts de teste não funcionais, mapeando critérios pré-estabelecidos para qualidades e características do sistema.
Prepara e gerencia dados de teste para refletir cenários do mundo real. Configura ambientes de teste, colabora com as partes interessadas para esclarecer requisitos e automatiza testes repetíveis.
Participa em revisões de requisitos para refinar planos de teste abrangentes. Realiza testes exploratórios para investigar comportamentos incomuns.
Executa testes, resolve problemas à medida que surgem. Análises e relatórios sobre atividades de teste, fornecendo uma cobertura abrangente de atributos não funcionais.', 'Designs non-functional test cases and scripts, mapping to pre-set criteria for system qualities and characteristics.
Prepares and manages test data to reflect real-world scenarios. Configures test environments, collaborates with stakeholders to clarify requirements and automates repeatable tests.
Participates in requirement reviews to refine comprehensive test plans. Undertakes exploratory tests to investigate unusual behaviours.
Executes tests, troubleshooting issues as they arise. Analyses and reports on test activities, providing thorough coverage of non-functional attributes.'),
(15271, 4, 'Seleciona abordagens de testes não funcionais adequadas, considerando a criticidade e a complexidade do sistema.
Desenvolve, automatiza e executa planos de testes para atributos de end-to-end do sistema. Configura e gerencia ambientes de testes complexos, garantindo a alinhamento com as condições de produção.
Aplica estratégias baseadas em risco para priorizar esforços de testes e colabora entre equipes para garantir cobertura de testes automatizada abrangente. Resolve problemas em tempo real, garantindo resolução rápida.
Análise e relatórios sobre atividades de testes, resultados e riscos, incluindo o trabalho de outros.', 'Selects suitable non-functional testing approaches, considering system criticality and complexity.
Develops, automates and executes test plans for end-to-end system attributes. Configures and manages complex, test environments, ensuring alignment with production conditions.
Applies risk-based strategies to prioritise test efforts and collaborates across teams to ensure comprehensive automated test coverage. Troubleshoots issues in real-time, ensuring prompt resolution.
Analyses and reports on test activities, results and risks, including the work of others.'),
(15271, 5, 'Planeja e executa testes não funcionais em todas as fases, garantindo a alinhamento com os requisitos e priorizando estratégias baseadas em risco.
Fornece aconselhamento especializado sobre métodos, ferramentas e frameworks não funcionais. Lidera a configuração e manutenção de ambientes de testes avançados.
Monitora a aplicação de padrões de testes, garantindo que eles reflectam condições do mundo real. Resolve problemas complexos, trabalhando em estreita colaboração com as partes interessadas.
Lida os esforços para melhorar a eficiência e a confiabilidade dos testes não funcionais. Identifica melhorias e contribui para políticas organizacionais, padrões e diretrizes para testes não funcionais.', 'Plans and drives non-functional testing across all stages, ensuring alignment with requirements and prioritising risk-based strategies.
Provides expert advice on non-functional methods, tools and frameworks. Leads the setup and maintenance of advanced test environments.
Monitors the application of testing standards, ensuring they reflect real-world conditions. Troubleshoots and resolves complex issues, working closely with stakeholders.
Leads efforts to improve the efficiency and reliability of non-functional testing. Identifies improvements and contributes to organisational policies, standards and guidelines for non-functional testing.'),
(15271, 6, 'Desenvolve políticas, padrões e diretrizes organizacionais para testes de não funcionais, garantindo que estejam alinhados com a estratégia de negócios e incorporem uma abordagem baseada em risco.
Planeia e dirige atividades de testes estratégicos e complexos, garantindo que estejam alinhadas com os objetivos de qualidade do sistema global. Gerencia riscos e oportunidades, coordenando-se com outros tipos de testes.
Desenvolve capacidades organizacionais para enfrentar desafios complexos de validação de qualidade. Promove a automação contínua e melhorias em ambientes de testes.
Promove uma cultura de qualidade em testes não funcionais, impulsiona a adesão às normas organizacionais e a mitigação proativa de riscos.', 'Develops organisational policies, standards and guidelines for non-functional testing, ensuring they align with business strategy and incorporate a risk-based approach.
Plans and leads strategic, complex testing activities, ensuring they align with overall system quality goals. Manages risks and opportunities, coordinating with other types of testing.
Develops organisational capabilities to address complex quality validation challenges. Drives continuous automation and improvements in test environments.
Promotes a culture of quality in non-functional testing, driving adherence to organisational standards and proactive risk mitigation.'),
(15272, 4, 'Cria algoritmos moderadamente complexos usando uma variedade de técnicas matemáticas e com sensibilidade às limitações das técnicas.
Utiliza ambientes sofisticados de computação e visualização científica.
Avalia a estabilidade, precisão e eficiência dos algoritmos e faz ou recomenda melhorias para eles.
Itera e melhora os modelos, usando entrada e feedback de especialistas, conforme apropriado.', 'Creates moderately complex algorithms using a range of mathematical techniques and with sensitivity to the limitations of the techniques.
Uses sophisticated scientific computing and visualisation environments.
Assesses the stability, accuracy and efficiency of algorithms and makes or recommends improvements to them.
Iterates and improves models using feedback from experts as appropriate.'),
(15272, 5, 'Cria, testa e melhora algoritmos complexos que resolvem numericamente problemas do mundo real.
Desenvolve técnicas matemáticas e computacionais para auxiliar na análise numérica.
Comunica limitações como incertezas e erros sistemáticos.
Analisa algoritmos quanto à sua conformidade com os padrões de design e desempenho.', 'Creates, tests and improves complex algorithms that numerically solve real-world problems.
Develops mathematical and computational techniques to assist with numerical analysis.
Communicates limitations such as uncertainty and systematic errors.
Reviews algorithms for their conformance to design and performance standards.'),
(15272, 6, 'Inicia a criação, teste, melhoria e aplicação de algoritmos numéricos que resolvem problemas matemáticos do mundo real.
Estabelece padrões e estratégias para a aplicação da análise numérica.
Orienta a implementação de recursos de análises numéricas para garantir o uso apropriado, consistente e eficaz em toda a organização.', 'Initiates the creation, testing, improvement and application of numerical algorithms that solve real-world mathematical problems.
Sets standards and strategies for the application of numerical analysis.
Leads the implementation of numerical analyses capabilities to ensure appropriate, consistent and effective usage across the organisation.'),
(15272, 7, 'Dirige a criação e revisão de uma abordagem e cultura multifuncional e corporativa para análise numérica.
Lidera o desenvolvimento dos recursos de análise numérica da organização e defende seu uso na resolução de problemas do mundo real.', 'Directs the creation and review of a cross-functional, enterprise-wide approach and culture for numerical analysis.
Leads the development of the organisation’s numerical analysis capabilities and champions its use in solving real-world problems.'),
(15273, 2, 'Suporta operações cibernéticas ofensivas, sob orientação.
Auxilia na criação de pastas de destino eletrônicas com base na inteligência fornecida.
Participa de tarefas operacionais básicas, seguindo protocolos de segurança estabelecidos.
Auxilia na documentação de operações e resultados, contribuindo para revisões pós-operacionais.', 'Supports offensive cyber operations under supervision.
Assists in creating electronic target folders based on provided intelligence.
Participates in basic operational tasks, following established security protocols.
Assists in documenting operations and outcomes, contributing to post-operation reviews.'),
(15273, 3, 'Realiza tarefas específicas dentro de operações cibernéticas ofensivas, alinhando tarefas operacionais com objetivos mais amplos.
Apoia a criação e manutenção de pastas de alvos eletrônicos, coleta e verificação de informações de alvos.
Auxilia na execução de operações, mantendo a segurança operacional.
Prepara relatórios detalhados e participa na análise pós-operatória.', 'Carries out specific tasks within offensive cyber operations, aligning operational tasks with broader objectives.
Supports the creation and maintenance of electronic target folders, gathering and verifying target information.
Assists in the execution of operations, maintaining operational security.
Prepares detailed reports and participates in post-operation analysis.'),
(15273, 4, 'É responsável pela execução de operações cibernéticas ofensivas, incluindo planejamento detalhado e definição de alvos.
Gerencia o desenvolvimento e atualização de pastas de alvos eletrônicos, garantindo precisão e abrangência. Coordena equipes operacionais, adaptando ações com base em informações em tempo real.
Assegura o cumprimento de padrões legais e éticos durante as operações. Avalia efeitos colaterais decorrentes de atividades de alvos, incluindo potenciais efeitos de segundo e terceiro grau.
Realiza análises pós-operacionais, avalia o impacto e recomenda melhorias.', 'Responsible for the execution of offensive cyber operations, including detailed planning and target selection.
Manages the development and updating of electronic target folders, ensuring accuracy and comprehensiveness. Coordinates operational teams, adapting actions based on real-time intelligence.
Ensures compliance with legal and ethical standards during operations. Evaluates collateral damage from targeting activities, including potential second and third-order effects.
Conducts post-operation analyses, assessing impact and recommending improvements.'),
(15273, 5, 'Lidera operações cibernéticas ofensivas complexas e de alto risco, supervisionando o planejamento, a execução e a análise.
Integra inteligência com planejamento operacional, alinhando todas as ações com os objetivos organizacionais. Avalia o custo de inteligência em relação ao benefício operacional de atacar alvos. Avalia possíveis efeitos colaterais, incluindo efeitos de segundo e terceiro grau.
Gerencia a criação e uso tático de pastas de alvos eletrônicos, coordenando-se com entidades externas, conforme necessário.
Desenvolve políticas e padrões para operações ofensivas, garantindo conformidade legal e ética. Fornece orientação especializada sobre capacidades ofensivas e táticas operacionais.', 'Leads complex and high-risk offensive cyber operations, overseeing planning, execution and analysis.
Integrates intelligence with operational planning, aligning all actions with organisational objectives. Evaluates the intelligence cost against the operational benefit of engaging targets. Assesses potential collateral damage, including second and third-order effects.
Manages the creation and tactical use of electronic target folders, coordinating with external entities as necessary.
Develops policies and standards for offensive operations, ensuring legal and ethical compliance. Provides expert guidance on offensive capabilities and operational tactics.'),
(15273, 6, 'Define a direção estratégica e as políticas para as operações cibernéticas ofensivas dentro da organização.
Lidera o desenvolvimento e o implementação de técnicas e capacidades operacionais avançadas. Supervisiona operações críticas e sensíveis, garantindo o alinhamento com objetivos de segurança nacionais ou da organização.
Colabora com a liderança sênior e entidades externas em operações ofensivas. Avalia custos de inteligência versus benefícios operacionais em nível estratégico. Avalia e mitiga efeitos colaterais potenciais.
Avalia e refina a eficácia das operações ofensivas, fornecendo recomendações para futuras iniciativas.', 'Sets the strategic direction and policies for offensive cyber operations within the organisation.
Leads the development and deployment of advanced operational techniques and capabilities. Oversees critical and sensitive operations, ensuring alignment with national or organisational security goals.
Collaborates with senior leadership and external entities on offensive operations. Evaluates intelligence cost versus operational benefit at a strategic level. Assesses and mitigates potential collateral damage.
Evaluates and refines the effectiveness of offensive operations, providing recommendations for future initiatives.'),
(15277, 3, 'Ajuda a projetar estruturas de equipe e fluxos de trabalho sob orientação, seguindo técnicas e ferramentas padrão de modelagem.
Ajuda a desenvolver representações visuais de modelos organizacionais para ajudar a compreensão. Ajuda na preparação e atualização de gráficos organizacionais, descrições de funções e outra documentação.
Apoia a avaliação de opções de design por meio da coleta e análise de dados.
Participa na criação de visões de design para atender às preocupações e perspectivas dos stakeholders.', 'Assists in designing team structures and workflows under guidance, following standard modelling techniques and tools.
Helps develop visual representations of organisational models to aid understanding. Assists in preparing and updating organisational charts, role descriptions and other documentation.
Supports evaluation of design options by gathering and analysing data.
Participates in creating design views to address stakeholder concerns and perspectives.'),
(15277, 4, 'Desenha estruturas de equipe e fluxos de trabalho usando técnicas de modelagem, seguindo arquiteturas, padrões de design e metodologias acordadas.
Desenvolve representações visuais de modelos e estruturas organizacionais para facilitar a compreensão e a tomada de decisões. Apoia a identificação e avaliação de opções de design alternativas e compromissos.
Cria múltiplas visões de design para atender às preocupações de diferentes stakeholders e apresentar diferentes perspectivas. Desenha representações de dinâmica de equipe e fluxos de trabalho para ajudar os stakeholders a entender e aprovar.
Revisa e aprimora designs para garantir que atendam às especificações.', 'Designs team structures and workflows using modelling techniques, following agreed architectures, design standards and methodologies.
Develops visual representations of organisational models and structures to facilitate understanding and decision-making. Supports the identification and evaluation of alternative design options and trade-offs.
Creates multiple design views to address the concerns of different stakeholders and to present different perspectives. Develops representations of team dynamics and workflows to aid stakeholder understanding and approval.
Reviews and refines designs to ensure they meet specifications.'),
(15277, 5, 'Dirige o design e a implementação de estruturas organizacionais para equipes, departamentos ou divisões importantes.
Realiza análises de impacto sobre as principais opções de design e compromissos para informar a tomada de decisões estratégicas.
Alinha estruturas organizacionais, papéis, empregos e caminhos de carreira existentes com novos processos e estratégias. Assegura que o design organizacional equilibre o desempenho organizacional e os requisitos culturais.
Revisa os projetos organizacionais e garante que os métodos, ferramentas e técnicas apropriados sejam aplicados de forma eficaz. Contribui para o desenvolvimento de políticas, processos e padrões de design organizacional.', 'Leads the design and implementation of organisational structures for significant teams, departments or divisions.
Conducts impact analyses on major design options and trade-offs to inform strategic decision-making.
Aligns existing organisational structures, roles, jobs and career paths to new processes and strategies. Ensures that the organisational design balances organisational performance and cultural requirements.
Reviews organisational designs and ensures that appropriate methods, tools and techniques are applied effectively. Contributes to development of organisational design policies, processes and standards.'),
(15277, 6, 'Defende o valor de novas formas de trabalhar para lidar com oportunidades e ameaças internas e externas.
Define a direção e orienta a seleção e uso de técnicas, metodologias e ferramentas de design organizacional.
Planeja e orienta as atividades de design da organização, identifica alternativas, avalia a viabilidade e recomenda soluções. Identifica as principais mudanças que afetam a organização e mobiliza recursos para implementar as mudanças.
Inicia a definição de novos limites da organização e cria o design da organização futura. Descreve os objetivos de medição de desempenho e a abordagem de implementação de alto nível.', 'Champions the value of new ways of working to address internal and external opportunities and threats.
Sets direction and leads in selecting and using organisation design techniques, methodologies and tools.
Plans and leads organisation design activities, identifies alternatives, assesses feasibility and recommends solutions. Identifies major changes affecting the organisation and mobilises resources to implement changes.
Initiates the definition of new organisation boundaries and creates future organisation design. Outlines performance measurement objectives and the high-level implementation approach.'),
(15277, 7, 'Estabelece e comunica a necessidade e a lógica para a estrutura organizacional e mudança de cultura.
Garante o compromisso organizacional e os recursos necessários para a mudança organizacional e cultural.
Lidera a mudança organizacional removendo obstáculos, advogando e fazendo lobby por mudanças nos níveis mais altos.
Implementa mecanismos para reforçar e incorporar mudanças organizacionais e culturais. Atua como um modelo para comportamentos desejados e define padrões e expectativas consistentes.', 'Establishes and communicates the need and rationale for organisational structure and culture change.
Secures organisational commitment and resources needed for organisational and culture change.
Leads organisational change by removing obstacles, advocating and lobbying for change at the highest levels.
Puts in place mechanisms to reinforce and embed organisational and culture change. Acts as a role model for desired behaviours and sets consistent standards and expectations.'),
(15274, 5, 'Contribui para identificar novas áreas de melhoria de capacidade dentro da organização, as quais podem ser melhorias em termos de habilidades, tecnologia ou processos.
Desenvolve e mantém um conhecimento detalhado das abordagens e técnicas de melhoria de capacidade e seleciona abordagens apropriadas para a organização.
Realiza atribuições de melhoria de capacidade, como avaliações de maturidade ou desempenho, para identificar pontos fortes e fracos. Seleciona e prioriza oportunidades de melhoria, gera envolvimento e planeja atividades de melhoria justificadas por benefícios organizacionais mensuráveis.
Oferece suporte, orientação, assessoria e sugestões para auxiliar atividades de melhoria contínua.', 'Contributes to identifying new areas of capability improvement within the organisation which may be enhancements to skills, technology or processes.
Develops and maintains a detailed knowledge of capability improvement approaches and techniques and selects appropriate approaches for the organisation.
Conducts capability improvement assignments, such as maturity or performance assessments, to identify strengths and weaknesses. Selects and prioritises improvement opportunities, generates buy-in and plans improvement activities justified by measurable organisational benefits.
Offers support, guidance, advice and suggestions to help continual improvement activities.'),
(15274, 6, 'Pesquisa, identifica, propõe e inicia atividades de melhoria de capacidade dentro da organização.
Conduz programas de melhoria substanciais. Planeja e gerencia a avaliação ou análise das capacidades organizacionais. Seleciona estruturas, abordagens e técnicas para uso.
Toma medidas para explorar oportunidades para fornecer impactos mensuráveis e benéficos sobre a eficácia operacional. Concebe soluções e conduz iniciativas de mudança, incluindo atividades de comunicação, transição e implementação.
Monitora as tendências internacionais, locais e do setor para estabelecer a capacidade necessária.', 'Seeks out, identifies, proposes and initiates capability improvement activities within the organisation.
Leads substantial improvement programmes. Plans and manages the evaluation or assessment of organisational capabilities. Selects frameworks, approaches and techniques for use.
Takes action to exploit opportunities to deliver measurable, beneficial impacts upon operational effectiveness. Devises solutions and leads change initiatives, including communication, transition and implementation activities.
Monitors international, national and sector trends to establish the needed capability.'),
(15274, 7, 'Representa e orienta a melhoria da capacidade organizacional no mais alto nível.
Determina a necessidade de melhoria da capacidade estratégica no nível da organização para atender as metas estratégicas e os objetivos de longo prazo da organização.
Articula com as outras áreas da organização para estabelecer requisitos e identifica, propõe, inicia e orienta programas significativos de melhoria da capacidade organizacional.
Gerencia a qualidade e adequação do trabalho realizado e oferece benefícios corporativos mensuráveis. Adota e/ou modifica as abordagens de melhoria de capacidade existentes conforme o necessário.', 'Represents and leads organisational capability improvement at the highest level.
Determines the need for strategic organisation-level capability improvement to satisfy the organisation''s strategic goals and long-term objectives.
Liaises with the organisation''s functions to establish requirements and identifies, proposes, initiates and leads significant organisational capability improvement programmes.
Manages the quality and appropriateness of the work performed and delivers measurable business benefits. Adopts and/or modifies existing capability improvement approaches as necessary.'),
(15275, 4, 'Apoia as equipes na adoção de novas práticas, fornecendo recursos e orientação contínuas.
Facilita um ambiente seguro para explorar desafios relacionados com a mudança.
Ajuda com sessões de engajamento para garantir o compromisso da liderança, com foco nos aspectos comportamentais da mudança.
Resolve problemas que surgem durante a implementação, garantindo mínimas interrupções.', 'Supports teams in adopting new practices, providing ongoing resources and guidance.
Facilitates a safe environment for exploring challenges related to change.
Assists with engagement sessions to secure leadership commitment, focusing on the behavioural aspects of change.
Addresses issues that arise during implementation, ensuring minimal disruption.'),
(15275, 5, 'Desenvolve e implementa planos de mudança cultural entre as equipes, garantindo o alinhamento com o sucesso a longo prazo.
Coordena equipes interfuncionais para apoiar a adoção de novos comportamentos. Comunica como as mudanças estão alinhadas com objetivos de negócios e sucesso a longo prazo, com foco nos impactos emocionais e comportamentais.
Apoia líderes e funcionários na exploração dos desafios associados à adoção de novas práticas.
Permite que os funcionários desenvolvam as habilidades e comportamentos necessários para uma mudança sustentada.', 'Develops and implements cultural change plans across teams, ensuring alignment with long-term success.
Coordinates cross-functional teams to support the adoption of new behaviours. Communicates how changes align with business goals and long-term success, focusing on emotional and behavioural impacts.
Supports leaders and employees in exploring challenges associated with adopting new practices.
Enables employees to develop the necessary skills and behaviours for sustained change.'),
(15275, 6, 'Promove novas formas de trabalho que se alinham com oportunidades estratégicas.
Influenciam e engajam-se com executivos seniores para obter o seu apoio para iniciativas de mudança.
Orienta o desenvolvimento de estratégias e roteiro para impulsionar a mudança de comportamento a longo prazo. Revisa o progresso, aborda desafios e garante a sustentabilidade das iniciativas de mudança.
Fornece orientação para líderes de mudança, com foco nos aspectos humanos da mudança organizacional.', 'Champions new ways of working that align with strategic opportunities.
Influences and engages with senior executives to gain their support for change initiatives.
Guides the development of strategies and roadmaps to drive long-term behavioural change. Reviews progress, addresses challenges and ensures the sustainability of change initiatives.
Provides guidance to change leaders, focusing on the human aspects of organisational change.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(3276, 2, 'Ajuda com tarefas de gerenciamento de mudanças organizacionais sob supervisão rotineira.
Apoia a coleta e análise de dados relacionados à preparação para mudanças e impacto.
Ajuda a documentar e comunicar planos e atividades de gerenciamento de mudanças.', 'Assists with organisational change management tasks under routine supervision.
Supports the collection and analysis of data related to change readiness and impact.
Helps document and communicate change management plans and activities.'),
(3276, 3, 'Segue técnicas padrão para investigar e analisar o porte, a natureza e o impacto das mudanças nas atividades operacionais.
Contribui para a recomendação de planos e ações de gestão de mudanças.
Apoia a implementação e se envolve com as partes interessadas sob orientação.', 'Follows standard techniques to investigate and analyse the size, nature and impact of changes to operational activities.
Contributes to change management plans and actions, focusing on the procedural execution of change.
Supports implementation and engages with stakeholders under direction.'),
(3276, 4, 'Conduz análises de prontidão para avaliar o tamanho, a natureza e o impacto da mudança organizacional.
Define as táticas a serem empregadas considerando os desafios a serem enfrentados. Oferece orientações e faz sugestões para dar apoio à implementação operacional das atividades de gerenciamento de mudanças.
Reúne feedback para analisar o impacto e a eficácia das atividades de gerenciamento de mudanças que estão sendo implantadas. Efetua correções conforme necessário.
Desenvolve e comunica os planos de gerenciamento de mudanças personalizados. Estabelece e cria relacionamentos com os patrocinadores do projeto e as principais partes interessadas.', 'Conducts readiness assessments to assess the size, nature and impact of organisational change.
Defines tactics to use considering the challenges to be addressed. Provides guidance and makes suggestions to support individuals responsible for operational implementation of change management activities.
Gathers feedback to analyse the impact and effectiveness of the change management activities being deployed. Takes corrective action as required.
Develops and communicates tailored change management plans. Establishes and builds relationships with the project sponsors and key stakeholders.'),
(3276, 5, 'Desenvolve a abordagem e os planos de gerenciamento de mudanças em colaboração com patrocinadores, usuários e equipes de projeto.
Cria e implementa planos de ação para garantir que tudo esteja pronto antes da mudança entrar em operação. Adquire recursos de gerenciamento de mudanças e desenvolve suas capacidades para oferecer as mudanças necessárias.
Reúne feedback para permitir melhorias no plano e na abordagem de gerenciamento de mudanças, segundo o cronograma. Avalia riscos e toma medidas preventivas.
Desenvolve e comunica planos de gerenciamento de mudanças personalizados para grupos de partes interessadas seniores. Fornece orientação e sugestões para dar suporte aos patrocinadores da mudança.', 'Develops the change management approach and a change management plan in collaboration with sponsors, users and project teams.
Creates and implements action plans to ensure readiness for change before going live. Acquires change management resources and develops their capabilities to deliver the required changes.
Gathers feedback to allow timely improvements to the change management plan and approach. Assesses risks and takes preventative action.
Develops and communicates tailored change management plans for senior stakeholder groups. Provides guidance to support change sponsors.'),
(3276, 6, 'Define e comunica a abordagem de gerenciamento de mudanças para uma parte significativa da organização.
Inicia, planeja e lidera iniciativas estratégicas, grandes e complexas de gerenciamento de mudanças. Fornece orientação aos líderes de mudança, enfatizando os aspectos técnicos e procedimentais da mudança.
Estabelece processos de feedback e lidera análises dos sucessos do gerenciamento de mudanças.
Permite melhorias contínuas na metodologia, ferramentas e treinamento de gerenciamento de mudanças necessários para aumentar a maturidade em toda a organização.', 'Defines and communicates the approach for change management for a significant part of the organisation.
Initiates, plans and leads strategic, large and complex change management initiatives. Provides guidance to change leaders, emphasising the technical and procedural aspects of change.
Establishes feedback processes and leads analyses of change management successes.
Enables continual improvements to change management methodology, tools and training necessary to enhance the maturity across the organisation.'),
(15276, 4, 'Facilita uma série de atividades ou oficinas em grupo nas situações de complexidade, ambiguidade e em situações com necessidades concorrentes das partes interessadas.
Cria uma sequência estruturada de reuniões, eventos ou workshops para resolver problemas complexos.
Compreende os resultados necessários das equipes, facilitando sua entrega.
Ajuda a melhorar os processos e o desempenho da equipe em reuniões, eventos ou workshops.', 'Facilitates a series of group activities or workshops in situations of complexity and ambiguity and competing stakeholder needs.
Designs a structured sequence of meetings, events or workshops to solve complex problems.
Understands required outcomes and outputs from teams and facilitates the team to deliver these.
Helps to improve team processes and performance in meetings, events or workshops.'),
(15276, 5, 'Atua como facilitador em grupos de trabalho para entregar metas e resultados definidos.
Oferece suporte, orientações e sugestões para que os grupos de trabalho e equipes aprendam a resolver problemas de forma colaborativa e a melhorar seu desempenho. Cria responsabilidades compartilhadas e acordos sustentáveis ​​com a equipe.
Implementa e melhora os princípios, práticas, processos e cerimônias acordados da equipe.
Reconhece os pontos fortes e as restrições da dinâmica da equipe e atua de acordo.', 'Facilitates workgroups to deliver defined goals and outcomes.
Provides support, guidance and suggestions to workgroups and teams to learn collaborative problem solving and improve their team performance. Creates shared responsibilities and sustainable agreements with the team.
Implements and improves agreed team principles, practices, processes & ceremonies.
Recognises and works with the strengths and constraints of team dynamics.'),
(15276, 6, 'Facilita o alcance dos objetivos e resultados organizacionais para equipes de liderança de diferentes funções.
Cria processos repetidos, sistemáticos ou ad hoc para a tomada de decisões, para a priorização e para a resolução de problemas no mais alto nível. Direciona as equipes de liderança no desenvolvimento de responsabilidades compartilhadas e na tomada de decisões que propiciem acordos sustentáveis.
Faz questionamentos e promove a conscientização do desempenho da equipe de liderança. Oferece sugestões para incentivar as equipes ao aprendizado e à melhoria em sua forma de trabalho conjunto.
Defende o desenvolvimento de grupos de trabalho auto-organizados na organização inteira.', 'Facilitates cross-functional leadership teams to deliver organisational goals and outcomes.
Designs repeatable, systematic or ad hoc team processes for decision-making, prioritisation and problem-solving at the highest level. Guides leadership teams in developing shared responsibilities and making decisions that enable sustainable agreements.
Asks questions and raises awareness of leadership team performance. Provides suggestions to encourage teams to learn and improve how they work together.
Champions the development of self-organising workgroups across the organisation.'),
(14887, 2, 'Auxilia em tarefas de testes de intrusão sob supervisão rotineira.
Suporta a execução de testes de penetração padronizados em sistemas, redes e aplicações.
Auxilia a documentar e reportar resultados de testes, descobertas e potenciais riscos de segurança.', 'Assists with penetration testing tasks under routine supervision.
Supports the execution of standard penetration tests on systems, networks and applications.
Helps document and report on test results, findings and potential security risks.'),
(14887, 3, 'Segue abordagens padronizadas para planejamento e execução de atividades de testes de intrusão.
Pesquisa e investiga técnicas de ataque e recomenda formas de defesa contra elas.
Analisa e elabora relatórios sobre as atividades, resultados, problemas e riscos dos testes de intrusão.', 'Follows standard approaches to design and execute penetration testing activities.
Researches and investigates attack techniques and recommends ways to defend against them.
Analyses and reports on penetration testing activities, results, issues and risks.'),
(14887, 4, 'Determina a abordagem de testes apropriada usando uma análise técnica aprofundada de riscos e vulnerabilidades típicas.
Produz scripts, materiais e pacotes de testes e efetua testes em redes, sistemas ou aplicativos novos e existentes. Registra e analisa as ações e resultados e modifica os testes, se necessário.
Fornece relatórios sobre o progresso, anomalias, riscos e problemas associados ao projeto geral.
Informa sobre testes de intrusão para oferecer suporte contra outros riscos.', 'Selects appropriate testing approaches using in-depth technical analysis of risks and typical vulnerabilities.
Produces test scripts, materials and test packs and tests new and existing networks, systems or applications. Provides advice on penetration testing to support others.
Records and analyses actions and results and modifies tests if necessary.
Provides reports on progress, anomalies, risks and issues associated with the overall project.'),
(14887, 5, 'Planeja e conduz testes de intrusão dentro de uma área definida de atividades de negócios.
Fornece insights objetivos sobre a existência de vulnerabilidades e sobre a eficácia das defesas e controles de mitigação.
Assume a responsabilidade pela integridade das atividades de teste e coordena a execução dessas atividades. Fornece aconselhamento e orientações sobre todos os aspectos de testes de intrusão.
Identifica necessidades e implementa novas abordagens para testes de intrusão. Contribui para os padrões de testes de segurança.', 'Plans and drives penetration testing within a defined area of business activity.
Delivers objective insights into the existence of vulnerabilities, the effectiveness of defences and mitigating controls.
Takes responsibility for the integrity of testing activities and coordinates the execution of these activities. Provides authoritative advice and guidance on all aspects of penetration testing.
Identifies needs and implements new approaches for penetration testing. Contributes to security testing standards.'),
(14887, 6, 'Determina a política de testes de intrusão e é responsável pelos processos de suporte.
Gerencia todas as atividades de testes de intrusão dentro da organização. Avalia e aconselha sobre a praticidade de alternativas de processo de testes.
Estabelece recursos para melhoria contínua e desenvolvimentos em testes de intrusão e orienta a implementação de novas abordagens.
Avalia as capacidades de desenvolvimento e teste dos fornecedores. Gerencia o relacionamento com o cliente no que diz respeito a testes de intrusão.', 'Determines penetration testing policy and owns the supporting processes.
Manages all penetration testing activities within the organisation. Assesses and advises on the practicality of testing process alternatives.
Establishes capability for continual improvement and invention in penetration testing and leads the implementation of new approaches.
Assesses suppliers'' development and testing capabilities. Manages client relationships with respect to penetration testing.'),
(7630, 4, 'Fornece direção operacional, suporte e orientação aos colegas de trabalho designados.
Aloca tarefas rotineiras ou atividades em projetos de acordo com os objetivos da equipe e as capacidades individuais. Monitora a qualidade e o desempenho de acordo com os critérios acordados a fim de fazer recomendações de aprendizagem ou escalar pontos de preocupação.
Treina os colegas no desenvolvimento das capacidades ideais de acordo com as metais pessoais e da equipe.
Facilita relações de trabalho eficazes entre os membros da equipe.', 'Provides operational direction, support and guidance to assigned colleagues.
Allocates routine tasks or project work, in line with team objectives and individual capabilities. Monitors quality and performance against agreed criteria to make learning recommendations or to escalate concerns.
Coaches colleagues in developing target skills and capabilities in line with team and personal goals.
Facilitates effective working relationships between team members.'),
(7630, 5, 'Formula, mantém e orienta grupos de trabalho e indivíduos a alcançar objetivos organizacionais.
Delega objetivos e responsabilidades, incluindo tarefas de gerenciamento de pessoas. Define metas de qualidade, desempenho e capacidade alinhadas com objetivos organizacionais.
Monitora o desempenho e as relações de trabalho e fornece feedback para abordar questões individuais. Encoraja o desenvolvimento de habilidades de acordo com as metas pessoais e da equipe. Ajusta a carga de trabalho, metas e capacidade da equipe para apoiar o crescimento individual.
Participa ativamente em processos formais, como recrutamento, recompensa, promoção e procedimentos disciplinares.', 'Forms, maintains and leads workgroups and individuals to achieve organisational objectives.
Delegates objectives and responsibilities, including people management tasks. Sets quality, performance and capability targets aligned with organisational goals.
Monitors performance and working relationships and provides feedback to address individual issues. Encourages skill development in line with team and personal goals. Adjusts workload, targets and team capacity to support individual growth.
Actively participates in formal processes such as recruitment, reward, promotion and disciplinary procedures.'),
(7630, 6, 'Determina e delega os objetivos e as responsabilidades de gestão de pessoas e de gestão funcional.
Cria e define o direcionamento para vários grupos de trabalho, visando atingir os objetivos organizacionais estratégicos. Define a estratégia de medição de qualidade e desempenho em linha com os objetivos organizacionais.
Fornece um ambiente de trabalho e recursos que permitam que indivíduos e grupos de trabalho executem suas tarefas com eficiência.
Conduz a implementação de processos organizacionais formais, como aqueles que tratam de recrutamento, recompensa, promoção e procedimentos disciplinares.', 'Determines and delegates people management and functional management objectives and responsibilities.
Creates and sets the direction for multiple workgroups to achieve strategic organisational objectives. Sets strategy for quality and performance measurement in line with organisational goals.
Provides a work environment and resources that allow individuals and workgroups to perform their tasks efficiently.
Leads the implementation of formal organisational processes such as recruitment, reward, promotion and disciplinary procedures.'),
(15278, 5, 'Garante que os líderes de programas/projetos e/ou responsáveis pelos serviços cumpram as estruturas de governança e o cronograma de gerenciamento de portfólio acordados.
Explica quais informações são necessárias e garante que forneçam essas informações para metas acordadas de prazos e precisão.
Produz relatórios conforme apropriado para a governança do portfólio, incluindo recomendações para mudanças no portfólio.', 'Ensures programme/project leads and/or service owners adhere to the agreed portfolio management and governance frameworks.
Explains what information is needed and ensures they provide this information to agreed targets of timelines and accuracy.
Produces reports as appropriate for portfolio governance, including making recommendations for changes to the portfolio.'),
(15278, 6, 'Engaja e influencia os gerentes seniores para garantir que o portfólio atenda aos objetivos de negócios acordados.
Lidera a definição, planejamento, agendamento e monitoramento das atividades do portfólio, garantindo o alinhamento com as normas de governança.
Assegura que cada componente do portfólio contribua para os objetivos globais. Identifica e aborda questões relacionadas com o portfólio, recomendando e monitorando ações corretivas.
Coleta e resume medidas de portfólio, relatando o status e garantindo a conformidade com as estruturas de governança.', 'Engages and influences senior managers to ensure the portfolio will deliver the agreed business objectives.
Leads the definition, planning, scheduling and monitoring of portfolio activities, ensuring alignment with governance standards.
Ensures each portfolio component contributes to the overall objectives. Identifies and addresses portfolio-related issues, recommending and monitoring corrective actions.
Collects and summarises portfolio measures, reporting on status and ensuring compliance with governance frameworks.'),
(15278, 7, 'Autoriza a estruturação de portfólios e alinha o portfólio com estratégias, objetivos, estruturas de governança e oportunidades emergentes.
Lidera a definição, implementação e revisão da estrutura de gerenciamento de portfólio da organização. Define parâmetros para a priorização de recursos e as mudanças a serem implementadas.
Recomenda e implementa medidas corretivas engajando e influenciando a alta administração.
Orienta o monitoramento contínuo e a revisão dos portfólios quanto ao impacto nas atividades de negócios atuais e os benefícios estratégicos a serem alcançados. Implementa estruturas de governança de portfólio e relatórios eficazes.', 'Authorises the structure of portfolios and aligns the portfolio with strategies, objectives, governance frameworks and emerging opportunities.
Leads the definition, implementation and review of the organisation’s portfolio management framework. Sets parameters for the prioritisation of resources and the changes to be implemented.
Recommends and implements corrective action by engaging and influencing senior management.
Leads the on-going monitoring and review of portfolios for impact on current business activities and the strategic benefits to be realised. Implements portfolio governance arrangements and effective reporting.'),
(15279, 2, 'Auxilia na compilação de relatórios para projetos, programas ou portfólios.
Mantém arquivos de programas e projetos a partir de dados reais e planejados.
Trabalha sob supervisão para apoiar as necessidades administrativas das equipes do projeto, contribuindo para as atividades de rotina do projeto.', 'Assists with the compilation of reports for projects, programmes, or portfolios.
Maintains programme and project files from supplied actual and forecast data.
Works under supervision to support the administrative needs of project teams, contributing to routine project activities.'),
(15279, 3, 'Fornece suporte básico para projetos, programas ou portfólios.
Ajuda com planejamento, agendamento, acompanhamento e relatórios usando ferramentas e processos de gerenciamento de projetos estabelecidos. Segue soluções recomendadas para garantir documentação e comunicação precisas do progresso do projeto.
Colabora estreitamente com equipes de projeto e partes interessadas, reunindo atualizações e informações para manter registros de projetos e assegurar a alinhamento com objetivos do projeto.
Participa em conselhos de projeto, equipes de garantia e reuniões de revisão de qualidade quando necessário.', 'Provides foundational support for projects, programmes, or portfolios.
Assists with planning, scheduling, tracking and reporting using established tools and processes. Follows recommended solutions to ensure accurate documentation and communication of project progress.
Collaborates closely with project teams and stakeholders, gathering updates and information to maintain project records and ensure alignment with project objectives.
Participates in project boards, assurance teams and quality review meetings when necessary.'),
(15279, 4, 'Oferece suporte a conselhos de controle de programas ou projetos, equipes de garantia de projetos e reuniões de revisão de qualidade.
Assume a responsabilidade pela prestação de serviços de suporte a projetos. Utiliza soluções de controle de projetos para planejamento, agendamento e acompanhamento. Configura e fornece orientações sobre softwares, procedimentos, processos, ferramentas e técnicas de gerenciamento de projetos.
Fornece orientações básicas sobre propostas de projetos. Pode oferecer visões gerais sobre projetos em tópicos como riscos, qualidade, finanças ou gestão de configuração.
Trabalha em estreita colaboração com conselhos de projetos e reuniões de revisão, contribuindo ativamente para discussões e decisões.', 'Supports programme or project control boards, project assurance teams and quality review meetings.
Takes responsibility for the provision of support services to projects. Uses project control solutions for planning, scheduling and tracking. Sets up and provides guidance on project management software, procedures, processes, tools and techniques.
Provides basic guidance on project proposals. May provide views across projects on topics such as risk, quality, finance, or configuration management.
Works closely with project boards and review meetings, contributing actively to discussions and decisions.'),
(15279, 5, 'Assume a responsabilidade pelo fornecimento de portfólio, programa e suporte a projetos.
Fornece aconselhamento sobre os padrões, procedimentos, métodos, ferramentas e técnicas disponíveis.
Avalia o desempenho de projetos e/ou programas e recomenda mudanças quando necessário.
Contribui para revisões e auditorias de gerenciamento de projetos e programas para garantir conformidade com padrões.', 'Takes responsibility for the provision of portfolio, programme and project support.
Advises on the available standards, procedures, methods, tools and techniques.
Evaluates project and/or programme performance and recommends changes where necessary.
Contributes to reviews and audits of project and programme management to ensure conformance to standards.'),
(15279, 6, 'Lidera a implementação e entrega de serviços de portfólio, programa e escritório de projetos.
Define a abordagem/política e estabelece padrões para o suporte fornecido para gerenciamento e monitoramento de portfólios, programas e projetos.
Gerencia recursos para garantir a entrega de serviços/recursos eficazes de acordo com a demanda atual e futura.
Analisa e melhora a entrega do portfólio, programas e serviços do escritório de projetos.', 'Leads implementation and delivery of portfolio, programme and project office services.
Defines the approach/policy and sets standards for the support provided for managing and monitoring portfolios, programmes, and projects.
Manages resources to ensure delivery of effective services/resources in line with current and planned demand.
Reviews and improves the delivery portfolio, programme and project office services.'),
(8969, 2, 'Ajuda com tarefas de gerenciamento de problemas sob supervisão rotineira.
Ajuda a documentar problemas e manter registros relevantes.
Ajuda a detectar, registrar, classificar e priorizar problemas em sistemas, processos e serviços.', 'Assists with problem management tasks under routine supervision.
Helps document problems and maintain relevant records.
Assists in detecting, logging, classifying, and prioritising problems in systems, processes, and services.'),
(8969, 3, 'Investiga problemas em sistemas, processos e serviços.
Auxilia na implementação de soluções pré-estabelecidas e medidas preventivas.', 'Investigates problems in systems, processes and services.
Contributes to the implementation of agreed remedies and preventative measures.'),
(8969, 4, 'Inicia e monitora as ações para investigar e resolver problemas em sistemas, processos e serviços.
Determina os reparos e soluções para os problemas.
Colabora com terceiros para implementar as soluções e medidas preventivas pré-estabelecidas.
Oferece suporte à análise de padrões e tendências para aperfeiçoar os processos de gerenciamento de problemas.', 'Initiates and monitors actions to investigate and resolve problems in systems, processes and services.
Determines problem fixes and remedies.
Collaborates with others to implement agreed remedies and preventative measures.
Supports analysis of patterns and trends to improve problem management processes.'),
(8969, 5, 'Garante que ações apropriadas sejam tomadas para antecipar, investigar e resolver problemas em sistemas e serviços.
Garante que problemas sejam totalmente documentados nos sistemas de informação relevantes.
Permite o desenvolvimento de soluções para os problemas. Coordena a implementação de soluções e medidas preventivas pré-estabelecidas.
Analisa padrões e tendências, aperfeiçoando os processos de gerenciamento de problemas.', 'Ensures appropriate action is taken to anticipate, investigate and resolve problems in systems and services.
Ensures problems are fully documented within the relevant reporting systems.
Enables development of problem solutions. Coordinates the implementation of agreed remedies and preventative measures.
Analyses patterns and trends and improves problem management processes.'),
(15280, 1, 'Executa scripts de teste de processo sob supervisão para verificar fluxos de trabalho de negócios e viagens de usuários.
Configure ambientes de teste básicos para simular processos de negócios.
Utiliza ferramentas de teste padrão para validação de processos, registra resultados e reporta problemas.', 'Executes given process test scripts under supervision to verify business workflows and user journeys.
Configures basic test environments to simulate business processes.
Uses standard testing tools for process validation, records results and reports issues.'),
(15280, 2, 'Desenha casos de teste e scripts para validar cenários e fluxos de trabalho de negócios importantes.
Suporta a preparação e gestão de dados de teste sob supervisão para alinhamento com processos de negócios. Configura ambientes de teste para refletir processos de negócios do mundo real.
Executa e registra testes de processos manuais e automatizados de acordo com planos de teste.
Análise e relatórios sobre atividades de teste, identificando problemas e riscos relacionados à validação de processos de negócios.', 'Designs test cases and scripts to validate key business scenarios and workflows.
Supports the preparation and management of test data under supervision to align with business processes. Configures test environments to reflect real-world business processes.
Executes and records manual and automated process tests in line with test plans.
Analyses and reports on test activities, identifying issues and risks related to business process validation.'),
(15280, 3, 'Desenha casos de teste de processo e scripts que abrangem cenários de negócios de ponta a ponta.
Participa ativamente em revisões de requisitos e design para refinar planos de teste. Prepara e gerencia dados de teste que refletem com precisão os processos de negócios.
Configura ambientes de teste, executa testes e resolve problemas à medida que surgem. Realiza testes exploratórios estruturados para avaliar fluxos de negócios alternativos.
Automatiza testes repetitivos para eficiência. Análise e relatórios sobre resultados, com foco nos impactos nos processos de negócios.', 'Designs process test cases and scripts that cover end-to-end business scenarios.
Actively participates in requirement and design reviews to refine test plans. Prepares and manages test data that accurately mirrors business processes.
Configures test environments, executes tests and addresses issues as they arise. Undertakes structured exploratory testing to assess alternative business flows.
Automates repeatable tests for efficiency. Analyses and reports on outcomes, focusing on impacts to business processes.'),
(15280, 4, 'Seleciona e aplica abordagens de teste apropriadas com base na crítica de negócios, risco e complexidade de processos.
Desenvolve, automatiza e executa planos de teste detalhados com foco na validação de processo de ponta a ponta. Assegura que ambientes de teste automatizados simulem com precisão processos e fluxos de trabalho reais.
Colabora estreitamente com as partes interessadas para refinar os requisitos de negócios e garantir a cobertura completa. Identifica e mitiga riscos ao longo do processo de teste e resolve problemas.
Fornece análises detalhadas e relatórios sobre o impacto dos resultados de testes nas operações de negócios, incluindo o trabalho realizado por outras pessoas.', 'Selects and applies appropriate testing approaches based on business criticality, risk and process complexity.
Develops, automates and executes detailed test plans focusing on end-to-end process validation. Ensures automated test environments accurately simulate real business processes and workflows.
Collaborates closely with stakeholders to refine business requirements and ensure full coverage. Identifies and mitigates risks throughout the testing process and addresses issues.
Provides detailed analysis and reports on the impact of test results on business operations, including work done by others.'),
(15280, 5, 'Dirige as atividades de testes de processos em todas as fases de desenvolvimento, garantindo o alinhamento com os objetivos de negócios e priorizando os fluxos de trabalho principais com base em risco.
Assegura que os ambientes de testes sejam robustos e representem as operações de negócios reais.
Fornece aconselhamento especializado sobre testes de processos, garantindo que os testes sejam eficazes e alinhados com as necessidades de negócios.
Dirige esforços para melhorar a eficiência e a confiabilidade dos testes de processos. Identifica lacunas e riscos e contribui para o desenvolvimento de políticas e padrões que apoiam testes de processos abrangentes e baseados em risco.', 'Leads process testing activities across all stages of development, ensuring alignment with business objectives and prioritising key workflows based on risk.
Ensures test environments are robust and reflective of actual business operations.
Provides expert advice on process testing, ensuring tests are effective and align with business needs.
Leads efforts to improve the efficiency and reliability of process testing. Identifies gaps and risks and contributes to the development of policies and standards that support comprehensive and risk-based process testing.'),
(15280, 6, 'Desenvolve políticas, padrões e diretrizes organizacionais para testes de processos, garantindo que estejam alinhados com a estratégia de negócios e incorporem uma abordagem baseada em risco.
Planeia e dirige iniciativas de testes de processos em grande escala, com foco na validação de processos complexos e críticos.
Lida esforços para otimizar e inovar metodologias de testes de processos, integrando-as com metas de negócios gerais e estratégias de gerenciamento de risco.
Promove uma cultura de qualidade em testes de processos, impulsiona a adesão às normas organizacionais e a mitigação proativa de riscos.', 'Develops organisational policies, standards and guidelines for process testing, ensuring they align with business strategy and incorporate a risk-based approach.
Plans and leads large-scale process testing initiatives, focusing on validating complex and critical processes.
Leads efforts to optimise and innovate process testing methodologies, integrating them with overall business goals and risk management strategies.
Promotes a culture of quality in process testing, driving adherence to organisational standards and proactive risk mitigation.'),
(2308, 2, 'Ajuda com tarefas de gerenciamento de produtos sob supervisão de rotina.
Ajuda a criar e curar conteúdo para apoiar o uso do produto.
Ajuda no monitoramento de resultados e feedback das atividades do produto.
Apoia a resolução de problemas, coletando e reportando dados de feedback e uso.', 'Assists with product management tasks under routine supervision.
Helps create and curate content to support product usage.
Assists in monitoring results and feedback from product activities.
Supports problem resolution by collecting and reporting on feedback and usage data.'),
(2308, 3, 'Cria e faz a curadoria de diversos conteúdos para apoiar a adoção e o uso de produtos ou serviços.
Monitora resultados e feedback de campanhas de produtos.
Aplica técnicas e ferramentas padrão para realizar atividades de análise e monitoramento de desempenho para produtos específicos.
Apoia a resolução de problemas, resolve questões e age com base no feedback para produtos em uso.', 'Creates and curates various content to support the adoption and usage of products or services.
Monitors results and feedback from product campaigns.
Applies standard techniques and tools to carry out analysis and performance monitoring activities for specified products.
Supports problem resolution, resolves issues and acts on feedback for products in use.'),
(2308, 4, 'Gerencia um ou mais produtos ou serviços de menor valor.
Prioriza requisitos do produto e desenvolve roteiros de produto. É responsável pelo backlog do produto. Gerencia elementos do ciclo de vida do produto para atender às necessidades do cliente/usuário e alcançar metas financeiras ou outras.
Utiliza insights de pesquisas de mercado e/ou usuários, feedback, opinião de especialistas e dados de uso para entender necessidades e oportunidades.
Facilita a aceitação de produtos através do desenvolvimento de conteúdo, apoio e avaliação de campanhas e monitoramento do desempenho do produto. Implementa testes de produtos e lançamentos de produtos.', 'Manages one or more lower-value products or services.
Prioritises product requirements and develops product roadmaps. Owns the product backlog. Manages elements of the product lifecycle to meet customer/user needs and achieve financial or other targets.
Uses insights from market and/or user research, feedback, expert opinion and usage data to understand needs and opportunities.
Facilitates uptake of products by developing content, supporting and evaluating campaigns and monitoring product performance. Rolls out product trials and product launches.'),
(2308, 5, 'Gerencia todo o ciclo de vida do produto para atender às necessidades do cliente/usuário e alcançar metas.
Seleciona e adapta métodos, ferramentas e técnicas de desenvolvimento de produtos apropriados.
Utiliza insights de pesquisas de mercado e/ou usuários, feedback e dados de uso para entender necessidades e oportunidades. Desenvolve propostas de produto e determina posicionamento e variantes para diferentes segmentos. Prioriza requisitos e desenvolve rotas de produto.
Coordena testes de clientes, lança produtos e apoia a comunicação e treinamento. Adapta produtos com base nas necessidades cambiantes de cliente/usuário e cria planos de aposentadoria e transição.', 'Manages the full product lifecycle to meet customer/user needs and achieve targets.
Selects and adapts appropriate product development methods, tools and techniques.
Uses insights from market and/or user research, feedback and usage data to understand needs and opportunities. Develops product propositions and determines positioning and variants for different segments. Prioritises requirements and develops product roadmaps.
Coordinates customer testing, product launches and supports communications and training. Adapts products based on changing customer/user needs and creates retirement and transition plans.'),
(2308, 6, 'Supervisiona o portfólio de produtos e serviços da organização e a entrega de valor ao cliente e/ou satisfação do usuário ao longo do tempo.
Cria a estrutura de gerenciamento do ciclo de vida do produto para clientes e usuários internos e externos. Defende a importância e o valor dos princípios de gerenciamento de produtos e modelos apropriados de desenvolvimento de produtos.
Alinha os objetivos de gerenciamento de produtos com os objetivos de negócios e autoriza a seleção e o planejamento de todas as atividades de gerenciamento de produtos.
Inicia a criação de novos produtos e serviços. Identifica como o desenvolvimento de novos produtos ou a adaptação de produtos existentes podem gerar novas oportunidades.', 'Oversees the organisation’s product and services portfolio and the delivery of customer value and/or user satisfaction.
Creates the product lifecycle management framework for internal and external customers and users. Champions the value of product management principles and appropriate product development models.
Aligns the product management objectives with business objectives and authorises the selection and planning of all product management activities.
Initiates the creation of new products and services. Identifies how developing new products or adapting existing products can create new opportunities.'),
(2801, 4, 'Auxilia profissionais na criação de planos de desenvolvimento pessoal.
Oferece aconselhamento sobre atividades de desenvolvimento adequadas, como aprendizado específico ou experiência a ser adquirida.
Monitora os registros de desenvolvimento contínuo dos profissionais.
Garante que as conquistas e as evoluções de capacitação sejam registradas e referenciadas aos objetivos pessoais e organizacionais.', 'Assists practitioners with creating personal development plans.
Advises on suitable development activities such as specific learning or experience to be gained.
Monitors practitioners’ continuing professional development records.
Ensures achievements and enhanced capabilities are recorded and referenced to personal and organisational objectives.'),
(2801, 5, 'Determina as necessidades de desenvolvimento de uma área de atuação profissional.
Alinha as atividades de desenvolvimento com as prioridades organizacionais, estratégias de aprendizagem, desenvolvimento e planos de carreira.
Auxilia os profissionais na criação de planos de desenvolvimento. Aconselha e orienta os profissionais designados, garantindo o alinhamento com os planos de desenvolvimento profissional e oportunidades de carreira.
Garante que os profissionais registrem evidências de desenvolvimento profissional contínuo. Contribui com as avaliações de desempenho dos profissionais, quando requerido.', 'Determines development needs for a professional practice area.
Aligns development activities with organisational priorities, learning and development strategies and career pathways.
Guides practitioners in creating development plans. Advises and supports assigned practitioners, ensuring alignment with professional development plans and career opportunities.
Ensures practitioners record evidence of continuing professional development. Contributes to practitioners'' performance appraisals, when required.'),
(2801, 6, 'Desenvolve e define uma estrutura de desenvolvimento profissional para uma ou mais disciplinas.
Determina e mantém as necessidades de desenvolvimento organizacional alinhadas com as necessidades do negócio e com a direção estratégica. Gera estratégias de desenvolvimento para atingir a mudança necessária.
Desenvolve e orienta comunidades de prática, incluindo a definição de roteiros de carreira.
Define a abordagem para identificar as pessoas adequadas para fornecer aconselhamento e suporte de carreira. Monitora o progresso e avalia os benefícios de negócio obtidos com o desenvolvimento profissional contínuo.', 'Develops and defines a professional development framework for one or more professional disciplines.
Determines and maintains organisational development needs in line with business needs and strategic direction. Generates development strategies to achieve required change.
Develops and leads communities of practice, including defining career pathways.
Defines the approach to identifying suitable individuals to provide career advice and support. Monitors progress and evaluates business benefits achieved from continual professional development.'),
(323, 6, 'Planeja, dirige e coordena atividades para gerenciar e implementar um programa desde a iniciação até a transição final para a gestão operacional e de rotina.
Planeja, agenda, monitora e reporta atividades relacionadas ao programa. Estabelece e mantém frameworks adequados e eficazes de governança e gestão de riscos.
Garante que políticas abrangentes de comunicação e relatórios estejam em vigor e sejam seguidas. Mantém-se atento às evoluções técnicas atuais que possam oferecer oportunidades aos programas.
Assegura que os programas sejam gerenciados para alcançar os benefícios de negócios acordados dentro dos prazos estabelecidos.', 'Plans, directs and co-ordinates activities to manage and implement a programme from initiation to final transition into operational, business-as-usual management.
Plans, schedules, monitors and reports on programme-related activities. Establishes and maintains appropriate and effective governance and risk management frameworks.
Ensures comprehensive reporting and communication policies are in place and followed. Maintains an awareness of current technical developments that may provide opportunities to the programmes.
Ensures programmes are managed to realise agreed business benefits within agreed timescales.'),
(323, 7, 'Estabelece a estratégia organizacional governando a gestão de programas, incluindo a aplicação de metodologias adequadas.
Planeja, dirige e coordena atividades para gerenciar e implementar programas complexos, desde a iniciação até a completa integração com a gestão operacional regular do negócio. Alinha os objetivos do programa com as metas de negócios e autoriza projetos e atividades relacionados.
Planeja, agenda, monitora e reporta as atividades do programa, apoiado por estratégias abrangentes de comunicação e relatórios.
Garante que frameworks de governança e gestão de riscos estejam em vigor para apoiar a tomada de decisões estratégicas e a execução do programa.', 'Sets organisational strategy governing programme management, including the application of appropriate methodologies.
Plans, directs and co-ordinates activities to manage and implement complex programmes from initiation to full integration with operational, business-as-usual management. Aligns programme objectives with business goals and authorises related projects and activities.
Plans, schedules, monitors and reports on programme activities, supported by comprehensive reporting and communication strategies.
Ensures governance and risk management frameworks are in place to support strategic decision-making and programme execution.'),
(15281, 2, 'Projeta, codifica, verifica, testa, documenta, corrige e reestrutura programas/scripts simples.
Aplica padrões acordados, ferramentas e medidas de segurança para atingir um resultado bem estruturado.
Revisa o próprio trabalho.', 'Designs, codes, verifies, tests, documents, amends and refactors simple programs/scripts.
Applies agreed standards, tools and basic security practices to achieve a well-engineered result.
Reviews own work.'),
(15281, 3, 'Projeta, codifica, verifica, testa, documenta, corrige e reestrutura programas/scripts moderadamente complexos.
Aplica padrões acordados, ferramentas e medidas de segurança para atingir um resultado bem estruturado.
Monitora e presta informações sobre o andamento. Identifica problemas relacionados às atividades de desenvolvimento de software. Propõe soluções práticas para resolver problemas.
Colabora nas revisões do trabalho com outras pessoas, quando necessário.', 'Designs, codes, verifies, tests, documents, amends and refactors moderately complex programs/scripts.
Applies agreed standards, tools and security measures to achieve a well-engineered result.
Monitors and reports on progress. Identifies issues related to software development activities. Proposes practical solutions to resolve issues.
Collaborates in reviews of work with others as appropriate.'),
(15281, 4, 'Projeta, codifica, verifica, testa, documenta, corrige e reestrutura programas/scripts e serviços de software de integração complexos.
Contribui para a seleção dos métodos, ferramentas, técnicas e práticas de segurança do desenvolvimento de software.
Aplica padrões e ferramentas pré-estabelecidas para atingir resultados bem planejados.
Participa de revisões do próprio trabalho e realiza revisões do trabalho dos colegas.', 'Designs, codes, verifies, tests, documents, amends and refactors complex programs/scripts and integration software services.
Contributes to the selection of the software development methods, tools, techniques, and security practices.
Applies agreed standards, tools, and security measures to achieve well-engineered outcomes.
Participates in reviews of own work and leads reviews of colleagues'' work.'),
(15281, 5, 'Assume a responsabilidade técnica em todos os estágios e iterações do desenvolvimento de software.
Planeja e conduz atividades de criação de software. Adota e adapta métodos, ferramentas e técnicas de desenvolvimento de software apropriados.
Mede e monitora aplicações de padrões de projeto/equipe para construção de software, incluindo segurança de software.
Contribui para o desenvolvimento de políticas organizacionais, normas e diretrizes para o desenvolvimento de software.', 'Takes technical responsibility across all stages and iterations of software development.
Plans and drives software construction activities. Adopts and adapts appropriate software development methods, tools and techniques.
Measures and monitors applications of project/team standards for software construction, including software security.
Contributes to the development of organisational policies, standards and guidelines for software development.'),
(15281, 6, 'Desenvolve políticas organizacionais, padrões e diretrizes para construção e reestruturação de software.
Planeja e lidera atividades de construção de software para projetos de desenvolvimento estratégicos, grandes e complexos.
Adapta ou desenvolve novos métodos e capacidades organizacionais e impulsiona a adoção e adesão a políticas e padrões', 'Develops organisational policies, standards and guidelines for software construction and refactoring.
Plans and leads software construction activities for strategic, large and complex development projects.
Adapts or develops new methods and organisational capabilities and drives adoption of, and adherence to, policies and standards.'),
(6232, 4, 'Define, documenta e executa pequenos projetos ou subprojetos.
Trabalha independente ou com uma pequena equipe participando ativamente em todas as fases do projeto. Aplica os métodos e ferramentas de gerenciamento de projetos apropriados. Identifica, avalia e gerencia os riscos de forma eficaz.
Prepara planos de projeto realistas (incluindo escopo, cronograma, qualidade, risco e planos de comunicação), garantindo o envolvimento das partes interessadas e o alinhamento com os padrões de governança organizacional.
Rastreia as atividades em relação ao cronograma do projeto, gerenciando o envolvimento das partes interessadas conforme apropriado. Monitora custos, tempos, qualidade e recursos usados. Toma medidas quando estes excedem as tolerâncias acordadas.', 'Defines, documents and executes small projects or sub-projects.
Works independently or with a small team, actively participating in all project phases. Applies appropriate project management methods and tools. Identifies, assesses and manages risks effectively.
Prepares realistic project plans ((including scope, schedule, quality, risk and communication plans), ensuring stakeholder involvement and alignment with organisational governance standards.
Tracks activities against the project schedule, managing stakeholder involvement as appropriate. Monitors costs, times, quality and resources used. Takes action where these exceed agreed tolerances.'),
(6232, 5, 'Assume toda a responsabilidade pela definição, abordagem, facilitação e conclusão satisfatória de projetos de médio porte.
Fornece liderança eficaz à equipe do projeto, adotando métodos e ferramentas de gerenciamento de projetos adequados. Gerencia processos de controle de mudança e avaliação de riscos, garantindo que os projetos estejam alinhados com os frameworks de governança e prioridades de negócios.
Comunica regularmente com as partes interessadas, garantindo que as entregas dos projetos atendam aos padrões, orçamentos e prazos acordados. Assegura que as revisões de qualidade de projetos e produtos ocorram conforme programado e de acordo com os procedimentos.
Monitora proativamente as métricas de desempenho, implementando ações preventivas e corretivas se necessário.', 'Takes full responsibility for the definition, approach, facilitation and satisfactory completion of medium-scale projects.
Provides effective leadership to the project team, adopting suitable project management methods and tools. Manages change control processes and assesses risks, ensuring projects align with governance frameworks and business priorities.
Communicates regularly with stakeholders, ensuring project deliverables meet agreed standards, budgets and timelines. Ensures project and product quality reviews occur on schedule and according to procedure.
Proactively monitors performance metrics, implementing preventive and corrective actions as needed.'),
(6232, 6, 'Assume toda a responsabilidade pela definição, documentação e conclusão bem-sucedida de projetos complexos.
Adota e adapta métodos e ferramentas de gerenciamento de projetos adequados às necessidades do projeto. Assegura monitoramento e controle eficazes de recursos, orçamentos e prazos.
Integra gerenciamento de risco robusto em frameworks de governança para alinhar decisões com padrões e disposição da organização em correr riscos.
Gerencia as expectativas das principais partes interessadas, garantindo que todas as atividades estejam alinhadas com os objetivos da organização, entreguem os resultados acordados e proporcionem valor para o negócio.', 'Takes full responsibility for the definition, documentation and successful completion of complex projects.
Adopts and adapts project management methods and tools suited to the project''s needs. Ensures effective monitoring and control of resources, budgets and timelines.
Integrates robust risk management within governance frameworks to align decisions with the organisation’s risk appetite and standards.
Manages expectations of key stakeholders, ensuring all activities align with organisational goals, deliver agreed outcomes and provide business value.'),
(6232, 7, 'Define a estratégia organizacional que rege a direção e a condução da gestão de projetos, garantindo que os projetos estejam alinhados com os objetivos estratégicos e com as estruturas de governança.
Autoriza a gestão de projetos de grande escala. Lidera o planejamento, programação, controle e relatórios de atividades de projetos estratégicos, de alto impacto e de alto risco.
Supervisiona a seleção e aplicação de metodologias de projetos. Dirige a abordagem para a gestão de riscos para projetos, garantindo que os riscos e questões sejam gerenciados de acordo com as políticas organizacionais.
Garante que os projetos entreguem os benefícios pretendidos e contribuam para metas de longo prazo.', 'Sets organisational strategy governing the direction and conduct of project management, ensuring projects align with strategic objectives and governance frameworks.
Authorises the management of large-scale projects. Leads project planning, scheduling, controlling and reporting activities for strategic, high impact, high risk projects.
Oversees the selection and application of project methodologies. Directs the approach to risk management for projects, ensuring risks and issues are managed in line with organisational policies.
Ensures projects deliver their intended benefits and contribute to long-term goals.'),
(6991, 2, 'Auxilia em tarefas de garantia de qualidade sob supervisão de rotina.
Apoia a coleta de dados e evidências relacionadas à garantia de qualidade.
Ajuda na revisão de registros para garantir a conformidade com os padrões de qualidade.
Ajuda a identificar e reportar problemas de qualidade e discrepâncias.', 'Assists with quality assurance tasks under routine supervision.
Supports the collection of data and evidence related to quality assurance.
Assists in reviewing records to ensure compliance with quality standards.
Helps identify and report quality issues and discrepancies.'),
(6991, 3, 'Contribui para a coleta de evidências e a realização de auditorias formais ou revisões de atividades.
Examina registros em busca de evidências de que testes apropriados e outras atividades de controle de qualidade.
Determina o cumprimento das diretrizes, normas e procedimentos organizacionais e identifica não conformidades e ocorrências anormais.', 'Contributes to the collection of evidence and the conduct of formal audits or reviews of activities.
Examines records for evidence that appropriate testing and other quality control activities have taken place.
Determines compliance with organisational directives, standards and procedures and identifies non-compliances, non-conformances and abnormal occurrences.'),
(6991, 4, 'Planeja, organiza e conduz a atividade de avaliação e determina se o controle de qualidade apropriado foi aplicado.
Conduz avaliações ou revisões formais para determinadas áreas de domínio, fornecedores ou partes da cadeia de suprimentos. Agrupa, coleta e examina registros, analisa as evidências e elabora todos ou parte dos relatórios formais de conformidade.
Determina os riscos associados às constatações e não conformidades e propõe ações corretivas.
Fornece aconselhamento e orientação no uso de padrões organizacionais.', 'Plans, organises and conducts assessment activity and determines whether appropriate quality control has been applied.
Conducts formal assessments or reviews for given domain areas, suppliers or parts of the supply chain. Collates, collects and examines records, analyses the evidence and drafts all or part of formal compliance reports.
Determines the risks associated with findings and non-compliance and proposes corrective actions.
Provides advice and guidance in the use of organisational standards.'),
(6991, 5, 'Planeja, organiza e realiza revisões e avaliações formais de áreas de domínios complexos, áreas multifuncionais e em toda a cadeia de suprimentos.
Avalia, estima e identifica falhas de conformidade com os padrões organizacionais e determina as razões subjacentes dessas falhas.
Prepara e relata os resultados da avaliação e os riscos associados. Garante que os responsáveis apropriados para as ações corretivas sejam identificados. Identifica oportunidades para aprimorar os mecanismos de controle organizacional.
Supervisiona as atividades de garantia de terceiros, fornecendo assessoria e experiência para apoiar as atividades de garantia.', 'Plans, organises and conducts formal reviews and assessments of complex domains areas, cross-functional areas and across the supply chain.
Evaluates, appraises and identifies non-compliances with organisational standards and determines the underlying reasons for non-compliance.
Prepares and reports on assessment findings and associated risks. Ensures appropriate owners for corrective actions are identified. Identifies opportunities to improve organisational control mechanisms.
Oversees the assurance activities of others, providing advice and expertise to support assurance activity.'),
(6991, 6, 'Lidera, desenvolve e é responsável por uma abordagem organizacional e compromisso com a garantia de qualidade.
Garante que os processos e atividades de garantia de qualidade sejam robustos e confiáveis, e adequadamente adaptados aos objetivos de qualidade da organização. Planeja recursos e atividades de garantia de qualidade organizacional, usando recursos internos ou de terceiros.
Considera as implicações da tecnologia emergente, abordagens, tendências, regulamentos e legislação.
Monitora e reporta atividades de garantia de qualidade, níveis de conformidade e oportunidades de melhoria.', 'Leads, develops and is accountable for an organisational approach and commitment to quality assurance.
Ensures quality assurance processes and activities are robust and reliable, and appropriately tailored to the organisation’s quality objectives. Plans and resources the organisational quality assurance activities, using internal or third-party resources.
Considers the implications of emerging technology, approaches, trends, regulations and legislation.
Monitors and reports on quality assurance activities, levels of compliance and improvement opportunities.'),
(11143, 2, 'Auxilia em tarefas de gerenciamento de qualidade sob supervisão de rotina.
Apoia o desenvolvimento, manutenção e distribuição de padrões de qualidade.
Ajuda a documentar e acompanhar atualizações de processos e padrões de gerenciamento de qualidade.', 'Assists with quality management tasks under routine supervision.
Supports the development, maintenance and distribution of quality standards.
Helps document and track updates to quality management processes and standards.'),
(11143, 3, 'Utiliza métodos adequados e uma abordagem sistemática no desenvolvimento, manutenção, controle e distribuição de normas de qualidade e ambientais.
Executa alterações técnicas e controla as atualizações e a distribuição de padrões de qualidade.
Distribui padrões novos e revisados.', 'Uses appropriate methods and a systematic approach to developing, maintaining, controlling and distributing quality and environmental standards.
Makes technical changes to and controls the updates and distribution of quality standards.
Distributes new and revised standards.'),
(11143, 4, 'Auxilia no desenvolvimento de novas ou melhores práticas e processos ou padrões organizacionais.
Auxilia projetos, funções ou equipes no planejamento da gestão da qualidade para sua área de responsabilidade.
Facilita melhorias localizadas no sistema de qualidade ou serviços.', 'Assists in the development of new or improved practices and organisational processes or standards.
Assists projects, functions or teams in planning the quality management for their area of responsibility.
Facilitates localised improvements to the quality system or services.'),
(11143, 5, 'Garante que projetos, equipes e funções tenham práticas apropriadas e estejam atendendo aos níveis de qualidade organizacionais exigidos.
Aconselha sobre a aplicação de técnicas e padrões de gestão da qualidade apropriados.
Determina as áreas em que os processos existentes devem mudar a partir da análise dos resultados da auditoria. Facilita melhorias nos processos mudando abordagens e práticas de trabalho, normalmente usando modelos reconhecidos.
Assume a responsabilidade de controlar a atualização e distribuição dos padrões organizacionais.', 'Ensures projects, teams and functions have appropriate practices in place and are meeting required organisational quality levels.
Advises on the application of appropriate quality management techniques and standards.
Determines areas where existing processes should change after analysing audit findings. Facilitates improvements to processes by changing approaches and working practices, typically using recognised models.
Takes responsibility for controlling updating and distributing organisational standards.'),
(11143, 6, 'Alcança e mantém a conformidade com os padrões nacionais e internacionais, conforme estabelecido.
Prioriza áreas para melhoria da qualidade considerando a estratégia, objetivos de negócios e resultados de auditorias internas e externas. Inicia a aplicação de técnicas de gestão de qualidade apropriadas nestas áreas.
Inicia melhorias nos processos alterando abordagens e práticas de trabalho, normalmente usando modelos reconhecidos.
Identifica e planeja ações corretivas sistemáticas para reduzir erros e melhorar a qualidade dos sistemas e serviços.', 'Achieves and maintains compliance against national and international standards, as appropriate.
Prioritises areas for quality improvement by considering strategy, business objectives and results from internal and external audits. Initiates the application of appropriate quality management techniques in these areas.
Initiates improvements to processes by changing approaches and working practices, typically using recognised models.
Identifies and plans systematic corrective action to reduce errors and improve the quality of the systems and services.'),
(11143, 7, 'Determina a estratégia de qualidade e garante o compromisso da liderança executiva.
Desenvolve políticas para aprovação e adoção pela gestão organizacional. Garante que tecnologia, procedimentos e recursos adequados estejam alocados para apoiar o sistema de qualidade.
Planeja e monitora o desempenho do sistema de gestão da qualidade e o cronograma de auditoria interna da qualidade.
Determina até que ponto as políticas de qualidade e os sistemas de qualidade atendem às necessidades organizacionais e os revisa se necessário.', 'Determines the quality strategy and secures commitment from executive leadership.
Develops policies for approval and adoption by organisational management. Ensures adequate technology, procedures and resources are in place to support the quality system.
Plans and monitors the performance of the quality management system and the internal quality audit schedule.
Determines the extent to which quality policies and quality systems meet organisational needs and reviews as necessary.'),
(15282, 2, 'Auxilia na configuração, sintonia e verificações funcionais de dispositivos e software de radiofrequência.
Resolve falhas até o nível de unidade substituível ou encaminha, de acordo com procedimentos fornecidos.
Realiza verificações de confiança do usuário e encaminha falhas de acordo com os procedimentos fornecidos.
Integra dispositivos de RF com aplicativos de software, usando configurações estáticas.', 'Assists with setting up, tuning and functional checks of radio frequency devices and software.
Resolves faults down to line replaceable unit level or escalates according to given procedures.
Carries out user confidence checks and escalates faults according to given procedures.
Integrates RF devices with software applications using static configurations.'),
(15282, 3, 'Implanta, configura, ajusta e calibra dispositivos e software de RF, seguindo cronogramas de manutenção e usando ferramentas e equipamentos de teste apropriados.
Incorpora modificações de hardware/firmware. Interpreta indicações automáticas de falha/desempenho e resolve falhas até o nível de componentes discretos ou escala, de acordo com procedimentos fornecidos.
Implementa protocolos de comunicação entre os elementos do sistema de acordo com padrões definidos.
Integra dispositivos de RF com aplicativos de software, incorporando reconfiguração dinâmica de elementos sob controle de software para otimizar seu desempenho operacional.', 'Deploys, sets up, tunes and calibrates RF devices and software following maintenance schedules and using appropriate tools and test equipment.
Incorporates hardware/firmware modifications. Interprets automatic fault/performance indications and resolves faults down to discrete component level or escalates according to given procedures.
Implements communication protocols between system elements in accordance with defined standards.
Integrates RF devices with software applications, incorporating dynamic reconfiguration of elements under software control to optimise their operational performance.'),
(15282, 4, 'Investiga e resolve condições de falha em todo o sistema, usando uma ampla variedade de ferramentas e técnicas de diagnóstico.
Reconfigura o equipamento para contornar interrupções temporárias. Especifica, seleciona e integra dispositivos de RF em um sistema.
Define protocolos de comunicação interna para transmissão nas frequências disponíveis.
Reconfigura dispositivos e softwares para otimizar o desempenho.', 'Investigates and resolves system-wide fault conditions using a wide range of diagnostic tools and techniques.
Reconfigures equipment to circumvent temporary outages. Specifies, selects and integrates RF devices in a system.
Defines internal communication protocols for transmission over the available frequencies.
Reconfigures devices and software to optimise performance.'),
(15282, 5, 'Monitora o desempenho do sistema, recomenda modificações de equipamentos e alterações nos procedimentos operacionais, métodos e cronogramas de manutenção.
Desenvolve cronogramas e procedimentos de manutenção. Aprova atualizações e modificações de equipamentos.
Analisa os padrões nacionais e da indústria sobre os protocolos e regulamentos de radiofrequência pertinentes.
Mede e avaliar a eficácia de dispositivos e softwares de RF.', 'Monitors system performance, recommends equipment modifications and changes to operating procedures, servicing methods and schedules.
Develops maintenance schedules and procedures. Approves equipment upgrades and modifications.
Reviews industry and national standards on relevant RF protocols and regulations.
Measures and evaluates the effectiveness of RF devices and software.'),
(15282, 6, 'Fornece direção e liderança gerais para o uso de dispositivos e softwares baseados em radiofrequência.
Especifica os requisitos de desempenho dos equipamentos de radiofrequência e define as respectivas políticas de manutenção.
Identifica oportunidades para explorar novas tecnologias e práticas e aperfeiçoar as existentes.
Desenvolve estratégias eficazes de implementação e compras.', 'Provides overall direction and leadership for the use of RF based devices and software.
Specifies requirements for radio frequency equipment performance and sets maintenance policy.
Identifies opportunities to exploit new technologies and improve existing technologies and practices.
Develops effective implementation and procurement strategies.'),
(1809, 2, 'Projeta, constrói e testa componentes simples em tempo real/integrados, como parte de um projeto geral de sistemas maiores.
Utiliza linguagens de programação apropriadas para acionar sensores e atuadores simples.
Aprende a usar ferramentas especializadas, como emuladores de circuito, analisadores lógicos e osciloscópios digitais.', 'Designs, builds and tests simple real-time/embedded components as part of an overall larger systems design.
Uses appropriate programming languages to drive simple sensors and actuators.
Applies specialised tools for real-time program analysis and system debugging.'),
(1809, 3, 'Projeta, constrói e integra componentes em tempo real/integrados de complexidade média, como parte de um projeto de sistemas geral maior.
Segue padrões acordados e usa ferramentas especializadas para análise e otimização de sistemas.
Utiliza hardware especializado, tipicamente sensores e atuadores, e otimiza o código do componente para desempenho real.
Aplica uma variedade de abordagens para a verificação e teste de componentes em tempo real.', 'Designs, builds and integrates medium-complexity real-time/embedded components as part of an overall larger systems design.
Follows agreed standards and uses specialised tools for system analysis and optimisation.
Drives specialist hardware, typically sensors and actuators, and optimises component code for performance.
Applies a range of approaches to the verification and testing of real-time components.'),
(1809, 4, 'Projeta, constrói e integra componentes e subsistemas complexos em tempo real/integrados.
Desenha layouts físicos que refletem a conexão entre os componentes do sistema para testar e otimizar o desempenho.
Constrói protótipos e simulações de sistema para auxiliar no desenvolvimento e permitir depuração, teste e solução de problemas de softwares integrados.
Aplica uma variedade de abordagens para validação, verificação e teste de componentes e subsistemas em tempo real, utilizando diversas ferramentas especializadas para análise e otimização de sistemas.', 'Designs, builds and integrates complex real-time/embedded components and sub-systems.
Designs physical layouts that reflect the connection between system components to test and optimise performance.
Builds system prototypes and simulations to aid development and enable debugging, testing and troubleshooting of embedded software.
Applies a range of approaches to the validation, verification, and testing of real-time components and sub-systems, using a variety of specialist tools for system analysis and optimisation.'),
(1809, 5, 'Projeta e desenvolve arquiteturas e sistemas em tempo real/integrados para atender aos requisitos de sistema acordados.
Planeja e gerencia o desenvolvimento de sistemas integrados/em tempo real complexos e seleciona as abordagens e técnicas a serem utilizadas.
Analisa as opções de design e compensações entre hardware e software, faz recomendações e avalia e gerencia os riscos associados. Garante que a validação, verificação e teste eficazes sejam realizados durante o desenvolvimento.
É responsável pela integração de vários subsistemas no sistema geral.', 'Designs and develops real-time/embedded architectures and systems to meet agreed system requirements.
Plans and manages the development of complex real-time/embedded systems and selects the approaches and techniques to be used.
Analyses design options and trade-offs between hardware and software, makes recommendations and assesses and manages associated risks. Ensures effective validation, verification and testing is undertaken throughout development.
Oversees the integration of multiple sub-systems into the overall system.'),
(1809, 6, 'Fornece orientação geral e liderança no desenvolvimento de sistemas integrados/em tempo real.
Desenvolve políticas, normas e diretrizes organizacionais para arquiteturas e designs de sistemas integrados/em tempo real.
Planeja e orienta desenvolvimentos de sistemas integrados/em tempo real estratégicos, grandes e complexos. Identifica oportunidades para explorar novas tecnologias e melhorar as tecnologias e práticas existentes.
Impulsiona a adesão a estratégias técnicas, arquiteturas de sistemas e a implementação de verificação, validação e testagem com base nos riscos. Desenvolve estratégias eficazes para implementação e aquisição.', 'Provides overall direction and leadership in the development of real-time/embedded systems.
Develops organisational policies, standards and guidelines for real-time/embedded systems architectures and designs.
Plans and leads strategic, large and complex real-time/embedded system developments. Identifies opportunities to exploit new technologies and improve existing technologies and practices.
Drives adherence to technical strategies, systems architectures and the implementation of risk-based verification, validation and testing. Develops effective implementation and procurement strategies.'),
(983, 1, 'Segue orientações detalhadas para confirmar o recebimento de registros, incluindo a captura de metadados essenciais.
Entrega registros digitais e físicos de acordo com procedimentos acordados.', 'Follows detailed guidance to acknowledge receipt of records, including the capture of essential metadata.
Delivers digital and physical records in line with agreed procedures.'),
(983, 2, 'Auxilia na coleta, entrega e retenção de registros.
Identifica e aplica metadados apropriados.
Utiliza métodos estabelecidos para transformar registros entre formatos ou meios, seguindo políticas e procedimentos organizacionais. Identifica e reporta riscos potenciais ou problemas relacionados ao manuseio de informações e segurança.
Executa tarefas administrativas para manter a acessibilidade, a recuperabilidade, a integridade, a segurança e a proteção de registros.', 'Assists in the collection, delivery and retention of records.
Identifies and applies appropriate metadata.
Uses established methods to transform records between formats or media, following organisational policies and procedures. Identifies and reports potential risks or issues related to information handling and security.
Performs administrative tasks to maintain accessibility, retrievability, integrity, security and protection of records.'),
(983, 3, 'Mantém metadados-chave para registros, incluindo informações de propriedade e categorias.
Configura controles rotineiros para restringir operações de registro apenas para ações aprovadas. Realiza pesquisas rotineiras para apoiar solicitações autorizadas. Apoia os usuários na localização e acesso a registros.
Utiliza métodos éticos e confiáveis para transformar dados entre formatos ou mídias, seguindo políticas organizacionais e conscientes de potenciais problemas ao lidar com informações.
Transforma dados entre formatos ou mídias usando métodos éticos e confiáveis. Segue as políticas organizacionais e identifica ativamente riscos potenciais no tratamento de informações.', 'Maintains key metadata for records, including ownership and category information.
Configures routine controls to restrict record operations to approved actions only. Conducts routine searches for records required to support authorised requests. Supports users in finding and accessing records.
Uses ethical and reliable methods to transform data between formats or media, following organisational policies and being aware of potential issues when handling information.
Transforms data between formats or media using ethical and reliable methods. Follows organisational policies and actively identifies potential risks in information handling.'),
(983, 4, 'Suporta a implementação de políticas e práticas de gerenciamento de registros, incluindo o descarte aprovado de registros.
Realiza pesquisas complexas ou sensíveis em registros para atender a solicitações autorizadas.
Monitora emite relatórios sobre a implementação de controles eficazes para gerenciamento de registros, incluindo controles de metadados e acesso. Recomenda ações de correção conforme necessário.
Fornece aconselhamento e orientação para permitir que práticas adequadas de gerenciamento de registros sejam adotadas em toda a organização.', 'Supports the implementation of records management policies and practices including the approved disposal of records.
Conducts complex or sensitive searches for records to address authorised requests.
Monitors and reports on the implementation of effective controls for records management including metadata and access controls. Recommends remediation actions as required.
Provides advice and guidance to enable appropriate records management practices to be adopted across the organisation.'),
(983, 5, 'Assegura a implementação de políticas de gerenciamento de registros que abranjam todos os aspectos de retenção e descarte.
Gerencia controles de acesso de registros, incluindo autorização de acesso e aprovação da divulgação de informações potencialmente confidenciais. Realiza e supervisiona pesquisas complexas de registros, procurando orientação jurídica quando necessário.
Revisa novas propostas de alteração e fornece aconselhamento especializado sobre gerenciamento de registros. Avalia e gerencia riscos relacionados a registros.
Contribui para o desenvolvimento de políticas, padrões e procedimentos para o cumprimento da legislação relacionada a registros.', 'Ensures implementation of records management policies covering all aspects of retention and disposal.
Manages access controls for records, including authorising access and approving the release of potentially sensitive information. Conducts and oversees complex record searches, seeking legal guidance when necessary.
Reviews new change proposals and provides specialist advice on records management. Assesses and manages records-related risks.
Contributes to the development of policy, standards and procedures for compliance with records-related legislation.'),
(15283, 2, 'Ajuda com tarefas de gerenciamento de lançamentos sob supervisão rotineira.
Apoia a coleta de dados e informações para planejamento e agendamento de lançamentos.
Ajuda na preparação de materiais e recursos de lançamentos. Ajuda a documentar e manter registros de atividades de lançamentos.
Participa em tarefas básicas de teste e garantia de qualidade e resolução de problemas.', 'Assists with release management tasks under routine supervision.
Supports the collection of data and information for release planning and scheduling.
Assists in the preparation of release materials and resources. Helps document and maintain records of release activities.
Participates in basic testing and quality assurance tasks and issue resolution.'),
(15283, 3, 'Apoia o planejamento e agendamento de lançamentos.
Coordena atividades de lançamentos com equipes relevantes. Siga processos e procedimentos de lançamentos definidos.
Participa em atividades de teste e garantia de qualidade para garantir que os lançamentos atendam aos padrões. Identifica e resolve problemas relacionados com o processo de lançamento.
Documenta e relata os resultados de lançamentos e comunica as conclusões aos stakeholders.', 'Supports the planning and scheduling of releases.
Coordinates release activities with relevant teams. Follows defined release processes and procedures.
Participates in testing and quality assurance activities to ensure releases meet standards. Identifies and resolves issues related to the release process.
Documents and reports on release outcomes and communicates findings to stakeholders.'),
(15283, 4, 'Planeja e programa as publicações de acordo com os requisitos e objetivos de negócios.
Coordena as atividades de publicação em várias equipes e partes interessadas. Gerencia o ciclo de vida da publicação, garantindo entrega atempada e de qualidade.
Assegura que as publicações atendam aos padrões de qualidade, segurança e conformidade definidos.
Comunica os planos de publicação, os progressos e os resultados às partes interessadas. Realiza revisões pós-publicação e identifica áreas para melhoria.', 'Plans and schedules releases in line with business requirements and objectives.
Coordinates release activities across multiple teams and stakeholders. Manages the release lifecycle, ensuring timely and quality deliverables.
Ensures releases meet defined quality, security and compliance standards.
Communicates release plans, progress and outcomes to stakeholders. Conducts post-release reviews and identifies areas for improvement.'),
(15283, 5, 'Desenvolve e mantém abordagens de lançamento, processos e ferramentas de automação.
Supervisiona o planejamento e o agendamento de lançamentos complexos e em grande escala. Coordena atividades de lançamento em vários projetos e programas.
Assegura que os processos e procedimentos de lançamento sejam aplicados e que os lançamentos possam ser revertidos conforme necessário.
Comunica abordagens e resultados de lançamento. Realiza análises pós-lançamento e impulsiona melhorias contínuas.', 'Develops and maintains release approaches, processes and automation tools.
Oversees the planning and scheduling of complex, large-scale releases. Coordinates release activities across multiple projects and programmes.
Ensures release processes and procedures are applied and that releases can be rolled back as needed.
Communicates release approaches and outcomes. Conducts post-release analysis and drives continuous improvement.'),
(15283, 6, 'Define estratégias, políticas e padrões de gerenciamento de lançamentos organizacionais.
Alinha a gestão de lançamentos com estratégias e objetivos de negócios globais. Assegura a disponibilidade de recursos e ferramentas para gerenciamento de lançamentos eficaz.
Comunica estratégias e resultados de lançamentos para as partes interessadas.
Impele a adoção de novas técnicas e tecnologias de gerenciamento de lançamentos.', 'Defines organisational release management strategies, policies and standards.
Aligns release management with overall business strategies and objectives. Ensures the availability of resources and tools for effective release management.
Communicates release strategies and outcomes to stakeholders.
Drives the adoption of new release management techniques and technologies.'),
(15284, 2, 'Usa técnicas padrão para obter, especificar e documentar requisitos para áreas de assunto simples, com limites claramente definidos.
Auxilia na definição e gerenciamento de requisitos.
Auxilia na criação de uma linha de base de requisitos/pendências.
Auxilia na investigação e aplicação de alterações nos requisitos.', 'Uses standard techniques to elicit, specify and document requirements for simple subject areas with clearly-defined boundaries.
Assists in the definition and management of requirements.
Assists in the creation of a requirements baseline/backlog.
Assists in investigating and applying changes to requirements.'),
(15284, 3, 'Define e gerencia o escopo, definição de requisitos e atividades de priorização para mudanças em pequena escala e auxilia em iniciativas de mudança mais complexas.
Segue os padrões acordados, aplicando técnicas apropriadas para obter e documentar requisitos detalhados. Fornece um desafio construtivo para as partes interessadas, conforme necessário. Revisa os requisitos quanto a erros e omissões.
Prioriza requisitos e documenta a rastreabilidade até a origem.
Fornece contribuições para a linha de base/backlog de requisitos. Investiga, gerencia e aplica solicitações de alterações nos requisitos, em conformidade com a política de gerenciamento de mudanças.', 'Defines and manages scoping, requirements definition and prioritisation activities for small-scale changes and assists with more complex change initiatives.
Follows agreed standards and applies appropriate techniques to elicit and document detailed requirements. Provides constructive challenge to stakeholders as required. Reviews requirements for errors and omissions.
Prioritises requirements and documents traceability to source.
Provides input to the requirements baseline/backlog. Investigates, manages and applies requests for changes to requirements, in line with change management policy.'),
(15284, 4, 'Define e gerencia atividades de escopo, definição de requisitos e priorização para iniciativas de porte e complexidade médios.
Contribui na seleção da abordagem dos requisitos.
Facilita a contribuição das partes interessadas, oferece desafios construtivos e possibilita a priorização eficaz dos requisitos.
Estabelece linhas de base de requisitos ou backlogs, obtém acordo apropriado para requisitos e garante rastreabilidade até a origem.', 'Defines and manages scoping, requirements definition and prioritisation activities for initiatives of medium size and complexity.
Contributes to selecting the requirements approach.
Facilitates input from stakeholders, provides constructive challenge and enables effective prioritisation of requirements.
Establishes requirements baselines or backlogs, obtains appropriate agreement to requirements and ensures traceability to source.'),
(15284, 5, 'Planeja e conduz o escopo, a definição de requisitos e as atividades de priorização para iniciativas grandes e complexas.
Seleciona, adota e adapta a definição e os métodos, ferramentas e técnicas de gerenciamento apropriados dos requisitos. Contribui para o desenvolvimento de métodos e padrões organizacionais para o gerenciamento de requisitos.
Obtém informações e acordos com os requisitos de uma gama diversificada de partes interessadas. Negocia com as partes interessadas para gerenciar prioridades e conflitos concorrentes.
Estabelece linhas de base de requisitos ou backlogs. Garante que as mudanças nos requisitos sejam investigadas e gerenciadas.', 'Plans and drives scoping, requirements definition and prioritisation activities for large, complex initiatives.
Selects, adopts and adapts appropriate requirements definition and management methods, tools and techniques. Contributes to the development of organisational methods and standards for requirements management.
Obtains input and agreement to requirements from a diverse range of stakeholders. Negotiates with stakeholders to manage competing priorities and conflicts.
Establishes requirements baselines or backlogs. Ensures changes to requirements are investigated and managed.'),
(15284, 6, 'Defende a importância e o valor dos princípios de gerenciamento de requisitos e a seleção de modelos de ciclo de vida de gerenciamento de requisitos apropriados.
Desenvolve políticas organizacionais, normas e diretrizes para definição e gerenciamento de requisitos.
Planeja e lidera o escopo, a definição de requisitos e a definição de prioridades para programas complexos e estratégicos.
Impulsiona a adoção e a adesão a políticas e padrões. Desenvolve novos métodos e capacidades organizacionais para o gerenciamento de requisitos.', 'Champions the importance and value of requirements management principles and selecting effective requirements management lifecycle models.
Develops organisational policies, standards and guidelines for requirements definition and management.
Plans and leads scoping, requirements definition and priority setting for complex, strategic programmes.
Drives adoption of, and adherence to, policies and standards. Develops new methods and organisational capabilities for requirements management.'),
(4958, 2, 'Auxilia em tarefas de recrutamento e seleção sob supervisão rotineira.
Auxilia no recrutamento e incorporação de novos colaboradores.
Apoia a documentação e rastreamento de atividades de recrutamento e seleção.', 'Assists with resourcing tasks under routine supervision.
Helps with recruiting and onboarding new employees.
Supports the documentation and tracking of resourcing activities.'),
(4958, 3, 'Apoia os gerentes e as equipes nas atividades de recrutamento e seleção.
Utiliza soluções recomendadas para planejamento, programação e rastreamento de atividades de recrutamento.
Fornece orientação sobre gerenciamento de recursos e softwares de recrutamento, procedimentos, processos, ferramentas e técnicas.', 'Supports managers and teams in resourcing and recruitment activities.
Uses recommended tools for planning, scheduling and tracking resourcing activity.
Provides guidance on resource management and recruitment software, procedures, processes, tools and techniques.'),
(4958, 4, 'Facilita e apoia a execução de atividades de recrutamento e seleção em colaboração com gestores e equipes.
Analisa solicitações de recursos para determinar tarefas, habilidades e esforços necessários. Disponibiliza e comunica posições de trabalho em aberto, interna e externamente.
Conduz entrevistas e avaliações em formato e estrutura planejados.
Implementa a alocação de recursos de acordo com as necessidades das atividades. Contribui para a transição de recursos, cumprindo regulações externas relevantes e códigos de prática.', 'Facilitates and supports the execution of resourcing activities in collaboration with managers and teams.
Analyses resource requests to determine tasks, skills and effort required. Creates and communicates open positions internally and externally.
Conducts interviews and assessments using a planned format and structure.
Implements internal resource allocation matching skills to tasks. Contributes to transitioning of resources, complying with relevant statutory or external regulations and codes of practice.'),
(4958, 5, 'Planeja e gerencia a aquisição e implantação de recursos, para atender necessidades específicas e demandas contínuas.
Define e gerencia a implantação de ferramentas e processos de recursos. Informa sobre as opções disponíveis e personaliza a abordagem de recursos para atender aos requisitos. Cumpre as normas, regulamentações e códigos de prática, garantindo a conformidade.
Engaja-se com partes externas para apoiar os planos de recursos.
Mede a eficácia dos processos de recursos e implementa melhorias.', 'Plans and manages the acquisition and deployment of resources to meet specific needs and ongoing demand.
Defines and manages the implementation of resourcing processes and tools. Advises on available options and customises resourcing approach to meet requirements. Adheres to standards, statutory or external regulations and codes of practice and ensures compliance.
Engages with external parties in support of resourcing plans.
Measures effectiveness of resourcing processes and implements improvements.'),
(4958, 6, 'Define a abordagem do planejamento dos recursos para uma parte significativa da organização, em linha com os planos de força de trabalho e objetivos estratégicos do negócio.
Comunica a abordagem de planejamento de recursos e obtém o compromisso organizacional. Informa sobre padrões, regulamentações e códigos de prática, garantindo a conformidade.
Mantém uma forte rede externa e uma estrutura de fornecedores para oferecer apoio aos recursos de recrutamento e seleção.
Orienta o desenvolvimento de planos e do orçamento para garantir que a organização possuam os recursos com as habilidades adequadas para cumprir os objetivos e compromissos organizacionais. Analisa continuamente a eficácia e o sucesso dos processos de gestão de recursos.', 'Defines resourcing approach for a significant part of the organisation in line with workforce plans and strategic business goals.
Communicates resourcing approach and obtains organisational commitment. Advises on standards, regulations and codes of practice and ensures compliance.
Maintains a strong external network and supplier framework to support sourcing and acquiring resources.
Leads development of plans and budget to ensure the organisation has appropriately skilled resources to meet organisational objectives and commitments. Reviews the ongoing success and effectiveness of resource management processes.'),
(6113, 2, 'Ajuda na coleta e no relatório de dados para apoiar atividades de gerenciamento de riscos sob supervisão rotineira.
Ajuda a criar e manter documentação de riscos e atividades de gerenciamento de riscos.
Ajuda a identificar e relatar problemas e discrepâncias.', 'Assists in collecting and reporting data to support risk management activities under routine supervision.
Helps create and maintain documentation of risks and risk management activities.
Helps identify and report issues and discrepancies.'),
(6113, 3, 'Realiza atividades básicas de gerenciamento de risco.
Mantém documentação de riscos, ameaças, vulnerabilidades e ações de mitigação.', 'Undertakes basic risk management activities.
Maintains documentation of risks, threats, vulnerabilities and mitigation actions.'),
(6113, 4, 'Exerce atividades de gerenciamento de riscos dentro de uma função específica, área técnica ou projeto de complexidade média.
Identifica riscos e vulnerabilidades, avalia o seu impacto e probabilidade, desenvolve estratégias de mitigação e relatórios sobre o negócio.
Envolve especialistas de forma geral e especialistas de domínio na área, conforme necessário.', 'Carries out risk management activities within a specific function, technical area or project of medium complexity.
Identifies risks and vulnerabilities, assesses their impact and probability, develops mitigation strategies and reports to the business.
Involves specialists and domain experts as necessary.'),
(6113, 5, 'Planeja e implementa atividades de gerenciamento de risco complexas e substanciais dentro de uma função, área técnica, projeto ou programa específico.
Implementa processos de gerenciamento de risco consistentes e confiáveis e relatórios para as principais partes interessadas.
Envolve especialistas de domínio conforme necessário.
Aconselha sobre a abordagem da organização para a gestão de riscos.', 'Plans and implements complex and substantial risk management activities within a specific function, technical area, project or programme.
Establishes consistent risk management processes and reporting mechanisms aligned with governance frameworks.
Engages specialists and domain experts as necessary.
Advises on the organisation''s approach to risk management.'),
(6113, 6, 'Planeja e gerencia a implementação de processos de gerenciamento de risco em toda a organização, integrando ferramentas e técnicas alinhadas com quadros de governança.
Considera atividades de risco e mitigação em toda a organização no contexto do risco empresarial como um todo e apetite de risco da organização.
Fornece liderança na gestão de risco, garantindo que as práticas apoiem a tomada de decisões estratégicas e o cumprimento das políticas organizacionais.', 'Plans and manages the implementation of organisation-wide risk management processes, integrating tools and techniques aligned with governance frameworks.
Considers organisation-wide risk and mitigation activities within the context of business risk as a whole and the organisation’s appetite for risk.
Provides leadership on risk management, ensuring practices support strategic decision-making and compliance with organisational policies.'),
(6113, 7, 'Estabelece a estratégia de gestão de risco da organização, definindo e comunicando o apetite de risco de acordo com a governança e objetivos estratégicos.
Define e comunica o apetite da organização para o risco.
Fornece recursos para implementar a estratégia de risco da organização.
Delega autoridade para planejamento detalhado e execução de atividades de gestão de risco em toda a organização.', 'Establishes the organisation''s risk management strategy, defining and communicating the risk appetite in alignment with governance and strategic objectives.
Defines and communicates the organisation''s appetite for risk.
Provides resources to implement the organisation''s risk strategy.
Delegates authority for detailed planning and execution of risk management activities across the organisation.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(15285, 4, 'Coleta evidências de garantia de segurança, usando métodos e ferramentas apropriadas.
Realiza todo o trabalho de acordo com padrões de segurança, técnicos e de qualidade pré-estabelecidos.', 'Collects safety assurance evidence using appropriate methods and tools.
Undertakes all work in accordance with agreed safety, technical and quality standards.'),
(15285, 5, 'Realiza análises de segurança usando técnicas pré-estabelecidas, para verificar ou validar se os requisitos de segurança são implementados.
Participa de avaliações de segurança do sistema.
Cria relatórios de avaliação de segurança, recomendando e definindo como os requisitos de segurança do sistema podem ser atendidos.', 'Undertakes safety analyses using agreed techniques to verify or validate that safety requirements are implemented.
Participates in system safety assessments.
Creates safety assessment reports and recommends and defines how a system''s safety requirements can be satisfied.'),
(15285, 6, 'Defende e promove práticas de segurança na organização.
Conduz avaliações de segurança de acordo com as políticas e normas organizacionais de segurança.
Define e implementa políticas e normas organizacionais para avaliação de segurança do sistema.
Garante a conformidade com as normas e políticas definidas e supervisiona as atividades gerais de avaliação do ciclo de vida de segurança.', 'Champions and promotes safety practices in the organisation.
Leads safety assessments according to organisational safety policies and standards.
Defines and implements organisational policies and standards for system safety assessment.
Assures compliance with defined standards and policies and oversees overall safety lifecycle assessment activities.'),
(3913, 2, 'Assiste com tarefas de engenharia de segurança sob supervisão de rotina.
Apoia a documentação das atividades de análise de perigos e riscos.
Ajuda a coletar provas de garantia de segurança usando métodos e procedimentos acordados.', 'Assists with safety engineering tasks under routine supervision.
Supports the documentation of hazard and risk analysis activities.
Helps collect safety assurance evidence using agreed methods and procedures.'),
(3913, 3, 'Auxilia na análise de ameaças e riscos durante o desenvolvimento e implementação do sistema, usando métodos e procedimentos acordados.
Documenta os resultados das atividades de análise de ameaças e riscos.
Auxilia na coleta de evidências de garantia de segurança, usando métodos e ferramentas apropriados.
Executa todas as atividades de acordo com os padrões de segurança, técnicos e de qualidade acordados.', 'Contributes to hazard and risk analysis during system development and implementation using agreed methods and procedures.
Documents the results of hazard and risk analysis activities.
Contributes to the collection of safety assurance evidence using appropriate methods and tools.
Undertakes all work in accordance with agreed safety, technical and quality standards.'),
(3913, 4, 'Contribui para a identificação, análise e documentação de ameaças e riscos de segurança, usando métodos e procedimentos acordados.
Contribui para a especificação de requisitos de segurança.
Analisa e documenta os resultados da validação de segurança durante o desenvolvimento e implementação do sistema.
Contribui para o desenvolvimento e manutenção dos planos de garantia de segurança do projeto. Reúne evidências de garantia de segurança para a preparação de casos de segurança.', 'Contributes to identifying, analysing and documenting hazards and safety risks using agreed methods and procedures.
Contributes to the specification of safety requirements.
Analyses and documents safety validation results during system development and implementation.
Contributes to developing and maintaining project safety assurance plans. Gathers safety assurance evidence for safety case preparation.'),
(3913, 5, 'Identifica e analisa as ameaças e contribui para a identificação e avaliação das medidas de redução dos riscos, assegurando a sua adequada documentação.
Especifica arquiteturas de sistemas relacionadas à segurança para níveis de segurança definidos.
Desenvolve e mantém planos de garantia de segurança de projeto. Monitora a implementação e a conformidade. Garante que as evidências de garantia de segurança sejam coletadas para a preparação do caso de segurança.
Trabalha com arquitetos de sistemas, designers e desenvolvedores, para garantir a implementação dos requisitos de segurança.', 'Identifies and analyses hazards and contributes to identifying and evaluating risk reduction measures, ensuring these are adequately documented.
Specifies safety-related systems architectures for defined safety levels.
Develops and maintains project safety assurance plans. Monitors implementation and compliance. Ensures safety assurance evidence is gathered for safety case preparation.
Works with system architects, designers and developers to assure safety requirements implementation.'),
(3913, 6, 'Assume total responsabilidade pela análise de ameaças e avaliação de riscos, projeto arquitetônico de sistema relacionado à segurança e planejamento de conformidade de segurança.
Orienta a definição e alocação de requisitos de segurança para o sistema, de acordo com a natureza do sistema e os níveis de segurança exigidos.
Assume a responsabilidade pelos aspectos relacionados à segurança em vários projetos complexos ou de alto nível de integridade de segurança.', 'Takes full responsibility for hazard analysis and risk evaluation, safety-related systems architectural design and safety compliance planning.
Leads the definition and allocation of safety requirements for the system, according to the system''s nature and required safety level.
Takes responsibility for the safety-related aspects of multiple complex or high safety integrity level projects.'),
(15286, 1, 'Comunica-se de forma eficaz com os clientes para fornecer informações básicas sobre produtos e serviços.
Recorre aos colegas para a resolução de dúvidas e reclamações mais complexas sobre o atendimento ao cliente.
Utiliza sistemas de suporte às vendas para recuperar e inserir dados.', 'Communicates effectively with customers to provide basic information about products and services.
Seeks assistance from colleagues for the resolution of more complex customer service queries and complaints.
Uses sales support systems to retrieve and enter data.'),
(15286, 2, 'Comunica-se de forma eficaz com os clientes por telefone e pessoalmente.
Auxilia na prestação de serviços ao cliente, incluindo aconselhamento técnico e orientações sobre o uso bem-sucedido de produtos e serviços.
Auxilia na criação de soluções para os requisitos dos clientes e resolve problemas simples.', 'Communicates effectively with customers by telephone and in person.
Assists in providing customer service, including technical advice and guidance on the successful use of products and services.
Assists in devising solutions to customer requirements and solves straightforward problems.'),
(15286, 3, 'Auxilia os clientes a esclarecer seus requisitos e documenta as conclusões alcançadas.
Contribui para a preparação e suporte de cotações e propostas de venda.
Fornece atendimento ao cliente, incluindo aconselhamento técnico e orientação sobre o uso bem-sucedido de produtos e serviços complexos.', 'Helps customers to clarify their requirements and documents the conclusions reached.
Contributes to preparing and supporting bids and sales proposals.
Provides customer service, including technical advice and guidance on the successful use of complex products and services.'),
(15286, 4, 'Trabalha em estreita colaboração com a equipe de vendas para ajudar os clientes em potencial a esclarecer suas necessidades e requisitos.
Concebe soluções e avalia sua viabilidade e praticidade.
Demonstra viabilidade técnica, usando modelos físicos ou de simulação. Resolve problemas técnicos.
Produz estimativas de custo e risco e planos de projeto iniciais para formular propostas de venda.', 'Works closely with the sales team to help prospects to clarify their requirements.
Devises solutions and assesses their feasibility and practicality.
Demonstrates technical feasibility using physical or simulation models. Resolves technical problems.
Produces estimates of cost and risk and initial project plans to inform sales proposals.'),
(15286, 5, 'Trabalha em estreita colaboração com a equipe de vendas para garantir que os clientes sejam atendidos e aconselhados adequadamente.
Garante sejam elaborados planos de projeto e estimativas confiáveis ​​de custos, esforço e risco.
Gerencia todas as atividades de suporte de vendas, assumindo total responsabilidade pelo conteúdo técnico de cotações e propostas de vendas.
Estabelece métricas para fornecer dados sobre o desempenho e ajudar na melhoria contínua das atividades de suporte de vendas.', 'Works closely with the sales team to ensure customers are assisted and advised appropriately.
Ensures reliable cost, effort and risk estimates and project plans are produced.
Manages all sales support activities, taking full responsibility for the technical content of bids and sales proposals.
Establishes metrics to provide data on performance and support continual improvement of sales support activities.'),
(15286, 6, 'Lidera as atividades de atendimento ao cliente da organização para garantir que estejam alinhadas com os objetivos e políticas corporativas.
Aprova propostas e inicia a implementação da atividade de desenvolvimento em sistemas e serviços ao cliente.', 'Leads the organisation''s sales-related customer service activities to ensure they are aligned with corporate objectives and policy.
Approves proposals and initiates the implementation of development activity in customer services and systems.'),
(11053, 4, 'Analisa um problema do mundo real e, em seguida, seleciona modelos físicos e matemáticos apropriados para aproximar os fenômenos em investigação.
Aplica técnicas matemáticas relevantes para simular o problema.
Realiza avaliações de qualidade e desempenho nos resultados do modelo e efetua melhorias nos modelos.
Fornece conselhos e orientações para aqueles que usam esses modelos.', 'Analyses the real-world problem, then selects appropriate physical and mathematical models to approximate the phenomena under investigation.
Applies relevant mathematical techniques to simulate the problem.
Conducts quality and performance assessments on computational model outputs and makes improvements to the models.
Provides advice and guidance to the users of these models.'),
(11053, 5, 'Investiga problemas do mundo real para avaliar se os modelos científicos existentes fornecem soluções eficazes.
Cria novas representações matemáticas de fundamentos da ciência que podem ser implementadas em um modelo computacional. Aplica técnicas avançadas de programação para implementar modelos científicos e aplicá-los na resolução de problemas.
Analisa o funcionamento dos modelos existentes para melhorar a precisão e o desempenho.
Comunica limitações como incertezas e erros sistemáticos. Garante o uso adequado dos modelos computacionais.', 'Investigates real-world problems to assess whether existing scientific models provide effective solutions.
Creates new mathematical representations of the underlying science that can be implemented in a computational model. Applies advanced programming techniques to implement scientific models and apply these for problem-solving.
Analyses the functioning of existing computational models to improve accuracy and performance.
Communicates limitations such as uncertainty and systematic errors. Ensures appropriate usage of computational models.'),
(11053, 6, 'Inicia a criação, teste, melhoria e aplicação de estruturas de modelos matemáticos que representam sistemas do mundo real e teorias científicas.
Define padrões e abordagens para a aplicação de modelagem científica.
Supervisiona a representação de princípios e teorias de ciência e matemática em modelos para garantir o uso apropriado, consistente e eficaz.
Desenvolve ou introduz novas técnicas matemáticas quando necessário.', 'Initiates the creation, testing, improvement and application of mathematical model frameworks representing real-world systems and scientific theories.
Sets standards and approaches for the application of scientific modelling.
Oversees the representation of science and mathematics principles and theories in models to ensure appropriate, consistent and effective usage.
Develops or introduces new mathematical techniques where necessary.'),
(11053, 7, 'Dirige a criação e a revisão de uma abordagem e cultura multifuncional em toda a empresa para modelagem científica.
Lidera o desenvolvimento das capacidades de modelagem científica da organização e defende seu uso na solução de problemas do mundo real.', 'Directs the creation and review of a cross-functional, enterprise-wide approach and culture for scientific modelling.
Leads the development of the organisation’s scientific modelling capabilities and champions its use in solving real-world problems.'),
(14904, 1, 'Realiza tarefas simples de administração de segurança.
Mantém registros e documentação relevantes, contribuindo com a integridade global dos dados.', 'Performs simple security administration tasks.
Maintains relevant records and documentation, contributing to overall data integrity.'),
(14904, 2, 'Recebe e responde às solicitações rotineiras de suporte de segurança.
Mantém registros e comunica eficazmente as ações tomadas.
Auxilia na investigação e resolução de problemas relacionados com sistemas de segurança usando ferramentas e técnicas básicas de diagnóstico.
Documenta informações de incidentes e eventos e gera relatórios sobre exceções e eventos de segurança. Contribui para os processos de relatórios de gerenciamento.', 'Receives and responds to routine requests for security support.
Maintains records and effectively communicates actions taken.
Assists in the investigation and resolution of issues relating to security systems using basic diagnostic tools and techniques.
Documents incident and event information and generates reports on exceptions and security events. Contributes to management reporting processes.'),
(14904, 3, 'Investiga falhas menores de segurança utilizando procedimentos estabelecidos, incorporando ferramentas e técnicas analíticas.
Executa tarefas de segurança operacional não padrão que se adaptam a tecnologias em evolução e cenários de ameaças.
Endereça e resolve uma variedade de eventos de segurança para manter a integridade dos sistemas e a continuidade operacional.', 'Investigates minor security breaches using established procedures, incorporating analytical tools and techniques.
Performs non-standard operational security tasks adapting to evolving technologies and threat landscapes.
Addresses and resolves a variety of security events to maintain system integrity and operational continuity.'),
(14904, 4, 'Mantém e otimiza os processos de segurança operacional.
Verifica se todas as solicitações de suporte são tratadas de acordo com protocolos estabelecidos, incluindo sistemas baseados em nuvem e sistemas automatizados. Fornece aconselhamento sobre a implementação e gestão de segurança física, processual e técnica englobando ativos físicos e digitais.
Investiga violações de segurança de acordo com procedimentos estabelecidos usando ferramentas e técnicas avançadas e recomenda ações corretivas necessárias.
Possibilita a implementação eficaz de medidas de segurança recomendadas e monitora seu desempenho.', 'Maintains and optimises operational security processes.
Checks that all requests for support are dealt with according to established protocols, including for cloud-based and automated systems. Provides advice on implementing and managing physical, procedural and technical security encompassing both physical and digital assets.
Investigates security breaches in accordance with established procedures using advanced tools and techniques and recommends necessary corrective actions.
Enables effective implementation of recommended security measures and monitors their performance.'),
(14904, 5, 'Supervisiona os procedimentos de operações de segurança, garantindo a adesão e a eficácia, incluindo práticas de segurança em nuvem e respostas automatizadas às ameaças.
Revisa as violações e vulnerabilidades de segurança reais ou potenciais e assegura que sejam investigadas prontamente e minuciosamente. Recomenda ações e melhorias de controle apropriadas.
Assegura a integridade e a completude dos registros de segurança, garantindo o apoio e a adesão oportunas aos procedimentos estabelecidos.
Contribui para a criação e manutenção de políticas de segurança, padrões e procedimentos que integram novos requisitos de conformidade e avanços tecnológicos.', 'Oversees security operations procedures, ensuring adherence and effectiveness, including cloud security practices and automated threat responses.
Reviews actual or potential security breaches and vulnerabilities and ensures they are promptly and thoroughly investigated. Recommends actions and appropriate control improvements.
Ensures the integrity and completeness of security records, ensuring timely support and adherence to established procedures.
Contributes to the creation and maintenance of security policies, standards and procedures integrating new compliance requirements and technology advances.'),
(14904, 6, 'Desenvolve políticas, padrões, processos e diretrizes abrangentes para a segurança organizacional em todo o cenário digital.
Assegura a relevância contínua e implementação eficaz de políticas e padrões de segurança, adaptando-se às tecnologias e ameaças emergentes.
Revisa e fornece aconselhamento sobre aspectos de segurança de novas iniciativas de negócios considerando as implicações no cenário digital em evolução.
Lidera o planejamento estratégico para operações de segurança, integrando inteligência avançada de ameaças e automação para melhorar a resiliência organizacional.', 'Develops comprehensive policies, standards, processes and guidelines for organisational security across the entire digital landscape.
Ensures the ongoing relevance and effective implementation of security policies and standards, adapting to emerging technologies and threats.
Reviews and advises on security aspects of new business initiatives considering implications in the evolving digital landscape.
Leads strategic planning for security operations, integrating advanced threat intelligence and automation to enhance organisational resilience.'),
(790, 3, 'Identifica novos leads e clientes em potencial e os comunica ao gerente de vendas.
Responde aos leads de vendas atribuídos. Auxilia na manutenção de relacionamentos com clientes existentes e identifica oportunidades potenciais para vendas ou serviços adicionais.
Aplica padrões e ferramentas acordados para executar tarefas de vendas simples ou dar suporte a processos de vendas complexos.
Monitora e reporta cotas de vendas atribuídas, desempenho, satisfação do cliente, inteligência de mercado e concorrentes.', 'Identifies new leads and prospects and communicates them to the sales manager.
Responds to assigned sales leads. Assists in maintaining relationships with existing customers and identifies potential opportunities for additional sales or services.
Applies agreed standards and tools to perform simple sales tasks or support complex sales processes.
Monitors and reports on assigned sales quota, performance, customer satisfaction, market intelligence and competitors.'),
(790, 4, 'Identifica e qualifica novos leads de vendas e clientes potenciais com o objetivo de desenvolver um pipeline de oportunidades em potencial.
Gerencia leads de vendas existentes.
Compreende e utiliza informações para atingir os objetivos de vendas.
Compreende o cliente e suas necessidades, desenvolve e melhora o relacionamento, antes, durante e após a conclusão de acordos/contratos. Identifica oportunidades de upselling e cross-selling na base de clientes existente.', 'Identifies and qualifies new sales leads and prospects with a view to developing a pipeline of potential opportunities.
Manages existing sales leads.
Collects and uses information to achieve sales objectives.
Understands customers and their needs, and develops and enhances customer relationships before, during and after the conclusion of agreements/contracts. Identifies opportunities for upselling and cross-selling within the existing customer base.'),
(790, 5, 'Desenha e implementa estratégias de vendas e trabalha com a alta gestão para implementar planos de vendas.
Desenvolve e mantém relações efetivas com clientes a nível executivo e qualifica novos leads de vendas. Colabora com equipes de cotações e propostas para alinhar estratégias de vendas.
Negocia e assina contratos. Mantém contato com clientes durante e após as vendas para prevenir problemas e identificar oportunidades. Desenvolve estratégias para crescimento e retenção de contas. Implementa iniciativas para garantir valor e fidelidade a longo prazo.
Planeja, monitora e controla equipes de vendas. Contribui para o desenvolvimento de equipes de vendas e desenvolvimento de produto/serviço.', 'Designs and implements sales strategies and works with senior management to implement sales plans.
Develops and maintains effective customer relationships at executive levels and qualifies new sales leads. Collaborates with bid teams to align sales strategies.
Agrees and signs contracts. Maintains customer contact during and after sales to pre-empt issues and identify opportunities. Develops strategies for account growth and retention. Implements initiatives to ensure long-term value and loyalty.
Plans, monitors and controls sales teams. Contributes to the development of sales teams and product/service development.'),
(790, 6, 'Supervisiona as atividades de vendas da organização para se alinhar aos objetivos de negócio.
Aprova propostas e metas de vendas. Desenvolve políticas e estratégias de vendas e contribui para a estratégia de marketing. Trabalha com a gestão de ofertas para garantir que as estratégias de vendas sejam representadas efetivamente nas principais propostas.
Negocia questões técnicas e contratuais com representantes sênior de clientes. Negocia e assina contratos.
Colabora em serviços, produtos, sistemas e contratos em evolução para atender às necessidades futuras dos clientes. Implementa estratégias para valor e parcerias ao longo da vida do cliente. Supervisiona programas de gerenciamento de contas-chave.', 'Oversees the organisation''s sales activities to align with business objectives.
Approves sales proposals and targets. Develops sales policy and strategy, and contributes to the marketing strategy. Works with bid management to ensure sales strategies are effectively represented in major proposals.
Negotiates with senior customer representatives on technical and contractual issues. Agrees and signs contracts.
Collaborates on evolving services, products, systems and contracts to meet future customer needs. Implements strategies for lifetime customer value and partnerships. Oversees key account management programmes.'),
(15287, 3, 'Aplica critérios de aceitação de serviços padronizados e participa nos testes de aceitação de serviços.
Colabora com equipes de entrega para garantir que as entregas atendam aos padrões exigidos.
Documenta e comunica os resultados das atividades de aceitação de serviços.
Identifica e reporta problemas ou não conformidades, ajudando na sua resolução.', 'Applies standard service acceptance criteria and participates in service acceptance testing.
Collaborates with delivery teams to ensure service deliverables meet the required standards.
Documents and communicates the outcomes of service acceptance activities.
Identifies and reports issues or non-conformances, assisting with their resolution.'),
(15287, 4, 'Interage com times de entrega para confirmar que os produtos desenvolvidos atendam aos critérios de aceitação de serviços e estejam de acordo com os padrões exigidos.
Avalia os riscos relacionados à aceitação de serviços e sugere ações para endereçar os riscos identificados.
Facilita a comunicação de critérios de aceitação entre equipes para manter o alinhamento e a consistência ao longo do processo.
Fornece contribuições para os processos de controle de mudanças.', 'Engages with delivery teams to confirm that products developed meet the service acceptance criteria and are to the required standard.
Assesses risks related to service acceptance and suggests actions to address identified risks.
Facilitates the communication of acceptance criteria across teams to maintain alignment and consistency throughout the process.
Provides input into change control processes.'),
(15287, 5, 'Envolve-se com equipes de entrega para garantir que os produtos corretos sejam produzidos em tempo hábil.
Lidera a avaliação de entregas de serviços complexos ou críticos, garantindo que atendam às necessidades operacionais atuais e futuras. Lidera avaliações de risco abrangentes, identificando e priorizando riscos que podem afetar a prontidão do serviço.
Fornece aconselhamento confiável sobre práticas de aceitação de serviço. Fornece recomendações para melhorar a prontidão do serviço e melhorar os processos de aceitação do serviço.
Avalia a qualidade dos resultados dos projetos em relação aos critérios de aceitação de serviço acordados.', 'Engages with delivery teams to ensure correct products are produced in a timely fashion.
Leads the assessment of complex or critical service deliverables, ensuring they meet both current and future operational needs. Leads comprehensive risk evaluations identifying and prioritising risks that may impact service readiness.
Provides authoritative advice on service acceptance practices. Provides recommendations for enhancing service readiness and improving service acceptance processes.
Evaluates the quality of project outputs against agreed service acceptance criteria.'),
(15287, 6, 'Desenvolve a abordagem da organização para aceitação de serviços, é responsável pelo processo de transição e define os critérios de aceitação para transições de serviços.
Garante que as atividades de gestão de riscos estejam alinhadas com a estrutura mais ampla de gestão de riscos da organização. Promove e monitora os resultados de qualidade dos projetos para garantir que estejam adequados à finalidade e ao uso nos serviços operacionais.
Envolve-se ativamente com as partes interessadas para promover a conscientização e a conformidade com os planos e processos de qualidade de transição de serviços.
Entra em acordo sobre os critérios de aceitação do serviço com as equipes de entrega.', 'Develops the organisation''s approach for service acceptance, owns the transition process and defines the acceptance criteria for service transitions.
Ensures risk management activities are aligned with the organisation''s broader risk management framework. Promotes and monitors project quality outputs to ensure they are fit for purpose and fit for use within operational services.
Actively engages with stakeholders to promote awareness and compliance with service transition quality plans and processes.
Agrees the service acceptance criteria with delivery teams.'),
(15288, 2, 'Ajuda com tarefas de gerenciamento de catálogos de serviços sob supervisão de rotina.
Suporta a coleta e atualização de informações de serviços e produtos.
Ajuda a manter a precisão e relevância do catálogo de serviços.', 'Assists with service catalogue management tasks under routine supervision.
Supports the collection and updating of service and product information.
Helps maintain the accuracy and relevance of the service catalogue.'),
(15288, 3, 'Reúne as informações necessárias para preencher o catálogo de serviços.
Edita e mantém descrições de serviços e produtos e mantém a lista de serviços disponíveis atualizada.
Atua como ponto de contato, recebendo e gerenciando atualizações de rotina do catálogo de serviços.
Identifica oportunidades para melhorar os processos de gerenciamento do catálogo de serviços.', 'Collates information needed to populate the service catalogue.
Edits and maintains service and product descriptions and keeps the list of available services up to date.
Acts as a contact point, receiving and handling routine updates to the service catalogue.
Identifies opportunities to improve service catalogue management processes.'),
(15288, 4, 'Contribui para a concepção e implementação de um catálogo de serviços.
Permite a automação de solicitações de serviço e de atendimento de pedidos.
Fornece aconselhamento e orientação sobre as informações a serem incluídas no catálogo de serviços.
Contribui para revisões e melhorias do catálogo e dos processos de gestão do catálogo de serviços.', 'Contributes to the design and implementation of a service catalogue.
Enables automation of service requests and order fulfilment.
Provides advice and guidance on the information to be included in the service catalogue.
Contributes to reviews and improvement of the catalogue and of service catalogue management processes.'),
(15288, 5, 'Gerencia a criação e manutenção de um catálogo de serviços.
Garante que o catálogo de serviços esteja completo e atualizado. Trabalha com proprietários de serviços para garantir consistência e precisão das entradas do catálogo de serviços.
Conclui revisões regulares do catálogo com as partes interessadas para garantir a relevância nas necessidades e requisitos do negócio.
Gerencia os processos de gerenciamento do catálogo de serviços.', 'Manages the creation and maintenance of a catalogue of services.
Ensures the service catalogue is complete and current. Works with service owners to ensure consistency and accuracy of the service catalogue entries.
Completes regular reviews of the catalogue with stakeholders to ensure relevance to business needs and requirements.
Manages the service catalogue management processes.'),
(15289, 2, 'Monitora e registra o serviço efetivo fornecido.
Compara o serviço entregue e os acordos de nível de serviço, identificando quaisquer desvios ou áreas para melhoria.', 'Monitors and logs the actual service provided.
Compares delivered service to service level agreements, identifying any deviations or areas for improvement.'),
(15289, 3, 'Monitora as métricas de desempenho de entrega de serviços.
Estabelece contato com as partes interessadas para ajudá-las a planejar eventuais deteriorações no serviço e/ou violações em acordos de nível de serviço.', 'Monitors service delivery performance metrics.
Liaises with stakeholders to help them plan for a deterioration in service and/or breaches of service level agreements.'),
(15289, 4, 'Executa tarefas definidas para monitorar a entrega de serviços em relação a acordos de nível de serviço e mantém registros de informações relevantes.
Analisa o desempenho da prestação de serviços para identificar as ações necessárias para manter ou melhorar os níveis de serviço.
Inicia e reporta ações para manter ou melhorar os níveis de serviço.', 'Performs defined tasks to monitor service delivery against service level agreements and maintains records of relevant information.
Analyses service delivery performance to identify actions required to maintain or improve levels of service.
Initiates and reports on actions to maintain or improve levels of service.'),
(15289, 5, 'Garante que a entrega do serviço atenda aos níveis de serviço estabelecidos.
Negocia requisitos de nível de serviço e os níveis de serviço já acordados com os clientes.
Diagnostica problemas de entrega de serviço e inicia ações para manter ou melhorar os níveis de serviço.
Estabelece e mantém métodos, procedimentos e instalações operacionais e os revisa regularmente quanto à eficácia e eficiência.', 'Ensures service delivery meets agreed service levels.
Negotiates service level requirements and agreed service levels with customers.
Diagnoses service delivery problems and initiates actions to maintain or improve levels of service.
Establishes and maintains operational methods, procedures and facilities and reviews them regularly for effectiveness and efficiency.'),
(15289, 6, 'Garante que a prestação de serviços seja monitorada de forma eficaz e que as ações identificadas para manter ou melhorar os níveis do serviço sejam implementadas.
Garante que os acordos de nível de serviço sejam completos e tenham um bom custo-benefício ao longo de todo o catálogo de serviços disponíveis. Garante que métodos, procedimentos, instalações e ferramentas operacionais sejam estabelecidos, revisados e mantidos. Prepara propostas para atender as mudanças previstas nos níveis ou tipos de serviços.
Revisa a entrega dos serviços para garantir que as metas acordadas sejam cumpridas.
Negocia com as partes relevantes em relação a interrupções e alterações significativas na prestação dos serviços.', 'Ensures service delivery is monitored effectively and that identified actions to maintain or improve levels of service are implemented.
Ensures service level agreements are complete and cost-effective across the catalogue of available services. Ensures operational methods, procedures, facilities and tools are established, reviewed and maintained. Prepares proposals to meet forecast changes in the levels or types of services.
Reviews service delivery to ensure agreed targets are met.
Negotiates with relevant parties in respect of disruptions and major amendments to the provision of services.'),
(15289, 7, 'Define estratégias para entrega de serviços que suportam as necessidades estratégicas da organização do cliente.
Autoriza a alocação de recursos para monitorar os acordos de prestação de serviços.
Fornece liderança dentro da indústria na identificação de tendências futuras.
Desenvolve relacionamentos com clientes no mais alto nível para identificar áreas potenciais de interesse mútuo de negócio, para desenvolvimento futuro. Mantém uma visão geral da contribuição dos acordos de prestação de serviços para o sucesso organizacional.', 'Sets strategies for service delivery that support the strategic needs of the client organisation.
Authorises allocation of resources for monitoring service delivery arrangements.
Develops relationships with customers at the highest level to identify potential areas of mutual commercial interest for future development.
Maintains an overview of the contribution of service delivery arrangements to organisational success. Provides leadership within the industry on the identification of future trends.'),
(15290, 2, 'Ajuda com tarefas de configuração de software.
Suporta a configuração e personalização de ambientes e plataformas de software.
Ajuda a documentar e relatar alterações de configuração e implementações.
Revisa o próprio trabalho.', 'Assists with software configuration tasks.
Supports the setup and customisation of software environments and platforms.
Helps document and report on configuration changes and deployments.
Reviews own work.'),
(15290, 3, 'Auxilia na concepção, verificação, documentação, alteração e refatoração de configurações de software moderadamente complexas para implantação.
Aplica padrões e ferramentas previamente acordados para alcançar um resultado projetado.
Colabora nas revisões do trabalho de outras pessoas/equipes, conforme apropriado.', 'Designs, verifies, documents, amends and refactors moderately complex software configurations for deployment.
Applies agreed standards and tools, to achieve a well-engineered result.
Collaborates in reviews of work with others as appropriate.'),
(15290, 4, 'Projeta, verifica, documenta, corrige e reestrutura configurações complexas de software para implantação.
Contribui para a seleção dos métodos, ferramentas e técnicas de configuração de software.
Aplica padrões e ferramentas pré-estabelecidas para atingir resultados bem planejados.
Participa de revisões do próprio trabalho e conduz a revisão do trabalho dos colegas.', 'Designs, verifies, documents, amends and refactors complex software configurations for deployment.
Contributes to the selection of the software configuration methods, tools and techniques.
Applies agreed standards and tools, to achieve well-engineered outcomes.
Participates in reviews of own work and leads reviews of colleagues'' work.'),
(15290, 5, 'Assume a responsabilidade técnica em todos os estágios e iterações de desenvolvimento e implantação da configuração.
Planeja e conduz as atividades de criação de software. Adota e adapta métodos, ferramentas e técnicas de configuração de software apropriadas.
Mede e monitora a aplicação de normas para o design e a implantação da configuração, incluindo segurança de software.
Contribui para o desenvolvimento de políticas organizacionais, normas e diretrizes o design e implantação da configuração de software.', 'Takes technical responsibility across all stages and iterations of configuration development and deployment.
Plans and drives software configuration activities. Adopts and adapts appropriate software configuration methods, tools and techniques.
Measures and monitors the application of standards for configuration design and deployment including software security.
Contributes to the development of organisational policies, standards and guidelines for software configuration design and deployment.'),
(15290, 6, 'Desenvolve políticas organizacionais, padrões e diretrizes para projeto de configuração de software, implantação e refatoração.
Planeja e lidera as atividades de configuração e implantação de software em projetos de implantação estratégicos, grandes e complexos.
Desenvolve novos métodos e capacidades organizacionais e impulsiona a adoção e adesão a políticas e padrões.', 'Develops organisational policies, standards and guidelines for software configuration design, deployment and refactoring.
Plans and leads software configuration and deployment activities for strategic, large and complex deployment projects.
Develops new methods and organisational capabilities and drives adoption of and adherence to policies and standards.'),
(3266, 2, 'Cria e documenta projetos detalhados para aplicativos ou componentes de software simples.
Aplica técnicas de modelagem, padrões e ferramentas conforme acordado.
Contribui para o projeto de componentes de sistemas de software maiores, garantindo alinhamento com os requisitos gerais de design, incluindo segurança.
Efetua revisões do próprio trabalho.', 'Creates and documents detailed designs for simple software applications or components.
Applies agreed modelling techniques, standards, patterns and tools.
Contributes to the design of components of larger software systems, ensuring alignment with overall design requirements, including security.
Reviews own work.'),
(3266, 3, 'Realiza o projeto completo de aplicativos ou componentes de software moderadamente complexos.
Aplica padrões, diretrizes e ferramentas conforme acordado. Auxilia como parte de uma equipe no projeto de componentes de sistemas de software maiores. Especifica interfaces de usuário e/ou de sistema.
Cria várias visualizações de projeto para atender às preocupações das diferentes partes interessadas e para lidar com requisitos funcionais e não funcionais, considerando todos os fatores relevantes, incluindo segurança. Auxilia na avaliação de opções e trade-offs.
Colabora nas revisões do trabalho com outros profissionais/equipes, conforme apropriado.', 'Undertakes complete design of moderately complex software applications or components.
Applies agreed standards, guidelines, patterns and tools. Assists as part of a team in the design of components of larger software systems. Specifies user and/or system interfaces.
Creates multiple design views to address the different stakeholders'' concerns and to handle functional and non-functional requirements, considering all relevant factors, including security. Assists in the evaluation of options and trade-offs.
Collaborates in reviews of work with others as appropriate.'),
(3266, 4, 'Desenha e arquitetura aplicações, componentes e módulos de software complexos.
Utiliza técnicas de modelagem apropriadas em conformidade com padrões, diretrizes, padrões e metodologias de design de software acordados. Produz e comunica múltiplas visões de design para atender às preocupações dos stakeholders e atender a requisitos funcionais e não funcionais, incluindo segurança.
Identifica, avalia e recomenda alternativas de design e compromissos. Modela, simula ou protótipa comportamentos de software propostos para garantir a aprovação dos stakeholders e facilitar a construção de software eficaz.
Revisa, verifica e aprimora seus próprios designs em relação às especificações e lidera revisões dos designs de outros.', 'Designs and architects complex software applications, components and modules.
Uses appropriate modelling techniques in line with agreed software design standards, guidelines, patterns and methodologies. Produces and communicates multiple design views to address stakeholder concerns and meet both functional and non-functional requirements including security.
Identifies, evaluates and recommends design alternatives and trade-offs. Models, simulates or prototypes proposed software behaviours to secure stakeholder approval and facilitate effective software construction.
Reviews, verifies and enhances own designs against specifications and leads reviews of others'' designs.'),
(3266, 5, 'Especifica, projeta e arquiteta aplicativos de software, componentes e módulos grandes ou complexos.
Adota e adapta métodos, ferramentas e técnicas de design de software. Realiza análises de impacto nas principais opções de projeto, faz recomendações e avalia e gerencia os riscos associados. Especifica protótipos/simulações para permitir a tomada de decisões.
Avalia projetos de software para garantir a aderência aos padrões e identifica ações corretivas. Garante que o projeto do software equilibre os requisitos funcionais, de qualidade, de segurança e de gerenciamento de sistemas.
Contribui para o desenvolvimento de políticas e padrões de projeto e arquitetura de software organizacional.', 'Specifies, designs and architects large or complex software applications, components and modules.
Adopts and adapts software design methods, tools and techniques. Undertakes impact analysis on major design options, makes recommendations and assesses and manages associated risks. Specifies prototypes/simulations to enable informed decision-making.
Evaluates software designs to ensure adherence to standards and identifies corrective action. Ensures the software design balances functional, quality, security and systems management requirements.
Contributes to the development of organisational software design and architecture policies and standards.'),
(3266, 6, 'Lidera a seleção e desenvolvimento de design de software e métodos arquitetônicos, ferramentas e técnicas.
Define e mantém princípios arquitetônicos, padrões e frameworks para orientar o design e desenvolvimento de software em toda a organização.
Assegura a adesão a estratégias técnicas e arquiteturas de sistemas (incluindo segurança).', 'Leads the selection and development of software design and architectural methods, tools and techniques.
Defines and maintains architectural principles, patterns and frameworks to guide software design and development across the organisation.
Ensures adherence to technical strategies and systems architectures (including security).'),
(10675, 4, 'Contribui para o desenvolvimento de arquiteturas de solução em áreas específicas de negócios, infraestrutura ou funções.
Identifica e avalia arquiteturas alternativas e as compensações em custo, desempenho e escalabilidade. Determina e documenta decisões arquitetonicamente significativas.
Produz especificações de componentes, camadas e interfaces baseadas em nuvem ou locais, para tradução em designs detalhados usando serviços e produtos selecionados.
Apoia projetos ou iniciativas de mudança por meio da preparação de planos técnicos e da aplicação de princípios de design. Alinha as soluções aos padrões de arquitetura corporativa e de solução (incluindo segurança).', 'Contributes to the development of solution architectures in specific business, infrastructure or functional areas.
Identifies and evaluates alternative architectures and the trade-offs in cost, performance and scalability. Determines and documents architecturally significant decisions.
Produces specifications of cloud-based or on-premises components, tiers and interfaces, for translation into detailed designs using selected services and products.
Supports projects or change initiatives through the preparation of technical plans and application of design principles. Aligns solutions with enterprise and solution architecture standards (including security).'),
(10675, 5, 'Lidera o desenvolvimento de arquiteturas de solução em áreas específicas de negócios, infraestrutura ou funcionais.
Lidera a preparação de planos técnicos e garante a disponibilidade de recursos técnicos adequados. Assegura que as ferramentas e métodos apropriados estejam disponíveis, sejam compreendidos e aplicados no desenvolvimento da arquitetura.
Fornece orientação técnica e governança para o desenvolvimento e integração de soluções. Avalia solicitações de mudanças e desvios das especificações, recomendando ações.
Garante que as estratégias técnicas, políticas, normas e práticas relevantes (incluindo segurança e gestão de custos) sejam aplicadas corretamente.', 'Leads the development of solution architectures in specific business, infrastructure or functional areas.
Leads the preparation of technical plans and ensures appropriate technical resources are made available. Ensures appropriate tools and methods are available, understood and employed in architecture development.
Provides technical guidance and governance on solution development and integration. Evaluates requests for changes and deviations from specifications and recommends actions.
Ensures relevant technical strategies, policies, standards and practices (including security and cost management) are applied correctly.'),
(10675, 6, 'Lidera o desenvolvimento de arquiteturas para soluções complexas, garantindo consistência com os requisitos acordados.
Estabelece políticas, princípios e práticas para a seleção de componentes da arquitetura de solução.
Gerencia trade-offs e equilibra requisitos funcionais, qualidade de serviço, eficiência de custos e de gestão de sistemas em uma área significativa da organização. Comunica as decisões propostas às partes interessadas.
Coordena e gerencia a arquitetura-alvo em vários projetos ou iniciativas. Mantém uma arquitetura estável e viável, assegurando a consistência do design e a conformidade com os padrões apropriados em diversos projetos ou iniciativas.', 'Leads the development of architectures for complex solutions ensuring consistency with agreed requirements.
Establishes policies, principles and practices for the selection of solution architecture components.
Manages trade-offs and balances functional, service quality, cost efficiency and systems management requirements within a significant area of the organisation. Communicates proposed decisions to stakeholders.
Coordinates and manages the target architecture across multiple projects or initiatives. Maintains a stable, viable architecture and ensures consistency of design and adherence to appropriate standards across multiple projects or initiatives.'),
(1979, 2, 'Auxilia na preparação de questionários de pré-qualificação e convites para licitações em resposta a business cases.
Reúne informações relevantes para licitações.
Elabora critérios de avaliação detalhados para licitações simples.
Auxilia na avaliação das licitações.', 'Assists in the preparation of pre-qualification questionnaires and tender invitations in response to business cases.
Assembles relevant information for tenders.
Produces detailed evaluation criteria for simple tender criteria.
Assists in the evaluation of tenders.'),
(1979, 3, 'Prepara questionários de pré-qualificação e convites a licitações em resposta a business cases.
Reconhece a diferença entre opções de sistemas de código aberto ou proprietários.
Aplica procedimentos e ferramentas padrão para produzir critérios de avaliação detalhados para propostas complexas e para avaliação de propostas.', 'Prepares pre-qualification questionnaires and tender invitations in response to business cases.
Recognises the difference between open source and proprietary systems options.
Applies standard procedures and tools to produce detailed evaluation criteria for complex tenders and to evaluate tenders.'),
(1979, 4, 'Analisa os business cases (requisitos, benefícios potenciais e opções) e determina as rotas de aquisição apropriadas.
Usando conhecimento do mercado para informar as especificações, garante que questionários detalhados de pré-qualificação e convites para licitação sejam preparados.
Coleta e reúne dados para apoiar a colaboração e negocia termos e condições para refletir a escala dos requisitos e incentivar o bom desempenho.
Avalia propostas com base em critérios de especificação e avaliação, prepara documentação de aceitação e fornece aconselhamento sobre contratos e acordos de nível de serviço.', 'Reviews business cases (requirements, potential benefits and options) and determines appropriate procurement routes.
Using market knowledge to inform specifications, ensures detailed pre-qualification questionnaires and tender invitations are prepared.
Collects and collates data to support collaboration and negotiates terms and conditions to reflect the scale of requirements and encourage optimal performance.
Evaluates tenders based on specification and evaluation criteria, prepares acceptance documentation and advises on contracts and service level agreements.'),
(1979, 5, 'Planeja e gerencia as atividades de compras.
Gerencia processos de licitação, avaliação e aquisição. Pesquisa fornecedores e mercados, e mantém um amplo entendimento do ambiente de negócios, para informar e desenvolver estratégias comerciais e planos de aquisições.
Fornece aconselhamento sobre casos de negócios para modelos alternativos de fornecimento. Fornece aconselhamento sobre políticas e procedimentos que abranjam licitação, seleção de fornecedores e aquisição.
Negocia com potenciais parceiros e fornecedores, desenvolvendo critérios e procedimentos de aceitação. Elabora e celebra contratos.', 'Plans and manages procurement activities.
Manages tender, evaluation and acquisition processes. Researches suppliers and markets, and maintains a broad understanding of the commercial environment, to inform and develop commercial strategies and sourcing plans.
Advises on the business case for alternative sourcing models. Advises on policy and procedures covering tendering, the selection of suppliers and procurement.
Negotiates with potential partners and suppliers, developing acceptance criteria and procedures. Drafts and places contracts.'),
(1979, 6, 'Desenvolve políticas e procedimentos para atividades de aquisição.
Estabelece estratégias de compras, padrões, métodos, processos e boas práticas que garantam o cumprimento da legislação, regulações e requisitos de segurança da informação.
Lidera o processo de aquisição, desde o esclarecimento dos requisitos até a colocação, monitoramento e rescisão de contratos. Conduz negociações complexas e define parâmetros para negociações rotineiras. Garante que os termos e condições estejam alinhados com os requisitos organizacionais, legislação vigente e políticas.
Identifica parceiros externos, engajando-se com profissionais em disciplinas relacionadas conforme apropriado.', 'Develops policy and procedures for sourcing and procurement activities.
Establishes procurement strategies, standards, methods, processes and good practices that ensure compliance with legislation, regulation and information security requirements.
Leads the procurement process, from clarifying requirements through to placing, monitoring and terminating contracts. Conducts complex negotiations and sets parameters for routine negotiations. Ensures terms and conditions align with organisational requirements, current legislation and policy.
Identifies external partners, engaging with professionals in related disciplines as appropriate.'),
(1979, 7, 'Formata e lidera as estratégias gerais de aquisição da organização, garantindo alinhamento com a visão de negócios global e objetivos de longo prazo.
Assume a responsabilidade total pelas atividades de aquisição, orientando a visão e as decisões estratégicas relacionadas a aquisições.
Desenvolve, implanta e avalia continuamente processos de aquisição de forma estratégica para se alinhar com as condições dinâmicas do mercado dinâmicas e os objetivos organizacionais.
Lida com negociações de alto nível para grandes contratos, estabelecendo frameworks de negociação e estratégias que afetam significativamente a posição de mercado e sucesso da organização.', 'Shapes and leads the organisation''s overarching sourcing and procurement strategies, ensuring alignment with the global business vision and long-term objectives.
Assumes full accountability for all sourcing and procurement activities, guiding the organisation''s sourcing vision and strategic procurement decisions.
Strategically develops, deploys and continually assesses procurement processes to align with dynamic market conditions and organisational goals.
Leads high-level negotiations for major, organisation-defining contracts, setting negotiation frameworks and strategies that significantly impact the organisation''s market position and success.'),
(15291, 4, 'Fornece aconselhamento detalhado e específico para apoiar o planejamento e as operações da organização, geralmente relacionado à área imediata de responsabilidade.
Mantém ativamente um nível de conhecimento reconhecido como especialista em uma ou mais especialidades identificáveis.
Reconhece e identifica os limites de seu próprio conhecimento especializado.
Quando apropriado, colabora com outros especialistas para garantir que o aconselhamento oferecido seja profissionalmente sólido e adequado às necessidades da organização.', 'Provides detailed and specific advice to support the organisation''s planning and operations, typically related to the immediate area of responsibility.
Actively maintains recognised expert level knowledge in one or more identifiable specialisms.
Recognises and identifies the boundaries of their own specialist knowledge.
Where appropriate, collaborates with other specialists to ensure advice given is professionally sound and appropriate to the organisation''s needs.'),
(15291, 5, 'Fornece conselhos profissionais que informam a liderança operacional e influenciam a tradução da estratégia nas operações em sua área especializada.
Supervisiona o fornecimento de aconselhamento especializado por terceiros.
Consolida conhecimentos de diversas fontes, incluindo especialistas terceirizados, para fornecer aconselhamento coerente e profissionalmente sólido para atingir os objetivos organizacionais.
Apoia e promove o desenvolvimento e o compartilhamento de conhecimentos especializados dentro da organização.', 'Provides professional advice that informs operational leadership and influences the translation of strategy into operations in their specialist area.
Oversees the provision of specialist advice by others.
Consolidates expertise from multiple sources, including third-party experts, to provide coherent and professionally sound advice to further organisational objectives.
Supports and promotes the development and sharing of specialist knowledge within the organisation.'),
(15291, 6, 'Lidera e promove o desenvolvimento e aplicação de conhecimentos especializados em toda a organização, fornecendo aconselhamento profissional que forma a direção e decisões de alto nível.
Mantém uma rede de especialistas reconhecidos (dentro e/ou fora da organização) que pode fornecer aconselhamento especializado em áreas relevantes.
Influencia ativamente o planejamento de desenvolvimento profissional em uma parte significativa da organização para promover o desenvolvimento de conhecimentos especializados apropriados e fornecer aconselhamento profissional de alta qualidade.', 'Leads and promotes the development and application of specialist knowledge across the organisation, delivering professional advice that shapes direction and high-level decisions.
Maintains a network of recognised experts (inside and/or outside the organisation) who can deliver expert advice in relevant areas.
Actively influences professional development planning across a significant part of the organisation to further the development of appropriate expertise and provision of high-quality professional advice.'),
(1450, 4, 'Lida com problemas e situações, gerenciando resoluções, ações corretivas, lições aprendidas e coleta e disseminação de informações relevantes.
Implementa o plano de comunicação/engajamento das partes interessadas.
Coleta e utiliza feedback de clientes e partes interessadas para ajudar a medir a eficácia do gerenciamento das partes interessadas.
Ajuda a desenvolver e aprimorar os relacionamentos com clientes e partes interessadas.', 'Deals with problems and issues, managing resolutions, corrective actions, lessons learned and the collection and dissemination of relevant information.
Implements stakeholder engagement/communications plans.
Collects and uses feedback from customers and stakeholders to help measure the effectiveness of stakeholder management.
Helps develop and enhance customer and stakeholder relationships.'),
(1450, 5, 'Identifica as necessidades de comunicação e relacionamento dos grupos de partes interessadas.
Traduz as estratégias de comunicação/engajamento das partes interessadas em atividades e resultados específicos. Facilita a comunicação aberta e a discussão entre as partes interessadas.
Atua como único ponto de contato, desenvolvendo, mantendo e trabalhando para estratégias e planos de engajamento das partes interessadas. Oferece feedback para avaliar e promover a compreensão.
Facilita os processos de tomada de decisão de negócios. Captura e divulga informações técnicas e de negócios.', 'Identifies the communications and relationship needs of stakeholder groups.
Translates communications/stakeholder engagement strategies into specific activities and deliverables. Facilitates open communication and discussion between stakeholders.
Acts as a single point of contact by developing, maintaining and working to stakeholder engagement strategies and plans. Provides informed feedback to assess and promote understanding.
Facilitates business decision-making processes. Captures and disseminates technical and business information.'),
(1450, 6, 'Dirige o desenvolvimento de estratégias e planos abrangentes de gestão de partes interessadas.
Estabelece e constrói relações estratégicas de longo prazo com partes interessadas-chave para apoiar a prestação de serviços e iniciativas de mudança.
Funciona como ponto de contacto principal, garantindo comunicação e alinhamento eficazes. Negocia e garante que os acordos atendam às necessidades das partes interessadas.
Supervisiona o monitoramento das relações de partes interessadas, captura as lições aprendidas e fornece feedback. Lidera iniciativas para melhorar a comunicação e as relações, promovendo a colaboração e a compreensão entre todas as partes.', 'Leads the development of comprehensive stakeholder management strategies and plans.
Establishes and builds long-term, strategic relationships with key stakeholders to support service delivery and change initiatives.
Acts as a principal point of contact, ensuring effective communication and alignment. Negotiates and ensures agreements meet stakeholder needs.
Oversees the monitoring of stakeholder relationships, capturing lessons learned and providing feedback. Leads initiatives to enhance communication and relationships, promoting collaboration and understanding between all parties.'),
(1450, 7, 'Determina a abordagem estratégica para compreender os objetivos e requisitos das partes interessadas.
Trabalha com todas as partes interessadas para identificá-las e estabelecer relacionamentos eficazes entre elas.
Estabelece e promove a visão geral de como os objetivos das partes interessadas são atendidos e determina os papéis e o alinhamento da organização.
Gerencia ativamente os relacionamentos com as partes interessadas mais experientes e atua como ponto de escalação final para a resolução de problemas.', 'Determines the strategic approach to understanding stakeholder objectives and requirements.
Works with all interested parties to identify stakeholders and establish effective relationships.
Establishes and promotes the overall vision for how stakeholder objectives are met and determines organisational roles and alignment.
Actively manages relationships with the most senior stakeholders and is the ultimate escalation point for issue resolution.'),
(15292, 2, 'Ajuda com tarefas de gerenciamento de armazenamento, como provisionamento.
Suporta a configuração e configuração de sistemas de armazenamento, incorporando práticas de segurança padrão.
Ajuda a monitorar o desempenho e a capacidade do armazenamento e documenta a utilização do armazenamento.', 'Assists with storage management tasks such as provisioning.
Supports the setup and configuration of storage systems, incorporating standard security practices.
Helps monitor storage performance and capacity, and documents storage utilisation.'),
(15292, 3, 'Executa tarefas rotineiras de armazenamento de dados, seguindo procedimentos estabelecidos e utilizando ferramentas padrão.
Implementa as configurações documentadas para alocação de armazenamento, instalação e manutenção de sistemas de armazenamento seguro, usando procedimentos operacionais pré-estabelecidos.
Identifica problemas operacionais e contribui para a sua resolução.
Utiliza ferramentas padrão de gerenciamento e criação de relatórios para coletar e relatar a utilização, o desempenho e as estatísticas de backup do armazenamento.', 'Executes routine storage management tasks following established procedures and using standard tools.
Implements documented configurations for allocation of storage, installation and maintenance of secure storage systems using the agreed operational procedures.
Identifies operational problems, including security-related issues, and contributes to their resolution.
Uses standard management and reporting tools to collect and report on storage utilisation, performance and backup statistics.'),
(15292, 4, 'Prepara e mantém procedimentos operacionais para gerenciamento de armazenamento.
Monitora capacidade, desempenho, disponibilidade e outras métricas operacionais. Toma as medidas adequadas para garantir a manutenção corretiva e proativa dos sistemas de armazenamento e backup para proteger as informações de negócio.
Elabora relatórios e propostas de melhoria.
Contribui para o planejamento e implantação de novas instalações e manutenções programadas e alterações de sistemas existentes.', 'Prepares and maintains operational procedures for storage management.
Monitors capacity, performance, availability and other operational metrics. Takes appropriate action to ensure corrective and proactive maintenance of storage and backup systems to protect and secure business information.
Creates reports and proposals for improvement.
Contributes to the planning and implementation of new installations and scheduled maintenance and changes of existing systems.'),
(15292, 5, 'Desenvolve padrões e diretrizes para implementar proteção de dados e funcionalidade de recuperação de desastres para todos os aplicativos e dados de negócio.
Fornece aconselhamento especializado e orientação para implementar e melhorar o gerenciamento de armazenamento.
Gerencia os sistemas de armazenamento e backup para fornecer os níveis de serviço acordados.
Cria, melhora e suporta serviços de gerenciamento de armazenamento com utilização otimizada dos recursos de armazenamento, garantindo a segurança, disponibilidade e integridade dos dados.', 'Develops standards and guidelines for implementing data protection and disaster recovery functionality for all business applications and business data.
Provides authoritative advice and guidance to implement and improve storage management.
Manages storage and backup systems to provide agreed service levels.
Creates, improves and supports storage management services with optimal utilisation of storage resources, ensuring security, availability and integrity of data.'),
(15292, 6, 'Desenvolve políticas, padrões e diretrizes organizacionais para gerenciamento de armazenamento.
Desenvolve estratégias para gerenciar armazenamento e dados com base no nível de criticidade das informações.
Garante a conformidade com os requisitos regulatórios e de segurança.
Alinha investimentos no gerenciamento de armazenamento com as metas de negócios e políticas de gerenciamento de dados.', 'Develops organisational policies, standards and guidelines for storage management.
Develops strategies for managing storage and data based on the level of criticality of the information.
Ensures compliance with regulatory and security requirements.
Aligns investments in storage management with business goals and data management policies.'),
(8168, 4, 'Contribui para a coleta e análise de informações para apoiar o desenvolvimento de estratégias.
Auxilia na preparação de relatórios e análises para planejamento estratégico.
Apoia a comunicação de planos estratégicos e das iniciativas de mudança relacionadas às partes interessadas relevantes.
Ajuda a monitorar o progresso em relação aos objetivos estratégicos e fornece retorno.', 'Contributes to the collection and analysis of information to support strategy development.
Assists in the preparation of reports and insights for strategic planning.
Supports the communication of strategic plans and related change initiatives to relevant stakeholders.
Helps monitor progress against strategic objectives and provides feedback.'),
(8168, 5, 'Reúne informações e cria relatórios e percepções para apoiar os processos de gestão estratégica.
Assegura que todas as partes interessadas estejam cientes da abordagem e dos cronogramas de gestão estratégica. Fornece suporte e orientações para ajudar as partes interessadas a aderirem à abordagem.
Desenvolve e comunica planos para impulsionar a estratégia e o planejamento da mudança relacionado.
Contribui para o desenvolvimento de políticas, normas e diretrizes para o desenvolvimento e planejamento estratégico.', 'Collates information and creates reports and insights to support strategy management processes.
Ensures all stakeholders are aware of the strategic management approach and timetables. Provides support and guidance to help stakeholders adhere to the approach.
Develops and communicates plans to drive forward the strategy and related change planning.
Contributes to the development of policies, standards and guidelines for strategy development and planning.'),
(8168, 6, 'Define políticas, normas e diretrizes sobre como a organização conduz o desenvolvimento e o planejamento da estratégia.
Lidera e gerencia a criação ou revisão de uma estratégia que atenda aos requisitos do negócio.
Desenvolve, comunica, implementa e analisa os processos que integram a gestão estratégica na gestão operacional da organização.', 'Sets policies, standards and guidelines for how the organisation conducts strategy development and planning.
Leads and manages the creation or review of a strategy that meets the requirements of the business.
Develops, communicates, implements and reviews the processes which embed strategic management in the operational management of the organisation.'),
(8168, 7, 'Lidera a definição, implementação e comunicação da estrutura de gestão estratégica da organização.
Direciona a criação e revisão de uma estratégia e de planos para apoiar os requisitos estratégicos do negócio.', 'Leads the definition, implementation and communication of the organisation’s strategic management framework.
Directs the creation and review of a strategy and plans to support the strategic requirements of the business.'),
(15293, 4, 'Contribui para o desenvolvimento de trilhas de ensino, selecionando ou especificando os seus conteúdos ou abordagens de avaliação, para uma ou mais áreas especializadas.', 'Contributes to curriculum development by selecting or specifying curriculum content or assessment approaches for one or more specialist areas.'),
(15293, 5, 'Contribui para a especificação e desenvolvimento de trilhas de ensino e avaliação em contexto educativo ou por avaliadores independentes.', 'Contributes to the specification and development of curricula and assessment in an educational context or for an independent examination body.'),
(15293, 6, 'Lidera a especificação e desenvolvimento de trilhas de ensino e avaliações em contexto educacional ou para um corpo de exame independente.
Contribui para o desenvolvimento de uma estratégia de evolução curricular.
Garante que as atuais pesquisas de domínio sejam representadas nos currículos.', 'Leads the specification and development of curricula and assessment in an educational context or for an independent examination body.
Contributes to the development of a strategy for curriculum evolution.
Ensures relevant current domain research is represented in the curricula.'),
(15293, 7, 'Autoriza as trilhas de ensino e as estratégias de avaliação para uma ampla gama de currículos ou roteiros de aprendizagem.
Dirige a definição, implementação e monitoramento de currículos para satisfazer as referências e estruturas estatutárias e profissionais relevantes.
Desenvolve estratégias para a evolução dos currículos ao longo do tempo.
Incorpora domínios emergentes e temas pedagógicos em planos para trilhas de ensino futuras.', 'Authorises the curriculum and assessment strategies for a broad range of curricula or learning pathways.
Directs the definition, implementation and monitoring of curricula to satisfy relevant statutory and professional benchmarks and frameworks.
Develops strategies for the evolution of curricula over time.
Incorporates emerging domain and pedagogical themes into plans for future curricula.'),
(13834, 2, 'Auxilia na coleta e geração de relatórios sobre dados de desempenho de fornecedores.
Auxilia na comunicação rotineira do dia-a-dia entre a organização e os fornecedores.', 'Assists in the collection and reporting of supplier performance data.
Assists with the routine day-to-day communication between the organisation and suppliers.'),
(13834, 3, 'Atua como ponto de contato rotineiro entre a organização e os fornecedores.
Suporta a resolução de incidentes, problemas ou desempenho insatisfatório, relacionados ao fornecedor.
Coleta e reporta dados de desempenho dos fornecedores.', 'Acts as the routine contact point between the organisation and suppliers.
Supports resolution of supplier-related incidents, problems, or unsatisfactory performance.
Collects and reports on supplier performance data.'),
(13834, 4, 'Coleta dados de desempenho dos fornecedores e investiga problemas.
Monitora e reporta o desempenho dos fornecedores, satisfação do cliente, aderência aos requisitos de segurança e inteligência de mercado. Valida se o desempenho dos fornecedores está de acordo com os termos do contrato.
Envolve-se de forma proativa e colaborativa com os fornecedores para resolver incidentes (incluindo segurança), problemas ou desempenho insatisfatório.
Implementa iniciativas e programas de melhoria de serviços relacionados ao gerenciamento de fornecedores.', 'Collects supplier performance data and investigates problems.
Monitors and reports on supplier performance, customer satisfaction, adherence to security requirements and market intelligence. Validates that suppliers'' performance is in accordance with contract terms.
Engages proactively and collaboratively with suppliers to resolve incidents, problems, or unsatisfactory performance.
Implements supplier management-related service improvement initiatives and programmes.'),
(13834, 5, 'Gerencia fornecedores para atender os principais indicadores de desempenho e metas acordadas.
Gerencia as relações operacionais entre fornecedores e garante que possíveis disputas ou conflitos sejam identificados e resolvidos.
Realiza benchmarking e faz uso dos dados de desempenho dos fornecedores para garantir que o desempenho seja devidamente monitorado e revisado regularmente. Utiliza a experiência dos fornecedores para apoiar e reportar roteiros de desenvolvimento.
Gerencia a implementação de ações de melhoria do serviço dos fornecedores. Identifica restrições e oportunidades ao negociar ou renegociar contratos.', 'Manages suppliers to meet key performance indicators and agreed targets.
Manages the operational relationships between suppliers and ensures potential disputes or conflicts are raised and resolved.
Performs bench-marking and makes use of supplier performance data to ensure performance is adequately monitored and regularly reviewed. Use suppliers'' expertise to support and inform development roadmaps.
Manages implementation of supplier service improvement actions. Identifies constraints and opportunities when negotiating or renegotiating contracts.'),
(13834, 6, 'Desenvolve políticas, normas e diretrizes organizacionais para garantir o gerenciamento eficaz de fornecedores em toda a cadeia de suprimentos integrada.
Define a abordagem da comunicação corporativa e da gestão da relação com os fornecedores. Estabelece um ambiente de trabalho positivo e eficaz com os fornecedores para benefício mútuo.
Garante que recursos e ferramentas estejam disponíveis para realizar benchmarking. Consulta a análise dos fornecedores e avalia a eficácia em toda a cadeia de suprimentos.
Gerencia riscos e garante a qualidade dos serviços prestados pelos fornecedores.', 'Develops organisational policies, standards and guidelines to ensure effective supplier management across the integrated supply chain.
Defines the approach for commercial communications and the management of relationships with suppliers. Establishes a positive and effective working environment with suppliers for mutual benefit.
Ensures resources and tools are in place to conduct bench-marking. Reviews supplier analysis and assesses effectiveness across the supply chain.
Manages risks and assures the quality of the services delivered by suppliers.'),
(13834, 7, 'Determina a estratégia geral de gestão de fornecedores, adotando um gerenciamento eficaz e relacionamentos operacionais em todos os níveis.
Lidera parcerias colaborativas com fornecedores. Alinha os objetivos de desempenho dos fornecedores e as atividades de gerenciamento de relacionamento com os objetivos de negócios e com as estratégias de fornecimento.
Estabelece estruturas para governança de fornecedores e monitoramento de serviços.
Garante valor comercial dos contratos e representa a organização em disputas significativas com fornecedores.', 'Determines overall supplier management strategy, embracing effective management and operational relationships at all levels.
Leads collaborative supplier partnerships. Aligns supplier performance and relationship management with business objectives and sourcing strategies.
Establishes frameworks for supplier governance and service monitoring.
Ensures commercial value from contracts and represents the organisation in significant supplier disputes.'),
(3845, 4, 'Avalia e relata como diferentes decisões táticas afetam a sustentabilidade.
Analisa fatores e riscos (políticos, legislativos, tecnológicos, econômicos, sociais) que impactam os processos operacionais e a direção estratégica.
Avalia e reporta a implementação de medidas de sustentabilidade em áreas específicas.', 'Assesses and reports on how different tactical decisions affect sustainability.
Evaluates factors and risks (political, legislative, technological, economic, social) that impact on operational processes and strategic direction.
Evaluates and reports on the implementation of sustainability measures in specific areas.'),
(3845, 5, 'Fornece consultoria especializada e orientação sobre planejamento, projeto e implementação de soluções de sustentabilidade.
Avalia e seleciona métodos, ferramentas e práticas de sustentabilidade a serem usados de acordo com as políticas e normas acordadas.
Identifica e recomenda melhorias na abordagem da organização em relação à sustentabilidade.', 'Provides expert advice and guidance on planning, designing and implementing sustainability solutions.
Evaluates and selects sustainability methods, tools and practices to be used in line with agreed policies and standards.
Identifies and recommends improvements to the organisation''s approach to sustainability.'),
(3845, 6, 'Desenvolve e promove estratégias, políticas, normas e diretrizes organizacionais para a sustentabilidade.
Lidera a introdução e o uso de técnicas, metodologias e ferramentas de sustentabilidade.', 'Develops and promotes organisational strategies, policies, standards and guidelines for sustainability.
Leads the introduction and use of sustainability techniques, methodologies and tools.'),
(15297, 2, 'Ajuda com tarefas de administração de software do sistema sob supervisão de rotina.
Suporta a instalação e configuração de software do sistema.
Ajuda a monitorar o desempenho do sistema e o uso de recursos.
Ajuda a documentar as configurações e atualizações de software do sistema.', 'Assists with system software administration tasks under routine supervision.
Supports the installation and configuration of system software.
Helps monitor system performance and resource usage.
Assists in documenting system software settings and updates.'),
(15297, 3, 'Monitoriza sistemas operacionais para uso de recursos e taxas de falha, para informar e facilitar o ajuste do software do sistema.
Aplica configurações de software do sistema para otimizar o desempenho, permitindo o máximo rendimento e utilização eficiente dos recursos.
Instala e testa novas versões de software do sistema.
Ajuda na criação de procedimentos de implementação de software, incluindo planos de contingencia de falha.', 'Monitors operational systems for resource usage and failure rates, to inform and facilitate system software tuning.
Applies system software settings to optimise performance, enabling maximum throughput and efficient resource utilisation.
Installs and tests new versions of system software.
Assists in creating software implementation procedures, including fallback contingency plans.'),
(15297, 4, 'Monitoriza as métricas de software do sistema e ajusta as configurações para uma disponibilidade e desempenho ótimos.
Aplica a experiência técnica para investigar e resolver problemas complexos de software do sistema, solicitando a ação do fornecedor se necessário.
Analisa as atualizações de software do sistema e determina quais necessitam de ações.
Desenvolve procedimentos abrangentes de implementação de software com planos de contingencia robustos.', 'Monitors system software metrics and adjusts configurations for optimum availability and performance.
Applies technical expertise to investigates and resolve complex system software issues, requesting action from supplier if required.
Analyses system software updates and determines which ones require actions.
Develops comprehensive software implementation procedures with robust contingency plans.'),
(15297, 5, 'Garante que os softwares de sistema sejam provisionados e configurados para apoiar o alcance dos objetivos do serviço.
Desenvolve e mantém ferramentas e processos de diagnóstico para solução de problemas e análise de desempenho.
Avalia novos softwares de sistema e recomenda sua adoção, se apropriado. Planeja o provisionamento e teste de novas versões de softwares de sistema.
Garante que os procedimentos operacionais e diagnósticos para softwares de sistema estejam atualizados, acessíveis e bem compreendidos. Investiga e coordena a resolução de problemas potenciais e reais do serviço.', 'Ensures system software is provisioned and configured to support the achievement of service objectives.
Develops and maintains diagnostic tools and processes for troubleshooting and performance analysis.
Evaluates new system software and recommends adoption if appropriate. Plans the provisioning and testing of new versions of system software.
Ensures operational procedures and diagnostics for system software are current, accessible and well understood. Investigates and coordinates the resolution of potential and actual service problems.'),
(15294, 2, 'Ajuda na criação e documentação de elementos de design de sistema sob supervisão de rotina.
Siga procedimentos e diretrizes estabelecidos.
Ajuda a criar e manter a documentação.', 'Assists in the creation and documentation of system design elements under routine supervision.
Follows established procedures and guidelines.
Helps create and maintain documentation.'),
(15294, 3, 'Segue abordagens padronizadas e padrões de projeto estabelecidos para criar novos projetos para sistemas simples ou componentes do sistema.
Identifica e resolve pequenos problemas de design.
Identifica opções alternativas de projeto e busca orientação ao desviar dos padrões de projeto estabelecidos.', 'Follows standard approaches and established design patterns to create new designs for simple systems or system components.
Identifies and resolves minor design issues.
Identifies alternative design options and seeks guidance when deviating from established design patterns.'),
(15294, 4, 'Projeta componentes de sistema usando técnicas de modelagem apropriadas, seguindo arquiteturas, padrões de projeto, normas e metodologia pré-estabelecidas.
Identifica e avalia opções alternativas de design e trade-offs. Cria várias visualizações de design para atender às preocupações das diferentes partes interessadas e para lidar com requisitos funcionais e não funcionais.
Modela, simula ou cria protótipo de comportamento de componentes de sistemas propostos para permitir a aprovação das partes interessadas.
Produz especificações de projeto detalhadas para formar a base para a construção de sistemas. Analisa, verifica e aprimora os próprios projetos em relação às especificações.', 'Designs system components using appropriate modelling techniques following agreed architectures, design standards, patterns and methodology.
Identifies and evaluates alternative design options and trade-offs. Creates multiple design views to address the concerns of the different stakeholders and to handle functional and non-functional requirements.
Models, simulates or prototypes the behaviour of proposed system components to enable approval by stakeholders.
Produces detailed design specifications to form the basis for the construction of systems. Reviews, verifies and improves own designs against specifications.'),
(15294, 5, 'Projeta sistemas grandes ou complexos e realiza análises de impacto nas principais opções de design e trade-offs.
Garante que o design dos sistemas equilibre os requisitos funcionais e não funcionais.
Revisa os projetos de sistemas e garante que métodos, ferramentas e técnicas apropriadas sejam aplicadas de forma eficaz. Faz recomendações e avalia e gerencia os riscos associados.
Adota e adapta métodos, ferramentas e técnicas de projeto de sistemas. Contribui para o desenvolvimento de políticas de design de sistemas, padrões e seleção de componentes de arquitetura.', 'Designs large or complex systems and undertakes impact analysis on major design options and trade-offs.
Ensures the system design balances functional and non-functional requirements.
Reviews systems designs and ensures appropriate methods, tools and techniques are applied effectively. Makes recommendations and assesses and manages associated risks.
Adopts and adapts system design methods, tools and techniques. Contributes to development of system design policies, standards and selection of architecture components.'),
(15294, 6, 'Desenvolve e impulsiona a adoção e a adesão às políticas, padrões, diretrizes e métodos organizacionais para o design de sistemas.
Defende a importância e o valor dos princípios de design de sistemas e a seleção de modelos de ciclo de vida de projeto de sistemas apropriados.
Lidera atividades de design de sistemas para programas de desenvolvimento de sistemas estratégicos, grandes e complexos. Desenvolve estratégias de implementação eficazes, consistentes com os requisitos especificados, arquiteturas e restrições de desempenho e viabilidade.
Desenvolve projetos de sistemas exigindo a introdução de novas tecnologias ou novos usos para tecnologias já existentes.', 'Develops and drives adoption of and adherence to organisational policies, standards, guidelines and methods for system design.
Champions the importance and value of system design principles and the selection of appropriate systems design lifecycle models.
Leads system design activities for strategic, large and complex systems development programmes. Develops effective implementation strategies consistent with specified requirements, architectures and constraints of performance and feasibility.
Develops system design requiring the introduction of new technologies or new uses for existing technologies.'),
(524, 4, 'Contribui para o planejamento e gestão dos trabalhos de desenvolvimento de sistemas.
Adopta e aplica métodos, ferramentas e técnicas de desenvolvimento de sistemas apropriados de acordo com as normas acordadas.
Colabora com as partes interessadas para garantir que os produtos de desenvolvimento de sistemas atendam aos requisitos e expectativas de qualidade. Gerencia riscos e questões relacionadas às atividades de desenvolvimento de sistemas, escalando conforme necessário.
Contribui para a melhoria contínua dos processos e práticas de desenvolvimento de sistemas.', 'Contributes to the planning and management of systems development work.
Adopts and applies appropriate systems development methods, tools and techniques in line with agreed standards.
Engages with stakeholders to ensure systems development deliverables meet requirements and quality expectations. Manages risks and issues related to systems development activities, escalating as needed.
Contributes to the continuous improvement of systems development processes and practices.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, descricao_en) VALUES
(524, 5, 'Planeja e conduz projetos de desenvolvimento de sistemas que apoiem os objetivos e planos da organização.
Seleciona, adota e adapta métodos, ferramentas e técnicas apropriadas de desenvolvimento de sistemas. Garante que as partes interessadas estejam cientes dos recursos necessários e que tais recursos sejam disponibilizados. Facilita a disponibilidade e a utilização ideal dos recursos.
Monitora e reporta o andamento dos projetos de desenvolvimento. Garante que os projetos sejam realizados de acordo com arquiteturas, padrões, métodos e ferramentas acordados e atendam aos requisitos de segurança e privacidade.
Desenvolve roteiros para comunicar a atividade de desenvolvimento futuro.', 'Plans and drives systems development work to deliver the organisation''s objectives and plans.
Selects, adopts and adapts appropriate systems development methods, tools and techniques. Ensures stakeholders are aware of required resources and that they are made available. Facilitates availability and optimum utilisation of resources.
Monitors and reports on the progress of development projects. Ensures projects are carried out in accordance with agreed architectures, standards, methods and tools and addresses security and privacy requirements.
Develops roadmaps to communicate future development activity.'),
(524, 6, 'Define a política e impulsiona a adesão aos padrões para o desenvolvimento de sistemas.
Lidera atividades para tornar a segurança e a privacidade parte integrante do desenvolvimento de sistemas.
Identifica e gerencia os recursos necessários para todas as etapas dos projetos de desenvolvimento de sistemas.
Garante que as metas técnicas, financeiras e de qualidade sejam cumpridas.', 'Sets policy and drives adherence to standards for systems development.
Leads activities to make security and privacy integral to systems development.
Identifies and manages the resources necessary for all stages of systems development projects.
Ensures technical, financial and quality targets are met.'),
(524, 7, 'Orienta a definição, implementação e melhoria contínua da estrutura de gerenciamento de desenvolvimento de sistemas da organização.
Alinha o desenvolvimento de sistemas às estratégias e objetivos de negócios e com tecnologias emergentes e oportunidades digitais. Mantém um resumo da contribuição dos programas de desenvolvimento de sistemas para o sucesso organizacional.
Autoriza a estrutura de funções e plataformas de desenvolvimento de sistemas.
Define a estratégia de gerenciamento de recursos no desenvolvimento de sistemas e autoriza a alocação de recursos para programas de desenvolvimento de sistemas.', 'Directs the definition, implementation and continual improvement of the organisation’s systems development management framework.
Aligns systems development to business strategies and objectives and with emerging technology and digital opportunities. Maintains an overview of the contribution of systems development programmes to organisational success.
Authorises the structure of systems development functions and platforms.
Sets strategy for resource management within systems development and authorises the allocation of resources for systems development programmes.'),
(15295, 1, 'Segue procedimentos acordados para realizar instalações simples, substituir consumíveis e verificar o funcionamento correto das instalações.
Emite documentos e relatórios sobre o trabalho realizado.', 'Follows agreed procedures to perform simple installations, replace consumable items and check the correct working of installations.
Documents and reports on work done.'),
(15295, 2, 'Instala ou remove componentes de sistema, usando as instruções e ferramentas de instalação fornecidas.
Conduz testes padrão e contribui para investigações de problemas e falhas.
Confirma o funcionamento correto das instalações.
Documenta os resultados de acordo com os procedimentos acordados.', 'Installs or removes system components using supplied installation instructions and tools.
Conducts standard tests and contributes to investigations of problems and faults.
Confirms the correct working of installations.
Documents results in accordance with agreed procedures.'),
(15295, 3, 'Instala ou remove hardware e/ou software usando as instruções e ferramentas de instalação fornecidas, incluindo a liberação ao cliente.
Utiliza procedimentos padrão e ferramentas de diagnóstico para testar instalações, corrigir problemas e documentar resultados.
Registra detalhes de todos os componentes que foram instalados e removidos. Fornece assistência aos usuários e segue os procedimentos acordados para ajuda mais aprofundada ou encaminhamento.
Contribui para o desenvolvimento de procedimentos e normas de instalação.', 'Installs or removes hardware and/or software, using supplied installation instructions and tools, including handover to the client.
Uses standard procedures and diagnostic tools to test installations, correct problems, and document results.
Records details of all components that have been installed and removed. Assists users and follows agreed procedures for further help or escalation.
Contributes to the development of installation procedures and standards.'),
(15295, 4, 'Realiza ou supervisiona instalações e desinstalações complexas de sistemas ou componentes, incluindo a liberação ao cliente.
Desenvolve procedimentos e normas para instalação e liberação para manter e melhorar o serviço de instalação.
Agenda os trabalhos de instalação de acordo com as prioridades do cliente e da disponibilidade de recursos.
Garante o cumprimento dos procedimentos de segurança e qualidade estabelecidos.', 'Undertakes or supervises complex installations and de-installations of systems or components, including handover to the client.
Develops procedures and standards for installation and handover to maintain and improve the installation service.
Schedules installation work around client priorities and resource availability.
Ensures adherence to established safety and quality procedures.'),
(15295, 5, 'Assume a responsabilidade pelos projetos de instalação e/ou desativação.
Fornece liderança de equipe eficaz, incluindo fluxo de informações de e para o cliente durante os trabalhos do projeto.
Desenvolve e implementa planos de qualidade e declarações de métodos.
Monitora a eficácia das instalações e garante que recomendações apropriadas para mudanças sejam feitas.', 'Takes responsibility for installation and/or decommissioning projects.
Provides effective team leadership, including information flow to and from the customer during project work.
Develops and implements quality plans and method statements.
Monitors the effectiveness of installations and ensures appropriate recommendations for change are made.'),
(15296, 2, 'Produzir compilações de software a partir de componentes do sistema usando ferramentas e processos de automação de construção apropriados.
Realizar testes conforme definido em uma especificação de testes de integração e registrar detalhes de falhas.
Analisar e relatar atividades e resultados de testes de integração.
Identificar e relatar problemas e riscos.', 'Produces builds from system components using appropriate build automation tools and processes.
Conducts tests as defined in an integration test specification and records the details of any failures.
Analyses and reports on integration test activities and results.
Identifies and reports issues and risks.'),
(15296, 3, 'Define os módulos e componentes e dependências necessários para uma construção de integração e produz uma definição de construção.
Aceita os módulos e componentes completos, verificando se eles cumprem os critérios definidos. Produz builds a partir de componentes do sistema para carregamento em ambientes de destino.
Configura o hardware, software e ambiente de infraestrutura conforme exigido pelo sistema que está sendo integrado.
Produz as especificações de testes de integração, realiza os testes e registra e relata os resultados. Diagnostica falhas e documenta os resultados dos testes. Produz relatórios de integração do sistema.', 'Defines the modules and components and dependencies needed for an integration build and produces a build definition.
Accepts completed modules and components, checking that they meet defined criteria. Produces builds from system components for loading onto target environments.
Configures the hardware, software and infrastructure environment as required by the system being integrated.
Produces integration test specifications, conducts tests and records and reports on outcomes. Diagnoses faults and documents the results of tests. Produces system integration reports.'),
(15296, 4, 'Fornece conhecimentos técnicos para permitir a configuração de componentes do sistema e equipamentos para testes de sistemas.
Colabora com equipes técnicas para desenvolver e entrar em acordo sobre planos de integração de sistemas e reportar o seu progresso. Define compilações de integração complexas/novas. Garante que os ambientes de teste de integração estejam configurados corretamente.
Projeta, executa e reporta os resultados dos testes do build de integração. Identifica e documenta os componentes de integração do sistema para registro no sistema de gerenciamento de configuração.
Recomenda e implementa melhorias nos processos e ferramentas.', 'Provides technical expertise to enable the configuration of system components and equipment for systems testing.
Collaborates with technical teams to develop and agree system integration plans and report on progress. Defines complex/new integration builds. Ensures integration test environments are correctly configured.
Designs, performs and reports results of tests of the integration build. Identifies and documents system integration components for recording in the configuration management system.
Recommends and implements improvements to processes and tools.'),
(15296, 5, 'Planeja e conduz atividades para desenvolver recursos organizacionais para integração e construção de sistemas, incluindo automação e integração contínua.
Identifica, avalia e gerencia a adoção de ferramentas, técnicas e processos para criar uma estrutura de integração robusta. Oferece aconselhamento e orientação confiáveis sobre qualquer aspecto da integração de sistemas.
Orienta o trabalho de integração, de acordo com o sistema e design de serviço acordados. Avalia riscos e toma medidas preventivas. Mede e monitora as aplicações de normas.
Contribui para o desenvolvimento de políticas organizacionais, normas e diretrizes para integração de sistemas.', 'Plans and drives activities to develop organisational systems integration and build capabilities including automation and continuous integration.
Identifies, evaluates and manages the adoption of tools, techniques and processes to create a robust integration framework. Provides authoritative advice and guidance on any aspect of systems integration.
Leads integration work in line with the agreed system and service design. Assesses risks and takes preventative action. Measures and monitors applications of standards.
Contributes to the development of organisational policies, standards and guidelines for systems integration.'),
(15296, 6, 'Orienta o desenvolvimento da integração e construção de sistemas organizacionais, incluindo automação e integração contínua.
Desenvolve políticas organizacionais, normas e diretrizes para integração e construção de sistemas.
Fornece recursos para garantir que a integração e a criação de sistemas possam operar de forma eficaz, garantindo a adoção e adesão às políticas e padrões.', 'Leads the development of organisational systems integration and build capabilities including automation and continuous integration.
Develops organisational policies, standards and guidelines for systems integration and build.
Provides resources to ensure systems integration and build can operate effectively and ensures adoption and adherence to policies and standards.'),
(921, 2, 'Contribui para a entrega de aspectos de computação e trilhas de ensino em TI, em um contexto educacional formal.
Aplica boas práticas na aprendizagem de design de conteúdo, desenvolvimento e entrega.
Avalia o desempenho do aluno em aspectos de uma área curricular, fornecendo suporte para melhorar a compreensão do aluno conforme necessário.', 'Contributes to the delivery of aspects of computing and IT curricula in a formal educational context.
Applies good practice in learning content design, development and delivery.
Assesses student performance in aspects of a curriculum area, providing support to enhance student understanding as needed.'),
(921, 3, 'Oferece a maior parte de uma trilha de ensino.
Aplica boas práticas na aprendizagem de design de conteúdo, desenvolvimento e entrega. Mantém a conscientização sobre a importância da pesquisa pedagógica e de domínio.
Avalia o desempenho do aluno em uma trilha de ensino.
Fornece feedback e suporte para ajudar os alunos a melhorar sua compreensão.', 'Delivers the majority of a curriculum.
Applies good practice in learning content design, development and delivery. Maintains awareness of relevant pedagogical and domain research.
Assesses student performance across a curriculum.
Provides feedback and support to help students improve their understanding.'),
(921, 4, 'Entrega trilhas de ensino.
Aplica boas práticas apoiadas por pesquisa pedagógica para a concepção, desenvolvimento e entrega de conteúdo de aprendizagem.
Avalia o desempenho do aluno e analisa o desempenho do grupo.
Fornece aconselhamento e auxilia os alunos a permitir a realização dos objetivos de aprendizagem.', 'Delivers a curriculum.
Applies good practice supported by pedagogical research to learning content design, development and delivery.
Assesses student performance and reviews cohort performance.
Advises and assists students to enable the achievement of learning objectives.'),
(921, 5, 'Lidera o ensino e a avaliação de uma trilha de ensino ou roteiros de aprendizagem.
Implementa estratégias de aprimoramento de ensino e avaliação. Revê pesquisas e práticas pedagógicas relevantes para os tópicos das trilhas de ensino. Aplica boas práticas de ensino na concepção, desenvolvimento e entrega de conteúdos de aprendizagem.
Contribui para o desenvolvimento e implementação de práticas pedagógicas especializadas necessárias à trilha de ensino.
Avalia e monitora as realizações dos alunos e a eficácia das atividades em toda trilha de ensino. Fornece aconselhamento sobre o uso de pedagogia adequada e abordagens de avaliação.', 'Leads the teaching and assessment of a curriculum or learning pathway.
Implements enhancement strategies for teaching and assessment. Reviews pedagogical research and practices relevant to topics in the curricula. Applies good teaching practices in learning content design, development and delivery.
Contributes to the development and implementation of specialist teaching practices needed by the curriculum.
Evaluates and monitors student achievements and the effectiveness of teaching activities across the curriculum. Advises on the use of appropriate pedagogies and assessment approaches.'),
(921, 6, 'Orienta o ensino, avaliação e aprimoramento de uma variedade de trilhas de ensino ou roteiros de aprendizagem.
Revisa e avalia criticamente pesquisas e práticas pedagógicas relevantes para as trilhas de ensino. Desenvolve e orienta a introdução de práticas de ensino avançadas ou especializadas.
Orienta e apoia terceiros no desenvolvimento de boas práticas em design, desenvolvimento e entrega de conteúdo de aprendizagem.
Acompanha, avalia e reporta o desempenho das atividades de ensino e avaliação no âmbito das suas áreas de responsabilidade.', 'Leads the teaching, assessment and enhancement of a range of curricula or learning pathways.
Reviews and critically evaluates pedagogical research and practices relevant to the curricula. Develops and leads the introduction of advanced or specialist teaching practices.
Leads and supports others in the development of good practice in learning content design, development and delivery.
Monitors, evaluates and reports the performance of teaching and assessment activities within their areas of responsibility.'),
(921, 7, 'Autoriza estratégias de ensino, avaliação e aprimoramento para uma ampla gama de trilhas de ensino ou roteiros de aprendizagem.
Dirige a definição, implementação e monitoramento do ensino para satisfazer as referências e estruturas estatutárias e profissionais relevantes.
Garante recursos para cumprir os compromissos de ensino da organização.
Monitora e avalia o domínio relevante e a pesquisa pedagógica para identificar e implementar melhorias na entrega das trilhas de ensino.', 'Authorises teaching, assessment and enhancement strategies for a broad range of curricula or learning pathways.
Directs the definition, implementation and monitoring of teaching to satisfy relevant statutory and professional benchmarks and frameworks.
Secures resources to deliver the organisation''s teaching commitments.
Monitors and evaluates relevant domain and pedagogical research to identify and implement improvements to the delivery of the curricula.'),
(15299, 5, 'Assume a responsabilidade de gerenciar o projeto, aquisição, instalação, atualização, operação, controle, manutenção e uso efetivo do serviço de tecnologia específico.
Conduz a entrega de serviços, garantindo que os níveis de serviço pré-estabelecidos, requisitos de segurança e outros padrões de qualidade sejam atendidos. Garante a aderência às políticas e procedimentos relevantes.
Garante que os processos e práticas estejam alinhados entre equipes e fornecedores, para operar de forma eficaz e eficiente.
Monitora o desempenho dos serviços de tecnologia. Fornece os relatórios apropriados da condição atual, entre outros, para gerentes e usuários seniores.', 'Takes responsibility for managing the design, procurement, installation, upgrading, operation, control, maintenance and effective use of specific technology services.
Leads service delivery, ensuring agreed service levels, security requirements and other quality standards are met. Ensures adherence to relevant policies and procedures.
Ensures processes, procedures and practices are aligned across teams and providers to operate effectively and efficiently.
Monitors technology services performance. Provides appropriate status and other reports to managers and senior users.'),
(15299, 6, 'Gerencia e aloca recursos para orçamento, estimativa, planejamento, desenvolvimento e entrega de um portfólio de serviços e sistemas tecnológicos.
Engage e influencia as partes interessadas para garantir que os serviços sejam desenvolvidos e gerenciados para atender aos níveis de serviço acordados, requisitos de segurança e padrões de qualidade.
Planeia e implementa processos, procedimentos, ferramentas e práticas para monitorar e gerenciar o desempenho dos serviços tecnológicos.
Alinha a contribuição de sistemas e serviços especificados com objetivos organizacionais e financeiros. Recomende opções de aquisição, seja interna, externalizada ou combinada, garantindo a entrega de serviços ideal.', 'Manages and allocates resources for budgeting, estimating, planning, developing and delivering a portfolio of technology services and systems.
Engages and influences stakeholders to ensure services are developed and managed to meet agreed service levels, security requirements and quality standards.
Plans and implements processes, procedures, tools and practices for monitoring and managing the performance of technology services.
Aligns the contribution of specified systems and services with organisational and financial goals. Recommends sourcing options, whether in-house, outsourced, or a combination, ensuring optimal service delivery.'),
(15299, 7, 'Define a direção estratégica para a gestão do portfólio de serviços de tecnologia, garantindo a alinhamento com as estratégias organizacionais, objetivos e oportunidades emergentes.
Promove e avalia o potencial da tecnologia para impulsionar a mudança, avaliando a viabilidade e o impacto.
Autoriza o estabelecimento e integração de capacidades de prestação de serviços novas ou modificadas, equilibrando opções internas e externalizadas. Supervisiona a alocação de recursos para planejamento, desenvolvimento e entrega de serviços e produtos técnicos.
Mantenha uma visão estratégica de como os serviços de tecnologia contribuem para o sucesso organizacional.', 'Sets the strategic direction for managing the technology services portfolio, ensuring alignment with organisational strategies, objectives and emerging opportunities.
Promotes and assesses technology''s potential to drive change, evaluating feasibility and impact.
Authorises the establishment and integration of new or modified service delivery capabilities, balancing in-house and outsourced options. Oversees resource allocation for planning, developing and delivering technical services and products.
Maintains a strategic overview of how technology services contribute to organisational success.'),
(6641, 2, 'Contribui com tarefas rotineiras de coleta de inteligência de ameaças.
Monitora e detecta possíveis ameaças à segurança e encaminha de acordo com os procedimentos e padrões pertinentes.', 'Contributes to routine threat intelligence gathering tasks.
Monitors and detects potential security threats and escalates in accordance with relevant procedures and standards.'),
(6641, 3, 'Executa tarefas rotineiras de coleta de informações sobre ameaças.
Transforma as informações coletadas em um formato de dados que pode ser usado para atividades de segurança operacional.
Limpa e converte informações quantitativas em formatos consistentes.', 'Performs routine threat intelligence gathering tasks.
Transforms collected information into a data format that can be used for operational security activities.
Cleans and converts quantitative information into consistent formats.'),
(6641, 4, 'Reúne e analisa informações para requisitos de modelagem de ameaças de várias fontes.
Contribui para revisar, classificar e categorizar informações qualitativas de modelagem de ameaças.
Cria relatórios de modelagem de ameaças.
Avalia o valor, a utilidade e o impacto das fontes de modelagem de ameaças.', 'Collates and analyses information for threat intelligence requirements from a variety of sources.
Contributes to reviewing, ranking and categorising qualitative threat intelligence information.
Creates threat intelligence reports.
Evaluates the value, usefulness and impact of threat intelligence sources.'),
(6641, 5, 'Planeja e gerencia atividades de inteligência de ameaças.
Oferece consultoria especializada em atividades de inteligência de ameaças. Identifica quais são as categorias de ameaças mais impactantes e quais tipos de informações podem ajudar na defesa contra elas.
Analisa, classifica e categoriza informações qualitativas de inteligência de ameaças.
Orienta a produção e edição de relatórios de modelagem de ameaças que aprimoram o fluxo de trabalho de produção de inteligência. Distribui informações e obtém feedback sobre o valor, utilidade e impacto dos dados.', 'Plans and manages threat intelligence activities.
Identifies the most impactful threat categories and types of information that can help defend against them. Reviews, ranks and categorises qualitative threat intelligence information.
Provides expert advice on threat intelligence activities.
Leads the production and editing of threat intelligence reports that enhance the intelligence production workflow. Distributes information and obtains feedback about the value, usefulness and impact of the data.'),
(6641, 6, 'Define a direção, planeja e lidera a abordagem da organização para inteligência de ameaças, incluindo o uso de fornecedores.
Identifica as necessidades de inteligência de ameaças com base nos ativos a serem protegidos e nos tipos de inteligência que podem ajudar a protegê-los.
Envolve e influencia as partes interessadas relevantes para comunicar os resultados das pesquisas e a resposta necessária.
Garante a qualidade e precisão das informações de inteligência de ameaças. Revisa as capacidades de inteligência de ameaças.', 'Sets direction, plans and leads the organisation’s approach to threat intelligence, including the use of suppliers.
Identifies requirements for threat intelligence based on the assets to be protected and the types of intelligence that can help protect those assets.
Engages with and influences relevant stakeholders to communicate results of research and the required response.
Ensures quality and accuracy of threat intelligence information. Reviews threat intelligence capabilities.'),
(15300, 2, 'Auxilia no planejamento e preparação de testes de aceitação para sistemas, produtos, processos comerciais ou serviços.
Auxilia na coleta de feedback de testes de aceitação.', 'Assists in planning and preparing acceptance tests for systems, products, business processes or services.
Assists in collecting feedback from acceptance testing.'),
(15300, 3, 'Segue padrões e técnicas acordados para elaborar casos e cenários de teste baseados em critérios de aceitação predefinidos.
Analisa e relata atividades de teste, resultados, problemas e riscos.', 'Follows agreed standards and techniques to devise test cases and scenarios based on pre-defined acceptance criteria.
Analyses and reports on test activities, results, issues and risks.'),
(15300, 4, 'Desenvolve critérios de aceitação relacionados a requisitos funcionais e não funcionais, processos comerciais, recursos, histórias de usuários e regras de negócios.
Desenha e especifica casos e cenários de teste para verificar se os sistemas, produtos e serviços atendem aos critérios de aceitação e proporcionam os benefícios de negócios previstos.
Colabora com os colegas de projeto e as partes interessadas envolvidas na análise, desenvolvimento e uso operacional de produtos, sistemas ou serviços para a exatidão e uma cobertura de teste abrangente.
Analisa e relata atividades de teste, resultados, problemas e riscos, incluindo o trabalho de outras pessoas.', 'Develops acceptance criteria related to functional and non-functional requirements, business processes, features, user stories and business rules.
Designs and specifies test cases and scenarios to test that systems, products and services fulfil the acceptance criteria and deliver the predicted business benefits.
Collaborates with project colleagues and stakeholders involved in the analysis, development and operation of products, systems or services to ensure accuracy and comprehensive test coverage.
Analyses and reports on test activities, results, issues and risks including the work of others.'),
(15300, 5, 'Planeja e gerencia a atividade de teste de aceitação do usuário.
Especifica o ambiente de teste. Gerencia a criação de casos e cenários de teste, garantindo que eles reflitam condições operacionais realistas e necessidades de cobertura.
Assegura que os critérios de entrada e saída sejam definidos e cumpridos antes de os testes de aceitação de usuários começarem ou terminarem. Especifica os recursos de usuário necessários. Assegura que os usuários recebam treinamento e suporte adequados.
Assegura que os testes e resultados sejam documentados, analisados e reportados, destacando os problemas e riscos para as partes interessadas. Fornece aconselhamento autorizado sobre o planejamento e execução de testes de aceitação.', 'Plans and manages user acceptance testing activity.
Specifies the testing environment. Manages the creation of test cases and scenarios, ensuring they reflect realistic operational conditions and coverage needs.
Ensures entry and exit criteria are set and met before user acceptance testing starts or ends. Specifies required user resources. Ensures users receive appropriate training and support.
Ensures tests and results are documented, analysed and reported, highlighting issues and risks to stakeholders. Provides authoritative advice on acceptance testing planning and execution.'),
(15300, 6, 'Dirige a abordagem da organização para testes de aceitação de usuários.
Convoca as partes interessadas seniores para garantir o compromisso e os recursos da organização para testes de aceitação eficazes.
Integra critérios de entrada e saída no planejamento e execução de testes de aceitação de usuários. Fornece informações sobre os recursos necessários, incluindo habilidades e disponibilidade, para atividades de testes de aceitação de usuários. Relatórios sobre quaisquer riscos e problemas significativos, recomendando ações conforme necessário.
Desenvolve políticas, padrões e diretrizes organizacionais para testes de aceitação. Desenvolve capacidades e métodos de testes de aceitação para a organização.', 'Leads the organisation''s approach to user acceptance testing.
Engages senior stakeholders to secure organisational commitment and resources for effective acceptance testing.
Integrates entry and exit criteria into user acceptance testing planning and execution. Provides input on required resources, including skills and availability, for user acceptance testing activities. Reports on any significant risks and issues, recommending actions as needed.
Develops organisational policies, standards and guidelines for acceptance testing. Develops acceptance testing capabilities and methods for the organisation.'),
(15301, 2, 'Auxilia com tarefas de análise de experiência do usuário sob supervisão de rotina.
Dá suporte à coleta e documentação de requisitos do usuário.
Ajuda a organizar e estruturar dados de experiência do usuário para análise.', 'Assists with user experience analysis tasks under routine supervision.
Supports the collection and documentation of user requirements.
Helps organise and structure user experience data for analysis.'),
(15301, 3, 'Aplica técnicas e ferramentas padrão para desenvolver histórias de usuários e obter requisitos de experiência do usuário.
Organiza e estruturar a análise da experiência do usuário.
Trabalha com as partes interessadas para priorizar requisitos e resolver conflitos.', 'Applies standard techniques and tools for developing user stories and eliciting user experience requirements.
Organises and structures user experience analysis.
Works with stakeholders to prioritise requirements and resolve conflicts.'),
(15301, 4, 'Seleciona técnicas e ferramentas apropriadas para desenvolver histórias de usuários e obter requisitos de experiência do usuário em situações complexas.
Identifica e descrever os objetivos do projeto de sistemas, produtos e serviços.
Identifica as funções dos grupos de partes interessadas afetados. Resolve potenciais conflitos entre diferentes requisitos do usuário.
Especifica critérios mensuráveis ​​para a usabilidade necessária e acessibilidade do sistema, produtos e serviços.', 'Selects appropriate techniques and tools to develop user stories and elicit user experience requirements in complex situations.
Identifies and describes the design goals for systems, products, services and devices.
Identifies the roles of affected stakeholder groups. Resolves potential conflicts between differing user requirements.
Specifies measurable criteria for the required usability and accessibility of systems, products, services and devices.'),
(15301, 5, 'Determina as abordagens a serem utilizadas para análise da experiência do usuário.
Planeja e gerencia a experiência do usuário e as atividades de análise de acessibilidade.
Oferece consultoria especializada e orientação para apoiar a adoção e adaptação de abordagens acordadas.
Desenvolve ferramentas, técnicas e padrões de experiência do usuário, como parte da estrutura da organização para projeto centrado no usuário.', 'Determines the approaches to be used for user experience analysis.
Plans and manages user experience and accessibility analysis activities.
Provides expert advice and guidance to support the adoption and adaptation of agreed approaches.
Develops user experience tools, techniques and standards as part of the organisation''s framework for user-centred design'),
(15302, 2, 'Ajuda a criar elementos de experiência do usuário sob supervisão de rotina.
Segue procedimentos e diretrizes estabelecidos.
Ajuda a criar e manter a documentação.', 'Assists in creating user experience elements under routine supervision.
Follows established procedures and guidelines.
Helps create and maintain documentation.'),
(15302, 3, 'Aplica técnicas e ferramentas padrão para projetar interações e experiências do usuário com componentes de sistema, produto ou serviço.
Analisa os objetivos de projeto e os requisitos de segurança, usabilidade e acessibilidade acordados. Cria artefatos de design para comunicar ideias.
Auxilia, como parte de uma equipe, no projeto geral da experiência do usuário.
Auxilia na avaliação de opções de projeto e trade-offs. Considera e aplica diretrizes de design visual e branding de forma consistente, quando apropriado.', 'Applies standard techniques and tools for designing user interactions with and experiences of selected system, product or service components.
Reviews design goals and agreed security, usability and accessibility requirements. Creates design artefacts to communicate ideas.
Contributes to overall user experience design as part of a team.
Assists in evaluating design options and trade-offs. Considers and applies visual design and branding guidelines consistently when appropriate.'),
(15302, 4, 'Seleciona ferramentas, métodos e padrões de projeto apropriados para projetar interações do usuário com e experiências de um produto, sistema ou serviço.
Traduz conceitos em saídas e protótipos para feedback e avaliação do usuário.
Avalia opções de projeto alternativas e recomenda projetos levando em consideração requisitos de desempenho, segurança, usabilidade e acessibilidade.
Considera e integra elementos de projeto visual e de marca apropriados em projetos de experiência do usuário.', 'Selects appropriate tools, methods and design patterns to design user interactions with and experiences of a product, system or service.
Translates concepts into outputs and prototypes for user feedback and evaluation.
Evaluates alternative design options and recommends designs taking into account performance, security, usability and accessibility requirements.
Considers and integrates appropriate visual design and branding elements in user experience designs.'),
(15302, 5, 'Planeja e conduz atividades de projeto de experiência do usuário.
Fornece consultoria especializada e orientação para apoiar a adoção de abordagens acordadas. Determina as abordagens a serem usadas para projetar a experiência do usuário.
Usa abordagens iterativas para incorporar rapidamente o feedback do usuário em projetos.
Garante a consideração e integração apropriadas de elementos de design visual e branding no projeto da experiência do usuário.', 'Plans and drives user experience design activities.
Provides expert advice and guidance to support the adoption of agreed approaches. Determines the approaches to be used to design user experiences.
Uses iterative approaches to incorporate user feedback or evaluation rapidly into designs.
Ensures appropriate consideration and integration of visual design and branding elements into user experience design.'),
(15302, 6, 'Obtém compromisso organizacional com as estratégias para fornecer a experiência do usuário, usabilidade, acessibilidade e segurança necessárias.
Define políticas organizacionais, padrões e técnicas de projeto de experiência do usuário.
Planeja e conduz atividades de projeto de experiência do usuário em programas estratégicos, grandes e complexos.
Promove o valor do design centrado no usuário em toda a organização.', 'Obtains organisational commitment to strategies to deliver required user experience, usability, accessibility and security.
Defines organisational policies, standards and techniques for user experience design.
Plans and leads user experience design activities for strategic, large or complex programmes.
Promotes the value of user-centred design across the organisation.'),
(15303, 2, 'Auxilia na preparação e operação do ambiente, instalações e ferramentas necessárias para avaliar sistemas, produtos, serviços ou dispositivos.
Auxilia na coleta de feedback sobre protótipos e projetos de usuários e terceiros.', 'Assists in preparing and operating the environment, facilities and tools needed to evaluate systems, products, services or devices.
Assists in the collection of feedback on prototypes and designs from users and others.'),
(15303, 3, 'Avalia opções de projeto e protótipos para obter feedback do usuário sobre os requisitos de desenvolvimento de sistemas, produtos, serviços ou dispositivos.
Testa a usabilidade e acessibilidade de componentes e projetos alternativos. Administra uma série de avaliações, registrando dados e feedbacks. Analisa dados de avaliação e recomenda ações. Identifica áreas para pesquisa futura com usuários.
Verifica os sistemas, produtos, serviços ou dispositivos quanto à sua aderência às normas, diretrizes, guias de estilo e legislação aplicáveis.
Avalia a usabilidade de sistemas existentes ou concorrentes para fornecer valores de referência e como base para o projeto.', 'Evaluates design options and prototypes to obtain user feedback on requirements of developing systems, products, services or devices.
Tests the usability and accessibility of components and alternative designs. Administers a range of evaluations, recording data and feedback. Analyses evaluation data and recommends actions. Identifies areas for future user research.
Checks systems, products, services or devices for adherence to applicable standards, guidelines, style guides and legislation.
Evaluates the usability of existing or competitor systems to provide benchmark values and as input to design.'),
(15303, 4, 'Seleciona ferramentas e técnicas apropriadas para avaliar as experiências do usuário com produtos, sistemas, serviços ou dispositivos.
Valida se os requisitos de segurança, usabilidade e acessibilidade foram atendidos.
Verifica sistemas operacionais, produtos, serviços ou dispositivos para mudanças nas necessidades de usabilidade e acessibilidade.
Interpreta e apresenta resultados de avaliações, prioriza problemas e relata ações corretivas. Reúne feedbacks para pesquisas futuras com usuários.', 'Selects appropriate tools and techniques to evaluate user experiences of systems, products, services or devices.
Validates that security, usability and accessibility requirements have been met.
Checks operational systems, products, services or devices for changes in usability and accessibility needs.
Interprets and presents results of evaluations, prioritises issues and reports on remedial actions. Collates input for future user research.'),
(15303, 5, 'Gerencia a avaliação da experiência do usuário de sistemas, produtos, serviços ou dispositivos.
Garante que os requisitos de segurança, usabilidade e acessibilidade sejam atendidos e que as práticas necessárias tenham sido seguidas.
Aconselha sobre o que avaliar, o tipo de avaliação a ser usada e a extensão do envolvimento do usuário necessária. Trabalha iterativamente com equipes de projeto para garantir que o feedback da avaliação seja compreendido e agido.
Aconselha sobre a obtenção dos níveis de usabilidade e acessibilidade necessários de projetos ou protótipos específicos. Prioriza a entrada para futuras pesquisas do usuário.', 'Manages user experience evaluation of systems, products, services or devices.
Assures that the security, usability and accessibility requirements are met and required practices have been followed.
Advises on what to evaluate, type of evaluation to use and the extent of user involvement required. Works iteratively with design teams to ensure feedback from the evaluation is understood and acted upon.
Advises on the achievement of required usability and accessibility levels of specific designs or prototypes. Prioritises input for future user research.'),
(15303, 6, 'Defende padrões elevados na interação do usuário com os sistemas, produtos e serviços da organização, incluindo o envolvimento dos usuários nas atividades de avaliação.
Especifica padrões e métodos para segurança, usabilidade e acessibilidade, garantindo que tais itens sejam abordados em projetos futuros.
Desenvolve ou fornece recursos e capacidades para realizar uma avaliação eficaz da experiência do usuário, incluindo instalações especializadas centradas no usuário e comunidades de usuários. Conduz a provisão do feedback e os recursos para futuras pesquisas com usuários.
Colabora com parceiros internos e externos para facilitar a avaliação eficaz de sistemas, produtos e serviços.', 'Champions high standards in user interaction with the organisation’s systems, products and services including involvement of users in evaluation activities.
Specifies standards and methods for security, usability and accessibility and ensure this is addressed in future designs.
Develops or sources resources and capabilities to conduct effective user experience evaluation, including specialist user-centred facilities and communities of users. Leads the provision of input and resources for future user research.
Collaborates with internal and external partners to facilitate an effective evaluation of systems, products and services.'),
(9012, 2, 'Ajuda com tarefas de pesquisa do usuário sob supervisão de rotina.
Apoia a coleta e documentação da pesquisa do usuário.
Ajuda a organizar e compartilhar os resultados das atividades de pesquisa do usuário.
Participa de atividades básicas de projeto centrado no usuário conforme instruções.', 'Assists with user research tasks under routine supervision.
Supports the collection and documentation of user research.
Helps organise and share the outcomes of user research activities.
Participates in basic user-centred design activities as directed.'),
(9012, 3, 'Aplica métodos padrão para dar suporte a iniciativas de pesquisa de usuários.
Envolve-se efetivamente com usuários e representantes de clientes para gerar pesquisas de alta qualidade.
Documenta e compartilha os resultados da pesquisa do usuário.
Contribui para tarefas de análise e projeto de pesquisa sob orientação.', 'Applies standard methods to support user research initiatives.
Engages effectively with users and customer representatives to generate high-quality research.
Documents and shares the outcomes of user research.
Contributes to research design and analysis tasks under guidance.'),
(9012, 4, 'Conduz pesquisas generativas para o desenvolvimento de sistemas, produtos, serviços ou dispositivos.
Planeja as próprias atividades de pesquisa do usuário. Facilita a entrada de usuários e partes interessadas.
Identifica métodos apropriados de pesquisa de usuário.
Coleta e analisa dados de pesquisa do usuário. Oferece suporte à síntese de pesquisas e a criação de insights, relatórios e apresentações.', 'Conducts generative research for the development of systems, products, services or devices.
Plans own user research activities. Facilitates input from users and stakeholders.
Identifies appropriate user research methods for specific questions and contexts.
Collects and analyses user research data. Supports synthesis of research and the creation of insights, reports and presentations.'),
(9012, 5, 'Planeja e conduz atividades de pesquisa de usuários, fornecendo consultoria e orientação especializada para dar suporte à adoção de abordagens pré-definidas.
Seleciona e implementar métodos apropriados para envolver usuários em atividades de pesquisa generativas.
Conduz a coleta e análise de dados de pesquisa de usuários. Sintetiza pesquisas, desenvolve insights e apresenta conclusões para informar a tomada de decisões e impulsionar ações.
Conduz iniciativas complexas de pesquisa de usuários e identifica necessidades e tendências emergentes de usuários. Contribui para o desenvolvimento de métodos e padrões organizacionais para pesquisa de usuários.', 'Plans and drives user research activities providing expert advice and guidance to support the adoption of agreed approaches.
Selects and implements appropriate methods for engaging users in generative research activities.
Leads the collection and analysis of user research data. Synthesises research, develops insights and presents conclusions to inform decision-making and drive actions.
Leads complex user research initiatives and identifies emerging user needs and trends. Contributes to the development of organisational methods and standards for user research.'),
(9012, 6, 'Define a visão geral e a direção para as atividades de pesquisa do usuário.
Defende o projeto centrado no usuário e assegura o comprometimento organizacional com o envolvimento significativo dos usuários na pesquisa.
Desenvolve políticas, padrões e diretrizes organizacionais para pesquisa do usuário.
Desenvolve ou fornecer recursos e capacidades organizacionais para facilitar a adoção e a exploração da pesquisa do usuário. Colabora com parceiros internos e externos para facilitar a pesquisa eficaz do usuário.', 'Sets the overall vision and direction for user research activities.
Champions user-centred design and secures organisational commitment to the significant involvement of users in research.
Develops organisational policies, standards and guidelines for user research.
Develops or sources organisational resources and capabilities to facilitate the adoption and exploitation of user research. Collaborates with internal and external partners to facilitate effective user research.'),
(15304, 2, 'Executa avaliações rotineiras de vulnerabilidade de baixa complexidade, usando ferramentas automatizadas e semi automatizadas.
Escala problemas quando aplicável.
Contribui para documentar o escopo e avaliar os resultados das avaliações de vulnerabilidade.', 'Undertakes low-complexity routine vulnerability assessments using automated and semi-automated tools.
Escalates issues where appropriate.
Contributes to documenting the scope and evaluating the results of vulnerability assessments.'),
(15304, 3, 'Segue abordagens padrão para realizar avaliações básicas de vulnerabilidade em sistemas de informação de pequeno porte.
Oferece suporte à criação de catálogos de informações e ativos de tecnologia para a avaliação da vulnerabilidade.', 'Follows standard approaches to perform basic vulnerability assessments for small information systems.
Supports creation of catalogues of information and technology assets for vulnerability assessment.'),
(15304, 4, 'Reúne e analisa catálogos de ativos de informação e tecnologia para avaliação de vulnerabilidades.
Realiza avaliações de vulnerabilidade e análise de impacto ao negócio (BIA) em sistemas de informação de média complexidade.
Contribui para a seleção e implantação de ferramentas e técnicas de avaliação de vulnerabilidade.', 'Collates and analyses catalogues of information and technology assets for vulnerability assessment.
Performs vulnerability assessments and business impact analysis for medium complexity information systems.
Contributes to selection and deployment of vulnerability assessment tools and techniques.'),
(15304, 5, 'Planeja e gerencia as atividades de avaliação de vulnerabilidades dentro da organização.
Avalia e seleciona, analisa ferramentas e técnicas de avaliação de vulnerabilidade.
Fornece aconselhamento e orientação especializados para oferecer suporte à adoção das abordagens pré-estabelecidas.
Obtém e atua em relação a informações de vulnerabilidade e realiza avaliações de risco de segurança, análises de impacto ao negócio (BIA) e homologação de sistemas de informação complexos.', 'Plans and manages vulnerability assessment activities within the organisation.
Evaluates, selects and reviews vulnerability assessment tools and techniques.
Provides expert advice and guidance to support the adoption of agreed approaches.
Obtains and acts on vulnerability information and conducts security risk assessments, business impact analysis and accreditation on complex information systems.'),
(15305, 2, 'Ajuda com tarefas de pesquisa de vulnerabilidades sob supervisão de rotina.
Ajuda a documentar e relatar as descobertas das atividades de pesquisa de vulnerabilidades.', 'Assists with vulnerability research tasks under routine supervision.
Helps document and report findings from vulnerability research activities.'),
(15305, 3, 'Aplica técnicas e ferramentas padrão para pesquisa de vulnerabilidades.
Usa os recursos disponíveis para atualizar o conhecimento de especialidades relevantes.
Participa de comunidades de pesquisa.
Analisa e reporta atividades e resultados.', 'Applies standard techniques and tools for vulnerability research.
Uses available resources to update knowledge of relevant specialism.
Participates in research communities.
Analyses and reports on activities and results.'),
(15305, 4, 'Projeta e executa atividades complexas de pesquisa de vulnerabilidades.
Especifica requisitos de ambiente, dados, recursos e ferramentas para realizar avaliações.
Revisa os resultados dos testes e modifica os testes, se necessário. Cria relatórios para comunicar metodologia, descobertas e conclusões. Oferece aconselhamento sobre métodos de fraudes explorando padrões identificados.
Contribui ativamente emcomunidades de pesquisa.', 'Designs and executes complex vulnerability research activities.
Specifies requirements for environment, data, resources and tools to perform assessments.
Reviews test results and modifies tests if necessary. Creates reports to communicate methodology, findings and conclusions. Advises on deception methods by exploiting identified patterns.
Makes an active contribution to research communities.'),
(15305, 5, 'Planeja e gerencia atividades de pesquisa de vulnerabilidades.
Mantém uma forte rede externa na área de pesquisa de vulnerabilidades. Reúne informações sobre ameaças e vulnerabilidades novas e emergentes.
Avalia e documenta os impactos e ameaças à organização. Cria relatórios e compartilha conhecimento e insights com as partes interessadas.
Fornece aconselhamento especializado e orientação para apoiar a adoção de ferramentas e técnicas de pesquisa de vulnerabilidades. Contribui para o desenvolvimento de políticas organizacionais, normas e diretrizes para pesquisa e avaliação de vulnerabilidades.', 'Plans and manages vulnerability research activities.
Maintains a strong external network for vulnerability research. Gathers information on new and emerging threats and vulnerabilities.
Assesses and documents the impacts and threats to the organisation. Creates reports and shares knowledge and insights with stakeholders.
Provides expert advice and guidance to support the adoption of tools and techniques for vulnerability research. Contributes to the development of organisational policies, standards and guidelines for vulnerability research and assessment.'),
(15305, 6, 'Planeja e lidera a abordagem da organização para pesquisa de vulnerabilidade.
Identifica ameaças e vulnerabilidades novas e emergentes. Mantém uma forte rede externa. Participa de atividades profissionais externas para facilitar a coleta de informações e definir o escopo do trabalho.
Envolve-se e influencia as partes interessadas relevantes para comunicar os resultados da pesquisa e as respostas necessárias.
Desenvolve políticas e diretrizes organizacionais para monitorar ameaças e vulnerabilidades emergentes.', 'Plans and leads the organisation’s approach to vulnerability research.
Identifies new and emerging threats and vulnerabilities. Maintains a strong external network. Takes a leading part in external-facing professional activities to facilitate information gathering and set the scope of research work.
Engages with and influences relevant stakeholders to communicate results of research and the required response.
Develops organisational policies and guidelines for monitoring emerging threats and vulnerabilities.'),
(15306, 4, 'Reúne, mantém e analisa dados da capacidade da força de trabalho.
Realiza análises para identificar pontos fortes e deficiências com referência à estratégia de negócios e necessidades futuras específicas.
Contribui para o desenvolvimento de planos de mão de obra para atender a demanda atual e futura.
Coordena e programa as ações contínuas de planejamento da força de trabalho. Auxilia na manutenção de um inventário de habilidades e capacidades.', 'Gathers, maintains and analyses organisation-wide workforce capability data.
Performs gap analysis to identify workforce strengths and shortfalls with reference to business strategy and specific future needs.
Contributes to the development of organisation-wide workforce plans to meet current and future demand.
Coordinates and schedules ongoing workforce planning activities. Assists in maintaining a skills and capability inventory.'),
(15306, 5, 'Conduz o desenvolvimento de planos de força de trabalho para garantir a disponibilidade de recursos adequadamente qualificados para atender aos objetivos e compromissos organizacionais.
Contribui para o desenvolvimento da abordagem estratégica de planejamento da força de trabalho. Supervisiona e revisa a implantação dos planos de força de trabalho.
Desenvolve a avaliação do estado atual das habilidades, capacidades e potencial da força de trabalho. Prevê a demanda futura da força de trabalho por habilidades, com base em planos organizacionais amplos e fatores externos.
Mantém um inventário de habilidades e capacidades e identifica opções para eliminar as deficiências.', 'Leads the development of workforce plans to ensure the availability of appropriately skilled resources to meet organisational objectives and commitments.
Contributes to the development of the strategic workforce planning approach. Oversees and reviews the implementation of workforce plans.
Develops current-state assessment of workforce skills, capabilities and potential. Forecasts future workforce demand for skills based on broad organisation-wide plans and external factors.
Maintains a skills and capability inventory and identifies options for closing gaps.'),
(15306, 6, 'Define a abordagem do planejamento da força de trabalho para uma parte significativa da organização, em linha com os objetivos estratégicos de negócios.
Comunica a abordagem de planejamento da força de trabalho e obtém compromisso organizacional. Define a estrutura a ser usada para o inventário de habilidades e capacidades da organização.
Interpreta a estratégia de negócios para direcionar a previsão de demanda da força de trabalho (habilidades e números) para a organização. Monitora o ambiente externo em relação à oferta e às novas tendências.
Influencia as políticas e práticas de gestão de pessoas para alinhar aos planos de força de trabalho. Integra-se com estratégias e planos de recursos. Monitora a execução dos planos de força de trabalho.', 'Defines an integrated strategic workforce planning approach connecting organisational business goals to future skill needs.
Communicates the workforce planning approach and obtains organisational commitment. Selects frameworks to be used for the organisation''s skills and capability inventory.
Interprets business strategy to direct workforce demand forecasting (skills and numbers) for the organisation. Monitors the external environment in relation to supply and emerging trends.
Influences people management policies and practices to align with workforce plans. Integrates with resourcing strategies and plans. Monitors execution of workforce plans.'),
(15223, 3, 'Supports ethical reviews and conducts basic impact assessments under direction.
Gathers and analyses information for assessments. Reports on ethical issues and compliance with guidance from others. Documents findings from audits and reviews.
Assists with documentation and communication of ethical policies.
Supports others in responding to incidents.', 'Supports ethical reviews and conducts basic impact assessments under direction.
Gathers and analyses information for assessments. Reports on ethical issues and compliance with guidance from others. Documents findings from audits and reviews.
Assists with documentation and communication of ethical policies.
Supports others in responding to incidents.'),
(15223, 4, 'Engages stakeholders to communicate ethical considerations and influence design decisions.
Conducts detailed impact assessments and makes recommendations. Manages ethical reviews to ensure compliance with standards.
Evaluates risks and proposes measures to address ethical concerns. Leads discussions with stakeholders on ethical issues.
Designs and executes ethical impact assessments. Prepares reports based on audit findings.', 'Engages stakeholders to communicate ethical considerations and influence design decisions.
Conducts detailed impact assessments and makes recommendations. Manages ethical reviews to ensure compliance with standards.
Evaluates risks and proposes measures to address ethical concerns. Leads discussions with stakeholders on ethical issues.
Designs and executes ethical impact assessments. Prepares reports based on audit findings.'),
(15223, 5, 'Provides expert advice to integrate ethics into AI and data projects and programmes.
Oversees governance and assurance activities. Reviews and approves impact assessments and audits.
Promotes awareness of ethical principles and their application across the organisation.
Contributes to the development of policy, standards and guidelines related to AI and data ethics.', 'Provides expert advice to integrate ethics into AI and data projects and programmes.
Oversees governance and assurance activities. Reviews and approves impact assessments and audits.
Promotes awareness of ethical principles and their application across the organisation.
Contributes to the development of policy, standards and guidelines related to AI and data ethics.'),
(15223, 6, 'Sets direction for ethics in AI and data initiatives.
Defines governance processes to ensure compliance with ethical standards. Engages with industry bodies and experts to develop and drive industry recommended practices.
Develops and implements strategic ethical frameworks. Leads high-level reviews and decision-making processes.
Allocates resources to support the organisation’s commitment to ethical practices. Ensures the organisation has resources and skills for ethical assurance.', 'Sets direction for ethics in AI and data initiatives.
Defines governance processes to ensure compliance with ethical standards. Engages with industry bodies and experts to develop and drive industry recommended practices.
Develops and implements strategic ethical frameworks. Leads high-level reviews and decision-making processes.
Allocates resources to support the organisation’s commitment to ethical practices. Ensures the organisation has resources and skills for ethical assurance.'),
(15298, 3, 'Provides support for implementing systems and software lifecycle practices by applying established methods and procedures.
Supports automation and continuous integration processes under direction.
Monitors and reports on the effectiveness of lifecycle management activities.
Contributes to the documentation and maintenance of lifecycle tools and practices.', 'Provides support for implementing systems and software lifecycle practices by applying established methods and procedures.
Supports automation and continuous integration processes under direction.
Monitors and reports on the effectiveness of lifecycle management activities.
Contributes to the documentation and maintenance of lifecycle tools and practices.'),
(15298, 4, 'Elicits requirements for systems and software lifecycle working practices and automation.
Prepares design options for the working environment of methods, procedures, techniques, tools and people.
Selects systems and software lifecycle working practices for software components and micro-services.
Deploys automation to achieve well-engineered and secure outcomes.', 'Elicits requirements for systems and software lifecycle working practices and automation.
Prepares design options for the working environment of methods, procedures, techniques, tools and people.
Selects systems and software lifecycle working practices for software components and micro-services.
Deploys automation to achieve well-engineered and secure outcomes.'),
(15298, 5, 'Collaborates with those responsible for ongoing systems and software lifecycle management to select, adopt and adapt working practices.
Supports deployment of the working environment for systems and software lifecycle working practices.
Provides effective feedback to encourage development of the individuals and teams responsible for systems and software lifecycle working practices. Provides guidance and makes suggestions to support continual improvement and learning approach.
Contributes to identifying new domains within the organisation where systems and software lifecycle working practices can be deployed.', 'Collaborates with those responsible for ongoing systems and software lifecycle management to select, adopt and adapt working practices.
Supports deployment of the working environment for systems and software lifecycle working practices.
Provides effective feedback to encourage development of the individuals and teams responsible for systems and software lifecycle working practices. Provides guidance and makes suggestions to support continual improvement and learning approach.
Contributes to identifying new domains within the organisation where systems and software lifecycle working practices can be deployed.'),
(15298, 6, 'Obtains organisational commitment to strategies to deliver systems and software lifecycle working practices to achieve business objectives.
Works with others to integrate organisational policies, standards and techniques across the full software and systems lifecycle.
Develops and deploys the working environment supporting systems and software lifecycle practices for strategic, large and complex products and services.
Leads activities to manage risks associated with systems and software lifecycle working practices. Plans and manages the evaluation or assessment of systems and software lifecycle working practices', 'Obtains organisational commitment to strategies to deliver systems and software lifecycle working practices to achieve business objectives.
Works with others to integrate organisational policies, standards and techniques across the full software and systems lifecycle.
Develops and deploys the working environment supporting systems and software lifecycle practices for strategic, large and complex products and services.
Leads activities to manage risks associated with systems and software lifecycle working practices. Plans and manages the evaluation or assessment of systems and software lifecycle working practices'),
(15298, 7, 'Represents and leads systems and software lifecycle working practices at the highest level in the organisation.
Identifies opportunities for innovation in systems and software lifecycle working practices to achieve organisational goals and objectives.
Leads the essential cultural and environmental changes and communicates the benefits to all stakeholders.
Oversees the quality of the work performed and delivers measurable business benefits.', 'Represents and leads systems and software lifecycle working practices at the highest level in the organisation.
Identifies opportunities for innovation in systems and software lifecycle working practices to achieve organisational goals and objectives.
Leads the essential cultural and environmental changes and communicates the benefits to all stakeholders.
Oversees the quality of the work performed and delivers measurable business benefits.')
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao, descricao_en = EXCLUDED.descricao_en;

COMMIT;
