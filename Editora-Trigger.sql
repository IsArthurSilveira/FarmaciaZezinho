/* criação de triggers (ddl) */

delimiter //

-- 1. trigger: after insert on pedidos
-- objetivo: registrar no log de auditoria quando um novo pedido é criado.
create trigger trg_after_insert_pedidos
after insert on pedidos
for each row
begin
    insert into auditorialog (mensagem, dataregistro)
    values (concat('novo pedido id: ', new.idpedidos, ' criado pelo cliente cpf: ', new.cliente_cpf_cli, ' em ', new.datapedido, '.'), now());
end //

-- 2. trigger: before update on funcionario
-- objetivo: impedir a alteração do salário de um funcionário para um valor abaixo da faixa salarial de seu cargo.
create trigger trg_before_update_funcionario_salario
before update on funcionario
for each row
begin
    declare v_faixa_salario_min decimal(7,2);

    -- obter a faixa salarial do cargo atual do funcionário
    select c.faixasalario into v_faixa_salario_min
    from cargo c
    join trabalhar t on c.cbo = t.cargo_cbo
    where t.funcionario_cpf_func = new.cpf_func
    limit 1; -- assume que um funcionário tem apenas um cargo principal para esta validação

    -- se o novo salário for menor que a faixa salarial mínima do cargo
    if new.salario < v_faixa_salario_min then
        signal sqlstate '45000'
        set message_text = 'erro: o novo salário não pode ser menor que a faixa salarial mínima do cargo.';
    end if;

    insert into auditorialog (mensagem, dataregistro)
    values (concat('salário do funcionário cpf: ', new.cpf_func, ' atualizado de ', old.salario, ' para ', new.salario, '.'), now());
end //

-- 3. trigger: after update on vendas
-- objetivo: registrar no log de auditoria quando o valor de uma venda é atualizado.
create trigger trg_after_update_vendas_valor
after update on vendas
for each row
begin
    if new.valor <> old.valor then
        insert into auditorialog (mensagem, dataregistro)
        values (concat('valor da venda id: ', new.idvendas, ' alterado de ', old.valor, ' para ', new.valor, '.'), now());
    end if;
end //

-- 4. trigger: before delete on livros
-- objetivo: impedir a exclusão de um livro se ainda houver exemplares associados a ele.
create trigger trg_before_delete_livros
before delete on livros
for each row
begin
    declare v_num_exemplares int;

    -- contar o número de exemplares para o livro que está sendo excluído
    select count(*) into v_num_exemplares
    from exemplar
    where livros_isbn = old.isbn;

    -- se existirem exemplares, impedir a exclusão
    if v_num_exemplares > 0 then
        signal sqlstate '45000'
        set message_text = 'erro: não é possível excluir o livro. existem exemplares associados a ele.';
    end if;

    insert into auditorialog (mensagem, dataregistro)
    values (concat('tentativa de exclusão do livro isbn: ', old.isbn, ' (', old.titulo, ').'), now());
end //

-- 5. trigger: after insert on livroautores
-- objetivo: registrar no log de auditoria quando um novo autor é associado a um livro.
create trigger trg_after_insert_livroautores
after insert on livroautores
for each row
begin
    declare v_nome_autor varchar(45);
    declare v_titulo_livro varchar(45);

    select nome into v_nome_autor from autor where cpf_autor = new.autor_cpf_autor;
    select titulo into v_titulo_livro from livros where isbn = new.livros_isbn;

    insert into auditorialog (mensagem, dataregistro)
    values (concat('autor "', v_nome_autor, '" (cpf: ', new.autor_cpf_autor, ') associado ao livro "', v_titulo_livro, '" (isbn: ', new.livros_isbn, ').'), now());
end //

-- 6. trigger: before insert on exemplar
-- objetivo: garantir que a localização de um novo exemplar seja padronizada se for 'desconhecida'.
create trigger trg_before_insert_exemplar
before insert on exemplar
for each row
begin
    if lower(new.localizacao) = 'desconhecida' or new.localizacao is null or new.localizacao = '' then
        set new.localizacao = 'localização_padrão_estoque';
        insert into auditorialog (mensagem, dataregistro)
        values (concat('localização do novo exemplar com numero de serie: ', new.numeroserie, ' ajustada para "localização_padrão_estoque".'), now());
    else
         insert into auditorialog (mensagem, dataregistro)
        values (concat('novo exemplar com numero de serie: ', new.numeroserie, ' inserido com localização: ', new.localizacao, '.'), now());
    end if;
end //

delimiter ;