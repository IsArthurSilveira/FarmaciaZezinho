/* scripts para testar as stored procedures */
-- teste da procedure 1: inserir_livro_e_atualizar_estoque
-- estou incluindo-os nos parâmetros, mas eles não serão inseridos se as colunas não existirem.
call inserir_livro_e_atualizar_estoque(
    '9780000009999',         -- p_isbn
    'aventuras de sql',      -- p_titulo
    '2025-01-01',            -- p_data_publicacao
    'aventura',              -- p_genero
    300,                     -- p_npaginas
    'uma jornada emocionante pelo mundo do sql.', -- p_descricao
    2,                       -- p_areaconhecimento_idareaconhecimento (ciência da computação)
    '[https://exemplo.com/capas/aventuras_sql.jpg](https://exemplo.com/capas/aventuras_sql.jpg)', -- p_capaurl (pode não ser inserido se a coluna não existe)
    'sim',                   -- p_lancamento (pode não ser inserido se a coluna não existe)
    75.50,                   -- p_preco (pode não ser inserido se a coluna não existe)
    15.00,                   -- p_descontomaximo (pode não ser inserido se a coluna não existe)
    50,                      -- p_quantidadeestoque
    'armazém principal'      -- p_localizacaoestoque
);
select isbn, titulo, data_publicacao, genero, npaginas, descricao from livros where isbn = '9780000009999';
select isbn_livro, quantidade, localizacao from estoquelivros where isbn_livro = '9780000009999'; 
select numeroserie, estado, localizacao, livros_isbn from exemplar where livros_isbn = '9780000009999';
select mensagem from auditorialog where mensagem like 'livro "aventuras de sql"%';

-- teste da procedure 2: processar_venda_e_atualizar_pedido
call processar_venda_e_atualizar_pedido(
    108,                     -- p_idvendas
    '2025-06-25',            -- p_datavenda
    150.00,                  -- p_valor
    10.00,                   -- p_desconto
    '56789012345',           -- p_funcionario_cpf_func (lucas braga)
    2,                       -- p_pedidos_idpedidos (pedido id 2, status 'pendente')
    'crédito',               -- p_formapag_tipo
    1                        -- p_formapag_parcela
);
select idvendas, datavenda, valor, desconto from vendas where idvendas = 108;
select tipo, parcela, vendas_idvendas from formapag where vendas_idvendas = 108;
select idpedidos, status from pedidos where idpedidos = 2; -- deve estar 'concluído'
select mensagem from auditorialog where mensagem like 'venda id 108%';

-- teste da procedure 3: atualizar_funcionario_e_endereco
call atualizar_funcionario_e_endereco(
    '23456789012',           -- p_cpf_func (carlos souza)
    'carlos souza novo',     -- p_nomefunc
    5000.00,                 -- p_salario
    'pe',                    -- p_uf
    'olinda',                -- p_cidade
    'bairro novo',           -- p_bairro
    'rua da paz',            -- p_rua
    999,                     -- p_numero
    'apto 101',              -- p_comp
    '53000-000'              -- p_cep
);
select cpf_func, nomefunc, salario from funcionario where cpf_func = '23456789012';
select funcionariocpf, uf, cidade, bairro, rua, numero, comp, cep from enderecofunc where funcionariocpf = '23456789012';
select mensagem from auditorialog where mensagem like 'dados e endereço do funcionário cpf 23456789012%';

-- teste da procedure 4: gerenciar_autor_e_livro - adicionar
call gerenciar_autor_e_livro(
    'adicionar',             -- p_acao
    '999.888.777-66',        -- p_cpf_autor
    'novo autor fictício',   -- p_nomeautor
    'biografia de um novo autor fictício.', -- p_biografiaautor
    'brasileira',            -- p_nacionalidadeautor
    '1990-10-01',            -- p_datanascautor
    '9780000009999'          -- p_livros_isbn (o livro que acabamos de inserir)
);
select cpf_autor, nome from autor where cpf_autor = '999.888.777-66';
select livros_isbn, autor_cpf_autor from livroautores where livros_isbn = '9780000009999' and autor_cpf_autor = '999.888.777-66';
select mensagem from auditorialog where mensagem like 'autor cpf 999.888.777-66 associado ao livro isbn 9780000009999%';

-- teste da procedure 4: gerenciar_autor_e_livro - remover
call gerenciar_autor_e_livro(
    'remover',               -- p_acao
    '999.888.777-66',        -- p_cpf_autor
    null, null, null, null,  -- dados não usados na remoção, mas mantidos por assinatura
    '9780000009999'          -- p_livros_isbn
);
select livros_isbn, autor_cpf_autor from livroautores where livros_isbn = '9780000009999' and autor_cpf_autor = '999.888.777-66'; -- deve retornar vazio
select cpf_autor, nome from autor where cpf_autor = '999.888.777-66'; -- deve ter sido removido
select mensagem from auditorialog where mensagem like 'associação do autor cpf 999.888.777-66 com o livro isbn 9780000009999 removida%';

-- teste da procedure 5: inserir_ou_atualizar_contato - inserir
call inserir_ou_atualizar_contato(
    99,                      -- p_idcontato
    'novo_contato@editora.com', -- p_email
    '81987654321',           -- p_telefone
    null,                    -- p_departamento_iddepartamento
    null,                    -- p_funcionario_cpf_func
    '12345678901'            -- p_cliente_cpf_cli (clara luz)
);
select idcontato, email, telefone, cliente_cpf_cli from contato where idcontato = 99;
select mensagem from auditorialog where mensagem like 'contato id 99 inserido/atualizado%';

-- teste da procedure 5: inserir_ou_atualizar_contato - atualizar
call inserir_ou_atualizar_contato(
    99,                      -- p_idcontato
    'contato_atualizado@editora.com', -- p_email
    '81912345678',           -- p_telefone
    null,                    -- p_departamento_iddepartamento
    null,                    -- p_funcionario_cpf_func
    '12345678901'            -- p_cliente_cpf_cli
);
select idcontato, email, telefone, cliente_cpf_cli from contato where idcontato = 99;
select mensagem from auditorialog where mensagem like 'contato id 99 inserido/atualizado%'; -- mensagem é a mesma para inserção/atualização

-- teste da procedure 6: atualizar_preco_e_desconto_livro
call atualizar_preco_e_desconto_livro(
    '9780000000013',         -- p_isbn (lógica de programação)
    80.00,                   -- p_novopreco
    20.00                    -- p_novodescontomaximo
);
select isbn, titulo, preco, descontomaximo from livros where isbn = '9780000000013';
select mensagem from auditorialog where mensagem like 'preço e desconto do livro isbn 9780000000013%';