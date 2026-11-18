-- Soft/hard skills: classificacao curada das habilidades
-- hardskill = padrao; softskill = lista curada de competencias comportamentais genericas
SET search_path TO esco_dataset;

UPDATE habilidade
SET classificacao_habilidade = 'hardskill'
WHERE classificacao_habilidade IS NULL
  AND tipo_conceito <> 'grupo_habilidade';

CREATE TEMP TABLE _soft_skill (nome_norm text PRIMARY KEY);

INSERT INTO _soft_skill (nome_norm) VALUES
    ('trabalhar em equipe'),
    ('colaborar em equipes e redes'),
    ('cooperar com colegas'),
    ('estabelecer formas de cooperacao'),
    ('estabelecer relacoes de colaboracao'),
    ('colaborar e estabelecer contatos'),
    ('colaborar atraves das tecnologias digitais'),
    ('comunicar'),
    ('comunicacao'),
    ('aptidoes e competencias sociais e de comunicacao'),
    ('adaptar o estilo de comunicacao ao destinatario'),
    ('comunicar com as partes interessadas'),
    ('comunicar com clientes'),
    ('comunicar profissionalmente com profissionais de outras areas'),
    ('gerir conflitos'),
    ('gestao de conflitos'),
    ('resolver conflitos'),
    ('pensar de forma criativa'),
    ('expressar-se de forma criativa'),
    ('desenvolver ideias criativas'),
    ('estimular processos criativos'),
    ('tomar decisoes'),
    ('delegar responsabilidades'),
    ('revelar empatia'),
    ('estabelecer uma relacao de empatia'),
    ('etica'),
    ('cumprir prazos'),
    ('mostrar iniciativa'),
    ('assumir papel de lideranca'),
    ('liderar uma equipe'),
    ('principios de lideranca'),
    ('tecnicas de coaching'),
    ('motivar outras pessoas'),
    ('motivar o pessoal'),
    ('negociar'),
    ('negociar compromissos'),
    ('moderar negociacoes'),
    ('dar provas de sensibilidade intercultural'),
    ('aceitar criticas e orientacoes'),
    ('avaliar de forma critica a informacao e as suas fontes'),
    ('fazer criticas construtivas'),
    ('pensar com espirito critico'),
    ('pensar de forma abstrata'),
    ('pensar de forma analitica'),
    ('pensar de forma holistica'),
    ('pensar de forma inovadora'),
    ('pensar proativamente'),
    ('pensar rapidamente'),
    ('apresentar argumentos persuasivamente'),
    ('resolver problemas'),
    ('desenvolver estrategias de resolucao de problemas'),
    ('assumir responsabilidade'),
    ('revelar responsabilidade profissional'),
    ('servico ao cliente'),
    ('assertividade'),
    ('adaptar-se a mudanca'),
    ('adaptar-se a situacoes de mudanca');

UPDATE habilidade h
SET classificacao_habilidade = 'softskill'
FROM _soft_skill s
WHERE public.unaccent(lower(h.nome)) = s.nome_norm
  AND h.tipo_conceito <> 'grupo_habilidade';

DROP TABLE _soft_skill;

SELECT classificacao_habilidade, count(*) FROM habilidade GROUP BY 1 ORDER BY 1;
