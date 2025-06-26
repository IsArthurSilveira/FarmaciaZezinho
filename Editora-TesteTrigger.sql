/* scripts para testar as triggers (sem gerar erros que interrompam a execução) */

-- limpeza inicial para garantir um ambiente de teste limpo
truncate table auditorialog;

-- teste 1: trg_after_insert_pedidos
insert into pedidos (idpedidos, datapedido, status, cliente_cpf_cli)
values (100, curdate(), 'pendente', '12345678901'); -- clara luz
select * from auditorialog where mensagem like 'novo pedido id: 100%';
select 'status: ok (deve mostrar o novo pedido no log)';

-- teste 2: trg_before_update_funcionario_salario
-- neste cenário, apenas uma atualização de salário válida será testada para evitar o erro.
-- carlos souza (cpf: 23456789012) tem cargo 'revisor' (cbo 1002), faixaSalario = 3500.00
-- seu salário atual é 4500.00, então uma atualização para 4800.00 deve ter sucesso.
select 'atualizando o salário do carlos souza para 4800.00 (esperado: sucesso)';
update funcionario
set salario = 4800.00
where cpf_func = '23456789012';
select * from auditorialog where mensagem like 'salário do funcionário cpf: 23456789012%';
select * from funcionario where cpf_func = '23456789012';
select 'status: ok (salário atualizado com sucesso e registrado no log)';

-- teste 3: trg_after_update_vendas_valor
-- atualizar o valor da venda (deve registrar no log)
update vendas
set valor = 50.00
where idvendas = 1;
select * from auditorialog where mensagem like 'valor da venda id: 1%';
select * from vendas where idvendas = 1;
select 'status: ok (valor da venda atualizado e registrado no log)';

-- não atualizar o valor (não deve registrar no log)
update vendas
set desconto = 5.00 -- alterando outra coluna, não o valor
where idvendas = 1;
select * from vendas where idvendas=1;
select 'status: ok (desconto da venda atualizado, sem novo registro no log de valor)';

-- teste 4: trg_before_delete_livros
-- cenário: excluir um livro sem exemplares (deve ter sucesso)
-- primeiro, vamos criar um livro e garantir que não tenha exemplares
insert into livros (isbn, titulo, data_publicacao, genero, npaginas, descricao, areaconhecimento_idareaconhecimento)
values ('9780000000001', 'livro para teste', '2023-01-01', 'teste', 100, 'um livro para testes de exclusão.', 1);
select * from livros where isbn = '9780000000001';
select 'excluindo livro para teste (esperado: sucesso)';
delete from livros where isbn = '9780000000001';
select * from auditorialog where mensagem like 'tentativa de exclusão do livro isbn: 9780000000001%';
select 'status: ok (exclusão de livro sem exemplares bem-sucedida e registrada no log)';

-- teste 5: trg_after_insert_livroautores
-- associar um autor a um livro (deve registrar no log)
insert into autor (cpf_autor, nome, biografia, nacionalidade, datanasc)
values ('000.000.000-02', 'autor teste', 'biografia do autor teste', 'brasileira', '1980-01-01');
insert into livros (ISBN, titulo, data_publicacao, genero, Npaginas, Descricao, AreaConhecimento_idAreaConhecimento, CapaURL, Lancamento, Preco, DescontoMaximo) values
('9780000000011', 'Dom Casmurro', '1899-01-01', 'Romance', 256, 'Clássico da literatura brasileira.', 1, 'https://exemplo.com/capas/domcasmurro.jpg', 'Sim', 39.90, 10.00);
insert into livroautores (livros_isbn, autor_cpf_autor)
values ('9780000000011', '000.000.000-02'); -- dom casmurro
select * from livroautores where Autor_CPF_Autor = '000.000.000-02';
select * from auditorialog where mensagem like 'autor "autor teste"%associado ao livro "dom casmurro"%';
select 'status: ok (associação autor-livro registrada no log)';

-- teste 6: trg_before_insert_exemplar
-- cenário 1: inserir exemplar com localização 'desconhecida' (deve ser padronizada)
insert into exemplar (numeroserie, estado, localizacao, livros_isbn)
values (999, 'novo', 'desconhecida', '9780000000011');
select numeroserie, localizacao from exemplar where numeroserie = 999;
select * from auditorialog where mensagem like 'localização do novo exemplar com numero de serie: 999%';
select 'status: ok (localização padronizada e registrada no log)';

-- cenário 2: inserir exemplar com localização válida (não deve ser padronizada)
insert into exemplar (numeroserie, estado, localizacao, livros_isbn)
values (998, 'novo', 'estante xpto', '9780000000011');
select numeroserie, localizacao from exemplar where numeroserie = 998;
select * from auditorialog where mensagem like 'novo exemplar com numero de serie: 998%inserido com localização: estante xpto%';
select 'status: ok (localização válida mantida e registrada no log)';