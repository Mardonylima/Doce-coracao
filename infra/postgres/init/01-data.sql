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
    ('Santa Maria Madalena', 'santa-maria-madalena', 'SANTO'),-- 2
    ('São João Evangelista', 'sao-joao-evangelista', 'SANTO'),-- 3
    ('São Tomé', 'sao-tome', 'SANTO'),-- 4
    ('São Francisco de Assis', 'sao-francisco-de-assis', 'SANTO'),-- 5
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
    -- CONTEUDO REFERENTE A SÃO JOSEMARIA ESCRIVÁ
    -- VERSICULOS BIBLICOS REFERENTES AO TRABALHO E A SANTIFICAÇÃO DA VIDA COTIDIANA
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Santificação do trabalho', 'Tudo o que fizerdes, fazei de coração, como para o Senhor e não para os homens.', 'Colossenses 3,23', 'Bíblia Sagrada', 'santificacao-do-trabalho-cl-3-23', 1, NULL, NULL, 1, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Fazer tudo para a glória de Deus', 'Quer comais, quer bebais ou façais qualquer outra coisa, fazei tudo para a glória de Deus.', '1 Coríntios 10,31', 'Bíblia Sagrada', 'fazer-tudo-para-gloria-de-deus-1cor-10-31', 1, NULL, NULL, 2, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Fidelidade nas pequenas coisas', 'Quem é fiel nas pequenas coisas também é fiel nas grandes; e quem é injusto nas pequenas também é injusto nas grandes.', 'Lucas 16,10', 'Bíblia Sagrada', 'fidelidade-nas-pequenas-coisas-lc-16-10', 1, NULL, NULL, 3, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Permanecer unido a Cristo', 'Permanecei em mim, e eu permanecerei em vós. Como o ramo não pode dar fruto por si mesmo, se não permanecer na videira, assim também vós não podereis dar fruto se não permanecerdes em mim.', 'João 15,4', 'Bíblia Sagrada', 'permanecer-em-cristo-jo-15-4', 1, NULL, NULL, 4, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Sem Cristo nada podemos', 'Sem mim nada podeis fazer.', 'João 15,5', 'Bíblia Sagrada', 'sem-mim-nada-podeis-fazer-jo-15-5', 1, NULL, NULL, 5, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Buscar primeiro o Reino de Deus', 'Buscai em primeiro lugar o Reino de Deus e a sua justiça, e todas estas coisas vos serão acrescentadas.', 'Mateus 6,33', 'Bíblia Sagrada', 'buscar-reino-de-deus-mt-6-33', 1, NULL, NULL, 6, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Oferecer a vida como culto espiritual', 'Eu vos exorto, irmãos, pela misericórdia de Deus, a oferecerdes os vossos corpos como sacrifício vivo, santo e agradável a Deus: este é o vosso culto espiritual.', 'Romanos 12,1', 'Bíblia Sagrada', 'oferecer-a-vida-a-deus-rm-12-1', 1, NULL, NULL, 7, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Perseverança na obra do Senhor', 'Sede firmes, inabaláveis, sempre abundantes na obra do Senhor, sabendo que o vosso trabalho não é vão no Senhor.', '1 Coríntios 15,58', 'Bíblia Sagrada', 'perseveranca-na-obra-do-senhor-1cor-15-58', 1, NULL, NULL, 8, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Trabalhar com dedicação', 'Tudo quanto te vier à mão para fazer, faze-o conforme as tuas forças.', 'Eclesiastes 9,10', 'Bíblia Sagrada', 'tudo-faze-conforme-tuas-forcas-ecl-9-10', 1, NULL, NULL, 9, 'publicado', NULL),
    ('VERSICULO', 'BIBLICA', 'PRINCIPAL', 'Deus presente nas tarefas comuns', 'Maria, porém, guardava todas estas coisas, meditando-as em seu coração.', 'Lucas 2,19', 'Bíblia Sagrada', 'guardar-as-coisas-no-coracao-lc-2-19', 1, NULL, NULL, 10, 'publicado', NULL),
    -- CITACOES DE SÃO JOSEMARIA ESCRIVÁ
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Encontrar Deus na vida cotidiana', 'Ou sabemos encontrar o Senhor na nossa vida ordinária, de todos os dias, ou não O encontraremos nunca.', 'Caminho, 815', 'Caminho - São Josemaria Escrivá', 'encontrar-deus-na-vida-cotidiana-caminho-815', 1, 1, NULL, 11, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Santificação da vida comum', 'Aí, nas circunstâncias da vida comum, o Senhor nos espera.', 'Caminho, 307', 'Caminho - São Josemaria Escrivá', 'o-senhor-nos-espera-na-vida-comum-caminho-307', 1, 1, NULL, 12, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Valor sobrenatural das pequenas coisas', 'Fazei tudo por Amor. - Assim não há coisas pequenas: tudo é grande. - A perseverança nas pequenas coisas, por Amor, é heroísmo.', 'Caminho, 813', 'Caminho - São Josemaria Escrivá', 'fazer-tudo-por-amor-caminho-813', 1, 1, NULL, 13, 'publicado',NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Presença de Deus no trabalho', 'O trabalho, todo trabalho, é testemunho da dignidade do homem, do seu domínio sobre a criação.', 'Cristo que Passa, 47', 'Cristo que Passa - São Josemaria Escrivá', 'o-trabalho-e-testemunho-da-dignidade-do-homem-cristo-que-passa-47', 1, 1, NULL, 14, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Santificar o trabalho', 'Temos de santificar o trabalho, santificar-nos no trabalho e santificar os outros com o trabalho.', 'Questões Atuais do Cristianismo, 55', 'Questões Atuais do Cristianismo - São Josemaria Escrivá', 'santificar-o-trabalho-santificar-nos-no-trabalho-questoes-atuais-55', 1, 1, NULL, 15, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'O valor das pequenas coisas', 'Não tens reparado em que "ninharias" está o amor humano? — Pois também em "ninharias" está o Amor divino.', 'Caminho, 824', 'Caminho - São Josemaria Escrivá', 'ninharias-do-amor-divino-caminho-824', 1, 1, NULL, 16, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A santidade nos pequenos deveres', 'A santidade "grande" consiste em cumprir os "pequenos deveres" de cada instante.', 'Caminho, 817',  'Caminho - São Josemaria Escrivá', 'santidade-nos-pequenos-deveres-caminho-817', 1, 1, NULL, 17, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'O trabalho feito por amor', 'Na simplicidade do teu trabalho habitual, nos detalhes monótonos de cada dia, tens que descobrir o segredo — para tantos escondido — da grandeza e da novidade: o Amor.', 'Sulco, 489', 'Sulco - São Josemaria Escrivá', 'o-amor-no-trabalho-habitual-sulco-489', 1, 1, NULL, 18, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Trabalhar não é apenas cumprir', 'Para um católico, trabalhar não é cumprir, é amar!; e exceder-se com gosto, e sempre, no dever e no sacrifício.', 'Sulco, 527', 'Sulco - São Josemaria Escrivá', 'trabalhar-nao-e-cumprir-e-amar-sulco-527', 1, 1, NULL, 19, 'publicado',  NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'A dignidade do trabalho', 'A dignidade do trabalho se baseia no Amor. O grande privilégio do homem é poder amar, transcendendo assim o efêmero e transitório.', 'Cristo que Passa, 48', 'Cristo que Passa - São Josemaria Escrivá', 'dignidade-do-trabalho-baseada-no-amor-cristo-que-passa-48', 1, 1, NULL, 20, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Fazer o que se deve', 'Queres de verdade ser santo? — Cumpre o pequeno dever de cada momento: faz o que deves e está no que fazes.', 'Caminho, 815', 'Caminho - São Josemaria Escrivá', 'fazer-o-que-deves-e-estar-no-que-fazes-caminho-815', 1, 1, NULL, 21, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Unidade de vida', 'Não há uma vida cristã à margem da vida profissional, familiar e social; tudo deve ser ocasião de encontro com Deus.', 'Entrevistas com Mons. Escrivá, Questões Atuais do Cristianismo', 'Questões Atuais do Cristianismo - São Josemaria Escrivá', 'unidade-de-vida-e-encontro-com-deus', 1, 1, NULL, 22, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'O trabalho como caminho de santidade', 'O trabalho profissional, qualquer que seja, é meio e caminho de santidade.', 'Forja, 702', 'Forja - São Josemaria Escrivá', 'o-trabalho-como-caminho-de-santidade-forja-702', 1, 1, NULL, 23, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Amor nas tarefas ordinárias', 'Transforma em poesia heroica a prosa diária.', 'Forja, 803', 'Forja - São Josemaria Escrivá', 'transformar-a-prosa-diaria-em-poesia-heroica-forja-803', 1, 1, NULL, 24, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Cristo no meio da vida comum', 'Cristo passa ao nosso lado nas circunstâncias ordinárias da vida.', 'Cristo que Passa', 'Cristo que Passa - São Josemaria Escrivá', 'cristo-no-meio-da-vida-comum-cristo-que-passa', 1, 1, NULL, 25, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'As pequenas coisas feitas por amor', 'Faze tudo por Amor. Assim não há coisas pequenas: tudo é grande. A perseverança nas pequenas coisas, por Amor, é heroísmo.', 'Caminho, 813', 'Caminho - São Josemaria Escrivá', 'as-pequenas-coisas-feitas-por-amor-caminho-813', 1, 1, NULL, 26, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Não desprezar as pequenas coisas', 'Erraste o caminho se desprezas as coisas pequenas.', 'Caminho, 816', 'Caminho - São Josemaria Escrivá', 'nao-desprezar-as-pequenas-coisas-caminho-816', 1, 1, NULL, 27, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'O trabalho humilde como oração', 'Persevera no cumprimento exato das obrigações de agora. - Esse trabalho - humilde, monótono, pequeno - é oração plasmada em obras que te preparam para receber a graça do outro trabalho - grande, vasto e profundo - com que sonhas.', 'Caminho, 825', 'Caminho - São Josemaria Escrivá', 'o-trabalho-humilde-como-oracao-caminho-825', 1, 1, NULL, 28,'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Todo trabalho pode ser santificado', 'Qualquer atividade, seja ou não humanamente muito importante, tem de converter-se para ti num meio de servir o Senhor e os homens.', 'Forja, 684', 'Forja - São Josemaria Escrivá', 'todo-trabalho-pode-ser-servico-a-deus-forja-684', 1, 1, NULL, 29, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'PRINCIPAL', 'Trabalhar por amor', 'Não hás de trabalhar por entusiasmo, mas por Amor; com consciência do dever, que é abnegação.', 'Caminho, 994', 'Caminho - São Josemaria Escrivá', 'trabalhar-por-amor-caminho-994', 1, 1, NULL, 30, 'publicado', NULL),
    -- CITACOES TAMBEM AUTENTICAS POREM COMPLEMENTARES DE OUTROS AUTORES, MAS QUE SE RELACIONAM COM O TEMA DO COTIDIANO E DA SANTIFICAÇÃO DA VIDA ORDINÁRIA
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Santidade na vida comum', 'Não é somente no retiro que devemos procurar a perfeição; ela deve acompanhar-nos no meio das ocupações da vida.', 'Introdução à Vida Devota', 'Introdução à Vida Devota - São Francisco de Sales','santidade-no-meio-das-ocupacoes-da-vida', 1, 7, NULL, 32, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'O amor dá valor às pequenas ações', 'O bom Deus não olha tanto a grandeza das nossas ações, mas o amor com que as fazemos.', 'Manuscritos Autobiográficos', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'o-amor-nas-pequenas-acoes-santa-teresinha', 1, 9, NULL, 33, 'publicado', NULL),    
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A devoção para todos os estados de vida', 'A devoção deve ser exercida de modos diferentes segundo as diferentes condições da vida.', 'Introdução à Vida Devota', 'Introdução à Vida Devota - São Francisco de Sales', 'devocao-para-todos-os-estados-de-vida', 1, 7, NULL, 36, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A santidade no meio do mundo', 'A verdadeira devoção não prejudica coisa alguma, mas antes aperfeiçoa tudo.', 'Introdução à Vida Devota', 'Introdução à Vida Devota - São Francisco de Sales', 'a-verdadeira-devocao-aperfeicoa-tudo', 1, 7, NULL, 37, 'publicado', NULL ),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A vocação do amor', 'No coração da Igreja, minha Mãe, eu serei o Amor.', 'Manuscrito B', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'no-coracao-da-igreja-eu-serei-o-amor', 1, 9, NULL, 38, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'A confiança nas pequenas coisas', 'Quero procurar o meio de ir para o Céu por um caminho bem reto, muito curto, um caminho todo novo.', 'Manuscrito C', 'História de uma Alma - Santa Teresinha do Menino Jesus', 'pequeno-caminho-de-santa-teresinha', 1, 9, NULL, 39, 'publicado', NULL),
    ('CITACAO', 'AUTENTICA', 'COMPLEMENTAR', 'Deus basta', 'Quem a Deus tem nada lhe falta; só Deus basta.', 'Poesia: Nada te perturbe', 'Santa Teresa de Jesus', 'quem-a-deus-tem-nada-lhe-falta', 1, 8, NULL, 40, 'publicado', NULL),
    -- CITAÇÕES DE TRADIÇÃO OU ATRIBUIÇÃO NÃO DOCUMENTAL, MAS QUE SE RELACIONAM COM O TEMA DO COTIDIANO E DA SANTIFICAÇÃO DA VIDA ORDINÁRIA
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Pequenas coisas feitas com grande amor', 'Não podemos fazer grandes coisas; somente pequenas coisas com grande amor.', 'Frase atribuída em escritos e ensinamentos de Santa Teresa de Calcutá', 'Santa Teresa de Calcutá', 'pequenas-coisas-com-grande-amor', 1, 6, NULL, 31, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Amor como centro da vida cristã', 'A medida do amor é amar sem medida.', 'Tratado sobre o Amor de Deus', 'Tratado sobre o Amor de Deus - São Bernardo de Claraval', 'a-medida-do-amor-e-amar-sem-medida', 1, 10, NULL, 35, 'publicado', NULL),
    ('CITACAO', 'TRADICAO', 'COMPLEMENTAR', 'Encontrar Deus em tudo', 'Nada te perturbe, nada te espante; Deus não muda.', 'Poesias / tradição espiritual de Santa Teresa de Ávila', 'Tradição espiritual carmelita', 'nada-te-perturbe-santa-teresa', 1, 8, NULL, 34, 'publicado', NULL);