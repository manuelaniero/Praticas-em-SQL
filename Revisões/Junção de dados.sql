SELECT nm_funcionario, dt_nascimento, ds_cargo
FROM db_funcionario 
LEFT JOIN db_cargo
ON db_funcionario.cd_cargo = db_cargo.cd_cargo; 

SELECT 
    C.nm_cliente, 
    E.ds_complemento_end,
    L.nm_logradouro,
    B.nm_bairro
FROM 
    db_cliente C
LEFT JOIN 
    db_end_cli E ON C.nr_cliente = E.nr_cliente
LEFT JOIN 
    db_logradouro L ON E.cd_logradouro_cli = L.cd_logradouro
LEFT JOIN 
    db_bairro B ON L.cd_bairro = B.cd_bairro
ORDER BY 
    C.nr_cliente;

-- todos os pedidos realizados em 2019 listando numero do pedido, nome do motoboy, descrição do cargo e o nome do cliente

SELECT 
    P.nr_pedido, 
    F.nm_funcionario, 
    C.ds_cargo,
    I.nm_cliente
FROM
    db_pedido P 
JOIN
    db_funcionario F ON P.cd_func_motoboy = F.cd_funcionario
JOIN
    db_cargo C ON F.cd_cargo = C.cd_cargo
JOIN
    db_cliente I ON P.nr_pedido = I.nr_cliente 
WHERE 
    EXTRACT(YEAR FROM P.dt_pedido) = 2019
ORDER BY 
    P.nr_pedido;

-- todos os pedidos realizados pela atendente Juliana Moribe, listando numero do pedido, data do pedido e a data prevista da entrega, ordenando pela data do pedido
SELECT 
 P.nr_pedido, P.dt_pedido, P.dt_prev_entrega, F.nm_funcionario
 FROM 
 db_pedido P
 JOIN
 db_funcionario F  ON F.cd_funcionario = P.cd_func_atd 
 WHERE 
 nm_funcionario = 'Juliana Moribe'
 ORDER BY
 dt_pedido DESC


-- listar todas as lojas do estado da bahia, com numero da loja, nome da loja, nome da cidade e sigla UF 
SELECT 
    L.nm_loja,
    L.nr_loja,
    C.nm_cidade,
    E.sg_estado
FROM 
    db_loja L 
JOIN 
    db_end_loja EL ON L.nr_loja = EL.nr_loja
JOIN 
    db_logradouro LO ON EL.cd_logradouro = LO.cd_logradouro
JOIN
    db_bairro BA ON LO.cd_bairro = BA.cd_bairro
JOIN
    db_cidade C ON BA.cd_cidade = C.cd_cidade
JOIN 
    db_estado E ON C.sg_estado = E.sg_estado
WHERE 
    E.nm_estado = 'Bahia'
ORDER BY 
    L.nr_loja;

-- Listar todos os funcionarios como cargo de 'chapeiro', com loja em que trabalha, departamento, codigo do funcionario, nome do funcionario, salario bruto ORDENANDO FUNCIONARIO POR ORDEM ALFABETICA E POR LOJA
SELECT 
    F.nm_funcionario,
    F.vl_salario_bruto,
    F.cd_funcionario,
    D.nm_depto,
    L.nm_loja,
    C.cd_cargo,
    C.ds_cargo
FROM 
db_funcionario F
JOIN 
    db_cargo C ON F.cd_cargo = C.cd_cargo 
JOIN 
    db_depto D ON C.cd_depto = D.cd_depto
JOIN 
    db_loja L ON D.nr_loja = L.nr_loja
WHERE 
    ds_cargo = 'Chapeiro'
ORDER BY 
    F.nm_funcionario ASC, L.nm_loja ASC;

-- Relacionar tabelas de clientes e endereços para listar todos os clientes com seus respectivos endereços.
--Listar todos os funcionários e, caso exista, o nome de seu superior direto (caso haja um).
-- Listar todos os departamentos e os respectivos funcionários. Mostrar também departamentos sem funcionários.
-- Listar todos os pedidos com o nome do cliente, nome do produto e quantidade pedida.
--  Listar os funcionários e seus departamentos, mas apenas para os funcionários que têm um salário superior a R$ 2000.
-- Relacionar tabelas de clientes e endereços para listar todos os clientes com seus respectivos endereços.
SELECT 
    C.nm_cliente,
    E.ds_complemento_end,
    L.nm_logradouro,
    L.nr_cep
FROM 
    db_cliente C
JOIN 
    db_end_cli E ON C.nr_cliente = E.nr_cliente
JOIN
    db_logradouro L ON E.cd_logradouro_cli = l.cd_logradouro
    
--Listar todos os funcionários e, caso exista, o nome de seu superior direto (caso haja um).
SELECT 
    F.nm_funcionario, G.nm_funcionario AS superior 
FROM 
    db_funcionario 
LEFT JOIN 
    db_funcionario G ON F.cd_gerente = G.cd_funcionario;
    
-- Listar todos os departamentos e os respectivos funcionários. Mostrar também departamentos sem funcionários.
SELECT 
    D_.nm_depto,
    F.nm_funcionario
FROM 
    db_depto D
RIGHT JOIN
    db_funcionario F ON D.cd_depto = F.cd_depto;

-- Listar todos os pedidos com o nome do cliente, nome do produto e quantidade pedida.
SELECT 
    P.nr_pedido,   
    C.nm_cliente,    
    I.qt_pedido,    
    PR.ds_produto
FROM 
    db_pedido P
JOIN 
    db_cliente C ON P.nr_cliente = C.nr_cliente
JOIN 
    db_item_pedido I ON P.nr_pedido = I.nr_pedido
JOIN 
    db_produto PR ON I.cd_produto_loja = PR.cd_produto;
    
-- Listar os funcionários e seus departamentos, mas apenas para os funcionários que têm um salário superior a R$ 2000.
SELECT 
    F.nm_funcionario,
    D.nm_depto,
    F.vl_salario_bruto
 FROM 
    db_funcionario F
JOIN 
    db_cargo C ON F.cd_cargo = C.cd_cargo 
JOIN 
    db_depto D ON C.cd_depto = D.cd_depto
WHERE
vl_salario_bruto > 2000
    
