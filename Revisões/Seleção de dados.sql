SELECT nm_funcionario, dt_cadastramento
FROM db_funcionario;


SELECT nm_funcionario, 
       vl_salario_bruto * 1.05 AS salario_aumento_cinco,
       vl_salario_bruto * 1.08 AS salario_aumento_oito
FROM db_funcionario;

SELECT nm_cliente, qt_estrelas
FROM db_cliente;

SELECT ds_produto, vl_unitario
FROM db_produto;

SELECT nm_cliente, qt_estrelas
FROM db_cliente 
WHERE qt_estrelas >= 4;

SELECT nm_cliente, vl_medio_compra, qt_estrelas
FROM db_cliente 
WHERE qt_estrelas >= 3 AND vl_medio_compra > 70;

SELECT nm_cliente, qt_estrelas
FROM db_cliente 
WHERE vl_medio_compra > 80;

SELECT *
FROM db_produto 
WHERE vl_unitario> 15;
