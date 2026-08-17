CREATE TABLE temas (
    id BIGSERIAL PRIMARY KEY,-- identificador único do tema

    nome VARCHAR(100) NOT NULL,-- nome do tema
    slug VARCHAR(100) UNIQUE NOT NULL,-- slug do tema, usado para URLs amigáveis    
    descricao TEXT,-- descrição detalhada do tema

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE autores (
    id BIGSERIAL PRIMARY KEY,-- identificador único do autor

    nome VARCHAR(255) NOT NULL,-- nome completo do autor    
    slug VARCHAR(255) UNIQUE NOT NULL,-- slug do autor, usado para URLs amigáveis    
    tipo VARCHAR(50) NOT NULL,-- tipo do autor
    CHECK (tipo IN ('SANTO', 'PAPA', 'PADRE', 'MINISTERIO')),-- restrição para o tipo do autor
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE virtudes (
    id BIGSERIAL PRIMARY KEY,-- identificador único da virtude
    
    nome VARCHAR(100) NOT NULL,-- nome da virtude (ex: fé, esperança, caridade, etc.)    
    slug VARCHAR(100) UNIQUE NOT NULL -- slug da virtude, usado para URLs amigáveis
);

CREATE TABLE tags (
    id BIGSERIAL PRIMARY KEY,-- identificador único da tag
    
    nome VARCHAR(100) NOT NULL,-- nome da tag (ex: trabalho, oração, estudo)    
    slug VARCHAR(100) UNIQUE NOT NULL -- slug da tag, usado para URLs amigáveis
);

CREATE TABLE conteudos (
    id BIGSERIAL PRIMARY KEY,-- identificador único do conteúdo

    tipo VARCHAR(30) NOT NULL,-- tipo do conteúdo
    CHECK (tipo IN ('VERSICULO', 'CITACAO', 'ORACAO', 'MEDITACAO', 'DESAFIO')),-- restrição para o tipo do conteúdo
    classificacao VARCHAR(30) NOT NULL,-- classificação do conteúdo
    CHECK (classificacao IN ('BIBLICA', 'AUTENTICA', 'TRADICAO', 'DEVOCIONAL')),-- restrição para a classificação do conteúdo
    papel VARCHAR(30) NOT NULL DEFAULT 'PRINCIPAL',
    CHECK (papel IN ('PRINCIPAL', 'COMPLEMENTAR')),-- restrição para o papel do conteúdo  
    titulo VARCHAR(255),-- título do conteúdo    
    conteudo TEXT NOT NULL,-- conteúdo principal (ex: texto da oração, citação, etc.)    
    referencia VARCHAR(255),-- referência do conteúdo (ex: livro, capítulo, versículo, etc.)    
    fonte VARCHAR(255),-- fonte do conteúdo (ex: Bíblia, Catecismo, etc.)    
    slug VARCHAR(255) UNIQUE NOT NULL,-- slug do conteúdo, usado para URLs amigáveis    
    tema_id BIGINT NOT NULL,-- chave estrangeira para a tabela de temas    
    autor_id BIGINT,-- chave estrangeira para a tabela de autores    
    nivel VARCHAR(30),-- nível do conteúdo (ex: iniciante, intermediário, avançado)
    CHECK (nivel IN ('iniciante', 'intermediário', 'avançado')),-- restrição para o nível do conteúdo
    ordem INTEGER DEFAULT 0,-- ordem de exibição do conteúdo    
    status VARCHAR(20) DEFAULT 'publicado',-- status do conteúdo (ex: publicado, rascunho, arquivado)
    CHECK (status IN ('publicado', 'rascunho', 'arquivado')),-- restrição para o status do conteúdo
    tempo_liturgico VARCHAR(40),-- tempo litúrgico associado ao conteúdo (ex: Advento, Quaresma, Páscoa, etc.)
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    FOREIGN KEY (tema_id)
        REFERENCES temas(id),
    FOREIGN KEY (autor_id)
        REFERENCES autores(id)
);

CREATE TABLE conteudo_virtudes (
    conteudo_id BIGINT NOT NULL,-- chave estrangeira para a tabela de conteúdos
    
    virtude_id BIGINT NOT NULL,-- chave estrangeira para a tabela de virtudes
    
    PRIMARY KEY (conteudo_id, virtude_id),
        FOREIGN KEY (conteudo_id) 
            REFERENCES conteudos(id) ON DELETE CASCADE,
        FOREIGN KEY (virtude_id) 
            REFERENCES virtudes(id) ON DELETE CASCADE
);

CREATE TABLE conteudo_tags (
    conteudo_id BIGINT NOT NULL,-- chave estrangeira para a tabela de conteúdos
    
    tag_id BIGINT NOT NULL,-- chave estrangeira para a tabela de tags
    
    PRIMARY KEY (conteudo_id, tag_id),
        FOREIGN KEY (conteudo_id)
            REFERENCES conteudos(id) ON DELETE CASCADE,
        FOREIGN KEY (tag_id)
            REFERENCES tags(id) ON DELETE CASCADE
);

INSERT INTO
    temas (nome, slug, descricao)
VALUES
    ('Cotidiano', 'cotidiano', 'Tema sobre o cotidiano'),
    ('Perfeita Alegria', 'perfeita-alegria', 'Tema sobre alegria perfeita'),
    ('Pequenez', 'pequenez', 'Tema sobre a pequenez'),
    ('Abandono', 'abandono', 'Tema sobre o abandono'),
    ('Esponsalidade', 'esponsalidade', 'Tema sobre a esponsalidade');

INSERT INTO
    autores (nome, slug, tipo)
VALUES
    ('São Josemaria Escrivá', 'sao-josemaria-escriva', 'SANTO'),-- 1
    ('São Francisco de Assis', 'sao-francisco-de-assis', 'SANTO'),-- 2
    ('São João Evangelista', 'sao-joao-evangelista', 'SANTO'),-- 3
    ('São Tomé', 'sao-tome', 'SANTO'),-- 4    
    ('Santa Maria Madalena', 'santa-maria-madalena', 'SANTO'),-- 5
    -- santos complementares.
    ('Santa Teresa de Calcutá', 'santa-teresa-de-calcutta', 'SANTO'),-- 6
    ('São Francisco de Sales', 'sao-francisco-de-sales', 'SANTO'),-- 7
    ('Santa Teresa de Ávila', 'santa-teresa-de-avila', 'SANTO'),-- 8
    ('Santa Teresinha do Menino Jesus', 'santa-teresinha-do-menino-jesus', 'SANTO'),-- 9
    ('São Bernardo de Claraval', 'sao-bernardo-de-claraval', 'SANTO'); -- 10

INSERT INTO
    virtudes (nome, slug)
VALUES
    ('Fé', 'fe'),
    ('Esperança', 'esperanca'),
    ('Caridade', 'caridade'),
    ('Humildade', 'humildade'),
    ('Obediência', 'obediencia'),
    ('Perseverança', 'perseveranca'),
    ('Paciência', 'paciencia'),
    ('Castidade', 'castidade'),
    ('Simplicidade', 'simplicidade'),
    ('Generosidade', 'generosidade');

INSERT INTO
    tags (nome, slug)
VALUES
    ('Trabalho', 'trabalho'),
    ('Oração', 'oracao'),
    ('Estudo', 'estudo'),
    ('Família', 'familia'),
    ('Amizade', 'amizade');

INSERT INTO
    conteudos (tipo, classificacao, papel, titulo, conteudo, referencia, fonte, slug, tema_id, autor_id, nivel, ordem, status, tempo_liturgico)
VALUES
    -- VERSICULOS BIBLICOS
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Santificação do trabalho', 'Tudo o que fizerdes, fazei de coração, como para o Senhor e não para os homens.', 'Colossenses 3,23', 'Bíblia Sagrada', 'santificacao-do-trabalho-cl-3-23', 1, NULL, NULL, 1, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Fazer tudo para a glória de Deus', 'Quer comais, quer bebais ou façais qualquer outra coisa, fazei tudo para a glória de Deus.', '1 Coríntios 10,31', 'Bíblia Sagrada', 'fazer-tudo-para-gloria-de-deus-1cor-10-31', 1, NULL, NULL, 2, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Fidelidade nas pequenas coisas', 'Quem é fiel nas pequenas coisas também é fiel nas grandes; e quem é injusto nas pequenas também é injusto nas grandes.', 'Lucas 16,10', 'Bíblia Sagrada', 'fidelidade-nas-pequenas-coisas-lc-16-10', 1, NULL, NULL, 3, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Permanecer unido a Cristo', 'Permanecei em mim, e eu permanecerei em vós. Como o ramo não pode dar fruto por si mesmo, se não permanecer na videira, assim também vós não podereis dar fruto se não permanecerdes em mim.', 'João 15,4', 'Bíblia Sagrada', 'permanecer-em-cristo-jo-15-4', 1, NULL, NULL, 4, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Sem Cristo nada podemos', 'Sem mim nada podeis fazer.', 'João 15,5', 'Bíblia Sagrada', 'sem-mim-nada-podeis-fazer-jo-15-5', 1, NULL, NULL, 5, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Buscar primeiro o Reino de Deus', 'Buscai em primeiro lugar o Reino de Deus e a sua justiça, e todas estas coisas vos serão acrescentadas.', 'Mateus 6,33', 'Bíblia Sagrada', 'buscar-reino-de-deus-mt-6-33', 1, NULL, NULL, 6, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Oferecer a vida como culto espiritual', 'Eu vos exorto, irmãos, pela misericórdia de Deus, a oferecerdes os vossos corpos como sacrifício vivo, santo e agradável a Deus: este é o vosso culto espiritual.', 'Romanos 12,1', 'Bíblia Sagrada', 'oferecer-a-vida-a-deus-rm-12-1', 1, NULL, NULL, 7, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Perseverança na obra do Senhor', 'Sede firmes, inabaláveis, sempre abundantes na obra do Senhor, sabendo que o vosso trabalho não é vão no Senhor.', '1 Coríntios 15,58', 'Bíblia Sagrada', 'perseveranca-na-obra-do-senhor-1cor-15-58', 1, NULL, NULL, 8, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Trabalhar com dedicação', 'Tudo quanto te vier à mão para fazer, faze-o conforme as tuas forças.', 'Eclesiastes 9,10', 'Bíblia Sagrada', 'tudo-faze-conforme-tuas-forcas-ecl-9-10', 1, NULL, NULL, 9, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Guardar e meditar no coração', 'Maria, porém, guardava todas estas coisas, meditando-as em seu coração.', 'Lucas 2,19', 'Bíblia Sagrada', 'guardar-as-coisas-no-coracao-lc-2-19', 1, NULL, NULL, 10, 'publicado', NULL),
    -- CITACOES DE SÃO JOSEMARIA ESCRIVÁ (PRINCIPAL)
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Encontrar Deus na vida cotidiana', 'Ou sabemos encontrar o Senhor na nossa vida ordinária, de todos os dias, ou não O encontraremos nunca.', 'Amar o mundo apaixonadamente', 'São Josemaria Escrivá', 'encontrar-deus-na-vida-cotidiana', 1, 1, NULL, 11, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Santificação da vida comum', 'Aí, nas circunstâncias da vida comum, o Senhor nos espera.', 'Caminho, 307', 'Caminho - São Josemaria Escrivá', 'o-senhor-nos-espera-na-vida-comum-caminho-307', 1, 1, NULL, 12, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Valor sobrenatural das pequenas coisas', 'Fazei tudo por Amor. - Assim não há coisas pequenas: tudo é grande. - A perseverança nas pequenas coisas, por Amor, é heroísmo.', 'Caminho, 813', 'Caminho - São Josemaria Escrivá', 'fazer-tudo-por-amor-caminho-813', 1, 1, NULL, 13, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A dignidade de todo trabalho', 'O trabalho, todo trabalho, é testemunho da dignidade do homem, do seu domínio sobre a criação.', 'Cristo que Passa, 47', 'Cristo que Passa - São Josemaria Escrivá', 'o-trabalho-e-testemunho-da-dignidade-do-homem-cristo-que-passa-47', 1, 1, NULL, 14, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Santificar o trabalho', 'Temos de santificar o trabalho, santificar-nos no trabalho e santificar os outros com o trabalho.', 'Questões Atuais do Cristianismo, nº 10', 'Questões Atuais do Cristianismo - São Josemaria Escrivá', 'santificar-o-trabalho-santificar-nos-no-trabalho-questoes-atuais-10', 1, 1, NULL, 15, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Trabalhar não é apenas cumprir', 'Para um católico, trabalhar não é cumprir, é amar!; e exceder-se com gosto, e sempre, no dever e no sacrifício.', 'Sulco, 527', 'Sulco - São Josemaria Escrivá', 'trabalhar-nao-e-cumprir-e-amar-sulco-527', 1, 1, NULL, 16, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Fazer o que se deve', 'Queres de verdade ser santo? — Cumpre o pequeno dever de cada momento: faz o que deves e está no que fazes.', 'Caminho, 815', 'Caminho - São Josemaria Escrivá', 'fazer-o-que-deves-e-estar-no-que-fazes-caminho-815', 1, 1, NULL, 17, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'O trabalho como caminho de santidade', 'O trabalho profissional, qualquer que seja, é meio e caminho de santidade.', 'Forja, 702', 'Forja - São Josemaria Escrivá', 'o-trabalho-como-caminho-de-santidade-forja-702', 1, 1, NULL, 18, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Transformar a prosa diária em poesia heroica', 'Transforma em poesia heroica a prosa diária.', 'Entrevistas com Mons. Josemaria Escrivá, 116', 'Entrevistas com Mons. Josemaria Escrivá', 'transformar-a-prosa-diaria-em-poesia-heroica-entrevistas-116', 1, 1, NULL, 19, 'arquivado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Cristo no meio da vida comum', 'Cristo passa ao nosso lado nas circunstâncias ordinárias da vida.', 'Cristo que Passa', 'Cristo que Passa - São Josemaria Escrivá', 'cristo-no-meio-da-vida-comum-cristo-que-passa', 1, 1, NULL, 20, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Trabalhar na presença de Deus', 'Deves manter - ao longo do dia - uma constante conversa com Nosso Senhor, que se alimente também das próprias ocorrências da tua tarefa profissional.', 'Forja, 745', 'Forja - São Josemaria Escrivá', 'trabalhar-na-presenca-de-deus-forja-745', 1, 1, NULL, 21, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'O trabalho humilde como oração', 'Persevera no cumprimento exato das obrigações de agora. - Esse trabalho - humilde, monótono, pequeno - é oração plasmada em obras que te preparam para receber a graça do outro trabalho - grande, vasto e profundo - com que sonhas.', 'Caminho, 825', 'Caminho - São Josemaria Escrivá', 'o-trabalho-humilde-como-oracao-caminho-825', 1, 1, NULL, 22, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Trabalhar por amor', 'Não hás de trabalhar por entusiasmo, mas por Amor; com consciência do dever, que é abnegação.', 'Caminho, 994', 'Caminho - São Josemaria Escrivá', 'trabalhar-por-amor-caminho-994', 1, 1, NULL, 23, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Unidade de vida', 'Não há uma vida cristã à margem da vida profissional, familiar e social; tudo deve ser ocasião de encontro com Deus.', 'Entrevistas com Mons. Escrivá, Questões Atuais do Cristianismo', 'Questões Atuais do Cristianismo - São Josemaria Escrivá', 'unidade-de-vida-e-encontro-com-deus', 1, 1, NULL, 24, 'arquivado', NULL),
    -- CITACOES DE OUTROS AUTORES (COMPLEMENTAR)
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A devoção aperfeiçoa a vida cotidiana', 'A verdadeira devoção nada destrói; ao contrário, tudo aperfeiçoa.', 'Introdução à Vida Devota, Parte I, capítulo 3', 'Introdução à Vida Devota - São Francisco de Sales', 'santidade-no-meio-das-ocupacoes-da-vida', 1, 7, NULL, 25, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'O amor dá valor às pequenas ações', 'O bom Deus não olha tanto a grandeza das nossas ações, mas o amor com que as fazemos.', 'Manuscritos Autobiográficos', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'o-amor-nas-pequenas-acoes-santa-teresinha', 1, 9, NULL, 26, 'arquivado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A devoção para todos os estados de vida', 'A devoção deve ser exercida de modos diferentes segundo as diferentes condições da vida.', 'Introdução à Vida Devota', 'Introdução à Vida Devota - São Francisco de Sales', 'devocao-para-todos-os-estados-de-vida', 1, 7, NULL, 27, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A vocação do amor', 'No coração da Igreja, minha Mãe, eu serei o Amor.', 'Manuscrito B', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'no-coracao-da-igreja-eu-serei-o-amor', 1, 9, NULL, 28, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A confiança nas pequenas coisas', 'Quero procurar o meio de ir para o Céu por um caminho bem reto, muito curto, um caminho todo novo.', 'Manuscrito C', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'pequeno-caminho-de-santa-teresinha', 1, 9, NULL, 29, 'publicado', NULL),
    -- TRADICAO
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Pequenas coisas feitas com grande amor', 'Não podemos fazer grandes coisas; somente pequenas coisas com grande amor.', 'Frase atribuída em escritos e ensinamentos de Santa Teresa de Calcutá', 'Santa Teresa de Calcutá', 'pequenas-coisas-com-grande-amor', 1, 6, NULL, 30, 'arquivado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Amor como centro da vida cristã', 'A medida do amor é amar sem medida.', 'De diligendo Deo, cap. I', 'Tratado sobre o Amor de Deus - São Bernardo de Claraval', 'a-medida-do-amor-e-amar-sem-medida', 1, 10, NULL, 31, 'publicado', NULL);

INSERT INTO
    conteudos (tipo, classificacao, papel, titulo, conteudo, referencia, fonte, slug, tema_id, autor_id, nivel, ordem, status, tempo_liturgico)
VALUES
    -- VERSICULOS BIBLICOS
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria nas tribulações', 'E não somente isto, mas também nos gloriamos nas tribulações, sabendo que a tribulação produz a perseverança; e a perseverança, a experiência; e a experiência, a esperança.', 'Romanos 5,3-4', 'Bíblia Sagrada', 'alegria-nas-tribulacoes-rm-5-3-4', 2, NULL, NULL, 1, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria nas provações', 'Meus irmãos, tende por motivo de toda alegria o passardes por várias provações, sabendo que a provação da vossa fé produz perseverança.', 'Tiago 1,2-3', 'Bíblia Sagrada', 'alegria-nas-provacoes-tg-1-2-3', 2, NULL, NULL, 2, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria nos sofrimentos de Cristo', 'Alegrai-vos na medida em que sois participantes dos sofrimentos de Cristo, para que também, na revelação de sua glória, vos alegreis exultando.', '1 Pedro 4,13', 'Bíblia Sagrada', 'alegria-nos-sofrimentos-de-cristo-1pe-4-13', 2, NULL, NULL, 3, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria em meio às provações', 'Nisso exultais, ainda que agora, por um pouco de tempo, devais ser entristecidos por diversas provações.', '1 Pedro 1,6', 'Bíblia Sagrada', 'alegria-em-meio-as-provacoes-1pe-1-6', 2, NULL, NULL, 4, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria que nasce da fé', 'Sem o terdes visto, vós o amais; sem o verdes ainda, credes nele e exultais com uma alegria indizível e gloriosa.', '1 Pedro 1,8', 'Bíblia Sagrada', 'alegria-que-nasce-da-fe-1pe-1-8', 2, NULL, NULL, 5, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegrai-vos sempre no Senhor', 'Alegrai-vos sempre no Senhor. Repito: alegrai-vos. O Senhor está próximo.', 'Filipenses 4,4-5', 'Bíblia Sagrada', 'alegrai-vos-sempre-no-senhor-fl-4-4-5', 2, NULL, NULL, 6, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria em meio à tristeza', 'Em verdade vos digo: vós chorareis e vos lamentareis, mas o mundo se alegrará. Vós ficareis tristes, mas a vossa tristeza se transformará em alegria.', 'João 16,20', 'Bíblia Sagrada', 'a-tristeza-se-transformara-em-alegria-jo-16-20', 2, NULL, NULL, 7, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'A alegria de Cristo em nós', 'Tenho-vos dito isso para que a minha alegria permaneça em vós, e a vossa alegria seja completa.', 'João 15,11', 'Bíblia Sagrada', 'a-alegria-de-cristo-em-nos-jo-15-11', 2, NULL, NULL, 8, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Alegria nas fraquezas por Cristo', 'Por isso, por Cristo, alegro-me nas fraquezas, nos insultos, nas privações, nas perseguições, nas angústias; pois, quando sou fraco, então é que sou forte.', '2 Coríntios 12,10', 'Bíblia Sagrada', 'alegria-nas-fraquezas-por-cristo-2cor-12-10', 2, NULL, NULL, 9, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Sempre alegres mesmo sendo pobres', 'Como entristecidos, mas sempre alegres; como pobres, mas enriquecendo a muitos; como nada tendo, mas possuindo tudo.', '2 Coríntios 6,10', 'Bíblia Sagrada', 'sempre-alegres-mesmo-sendo-pobres-2cor-6-10', 2, NULL, NULL, 10, 'publicado', NULL),
    -- CITACOES DE SÃO FRANCISCO DE ASSIS (PRINCIPAL)
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A alegria espiritual vence a tristeza', 'Bem-aventurado o religioso que não encontra prazer e alegria senão nas santas palavras e obras do Senhor, e por elas conduz os homens ao amor de Deus.', 'Admoestações, 20,1-2', 'Admoestações - São Francisco de Assis', 'alegria-nas-santas-palavras-e-obras-do-senhor-admoestacoes-20,1-2', 2, 2, NULL, 11, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A pobreza unida à alegria', 'Onde há pobreza unida à alegria, aí não há cobiça nem avareza.', 'Admoestações, 27', 'Admoestações - São Francisco de Assis', 'pobreza-unida-a-alegria-admoestacoes-27', 2, 2, NULL, 12, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegrar-se no Senhor', 'Comportem-se como aqueles que se alegram no Senhor, satisfeitos e amáveis, como convém.', 'Regra não bulada, 7,15-16', 'Regra não bulada - São Francisco de Assis', 'alegrar-se-no-senhor-regra-nao-bulada-7', 2, 2, NULL, 13, 'arquivado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A verdadeira paciência na adversidade', 'O servo de Deus não pode saber quanta paciência e humildade possui enquanto tudo acontece como deseja; mas quando sofre o contrário, então se manifesta o que realmente possui.', 'Admoestações, 13', 'Admoestações - São Francisco de Assis', 'paciencia-na-adversidade-admoestacoes-13', 2, 2, NULL, 14, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A alegria de permanecer humilde', 'Bem-aventurado o servo que não se considera melhor quando é engrandecido e exaltado pelos homens do que quando é tido por vil, simples e desprezado.', 'Admoestações, 19,1', 'Admoestações - São Francisco de Assis', 'alegria-da-humildade-admoestacoes-19', 2, 2, NULL, 15, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Suportar as humilhações com paciência', 'Bem-aventurado o servo que recebe repreensão, acusação e correção com a mesma paciência que teria consigo mesmo.', 'Admoestações, 22,1', 'Admoestações - São Francisco de Assis', 'suportar-correcao-com-paciencia-admoestacoes-22', 2, 2, NULL, 16, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Amar sem depender das circunstâncias', 'Bem-aventurado o servo que ama seu irmão tanto quando ele está doente e não pode ajudá-lo como quando está saudável e pode servi-lo.', 'Admoestações, 24', 'Admoestações - São Francisco de Assis', 'amar-sem-depender-das-circunstancias-admoestacoes-24', 2, 2, NULL, 17, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A alegria de amar a Deus e ao próximo', 'Como são felizes e benditos aqueles que amam o Senhor e fazem o que Ele diz no Evangelho: amar a Deus de todo o coração e ao próximo como a si mesmos.', 'Carta aos Fiéis, 18', 'Carta aos Fiéis - São Francisco de Assis', 'felizes-os-que-amam-a-deus-e-ao-proximo-carta-aos-fieis-18', 2, 2, NULL, 18, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Guardar a paz nas adversidades', 'Verdadeiramente pacíficos são aqueles que, em tudo o que sofrem neste mundo por amor de nosso Senhor Jesus Cristo, guardam a paz na alma e no corpo.', 'Admoestações, 15,2', 'Admoestações - São Francisco de Assis', 'guardar-a-paz-nas-adversidades-admoestacoes-15', 2, 2, NULL, 19, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegria junto aos pobres', 'E devem alegrar-se quando convivem com pessoas vis e desprezadas, com pobres e fracos e doentes e leprosos e os que mendigam à beira da estrada.', 'Regra não bulada, IX, 2', 'Regra não bulada - São Francisco de Assis', 'alegria-junto-aos-pobres-regra-nao-bulada-9-2', 2, 2, NULL, 20, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegria diante da pobreza', 'Tendo alimentos e com que nos cobrir, com isso estamos contentes.', 'Regra não bulada, IX, 1', 'Regra não bulada - São Francisco de Assis', 'contentes-com-o-necessario-regra-nao-bulada-9-1', 2, 2, NULL, 21, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegria em meio às dificuldades', 'E quando as pessoas os envergonharem e não quiserem dar-lhes esmola, deem por tudo isso graças a Deus.', 'Regra não bulada, IX, 6', 'Regra não bulada - São Francisco de Assis', 'dar-gracas-a-deus-nas-humilhacoes-regra-nao-bulada-9-6', 2, 2, NULL, 22, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegria e humildade', 'Onde há paciência e humildade, não há ira nem perturbação.', 'Admoestação 27', 'Admoestações - São Francisco de Assis', 'paciencia-humildade-e-ausencia-de-perturbacao', 2, 2, NULL, 23, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegria e paz interior', 'Onde há paz e meditação, não há nervosismo nem dissipação.', 'Admoestação 27', 'Admoestações - São Francisco de Assis', 'paz-meditacao-e-alegria-interior', 2, 2, NULL, 24, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Alegria e misericórdia', 'Onde há misericórdia e discrição, não há excesso nem dureza de coração.', 'Admoestação 27', 'Admoestações - São Francisco de Assis', 'misericordia-e-discricao-no-caminho-da-alegria', 2, 2, NULL, 25, 'publicado', NULL);

INSERT INTO
    conteudos (tipo, classificacao, papel, titulo, conteudo, referencia, fonte, slug, tema_id, autor_id, nivel, ordem, status, tempo_liturgico)
VALUES
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Tornar-se como criança', 'Se não vos converterdes e não vos tornardes como crianças, não entrareis no Reino dos Céus.', 'Mateus 18,3', 'Bíblia Sagrada', 'tornar-se-como-crianca-mt-18-3', 3, NULL, NULL, 1, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O menor é o maior', 'Aquele que se fizer humilde como esta criança, esse será o maior no Reino dos Céus.', 'Mateus 18,4', 'Bíblia Sagrada', 'o-menor-e-o-maior-mt-18-4', 3, NULL, NULL, 2, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Diminuir para que Cristo cresça', 'É necessário que ele cresça e que eu diminua.', 'João 3,30', 'Bíblia Sagrada', 'que-ele-cresca-e-eu-diminua-jo-3-30', 3, NULL, NULL, 3, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'A pequenez da serva do Senhor', 'Porque olhou para a humildade de sua serva. Desde agora, todas as gerações me chamarão bem-aventurada.', 'Lucas 1,48', 'Bíblia Sagrada', 'olhou-para-a-humildade-de-sua-serva-lc-1-48', 3, NULL, NULL, 4, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Os pequenos no Reino', 'Quem é o menor entre todos vós, esse é o maior.', 'Lucas 9,48', 'Bíblia Sagrada', 'o-menor-entre-vos-e-o-maior-lc-9-48', 3, NULL, NULL, 5, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Pobreza de espírito', 'Bem-aventurados os pobres em espírito, porque deles é o Reino dos Céus.', 'Mateus 5,3', 'Bíblia Sagrada', 'bem-aventurados-os-pobres-em-espirito-mt-5-3', 3, NULL, NULL, 6, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Humilhar-se diante de Deus', 'Humilhai-vos sob a poderosa mão de Deus, para que ele vos exalte no tempo devido.', '1 Pedro 5,6', 'Bíblia Sagrada', 'humilhai-vos-diante-de-deus-1pe-5-6', 3, NULL, NULL, 7, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Considerar o outro superior', 'Nada façais por competição ou vanglória, mas, com humildade, considerai os outros superiores a vós mesmos.', 'Filipenses 2,3', 'Bíblia Sagrada', 'considerar-os-outros-superiores-fl-2-3', 3, NULL, NULL, 8, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Cristo esvaziou-se a si mesmo', 'Ele esvaziou-se a si mesmo, assumindo a condição de servo, tornando-se semelhante aos homens.', 'Filipenses 2,7', 'Bíblia Sagrada', 'cristo-esvaziou-se-a-si-mesmo-fl-2-7', 3, NULL, NULL, 9, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Deus escolhe os pequenos', 'Deus escolheu o que é fraco no mundo para confundir os fortes; escolheu o que é humilde e desprezado.', '1 Coríntios 1,27-28', 'Bíblia Sagrada', 'deus-escolhe-os-pequenos-1cor-1-27-28', 3, NULL, NULL, 10, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Chamados filhos de Deus', 'Vede que grande presente de amor o Pai nos deu: sermos chamados filhos de Deus! E nós o somos.', '1 João 3,1', 'Bíblia Sagrada', 'chamados-filhos-de-deus-1jo-3-1', 3, 3, NULL, 11, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Viver como filhos de Deus', 'Amados, desde agora somos filhos de Deus, mas ainda não se manifestou o que seremos. Sabemos que, quando ele se manifestar, seremos semelhantes a ele, porque o veremos tal como ele é.', '1 João 3,2', 'Bíblia Sagrada', 'somos-filhos-de-deus-1jo-3-2', 3, 3, NULL, 12, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Permanecer em Cristo', 'E agora, filhinhos, permanecei nele, para que, quando ele se manifestar, tenhamos confiança e não sejamos envergonhados diante dele na sua vinda.', '1 João 2,28', 'Bíblia Sagrada', 'permanecei-nele-filhinhos-1jo-2-28', 3, 3, NULL, 13, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Deus é maior que o nosso coração', 'Se o nosso coração nos condena, Deus é maior que o nosso coração e conhece todas as coisas.', '1 João 3,20', 'Bíblia Sagrada', 'deus-e-maior-que-o-nosso-coracao-1jo-3-20', 3, 3, NULL, 14, 'publicado', NULL);

INSERT INTO
    conteudos (tipo, classificacao, papel, titulo, conteudo, referencia, fonte, slug, tema_id, autor_id, nivel, ordem, status, tempo_liturgico)
VALUES
    -- VERSICULOS BIBLICOS
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Confiar em Deus de todo o coração', 'Confia no Senhor de todo o teu coração e não te apoies na tua própria inteligência. Reconhece-o em todos os teus caminhos, e ele tornará retas as tuas veredas.', 'Provérbios 3,5-6', 'Bíblia Sagrada', 'confiar-em-deus-de-todo-o-coracao-pv-3-5-6', 4, NULL, NULL, 1, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Entregar a Deus as preocupações', 'Lançai sobre ele toda a vossa preocupação, porque ele cuida de vós.', '1 Pedro 5,7', 'Bíblia Sagrada', 'entregar-a-deus-as-preocupacoes-1pe-5-7', 4, NULL, NULL, 2, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Deus conduz todas as coisas para o bem', 'Sabemos que todas as coisas concorrem para o bem daqueles que amam a Deus, daqueles que são chamados segundo o seu desígnio.', 'Romanos 8,28', 'Bíblia Sagrada', 'deus-conduz-todas-as-coisas-para-o-bem-rm-8-28', 4, NULL, NULL, 3, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Esperar silenciosamente no Senhor', 'O Senhor é minha porção, diz minha alma; por isso espero nele. O Senhor é bom para quem nele confia, para a pessoa que o procura. É bom esperar em silêncio a salvação do Senhor.', 'Lamentações 3,24-26', 'Bíblia Sagrada', 'esperar-silenciosamente-no-senhor-lm-3-24-26', 4, NULL, NULL, 4, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Lançar o fardo sobre o Senhor', 'Confia ao Senhor o teu fardo, e ele te sustentará; jamais permitirá que vacile o justo.', 'Salmo 55,23', 'Bíblia Sagrada', 'lancar-o-fardo-sobre-o-senhor-sl-55-23', 4, NULL, NULL, 5, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Não ter medo de confiar no Pai', 'Não tenhais medo, pequeno rebanho, porque foi do agrado de vosso Pai dar-vos o Reino.', 'Lucas 12,32', 'Bíblia Sagrada', 'nao-ter-medo-de-confiar-no-pai-lc-12-32', 4, NULL, NULL, 6, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Não deixar o coração se perturbar', 'Não se perturbe o vosso coração. Credes em Deus, crede também em mim.', 'João 14,1', 'Bíblia Sagrada', 'nao-se-perturbe-o-vosso-coracao-jo-14-1', 4, NULL, NULL, 7, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Tomé pergunta pelo caminho', 'Tomé lhe disse: Senhor, não sabemos para onde vais. Como podemos conhecer o caminho?', 'João 14,5', 'Bíblia Sagrada', 'tome-pergunta-pelo-caminho-jo-14-5', 4, 4, NULL, 8, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Crer mesmo sem ver', 'Jesus lhe disse: Porque me viste, creste. Bem-aventurados os que não viram e creram.', 'João 20,29', 'Bíblia Sagrada', 'crer-mesmo-sem-ver-jo-20-29', 4, NULL, NULL, 9, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Tomé entrega-se a Cristo', 'Tomé respondeu: Meu Senhor e meu Deus!', 'João 20,28', 'Bíblia Sagrada', 'tome-entrega-se-a-cristo-jo-20-28', 4, 4, NULL, 10, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Entregar o caminho ao Senhor', 'Entrega ao Senhor o teu caminho, confia nele, e ele agirá.', 'Salmo 37,5', 'Bíblia Sagrada', 'entregar-o-caminho-ao-senhor-sl-37-5', 4, NULL, NULL, 11, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Deixar Deus cuidar do amanhã', 'Não vos preocupeis, portanto, com o dia de amanhã, pois o dia de amanhã terá suas próprias preocupações. A cada dia basta o seu mal.', 'Mateus 6,34', 'Bíblia Sagrada', 'deixar-deus-cuidar-do-amanha-mt-6-34', 4, NULL, NULL, 12, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Confiar na Providência do Pai', 'Vosso Pai celeste sabe que precisais de tudo isso. Buscai primeiro o Reino de Deus e a sua justiça, e todas essas coisas vos serão acrescentadas.', 'Mateus 6,32-33', 'Bíblia Sagrada', 'confiar-na-providencia-do-pai-mt-6-32-33', 4, NULL, NULL, 13, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Aquietar a alma diante de Deus', 'Eu acalmei e aquietei a minha alma, como uma criança desmamada no colo de sua mãe; como uma criança desmamada, assim está minha alma em mim.', 'Salmo 131,2', 'Bíblia Sagrada', 'aquietar-a-alma-diante-de-deus-sl-131-2', 4, NULL, NULL, 14, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Esperar no Senhor', 'Israel, espera no Senhor, agora e para sempre.', 'Salmo 131,3', 'Bíblia Sagrada', 'esperar-no-senhor-agora-e-para-sempre-sl-131-3', 4, NULL, NULL, 15, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Caminhar pela fé', 'Pois caminhamos pela fé, não pela visão.', '2 Coríntios 5,7', 'Bíblia Sagrada', 'caminhar-pela-fe-e-nao-pela-visao-2cor-5-7', 4, NULL, NULL, 16, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'A fé nas coisas que não se veem', 'A fé é a realização daquilo que se espera e a demonstração de realidades que não se veem.', 'Hebreus 11,1', 'Bíblia Sagrada', 'a-fe-nas-coisas-que-nao-se-veem-hb-11-1', 4, NULL, NULL, 17, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Ir sem saber para onde', 'Foi pela fé que Abraão obedeceu ao ser chamado para partir para um lugar que deveria receber como herança; e partiu, sem saber para onde ia.', 'Hebreus 11,8', 'Bíblia Sagrada', 'partir-sem-saber-para-onde-hb-11-8', 4, NULL, NULL, 18, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Deus sustenta quem confia nele', 'Não temas, porque estou contigo; não te angusties, porque sou o teu Deus. Eu te fortaleço, eu te ajudo, eu te sustento com minha destra vitoriosa.', 'Isaías 41,10', 'Bíblia Sagrada', 'deus-sustenta-quem-confia-nele-is-41-10', 4, NULL, NULL, 19, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Transformar a ansiedade em oração', 'Não vos inquieteis por coisa alguma, mas em tudo, pela oração e pela súplica, acompanhadas de ação de graças, apresentai a Deus os vossos pedidos.', 'Filipenses 4,6', 'Bíblia Sagrada', 'transformar-a-ansiedade-em-oracao-fl-4-6', 4, NULL, NULL, 20, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Ir com Cristo mesmo diante da morte', 'Então Tomé, chamado Dídimo, disse aos outros discípulos: Vamos também nós, para morrermos com ele.', 'João 11,16', 'Bíblia Sagrada', 'ir-com-cristo-mesmo-diante-da-morte-jo-11-16', 4, 4, NULL, 21, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Confiar em Cristo quando a fé é provada', 'Disse Tomé: Se eu não vir em suas mãos a marca dos pregos, e não puser o meu dedo no lugar dos pregos, não acreditarei.', 'João 20,25', 'Bíblia Sagrada', 'confiar-em-cristo-quando-a-fe-e-provada-jo-20-25', 4, 4, NULL, 22, 'publicado', NULL),
    -- CITACOES COMPLEMENTARES
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Nada te perturbe', 'Nada te perturbe, nada te cause medo. Tudo passa, Deus não muda. A paciência obtém tudo. A quem tem Deus nada falta. Só Deus basta.', 'Poesias, 30', 'Poesias - Santa Teresa de Jesus', 'nada-te-perturbe-deus-nao-muda-poesias-30', 4, 8, NULL, 23, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Amar sem depender do que Deus concede', 'Amar-vos-ei, ó Senhor, e esperarei sempre na vossa misericórdia.', 'I Processo de Canonização, vol. I, art. 4', 'Processo de Canonização de São Francisco de Sales', 'amar-e-esperar-na-misericordia-de-deus-sao-francisco-de-sales', 4, 7, NULL, 24, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Abandonar-se à bondade de Deus', 'Já não perguntar o que Deus fará de mim; amo-O simplesmente, abandonando-me à sua bondade.', 'Audiência Geral de 2 de março de 2011', 'São Francisco de Sales - Bento XVI', 'abandonar-se-a-bondade-de-deus-sao-francisco-de-sales', 4, 7, NULL, 25, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Não pensar no sofrimento futuro', 'Nós que corremos pelo caminho do Amor não devemos pensar no que nos pode acontecer de doloroso no futuro, porque é faltar à confiança.', 'Carta 197', 'Carta 197 - Santa Teresa do Menino Jesus', 'nao-pensar-no-sofrimento-futuro-carta-197', 4, 9, NULL, 26, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'O abandono e a gratidão', 'Jesus não pede grandes ações, mas apenas o abandono e a gratidão.', 'Carta 197', 'Carta 197 - Santa Teresa do Menino Jesus', 'jesus-pede-abandono-e-gratidao-carta-197', 4, 9, NULL, 27, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Fazer tudo por amor', 'Fazer tudo por amor, nada por força.', 'Carta de 14 de outubro de 1604', 'Carta a Santa Joana de Chantal - São Francisco de Sales', 'fazer-tudo-por-amor-nada-por-forca', 4, 7, NULL, 28, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Não recusar nem desejar', 'Não recusar nada, nem desejar nada.', 'Carta de 1619 / último encontro com as Visitandinas', 'Totum amoris est - Papa Francisco sobre São Francisco de Sales', 'nao-recusar-nada-nem-desejar-nada-sao-francisco-de-sales', 4, 7, NULL, 29, 'publicado', NULL),
    ('CITACAO', 'DEVOCIONAL', 'COMPLEMENTAR', 'A confiança vence o medo do futuro', 'A confiança plena, que se torna abandono ao Amor, liberta-nos dos cálculos obsessivos, da preocupação constante com o futuro e dos medos que tiram a paz.', 'C’est la confiance, 24', 'C’est la confiance - Papa Francisco', 'confianca-que-se-torna-abandono-ao-amor', 4, NULL, NULL, 30, 'publicado', NULL),
    ('CITACAO', 'DEVOCIONAL', 'COMPLEMENTAR', 'Deixar-se conduzir por Deus', 'A sua confiança sem limites encoraja aqueles que se sentem frágeis, limitados e pecadores a deixarem-se conduzir e transformar para chegar ao alto.', 'C’est la confiance, 21', 'C’est la confiance - Papa Francisco', 'deixar-se-conduzir-e-transformar-por-deus', 4, NULL, NULL, 31, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Não desejar controlar o caminho', 'Não há necessidade de saber para onde vamos; basta que saibamos que Deus nos conduz.', 'Tratado do Amor de Deus', 'Tratado do Amor de Deus - São Francisco de Sales', 'deus-conduz-o-caminho-sao-francisco-de-sales', 4, 7, NULL, 32, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'A entrega não é passividade', 'O abandono não consiste em não fazer nada, mas em deixar que Deus conduza a nossa vida enquanto fazemos fielmente aquilo que está ao nosso alcance.', 'Totum amoris est', 'Totum amoris est - Papa Francisco', 'abandono-nao-e-passividade', 4, NULL, NULL, 33, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Confiar mesmo na escuridão', 'Mesmo na escuridão, Teresa vive a confiança total da criança que se abandona sem medo nos braços do pai e da mãe.', 'C’est la confiance, 27', 'C’est la confiance - Papa Francisco', 'confiar-mesmo-na-escuridao', 4, NULL, NULL, 34, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Confiar na misericórdia de Deus', 'A mim deu-me a sua Misericórdia infinita, e é através dela que contemplo e adoro as demais perfeições divinas.', 'Manuscrito A, 83v', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'confiar-na-misericordia-infinita-de-deus', 4, 9, NULL, 35, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Colaborar com Deus sem ansiedade', 'Não devemos esperar de maneira passiva aquilo que Deus nos manda, mas colaborar com Ele, a fim de que leve a cumprimento tudo o que iniciou a fazer em nós.', 'Audiência Geral de 24 de março de 1999', 'João Paulo II', 'colaborar-com-deus-sem-ansiedade', 4, NULL, NULL, 36, 'publicado', NULL);

INSERT INTO
    conteudos (tipo, classificacao, papel, titulo, conteudo, referencia, fonte, slug, tema_id, autor_id, nivel, ordem, status, tempo_liturgico)
VALUES
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Cristo é o Esposo', 'Aquele que tem a esposa é o esposo. O amigo do esposo, porém, que está presente e o ouve, regozija-se sobremodo com a voz do esposo. Nisso consiste a minha alegria, que agora se completa.', 'João 3,29', 'Bíblia Sagrada', 'cristo-e-o-esposo-jo-3-29', 5, NULL, NULL, 1, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Cristo ama a Igreja como Esposo', 'Maridos, amai as vossas mulheres, como Cristo amou a Igreja e se entregou por ela.', 'Efésios 5,25', 'Bíblia Sagrada', 'cristo-amou-a-igreja-e-se-entregou-por-ela-ef-5-25', 5, NULL, NULL, 2, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O grande mistério de Cristo e da Igreja', 'Por isso deixará o homem pai e mãe e se unirá à sua mulher, e os dois constituirão uma só carne. Esse mistério é grande, quero dizer, com referência a Cristo e à Igreja.', 'Efésios 5,31-32', 'Bíblia Sagrada', 'o-grande-misterio-de-cristo-e-da-igreja-ef-5-31-32', 5, NULL, NULL, 3, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Unido ao Senhor em um só espírito', 'Ao contrário, o que está unido ao Senhor é um só espírito com ele.', '1 Coríntios 6,17', 'Bíblia Sagrada', 'unido-ao-senhor-em-um-so-espirito-1cor-6-17', 5, NULL, NULL, 4, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'As bodas do Cordeiro', 'Alegremo-nos, exultemos e demos-lhe glória, porque chegaram as bodas do Cordeiro, e sua esposa está preparada.', 'Apocalipse 19,7', 'Bíblia Sagrada', 'as-bodas-do-cordeiro-ap-19-7', 5, NULL, NULL, 5, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Felizes os convidados para as bodas do Cordeiro', 'Felizes os convidados para as bodas do Cordeiro.', 'Apocalipse 19,9', 'Bíblia Sagrada', 'felizes-os-convidados-para-as-bodas-do-cordeiro-ap-19-9', 5, NULL, NULL, 6, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'A esposa do Cordeiro', 'Vem, e eu te mostrarei a noiva, a esposa do Cordeiro.', 'Apocalipse 21,9', 'Bíblia Sagrada', 'a-esposa-do-cordeiro-ap-21-9', 5, NULL, NULL, 7, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'A nova Jerusalém como esposa', 'Eu vi descer do céu, de junto de Deus, a Cidade Santa, a nova Jerusalém, como uma esposa ornada para o esposo.', 'Apocalipse 21,2', 'Bíblia Sagrada', 'a-nova-jerusalem-como-esposa-ap-21-2', 5, NULL, NULL, 8, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'A Esposa diz: Vem', 'O Espírito e a Esposa dizem: “Vem!” E aquele que ouve diga: “Vem!” E quem tem sede venha; e quem quiser receba de graça a água da vida.', 'Apocalipse 22,17', 'Bíblia Sagrada', 'a-esposa-diz-vem-ap-22-17', 5, NULL, NULL, 9, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O Senhor fala ao coração', 'Eu a atrairei, levá-la-ei ao deserto e falarei ao seu coração.', 'Oséias 2,16', 'Bíblia Sagrada', 'o-senhor-fala-ao-coracao-os-2-16', 5, NULL, NULL, 10, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Desposados para sempre', 'Eu te desposarei para sempre; eu te desposarei na justiça e no direito, no amor e na misericórdia.', 'Oséias 2,21', 'Bíblia Sagrada', 'desposados-para-sempre-os-2-21', 5, NULL, NULL, 11, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Desposados na fidelidade', 'Eu te desposarei na fidelidade, e tu conhecerás o Senhor.', 'Oséias 2,22', 'Bíblia Sagrada', 'desposados-na-fidelidade-os-2-22', 5, NULL, NULL, 12, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O amor da juventude', 'Lembro-me do teu amor na juventude, do teu carinho quando eras minha noiva, quando me seguias no deserto, numa terra não semeada.', 'Jeremias 2,2', 'Bíblia Sagrada', 'o-amor-da-juventude-jer-2-2', 5, NULL, NULL, 13, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Tu és o meu amado e eu sou tua', 'O meu amado é meu e eu sou dele; ele apascenta entre os lírios.', 'Cântico dos Cânticos 2,16', 'Bíblia Sagrada', 'meu-amado-e-meu-e-eu-sou-dele-cant-2-16', 5, NULL, NULL, 14, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Buscar aquele que a alma ama', 'Em meu leito, durante a noite, procurei aquele que minha alma ama; procurei-o e não o encontrei.', 'Cântico dos Cânticos 3,1', 'Bíblia Sagrada', 'buscar-aquele-que-a-alma-ama-cant-3-1', 5, NULL, NULL, 15, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Procurarei aquele que minha alma ama', 'Vou levantar-me e percorrer a cidade; pelas ruas e pelas praças procurarei aquele que minha alma ama.', 'Cântico dos Cânticos 3,2', 'Bíblia Sagrada', 'procurarei-aquele-que-minha-alma-ama-cant-3-2', 5, NULL, NULL, 16, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Encontrei aquele que minha alma ama', 'Mal havia passado por eles, encontrei aquele que minha alma ama. Agarrei-me a ele e não o deixei.', 'Cântico dos Cânticos 3,4', 'Bíblia Sagrada', 'encontrei-aquele-que-minha-alma-ama-cant-3-4', 5, NULL, NULL, 17, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O amor é forte como a morte', 'Põe-me como um selo sobre o teu coração, como um selo sobre o teu braço; porque o amor é forte como a morte, e a paixão é cruel como a sepultura.', 'Cântico dos Cânticos 8,6', 'Bíblia Sagrada', 'o-amor-e-forte-como-a-morte-cant-8-6', 5, NULL, NULL, 18, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'As muitas águas não podem apagar o amor', 'As águas torrenciais não podem apagar o amor, nem os rios afogá-lo. Se alguém oferecesse todas as riquezas de sua casa em troca do amor, seria desprezado.', 'Cântico dos Cânticos 8,7', 'Bíblia Sagrada', 'as-muitas-aguas-nao-podem-apagar-o-amor-cant-8-7', 5, NULL, NULL, 19, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Maria reconhece o Senhor', 'Disse-lhe Jesus: “Maria!” Voltando-se ela, exclamou em hebraico: “Rabôni!” — que quer dizer Mestre.', 'João 20,16', 'Bíblia Sagrada', 'maria-reconhece-o-senhor-jo-20-16', 5, 5, NULL, 20, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O Esposo está presente', 'Podem por acaso os convidados do casamento jejuar enquanto o esposo está com eles? Enquanto o esposo está com eles, não podem jejuar.', 'Marcos 2,19', 'Bíblia Sagrada', 'o-esposo-esta-presente-mc-2-19', 5, NULL, NULL, 21, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O Amado bate à porta', 'Eu dormia, mas meu coração velava. Ouvi a voz do meu amado, que batia: “Abre-me, minha irmã, minha amiga, minha pomba, minha perfeita!”', 'Cântico dos Cânticos 5,2', 'Bíblia Sagrada', 'o-amado-bate-a-porta-cant-5-2', 5, NULL, NULL, 22, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Abrir para o Amado', 'Levantei-me para abrir ao meu amado; minhas mãos destilavam mirra, meus dedos, mirra líquida, sobre a maçaneta da fechadura.', 'Cântico dos Cânticos 5,5', 'Bíblia Sagrada', 'abrir-para-o-amado-cant-5-5', 5, NULL, NULL, 23, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O desejo pelo Amado', 'Eu vos conjuro, filhas de Jerusalém: se encontrardes o meu amado, dizei-lhe que estou doente de amor.', 'Cântico dos Cânticos 5,8', 'Bíblia Sagrada', 'o-desejo-pelo-amado-cant-5-8', 5, NULL, NULL, 24, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Este é o meu Amado', 'Sua boca é muito doce; ele é todo desejável. Este é o meu amado, este é o meu amigo, filhas de Jerusalém.', 'Cântico dos Cânticos 5,16', 'Bíblia Sagrada', 'este-e-o-meu-amado-cant-5-16', 5, NULL, NULL, 25, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O teu Criador é o teu Esposo', 'Porque o teu esposo é o teu Criador; Senhor dos Exércitos é o seu nome. Teu redentor é o Santo de Israel, chamado Deus de toda a terra.', 'Isaías 54,5', 'Bíblia Sagrada', 'o-teu-criador-e-o-teu-esposo-is-54-5', 5, NULL, NULL, 26, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O Senhor se alegra com sua esposa', 'Assim como o jovem desposa uma virgem, assim te desposará aquele que te criou; e como o esposo se alegra com a esposa, assim o teu Deus se alegrará contigo.', 'Isaías 62,5', 'Bíblia Sagrada', 'o-senhor-se-alegra-com-sua-esposa-is-62-5', 5, NULL, NULL, 27, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O amor que nos precede', 'Com amor eterno eu te amei; por isso conservei por ti o meu amor.', 'Jeremias 31,3', 'Bíblia Sagrada', 'o-amor-que-nos-precede-jer-31-3', 5, NULL, NULL, 28, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O amor de Cristo nos impele', 'O amor de Cristo nos impele, considerando que um só morreu por todos; logo, todos morreram.', '2 Coríntios 5,14', 'Bíblia Sagrada', 'o-amor-de-cristo-nos-impele-2cor-5-14', 5, NULL, NULL, 29, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Viver para aquele que morreu e ressuscitou', 'Ele morreu por todos, para que os que vivem não vivam mais para si mesmos, mas para aquele que por eles morreu e ressuscitou.', '2 Coríntios 5,15', 'Bíblia Sagrada', 'viver-para-aquele-que-morreu-2cor-5-15', 5, NULL, NULL, 30, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Permanecer no amor de Cristo', 'Como o Pai me amou, assim também eu vos amei. Permanecei no meu amor.', 'João 15,9', 'Bíblia Sagrada', 'permanecei-no-amor-de-cristo-jo-15-9', 5, NULL, NULL, 31, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Amar para permanecer no amor', 'Se guardardes os meus mandamentos, permanecereis no meu amor, assim como eu guardei os mandamentos de meu Pai e permaneço no seu amor.', 'João 15,10', 'Bíblia Sagrada', 'permanecer-no-amor-pela-fidelidade-jo-15-10', 5, NULL, NULL, 32, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Cristo habita naquele que o ama', 'Se alguém me ama, guardará a minha palavra; meu Pai o amará, e nós viremos a ele e faremos nele a nossa morada.', 'João 14,23', 'Bíblia Sagrada', 'cristo-habita-naquele-que-o-ama-jo-14-23', 5, NULL, NULL, 33, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'O amor que responde ao Amor', 'Nós amamos porque ele nos amou primeiro.', '1 João 4,19', 'Bíblia Sagrada', 'amamos-porque-ele-nos-amou-primeiro-1jo-4-19', 5, NULL, NULL, 34, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Maria Madalena anuncia o Ressuscitado', 'Maria Madalena foi anunciar aos discípulos: “Eu vi o Senhor!”, e contou-lhes o que ele lhe tinha dito.', 'João 20,18', 'Bíblia Sagrada', 'maria-madalena-anuncia-o-ressuscitado-jo-20-18', 5, 5, NULL, 35, 'publicado', NULL);
