/* scripts para testar as functions */

-- teste da função 1: calcular_idade_funcionario
select f.nomefunc, f.datanasc, calcular_idade_funcionario(f.cpf_func) as idade_calculada
from funcionario f
where f.cpf_func in ('12345678901', '23456789012', '90123456789');

-- teste da função 2: obter_valor_total_pedidos_cliente
select c.nome, obter_valor_total_pedidos_cliente(c.cpf_cli) as valor_total_pedidos
from cliente c
where c.cpf_cli in ('12345678901', '78901234567');

-- teste da função 3: contar_livros_por_autor
select a.nome, contar_livros_por_autor(a.cpf_autor) as total_livros_publicados
from autor a
where a.cpf_autor in ('111.222.333-44', '222.333.444-55', '999.000.111-22');

-- teste da função 4: verificar_disponibilidade_exemplar
-- exemplar 11 está em pedido concluído (1)
select e.numeroserie, e.estado, verificar_disponibilidade_exemplar(e.numeroserie) as status_disponibilidade
from exemplar e
where e.numeroserie = 11;
-- exemplar 12 está em pedido pendente (2)
select e.numeroserie, e.estado, verificar_disponibilidade_exemplar(e.numeroserie) as status_disponibilidade
from exemplar e
where e.numeroserie = 12;
-- exemplar que não está em nenhum pedido (ex: 1)
select e.numeroserie, e.estado, verificar_disponibilidade_exemplar(e.numeroserie) as status_disponibilidade
from exemplar e
where e.numeroserie = 1;
-- exemplar inexistente
select 'exemplar inexistente:', verificar_disponibilidade_exemplar(9999) as status_disponibilidade;

-- teste da função 5: obter_nome_gerente_departamento
select d.nome, obter_nome_gerente_departamento(d.iddepartamento) as nome_gerente
from departamento d
where d.iddepartamento in (1, 2, 5, 8); -- editorial, produção, ti, atendimento

-- teste da função 6: calcular_preco_com_desconto
select l.titulo, l.preco, l.descontomaximo, calcular_preco_com_desconto(l.isbn) as preco_com_desconto
from livros l
where l.isbn = '9780000000011'; -- dom casmurro (ajustar se o ISBN não tiver preço e desconto)

-- teste com livro inexistente ou sem dados de preço/desconto
select 'livro inexistente:', calcular_preco_com_desconto('9999999999999') as preco_com_desconto;