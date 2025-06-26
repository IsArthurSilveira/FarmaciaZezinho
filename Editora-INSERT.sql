/*Comando INSERT*/
-- Funcionario
INSERT INTO Funcionario (CPF_Func, NomeFunc, sexo, dataNasc, ch, salario, dataAdm) VALUES
('12345678901', 'Ana Lima', 'F', '1985-06-12', 40, 3200.00, '2010-01-15'),
('23456789012', 'Carlos Souza', 'M', '1979-08-23', 40, 4500.00, '2005-03-20'),
('34567890123', 'João Pedro', 'M', '1990-05-10', 40, 2800.00, '2018-07-01'),
('45678901234', 'Maria Rosa', 'F', '1982-12-30', 40, 3900.00, '2012-11-02'),
('56789012345', 'Lucas Braga', 'M', '1995-09-15', 40, 2500.00, '2020-06-17'),
('67890123456', 'Fernanda Lopes', 'F', '1988-03-05', 40, 4200.00, '2015-04-12'),
('78901234567', 'Roberto Dias', 'M', '1975-07-20', 40, 5000.00, '2001-09-09'),
('89012345678', 'Paula Castro', 'F', '1993-01-25', 40, 3000.00, '2017-01-05'),
('90123456789', 'André Moura', 'M', '1998-04-16', 40, 2700.00, '2021-05-20'),
('01234567890', 'Juliana Alves', 'F', '1987-11-14', 40, 3800.00, '2013-08-25');

-- EnderecoFunc
INSERT INTO EnderecoFunc (FuncionarioCPF, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('12345678901', 'PE', 'Recife', 'Boa Vista', 'Rua A', 123, NULL, '50000-000'),
('23456789012', 'PE', 'Recife', 'Madalena', 'Rua B', 234, NULL, '50010-000'),
('34567890123', 'PE', 'Recife', 'Casa Forte', 'Rua C', 345, NULL, '50020-000'),
('45678901234', 'PE', 'Recife', 'Derby', 'Rua D', 456, NULL, '50030-000'),
('56789012345', 'PE', 'Recife', 'Pina', 'Rua E', 567, NULL, '50040-000'),
('67890123456', 'PE', 'Recife', 'Espinheiro', 'Rua F', 678, NULL, '50050-000'),
('78901234567', 'PE', 'Recife', 'Tamarineira', 'Rua G', 789, NULL, '50060-000'),
('89012345678', 'PE', 'Recife', 'Graças', 'Rua H', 890, NULL, '50070-000'),
('90123456789', 'PE', 'Recife', 'Rosarinho', 'Rua I', 901, NULL, '50080-000'),
('01234567890', 'PE', 'Recife', 'Torre', 'Rua J', 101, NULL, '50090-000');

-- Cargo
INSERT INTO Cargo (cbo, nome, faixaSalario) VALUES
(1001, 'Editor', 4500.00),
(1002, 'Revisor', 3500.00),
(1003, 'Diagramador', 3200.00),
(1004, 'Gerente de Produção', 5000.00),
(1005, 'Atendente', 2800.00),
(1006, 'Vendedor', 2600.00),
(1007, 'Designer Gráfico', 3800.00),
(1008, 'Analista de Dados', 4000.00),
(1009, 'Programador', 4200.00),
(1010, 'Financeiro', 4100.00);

-- Departamento
INSERT INTO Departamento (idDepartamento, nome, localizacao, Gerente_cpf) VALUES
(1, 'Editorial', 'Bloco A', '23456789012'),      
(2, 'Produção', 'Bloco B', '45678901234'),       
(3, 'Vendas', 'Bloco C', '78901234567'),        
(4, 'Marketing', 'Bloco D', '67890123456'),    
(5, 'TI', 'Bloco E', '89012345678'),          
(6, 'RH', 'Bloco F', '01234567890'),            
(7, 'Financeiro', 'Bloco G', '56789012345'),     
(8, 'Atendimento', 'Bloco H', '12345678901'),    
(9, 'Distribuição', 'Bloco I', '90123456789'),   
(10, 'Logística', 'Bloco J', '34567890123');     

-- Trabalhar
INSERT INTO Trabalhar (Cargo_cbo, Funcionario_CPF_Func, Departamento_idDepartamento) VALUES
(1001, '12345678901', 1),   
(1002, '23456789012', 1),  
(1003, '34567890123', 2),   
(1004, '45678901234', 2),   
(1005, '56789012345', 3),   
(1006, '67890123456', 3),   
(1007, '78901234567', 4),   
(1008, '89012345678', 5),   
(1009, '90123456789', 5),   
(1010, '01234567890', 7);   

-- Cliente
INSERT INTO Cliente (CPF_Cli, nome, sexo) VALUES
('12345678901', 'Clara Luz', 'F'),
('23456789012', 'José Dias', 'M'),
('34567890123', 'Lara Souza', 'F'),
('45678901234', 'Pedro Alves', 'M'),
('56789012345', 'Amanda Nunes', 'F'),
('67890123456', 'Tiago Rocha', 'M'),
('78901234567', 'Fabiana Melo', 'F'),
('89012345678', 'Renato Lima', 'M'),
('90123456789', 'Patrícia Silva', 'F'),
('01234567890', 'Diego Monteiro', 'M');

-- EnderecoCli
INSERT INTO EnderecoCli (Cliente_CPF_Cli, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('12345678901', 'PE', 'Recife', 'Boa Viagem', 'Av. Recife', 1, NULL, '51000-000'),
('23456789012', 'PE', 'Recife', 'Imbiribeira', 'Rua Recife', 2, NULL, '51010-000'),
('34567890123', 'PE', 'Recife', 'Piedade', 'Rua Piedade', 3, NULL, '51020-000'),
('45678901234', 'PE', 'Recife', 'Ibura', 'Rua Ibura', 4, NULL, '51030-000'),
('56789012345', 'PE', 'Recife', 'Areias', 'Rua Areias', 5, NULL, '51040-000'),
('67890123456', 'PE', 'Recife', 'Afogados', 'Rua Afogados', 6, NULL, '51050-000'),
('78901234567', 'PE', 'Recife', 'Cordeiro', 'Rua Cordeiro', 7, NULL, '51060-000'),
('89012345678', 'PE', 'Recife', 'Torre', 'Rua Torre', 8, NULL, '51070-000'),
('90123456789', 'PE', 'Recife', 'Tamarineira', 'Rua Tam', 9, NULL, '51080-000'),
('01234567890', 'PE', 'Recife', 'Derby', 'Rua Derby', 10, NULL, '51090-000');

-- Contato
INSERT INTO Contato (idContato, Email, Telefone, Departamento_idDepartamento, Funcionario_CPF_Func, Cliente_CPF_Cli) VALUES
(1, 'ana@editora.com', '8199990001', 1, '12345678901', NULL),
(2, 'carlos@editora.com', '8199990002', 1, '23456789012', NULL),
(3, 'joao@editora.com', '8199990003', 2, '34567890123', NULL),
(4, 'maria@editora.com', '8199990004', 2, '45678901234', NULL),
(5, 'lucas@editora.com', '8199990005', 3, '56789012345', NULL),
(6, 'fernanda@editora.com', '8199990006', 3, '67890123456', NULL),
(7, 'cliente1@email.com', '8199990010', NULL, NULL, '12345678901'),
(8, 'cliente2@email.com', '8199990011', NULL, NULL, '23456789012'),
(9, 'cliente3@email.com', '8199990012', NULL, NULL, '34567890123'),
(10, 'cliente4@email.com', '8199990013', NULL, NULL, '45678901234');

-- AreaConhecimento
INSERT INTO AreaConhecimento (idAreaConhecimento, nome, descricao) VALUES
(1, 'Literatura Brasileira', 'Estudo das obras, autores, movimentos literários e contextos históricos da produção literária nacional, promovendo o conhecimento da cultura e identidade brasileira.'),
(2, 'Ciência da Computação', 'Área voltada ao estudo de algoritmos, programação, estruturas de dados, inteligência artificial, sistemas operacionais e desenvolvimento de software e hardware.'),
(3, 'Administração', 'Campo que abrange gestão de empresas, finanças, recursos humanos, marketing e processos organizacionais, com foco em eficiência e resultados.'),
(4, 'Psicologia', 'Estudo do comportamento humano e dos processos mentais, incluindo abordagens clínicas, sociais, cognitivas e educacionais.'),
(5, 'Educação', 'Investigação e aplicação de métodos de ensino, aprendizagem, formação de professores, políticas educacionais e práticas pedagógicas.'),
(6, 'Matemática', 'Ciência exata que analisa estruturas abstratas, números, formas e padrões, com aplicações em diversas áreas do conhecimento e da tecnologia.'),
(7, 'Filosofia', 'Reflexão crítica sobre o conhecimento, a ética, a existência, a linguagem e a lógica, com raízes na tradição do pensamento ocidental e oriental.'),
(8, 'História', 'Estudo crítico das sociedades ao longo do tempo, analisando eventos, processos, culturas e transformações políticas, sociais e econômicas.'),
(9, 'Biologia', 'Ciência que estuda os seres vivos, suas estruturas, funções, evolução, ecossistemas e a relação entre os organismos e o meio ambiente.'),
(10, 'Química', 'Área que investiga a composição, estrutura, propriedades e transformações da matéria, com aplicações na indústria, saúde, meio ambiente e tecnologia.');

-- Livros
INSERT INTO livros (ISBN, titulo, data_publicacao, genero, Npaginas, Descricao, AreaConhecimento_idAreaConhecimento, CapaURL, Lancamento, Preco, DescontoMaximo) VALUES
('9780000000011', 'Dom Casmurro', '1899-01-01', 'Romance', 256, 'Clássico da literatura brasileira.', 1, 'https://exemplo.com/capas/domcasmurro.jpg', 'Sim', 39.90, 10.00),
('9780000000012', 'O Cortiço', '1890-08-15', 'Naturalismo', 304, 'Romance que retrata o cotidiano de um cortiço.', 1, 'https://exemplo.com/capas/ocortico.jpg', 'Não', 34.90, 8.00),
('9780000000013', 'Lógica de Programação', '2016-05-20', 'Tecnologia', 420, 'Aprenda lógica de programação com exercícios.', 2, 'https://exemplo.com/capas/logica.jpg', 'Sim', 69.90, 12.00),
('9780000000014', 'Banco de Dados para Iniciantes', '2018-02-10', 'Tecnologia', 350, 'Conceitos básicos de bancos de dados relacionais.', 2, 'https://exemplo.com/capas/bd.jpg', 'Não', 59.00, 10.00),
('9780000000015', 'Introdução à Administração', '2020-01-05', 'Negócios', 298, 'Conceitos básicos de administração.', 3, 'https://exemplo.com/capas/adm.jpg', 'Sim', 54.90, 11.00),
('9780000000016', 'Marketing Digital na Prática', '2021-09-10', 'Negócios', 270, 'Ferramentas e estratégias de marketing online.', 3, 'https://exemplo.com/capas/marketing.jpg', 'Sim', 62.00, 13.00),
('9780000000017', 'Teorias da Aprendizagem', '2017-08-15', 'Educação', 310, 'Estudos sobre como aprendemos.', 4, 'https://exemplo.com/capas/aprendizagem.jpg', 'Não', 49.90, 9.00),
('9780000000018', 'Didática Moderna', '2022-01-20', 'Educação', 260, 'Técnicas de ensino para o século XXI.', 4, 'https://exemplo.com/capas/didatica.jpg', 'Sim', 57.50, 10.00),
('9780000000019', 'Fundamentos da Psicologia', '2019-04-11', 'Psicologia', 400, 'Principais abordagens e teorias.', 5, 'https://exemplo.com/capas/psicologia.jpg', 'Não', 65.00, 12.00),
('9780000000020', 'Psicologia do Desenvolvimento', '2020-06-30', 'Psicologia', 390, 'Fases do desenvolvimento humano.', 5, 'https://exemplo.com/capas/desenvolvimento.jpg', 'Sim', 68.90, 11.00);
-- Exemplares
INSERT INTO Exemplar (NumeroSerie, estado, localizacao, livros_ISBN) VALUES
(1, 'novo', 'Estante A1', '9780000000011'),
(2, 'usado', 'Estante A1', '9780000000011'),
(3, 'novo', 'Estante A2', '9780000000012'),
(4, 'novo', 'Estante B1', '9780000000013'),
(5, 'novo', 'Estante B1', '9780000000013'),
(6, 'usado', 'Estante C3', '9780000000014'),
(7, 'novo', 'Estante D2', '9780000000015'),
(8, 'novo', 'Estante D2', '9780000000015'),
(9, 'novo', 'Estante D2', '9780000000015'),
(10, 'novo', 'Estante E1', '9780000000016'),
(11, 'usado', 'Estante F3', '9780000000017'),
(12, 'novo', 'Estante G1', '9780000000018'),
(13, 'novo', 'Estante G1', '9780000000018'),
(14, 'novo', 'Estante G1', '9780000000018'),
(15, 'usado', 'Estante H4', '9780000000019'),
(16, 'novo', 'Estante I2', '9780000000020'),
(17, 'novo', 'Estante I2', '9780000000020'),
(18, 'novo', 'Estante J1', '9780000000011'),
(19, 'novo', 'Estante J1', '9780000000011'),
(20, 'novo', 'Estante J1', '9780000000011'),
(21, 'novo', 'Estante K3', '9780000000012'),
(22, 'novo', 'Estante L1', '9780000000013'),
(23, 'novo', 'Estante L1', '9780000000013'),
(24, 'novo', 'Estante L1', '9780000000013'),
(25, 'usado', 'Estante M2', '9780000000014'),
(26, 'novo', 'Estante N1', '9780000000015'),
(27, 'novo', 'Estante N1', '9780000000015'),
(28, 'novo', 'Estante O3', '9780000000016'),
(29, 'novo', 'Estante P2', '9780000000017'),
(30, 'usado', 'Estante P2', '9780000000017'),
(31, 'novo', 'Estante Q1', '9780000000018'),
(32, 'novo', 'Estante Q1', '9780000000018'),
(33, 'usado', 'Estante Q1', '9780000000018'),
(34, 'novo', 'Estante R4', '9780000000019'),
(35, 'novo', 'Estante S1', '9780000000020'),
(36, 'usado', 'Estante S1', '9780000000020'),
(37, 'novo', 'Estante S1', '9780000000020');

-- Pedidos
INSERT INTO Pedidos (idPedidos, dataPedido, `Status`, Cliente_CPF_Cli) VALUES
(1, '2024-01-15', 'concluído', '01234567890'),
(2, '2024-01-20', 'pendente', '12345678901'),
(3, '2024-01-25', 'cancelado', '23456789012'),
(4, '2024-02-01', 'concluído', '34567890123'),
(5, '2024-02-05', 'pendente', '45678901234'),
(6, '2024-02-10', 'concluído', '56789012345'),
(7, '2024-02-15', 'concluído', '56789012345'),
(8, '2024-02-20', 'cancelado', '67890123456'),
(9, '2024-02-25', 'pendente', '78901234567'),
(10, '2024-03-01', 'concluído', '78901234567');

-- PedioExemplares
INSERT INTO PedidoExemplares (Pedidos_idPedidos, Exemplar_NumeroSerie) VALUES
(1, 11),
(2, 12),
(2, 13),
(3, 14),
(4, 15),
(4, 16),
(5, 17),
(5, 18),
(5, 19),
(6, 20),
(7, 21),
(8, 22),
(8, 23),
(8, 24),
(9, 25),
(10, 26);



-- Vendas
INSERT INTO Vendas (idVendas, dataVenda, valor, desconto, Funcionario_CPF_Func, Pedidos_idPedidos) VALUES
(1, '2024-01-16', 45.90, 5.00, '56789012345', 1),
(2, '2024-01-21', 89.90, 0.00, '67890123456', 2),
(3, '2024-01-26', 65.00, 3.00, '56789012345', 3),
(4, '2024-02-02', 72.50, 2.50, '67890123456', 4),
(5, '2024-02-06', 59.90, 0.00, '56789012345', 5),
(6, '2024-02-11', 78.00, 4.00, '67890123456', 6),
(7, '2024-02-16', 38.00, 1.00, '56789012345', 7),
(8, '2024-02-21', 49.90, 0.00, '67890123456', 8),
(9, '2024-02-26', 88.80, 8.80, '56789012345', 9),
(10, '2024-03-02', 92.00, 7.00, '67890123456', 10),
(11, '2024-03-10', 55.20, 3.00, '56789012345', 10),
(12, '2024-03-12', 120.00, 10.00, '67890123456', 1),
(13, '2024-03-15', 75.50, 5.50, '56789012345', 2),
(14, '2024-03-18', 90.00, 0.00, '67890123456', 3),
(15, '2024-03-20', 60.00, 4.00, '56789012345', 4),
(16, '2024-03-22', 82.30, 2.30, '67890123456', 5),
(17, '2024-03-25', 49.00, 0.00, '56789012345', 6),
(18, '2024-03-28', 105.00, 7.00, '67890123456', 10),
(19, '2024-03-30', 115.50, 5.50, '56789012345', 9),
(20, '2024-04-01', 70.00, 3.50, '67890123456', 8);

-- FormaPag
INSERT INTO FormaPag (idFormaPag, tipo, parcela, Vendas_idVendas) VALUES
(1, 'Crédito', 2, 1),
(2, 'Débito', 1, 2),
(3, 'Boleto', 1, 3),
(4, 'Pix', 1, 4),
(5, 'Crédito', 3, 5),
(6, 'Pix', 1, 6),
(7, 'Crédito', 2, 7),
(8, 'Débito', 1, 8),
(9, 'Boleto', 1, 9),
(10, 'Crédito', 1, 10);

-- Autor
INSERT INTO Autor (CPF_Autor, Nome, Biografia, Nacionalidade, DataNasc) VALUES
('111.222.333-44', 'Luis Fernando', 'Escritor brasileiro renomado', 'Brasileiro', '1970-05-15'),
('222.333.444-55', 'Marina Torres', 'Especialista em computação', 'Brasileira', '1982-08-30'),
('333.444.555-66', 'Roberta Dias', 'Consultora em administração', 'Brasileira', '1975-11-20'),
('444.555.666-77', 'Paulo Mendes', 'Psicólogo clínico', 'Brasileiro', '1968-01-05'),
('555.666.777-88', 'Jéssica Ramos', 'Pedagoga e educadora', 'Brasileira', '1985-03-12'),
('666.777.888-99', 'André Lima', 'Professor de matemática', 'Brasileiro', '1972-09-17'),
('777.888.999-00', 'Bianca Souza', 'Filósofa e escritora', 'Brasileira', '1980-12-25'),
('888.999.000-11', 'Carlos Braga', 'Historiador e pesquisador', 'Brasileiro', '1965-07-08'),
('999.000.111-22', 'Luciana Rocha', 'Bióloga marinha', 'Brasileira', '1978-04-22'),
('000.111.222-33', 'Henrique Farias', 'Químico especializado em materiais', 'Brasileiro', '1969-10-11');

-- LivroAutores
INSERT INTO LivroAutores (Livros_ISBN, Autor_CPF_Autor) VALUES
('9780000000011', '111.222.333-44'),
('9780000000012', '222.333.444-55'),
('9780000000013', '333.444.555-66'),
('9780000000014', '444.555.666-77'),
('9780000000015', '555.666.777-88'),
('9780000000016', '666.777.888-99'),
('9780000000017', '777.888.999-00'),
('9780000000018', '888.999.000-11'),
('9780000000019', '999.000.111-22'),
('9780000000020', '000.111.222-33');

-- PalavraChave
INSERT INTO PalavraChave (idPalavraChave, palavra, significado) VALUES
(1, 'literatura', 'Conjunto de obras escritas, especialmente ficção, poesia e ensaios'),
(2, 'algoritmo', 'Conjunto de passos ou regras para resolver um problema ou realizar uma tarefa'),
(3, 'gestão', 'Processo de planejar, organizar e controlar recursos para alcançar objetivos'),
(4, 'psicologia', 'Estudo científico do comportamento e dos processos mentais'),
(5, 'educação', 'Processo de ensinar e aprender conhecimentos, habilidades e valores'),
(6, 'cálculo', 'Ramo da matemática que estuda taxas de variação e acumulação'),
(7, 'ética', 'Ramo da filosofia que analisa os princípios morais e o comportamento correto'),
(8, 'história', 'Estudo dos eventos passados e suas causas e consequências'),
(9, 'genética', 'Ramo da biologia que estuda a hereditariedade e variação dos organismos'),
(10, 'química', 'Ciência que estuda a composição, propriedades e transformações da matéria');

-- LivroPalavras (exemplo com palavras-chave)
INSERT INTO LivroPalavras (Livros_ISBN, PalavraChave_idPalavraChave) VALUES
('9780000000011', 1),
('9780000000012', 2),
('9780000000013', 3),
('9780000000014', 4),
('9780000000015', 5),
('9780000000016', 6),
('9780000000017', 7),
('9780000000018', 8),
('9780000000019', 9),
('9780000000020', 10);
