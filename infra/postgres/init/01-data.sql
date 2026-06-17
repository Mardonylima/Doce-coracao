CREATE TABLE temas (
    id BIGSERIAL PRIMARY KEY, -- id referenciando cada tema, como "Cotidiano", "Perfeita Alegria", "Pequenez", "Abandono" ou "Esponsalidade"
    nome VARCHAR(100) NOT NULL, -- nome do tema, como "Cotidiano", "Perfeita Alegria", "Pequenez", "Abandono" ou "Esponsalidade"
    slug VARCHAR(100) UNIQUE NOT NULL, -- slug para identificar o tema de forma única, como "cotidiano", "perfeita-alegria", "pequenez", "abandono" ou "esponsalidade"
    descricao TEXT -- descrição do tema, como "Tema relacionado a assuntos do dia a dia", "Tema sobre alegria perfeita", "Tema sobre a pequenez", "Tema sobre o abandono" ou "Tema sobre a esponsalidade"
);

CREATE TABLE autores (
    id BIGSERIAL PRIMARY KEY, -- id referenciando cada autor, como "Santa Maria Madalena", "São Josemaria Escrivá" e etc
    nome VARCHAR(255) NOT NULL, -- nome do autor, como "Santa Maria Madalena", "São Josemaria Escrivá" e etc
    slug VARCHAR(255) UNIQUE NOT NULL, -- slug para identificar o autor de forma única, como "santa-maria-madalena", "sao-josemaria-escriva" e etc
    tipo VARCHAR(50) NOT NULL -- tipo do autor, como "santo", "escritor" ou "escritura"
);

CREATE TABLE conteudos (
    id BIGSERIAL PRIMARY KEY, -- id referenciando cada frase, oração, reflexão, etc

    tipo VARCHAR(50) NOT NULL, -- verciculo, citação, oração, meditação e desafio
    subtipo VARCHAR(50), -- bliblica, devocional, etc

    tema VARCHAR(255), -- tema para identificar o conteúdo, como "Frase do Dia", "Oração Matinal", "Meditação Noturna" ou "Desafio Semanal".

    conteudo TEXT NOT NULL, -- o texto principal do conteúdo, que pode ser uma frase, oração, reflexão ou desafio.

    tema_id BIGINT NOT NULL, -- para associar o conteúdo a um tema específico, como "Cotidiano", "Perfeita Alegria", "Pequenez", "Abandono" ou "Esponsalidade".
    autor_id BIGINT, -- para associar o conteúdo a um autor específico, como "Santa Maria Madalena", "São Josemaria Escrivá" e etc, ou deixar em branco para conteúdos sem um autor específico, como versículos bíblicos.

    nivel VARCHAR(50), -- para classificar o conteúdo em níveis de dificuldade ou profundidade, como "iniciante", "intermediário" e "avançado" nos desafios.

    created_at TIMESTAMP DEFAULT NOW(), -- para registrar a data e hora de criação do conteúdo.

    FOREIGN KEY (tema_id) REFERENCES temas(id),
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

INSERT INTO temas (nome, slug, descricao) 
VALUES
('Cotidiano', 'cotidiano', 'Tema relacionado a assuntos do dia a dia'),
('Perfeita Alegria', 'perfeita-alegria', 'Tema sobre alegria perfeita'),
('Pequenez', 'pequenez', 'Tema sobre a pequenez'),
('Abandono', 'abandono', 'Tema sobre o abandono'),
('Esponsalidade', 'esponsalidade', 'Tema sobre a esponsalidade');

INSERT INTO autores (nome, slug, tipo) 
VALUES
('São Josemaria Escrivá', 'sao-josemaria-escriva', 'santo'), -- 1
('Santa Maria Madalena', 'santa-maria-madalena', 'santo'), -- 2
('São João da Cruz', 'sao-joao-da-cruz', 'santo'), -- 3
('São Tomé', 'santo-tomé', 'santo'), -- 4
('São Francisco de Assis', 'sao-francisco-de-assis', 'santo'), -- 5
-- santos complementares.
('São Bernardo de Claraval', 'sao-bernardo-de-claraval', 'santo'), -- 6
('São Francisco de Sales', 'sao-francisco-de-sales', 'santo'), -- 7
('Santa Teresa de Calcutá', 'santa-teresa-de-calcutta', 'santo'), -- 8
('Santa Teresa de Ávila', 'santa-teresa-de-avila', 'santo'), -- 9
('Santa Teresinha do Menino Jesus', 'santa-teresinha-do-menino-jesus', 'santo'), -- 10
('Devocional', 'devocional', 'devocional'); -- 11

INSERT INTO conteudos (tipo, subtipo, tema, conteudo, tema_id, autor_id, nivel)
VALUES
-- Tema central: Encontrar Deus na vida comum. 15 Versículos Bíblicos
('Versículos', 'Bíblicos', 'Santificação do trabalho', 'Tudo o que fizerdes, fazei de coração, como para o Senhor e não para os homens.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Deus nas ações ordinárias', 'Quer comais, quer bebais, ou façais qualquer outra coisa, fazei tudo para a glória de Deus.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Excelência e dedicação', 'Tudo quanto fizer a tua mão, faze-o conforme as tuas forças.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Fidelidade nas pequenas coisas', 'Quem é fiel no pouco também é fiel no muito.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Unidade de vida', 'Tudo o que fizerdes, por palavras ou por obras, fazei tudo em nome do Senhor Jesus.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Perseverança diária', 'Bem-aventurados aqueles servos que o senhor, ao chegar, encontrar vigilantes.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Presença de Deus no cotidiano', 'Permanecei em Mim, e Eu permanecerei em vós.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Dependência da graça', 'Sem Mim nada podeis fazer.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Prioridade espiritual', 'Buscai primeiro o Reino de Deus e a sua justiça.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Constância', 'Aquele que perseverar até o fim será salvo.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Transformar o dever em missão', 'O meu alimento é fazer a vontade daquele que me enviou.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Serviço escondido', 'Quem quiser ser o primeiro, seja o servo de todos.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Gratidão diária', 'Em tudo dai graças.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Perseverança no trabalho e na fé', 'Sede firmes e constantes, sempre abundantes na obra do Senhor.', 1, 1, NULL),
('Versículos', 'Bíblicos', 'Contemplação no meio da vida comum', 'Maria guardava todas estas coisas, meditando-as em seu coração.', 1, 1, NULL),
-- CITAÇÕES AUTÊNTICAS. Referência principal: São Josemaria Escrivá
('Citação', 'Autentico', 'Presença de Deus.', 'Ou sabemos encontrar o Senhor na nossa vida quotidiana, ou não O encontraremos nunca.', 1, 1, NULL),
('Citação', 'Autentico', 'Santificação do cotidiano.', 'Há algo de santo, de divino, escondido nas situações mais comuns.', 1, 1, NULL),
('Citação', 'Autentico', 'Trabalho como vocação.', 'A tua vida de trabalho corrente, entre os teus semelhantes, é o lugar do teu encontro com Cristo.', 1, 1, NULL),
('Citação', 'Autentico', 'Valor espiritual do trabalho.', 'Não podes santificar-te sem trabalho.', 1, 1, NULL),
('Citação', 'Autentico', 'Atenção e fidelidade.', 'Faze o que deves e está no que fazes.', 1, 1, NULL),
('Citação', 'Autentico', 'Pequenos atos.', 'As coisas pequenas, feitas por amor, são grandes.', 1, 1, NULL),
('Citação', 'Autentico', 'Alegria no dever.', 'O segredo da felicidade está não em fazer sempre o que se gosta, mas em gostar sempre do que se faz.', 1, 1, NULL),
('Citação', 'Autentico', 'Intenção reta.', 'Não digas: é uma ninharia. Faz tudo por Amor.', 1, 1, NULL),
('Citação', 'Autentico', 'Encontro diário com Deus.', 'Deus espera-nos cada day.', 1, 1, NULL),
('Citação', 'Autentico', 'Tríplice dimensão do trabalho.', 'Santifica o teu trabalho. Santifica-te no teu trabalho. Santifica os outros através do teu trabalho.', 1, 1, NULL),
('Citação', 'Autentico', 'Encarnação e vida comum.', 'O valor divino do humano.', 1, 1, NULL),
('Citação', 'Autentico', 'Vida ordinária.', 'Não há outra estrada, filhos meus: ou sabemos encontrar o Senhor na vida de todos os dias, ou nunca O encontraremos.', 1, 1, NULL),
('Citação', 'Autentico', 'Fidelidade.', 'A santidade grande consiste em cumprir os deveres pequenos de cada instante.', 1, 1, NULL),
('Citação', 'Autentico', 'Heroísmo cotidiano.', 'Transformar a prosa diária em verso heroico.', 1, 1, NULL),
('Citação', 'Autentico', 'Vida interior.', 'Um minuto a mais de recolhimento vale ouro.', 1, 1, NULL),
-- CITAÇÕES COMPLEMENTARES. Referência principal: contidiano
('Citação', 'Complementares', 'Fé deve ser praticada com o coração.', 'A medida do amor é amar sem medida.', 1, 6, NULL),
('Citação', 'Complementares', 'Milagre moral', 'Faze tudo por amor; nada por força.', 1, 7, NULL),
('Citação', 'Complementares', 'O poder das pequenas ações', 'Nem todos podem fazer grandes coisas, mas podemos fazer pequenas coisas com grande amor.', 1, 8, NULL),
('Citação', 'Complementares', 'Santa Teresa de Ávila', 'A perfeição consiste em fazer a vontade de Deus.', 1, 9, NULL),
('Citação', 'Complementares', 'Pequenos gestos', 'O bom Deus não olha para a grandeza das nossas obras, mas para o amor com que são feitas.', 1, 10, NULL),
-- # CONTEÚDO DEVOCIONAL ORIGINAL DO JHS DOCE CORAÇÂO
('Devocional', 'Original', 'Cotidiano', 'Senhor, ensina-me a reconhecer Teus passos escondidos entre as tarefas deste dia.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'O amor transforma rotinas em oferendas.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'Nenhum trabalho é pequeno quando é realizado diante de Deus.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'A santidade cresce silenciosamente nas fidelidades que ninguém vê.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'Deus não desperdiça os esforços feitos por amor.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'O altar do cristão muitas vezes é a própria mesa de trabalho.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'A graça visita os momentos comuns mais do que imaginamos.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'A presença de Deus não interrompe a rotina; ela a ilumina.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'Hoje pode ser um dia comum para o mundo e extraordinário para a alma.', 1, 11, NULL),
('Devocional', 'Original', 'Cotidiano', 'O céu começa quando oferecemos a Deus aquilo que estamos vivendo agora.', 1, 11, NULL);
-- # MEDITAÇÕES ORIGINAIS DO JHS DOCE CORAÇÃO
-- PENSAR NAS ALTERARÇÕES QUE TENHO QUE FAZER PARA INCLUIR PARA FAZER AS MEDITAÇÕES E ORAÇÕES.
--( 'Meditação', '', '', '', 1, 11, NULL),