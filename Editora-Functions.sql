/* criação de stored functions (ddl) */

delimiter //

-- 1. função para calcular a idade de um funcionário com base na sua data de nascimento.
create function calcular_idade_funcionario(p_cpf_func varchar(14))
returns int deterministic
begin
    declare v_datanasc date;
    declare v_idade int;

    -- 1. selecionar a data de nascimento do funcionário
    select datanasc into v_datanasc
    from funcionario
    where cpf_func = p_cpf_func;

    -- 2. verificar se a data de nascimento foi encontrada
    if v_datanasc is null then
        return null; -- funcionário não encontrado
    end if;

    -- 3. calcular a idade em anos
    set v_idade = timestampdiff(year, v_datanasc, curdate());

    -- 4. retornar a idade
    return v_idade;
end //

-- 2. função para obter o valor total de pedidos de um cliente
create function obter_valor_total_pedidos_cliente(p_cpf_cli varchar(14))
returns decimal(10,2) deterministic
begin
    declare v_valor_total decimal(10,2) default 0.00;

    -- 1. somar o valor de todas as vendas vinculadas aos pedidos do cliente
    select sum(v.valor) into v_valor_total
    from cliente c
    join pedidos p on c.cpf_cli = p.cliente_cpf_cli
    join vendas v on p.idpedidos = v.pedidos_idpedidos
    where c.cpf_cli = p_cpf_cli;

    -- 2. verificar se o valor total é nulo (cliente sem vendas)
    if v_valor_total is null then
        set v_valor_total = 0.00;
    end if;

    -- 3. retornar o valor formatado (o retorno é decimal, a formatação é para exibição, não aqui)
    return v_valor_total;
end //

-- 3. função para contar o número de livros por autor
create function contar_livros_por_autor(p_cpf_autor varchar(14))
returns int deterministic
begin
    declare v_total_livros int default 0;

    -- 1. contar os livros associados ao autor
    select count(la.livros_isbn) into v_total_livros
    from autor a
    join livroautores la on a.cpf_autor = la.autor_cpf_autor
    where a.cpf_autor = p_cpf_autor;

    -- 2. retornar o total de livros
    return v_total_livros;
end //

-- 4. função para verificar a disponibilidade de um exemplar
create function verificar_disponibilidade_exemplar(p_numeroserie int)
returns varchar(10) deterministic
begin
    declare v_status varchar(10) default 'disponível';
    declare v_pedido_status varchar(45);

    -- 1. verificar se o exemplar existe
    select estado into v_status
    from exemplar
    where numeroserie = p_numeroserie;

    if v_status is null then
        return 'inexistente'; -- exemplar não encontrado
    end if;

    -- 2. verificar se o exemplar está em algum pedido pendente
    select p.status into v_pedido_status
    from pedidoexemplares pe
    join pedidos p on pe.pedidos_idpedidos = p.idpedidos
    where pe.exemplar_numeroserie = p_numeroserie and p.status = 'pendente'
    limit 1; -- limitar a 1 para eficiência, só precisamos saber se existe um pendente

    -- 3. decidir o status final
    if v_pedido_status = 'pendente' then
        set v_status = 'em_pedido';
    end if;

    -- 4. retornar o status
    return v_status;
end //

-- 5. função para obter o nome do gerente de um departamento
create function obter_nome_gerente_departamento(p_iddepartamento int)
returns varchar(45) deterministic
begin
    declare v_nome_gerente varchar(45);

    -- 1. selecionar o nome do gerente
    select f.nomefunc into v_nome_gerente
    from departamento d
    join funcionario f on d.gerente_cpf = f.cpf_func
    where d.iddepartamento = p_iddepartamento;

    -- 2. retornar o nome do gerente ou 'não definido'
    if v_nome_gerente is null then
        return 'não definido';
    else
        return v_nome_gerente;
    end if;
end //

-- 6. função para calcular o preço de venda com desconto para um livro
create function calcular_preco_com_desconto(p_isbn varchar(13))
returns decimal(10,2) deterministic
begin
    declare v_preco decimal(10,2);
    declare v_desconto_maximo decimal(4,2);
    declare v_preco_final decimal(10,2);

    -- 1. obter o preço e o desconto máximo do livro
    select preco, descontomaximo into v_preco, v_desconto_maximo
    from livros
    where isbn = p_isbn;

    -- 2. verificar se o livro foi encontrado e tem preço/desconto
    if v_preco is null or v_desconto_maximo is null then
        return null; -- livro ou dados de preço/desconto não encontrados
    end if;

    -- 3. calcular o preço final com desconto
    set v_preco_final = v_preco - (v_preco * (v_desconto_maximo / 100));

    -- 4. retornar o preço final
    return v_preco_final;
end //
delimiter ;