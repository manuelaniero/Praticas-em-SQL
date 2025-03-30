-- listar todos os funcionarios da loja onde trabalha o funcionario  com maior salario da emoresa, trazer o nome da loja, departamento cargo nome do funcionario e salario bruto 
SELECT 
    F.nm_funcionario,
    L.nm_loja,
    C.ds_cargo,
    F.vl_salario_bruto,
    D.nm_depto
FROM
    db_funcionario F
JOIN
    db_cargo C ON F.cd_cargo = C.cd_cargo 
JOIN
    db_depto D ON C.cd_depto = D.cd_depto 
JOIN
    db_loja L ON D.nr_loja = L.nr_loja 
WHERE 
    L.nr_loja = (
    SELECT L.nr_loja
    FROM db_funcionario
    WHERE vl_salario_bruto = 
    (SELECT MAX(vl_salario_bruto) FROM db_funcionario
)); 


-- demostre as vendas por categoria de produto das 3 lojas que mais venderam 2019 
SELECT 
    C.DS_CATEGORIA_PROD AS CATEGORIA,
    PED.NR_LOJA AS LOJA,
    SUM(IP.QT_PEDIDO * IP.VL_UNITARIO) AS TOTAL_VENDIDO
FROM DB_ITEM_PEDIDO IP
JOIN DB_PRODUTO_LOJA PL ON IP.CD_PRODUTO_LOJA = PL.CD_PRODUTO_LOJA
JOIN DB_PRODUTO P ON PL.CD_PRODUTO = P.CD_PRODUTO
JOIN DB_SUB_CATEGORIA_PROD SC ON P.CD_SUB_CATEGORIA_PROD = SC.CD_SUB_CATEGORIA_PROD
JOIN DB_CATEGORIA_PROD C ON SC.CD_CATEGORIA_PROD = C.CD_CATEGORIA_PROD
JOIN DB_PEDIDO PED ON IP.NR_LOJA = PED.NR_LOJA AND IP.NR_PEDIDO = PED.NR_PEDIDO
WHERE PED.NR_LOJA IN (
    SELECT NR_LOJA 
    FROM DB_PEDIDO 
    WHERE EXTRACT(YEAR FROM DT_PEDIDO) = 2019
    GROUP BY NR_LOJA
    HAVING SUM(VL_TOT_PEDIDO) >= (
        SELECT MIN(TOTAL_VENDIDO) 
        FROM (
            SELECT SUM(VL_TOT_PEDIDO) AS TOTAL_VENDIDO
            FROM DB_PEDIDO
            WHERE EXTRACT(YEAR FROM DT_PEDIDO) = 2019
            GROUP BY NR_LOJA
            ORDER BY TOTAL_VENDIDO DESC
            FETCH FIRST 3 ROWS ONLY)))
AND EXTRACT(YEAR FROM PED.DT_PEDIDO) = 2019
GROUP BY C.DS_CATEGORIA_PROD, PED.NR_LOJA
ORDER BY PED.NR_LOJA, TOTAL_VENDIDO DESC;

-- atualizar colluna ds_genero

UPDATE db_funcionario 
    SET ds_genero = 'Feminino'
WHERE fl_sexo_biologico = 'F';

UPDATE db_funcionario 
    SET ds_genero = 'Masculino'
WHERE fl_sexo_biologico = 'M';

SELECT * FROM db_funcionario;

-- Atualizar coluna ds_genero em db_cli_fisica

SELECT * FROM db_cli_fisica;

UPDATE db_cli_fisica
SET ds_genero = 
    CASE 
        WHEN fl_sexo_biologico = 'F' THEN 'Feminino'
        WHEN fl_sexo_biologico = 'M'  THEN 'Masculino'
    END;
