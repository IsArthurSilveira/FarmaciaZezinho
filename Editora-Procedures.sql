/* criação  procedures*/
-- 1. procedure para registrar novo livro e atualizar estoque
delimiter //
create procedure inserir_livro_e_atualizar_estoque(
    in p_isbn varchar(13),
    in p_titulo varchar(45),
    in p_data_publicacao date,
    in p_genero varchar(45),
    in p_npaginas int,
    in p_descricao varchar(500),
    in p_areaconhecimento_idareaconhecimento int,
    in p_capaurl varchar(255),
    in p_lancamento varchar(45),
    in p_preco decimal(10, 2),
    in p_descontomaximo decimal(4,2),
    in p_quantidadeestoque int,
    in p_localizacaoestoque varchar(50)
)
begin
    declare v_proximo_numero_serie int;

    -- inserir o novo livro na tabela livros
    insert into livros (isbn, titulo, data_publicacao, genero, npaginas, descricao, areaconhecimento_idareaconhecimento, capaurl, lancamento, preco, descontomaximo)
    values (p_isbn, p_titulo, p_data_publicacao, p_genero, p_npaginas, p_descricao, p_areaconhecimento_idareaconhecimento, p_capaurl, p_lancamento, p_preco, p_descontomaximo);

    -- obter o próximo numero de série em uma variável separada
    select coalesce(max(numeroserie), 0) + 1 into v_proximo_numero_serie from exemplar;

    -- inserir o exemplar inicial para o livro
    insert into exemplar (numeroserie, estado, localizacao, livros_isbn)
    values (v_proximo_numero_serie, 'novo', p_localizacaoestoque, p_isbn);
    
    insert into estoquelivros (isbn_livro, quantidade, localizacao)
    values (p_isbn, p_quantidadeestoque, p_localizacaoestoque)
    on duplicate key update quantidade = quantidade + p_quantidadeestoque;

    -- registrar uma auditoria (exemplo simples). a tabela auditorialog precisa ser criada.
    insert into auditorialog (mensagem, dataregistro)
    values (concat('livro "', p_titulo, '" (isbn: ', p_isbn, ') inserido e estoque atualizado.'), now());
end //
delimiter ;

-- 2. procedure para processar venda e atualizar status do pedido
delimiter //
create procedure processar_venda_e_atualizar_pedido(
    in p_idvendas int,
    in p_datavenda date,
    in p_valor decimal(6,2),
    in p_desconto decimal(4,2),
    in p_funcionario_cpf_func varchar(14),
    in p_pedidos_idpedidos int,
    in p_formapag_tipo varchar(45),
    in p_formapag_parcela int
)
begin
    declare v_proximo_idformapag int;

    -- inserir a venda
    insert into vendas (idvendas, datavenda, valor, desconto, funcionario_cpf_func, pedidos_idpedidos)
    values (p_idvendas, p_datavenda, p_valor, p_desconto, p_funcionario_cpf_func, p_pedidos_idpedidos);

    -- obter o próximo idformapag em uma variável separada
    select coalesce(max(idformapag), 0) + 1 into v_proximo_idformapag from formapag;

    -- inserir a forma de pagamento
    insert into formapag (idformapag, tipo, parcela, vendas_idvendas)
    values (v_proximo_idformapag, p_formapag_tipo, p_formapag_parcela, p_idvendas);

    -- atualizar o status do pedido para 'concluído'
    update pedidos
    set status = 'concluído'
    where idpedidos = p_pedidos_idpedidos;

    -- registrar uma auditoria. a tabela auditorialog precisa ser criada.
    insert into auditorialog (mensagem, dataregistro)
    values (concat('venda id ', p_idvendas, ' processada e pedido id ', p_pedidos_idpedidos, ' atualizado para "concluído".'), now());
end //
delimiter ;

-- 3. procedure para atualizar dados do funcionário e endereço
delimiter //
create procedure atualizar_funcionario_e_endereco(
    in p_cpf_func varchar(14),
    in p_nomefunc varchar(45),
    in p_salario decimal(7,2),
    in p_uf char(2),
    in p_cidade varchar(60),
    in p_bairro varchar(60),
    in p_rua varchar(70),
    in p_numero int,
    in p_comp varchar(45),
    in p_cep varchar(9)
)
begin
    -- atualizar dados do funcionário
    update funcionario
    set nomefunc = p_nomefunc, salario = p_salario
    where cpf_func = p_cpf_func;

    -- atualizar endereço do funcionário
    update enderecofunc
    set uf = p_uf, cidade = p_cidade, bairro = p_bairro, rua = p_rua, numero = p_numero, comp = p_comp, cep = p_cep
    where funcionariocpf = p_cpf_func;

    -- verificar se o endereço foi realmente atualizado (verificando linhas afetadas)
    if row_count() = 0 then
        -- se não atualizou, talvez não exista, então insere
        insert into enderecofunc (funcionariocpf, uf, cidade, bairro, rua, numero, comp, cep)
        values (p_cpf_func, p_uf, p_cidade, p_bairro, p_rua, p_numero, p_comp, p_cep);
    end if;

    -- registrar uma auditoria. a tabela auditorialog precisa ser criada.
    insert into auditorialog (mensagem, dataregistro)
    values (concat('dados e endereço do funcionário cpf ', p_cpf_func, ' atualizados.'), now());
end //
delimiter ;

-- 4. procedure para gerenciar autores e seus livros (adicionar/remover)
delimiter //
create procedure gerenciar_autor_e_livro(
    in p_acao varchar(10), -- 'adicionar' ou 'remover'
    in p_cpf_autor varchar(14),
    in p_nomeautor varchar(45),
    in p_biografiaautor varchar(450),
    in p_nacionalidadeautor varchar(45),
    in p_datanascautor date,
    in p_livros_isbn varchar(13)
)
begin
    if p_acao = 'adicionar' then
        -- inserir ou ignorar se o autor já existe
        insert ignore into autor (cpf_autor, nome, biografia, nacionalidade, datanasc)
        values (p_cpf_autor, p_nomeautor, p_biografiaautor, p_nacionalidadeautor, p_datanascautor);

        -- ligar o autor ao livro
        insert into livroautores (livros_isbn, autor_cpf_autor)
        values (p_livros_isbn, p_cpf_autor);

        -- registrar uma auditoria. a tabela auditorialog precisa ser criada.
        insert into auditorialog (mensagem, dataregistro)
        values (concat('autor cpf ', p_cpf_autor, ' associado ao livro isbn ', p_livros_isbn, '.'), now());

    elseif p_acao = 'remover' then
        -- remover a ligação do autor com o livro
        delete from livroautores
        where livros_isbn = p_livros_isbn and autor_cpf_autor = p_cpf_autor;

        -- opcional: remover o autor se ele não estiver mais associado a nenhum livro
        delete from autor
        where cpf_autor = p_cpf_autor and not exists (select 1 from livroautores where autor_cpf_autor = p_cpf_autor);

        -- registrar uma auditoria. a tabela auditorialog precisa ser criada.
        insert into auditorialog (mensagem, dataregistro)
        values (concat('associação do autor cpf ', p_cpf_autor, ' com o livro isbn ', p_livros_isbn, ' removida.'), now());
    end if;
end //
delimiter ;

-- 5. procedure para inserir ou atualizar contato
delimiter //
create procedure inserir_ou_atualizar_contato(
    in p_idcontato int,
    in p_email varchar(45),
    in p_telefone varchar(45),
    in p_departamento_iddepartamento int,
    in p_funcionario_cpf_func varchar(14),
    in p_cliente_cpf_cli varchar(14)
)
begin
    -- tenta atualizar o contato
    update contato
    set email = p_email, telefone = p_telefone, departamento_iddepartamento = p_departamento_iddepartamento, funcionario_cpf_func = p_funcionario_cpf_func, cliente_cpf_cli = p_cliente_cpf_cli
    where idcontato = p_idcontato;

    -- se o contato não existia, insere
    if row_count() = 0 then
        insert into contato (idcontato, email, telefone, departamento_iddepartamento, funcionario_cpf_func, cliente_cpf_cli)
        values (p_idcontato, p_email, p_telefone, p_departamento_iddepartamento, p_funcionario_cpf_func, p_cliente_cpf_cli);
    end if;

    -- log de auditoria
    insert into auditorialog (mensagem, dataregistro)
    values (concat('contato id ', p_idcontato, ' inserido/atualizado.'), now());

    -- exemplo de select para confirmar a operação (opcional)
    select * from contato where idcontato = p_idcontato;
end //
delimiter ;

-- 6. procedure para atualizar preço e desconto de livro
delimiter //
create procedure atualizar_preco_e_desconto_livro(
    in p_isbn varchar(13),
    in p_novopreco decimal(10, 2),
    in p_novodescontomaximo decimal(4,2)
)
begin
    -- declaração de variáveis para armazenar valores atuais
    declare v_precoatual decimal(10,2);
    declare v_descontoatual decimal(4,2);

    -- obter os valores atuais antes da atualização
    select preco, descontomaximo into v_precoatual, v_descontoatual
    from livros
    where isbn = p_isbn;

    -- atualizar o preço e o desconto máximo do livro
    update livros
    set preco = p_novopreco, descontomaximo = p_novodescontomaximo
    where isbn = p_isbn;

    -- verificar se a atualização foi bem-sucedida e logar. a tabela auditorialog precisa ser criada.
    if row_count() > 0 then
        insert into auditorialog (mensagem, dataregistro)
        values (concat('preço e desconto do livro isbn ', p_isbn, ' atualizados de (', v_precoatual, ', ', v_descontoatual, ') para (', p_novopreco, ', ', p_novodescontomaximo, ').'), now());
    else
        insert into auditorialog (mensagem, dataregistro)
        values (concat('tentativa de atualização falhou para o livro isbn ', p_isbn, '. livro não encontrado ou sem alterações.'), now());
    end if;

    -- selecionar o livro atualizado para confirmação
    select isbn, titulo, preco, descontomaximo from livros where isbn = p_isbn;
end //
delimiter ;

-- tabela para log de auditoria (para as procedures).
create table if not exists auditorialog (
    idlog int auto_increment primary key,
    mensagem varchar(500) not null,
    dataregistro datetime default current_timestamp
);

-- tabela estoque livros (para as procedures)
create table if not exists estoquelivros (
    isbn_livro varchar(14),
    quantidade int,
    localizacao varchar(50),
    primary key (isbn_livro),
    foreign key (isbn_livro) references livros(isbn)
);