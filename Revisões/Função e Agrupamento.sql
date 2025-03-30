-- quantidade de funcionarios ativos por nome da loja e nome de departamento 
SELECT 
    COUNT(F.nm_funcionario)AS quantidade_funcionario,
    L.nm_loja,
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
    st_func = 'A'
GROUP BY 
    L.nm_loja, D.nm_depto;


-- quantidade total de pedidos vendidos, total das vendas e o ticket médio por ano e por mes, ordenando do mes mais antigo - recente 
SELECT 
    EXTRACT(YEAR FROM P.dt_pedido) AS ano,
    EXTRACT(MONTH FROM P.dt_pedido) AS mes,
    COUNT(DISTINCT P.nr_pedido) AS quantidade_pedidos,
    SUM(P.vl_tot_pedido) AS total_vendas,
    AVG(P.vl_tot_pedido) AS ticket_medio
FROM 
    db_pedido P
JOIN 
    db_item_pedido I ON P.nr_pedido = I.nr_pedido
GROUP BY 
    EXTRACT(YEAR FROM P.dt_pedido),
    EXTRACT(MONTH FROM P.dt_pedido)
ORDER BY 
    ano ASC, 
    mes ASC;

-- Clientes que no ano de 2019, fizeram mais que cinco compras, mostrar nome do cliente, email, tipo de pessoa (PF OU PJ) e cidade de residencia (cidade-UF)

SELECT 
    C.NM_CLIENTE AS nome_cliente,
    C.DS_EMAIL AS email,
    CASE 
        WHEN PF.NR_CLIENTE IS NOT NULL THEN 'PF'
        WHEN PJ.NR_CLIENTE IS NOT NULL THEN 'PJ'
        ELSE 'Desconhecido'
    END AS tipo_pessoa,
    CI.NM_CIDADE || '-' || ES.SG_ESTADO AS cidade_residencia
FROM 
    DB_CLIENTE C
LEFT JOIN 
    DB_CLI_FISICA PF ON C.NR_CLIENTE = PF.NR_CLIENTE
LEFT JOIN 
    DB_CLI_JURIDICA PJ ON C.NR_CLIENTE = PJ.NR_CLIENTE
JOIN 
    DB_END_CLI EC ON C.NR_CLIENTE = EC.NR_CLIENTE
JOIN 
    DB_LOGRADOURO L ON EC.CD_LOGRADOURO_CLI = L.CD_LOGRADOURO
JOIN 
    DB_BAIRRO B ON L.CD_BAIRRO = B.CD_BAIRRO
JOIN 
    DB_CIDADE CI ON B.CD_CIDADE = CI.CD_CIDADE
JOIN 
    DB_ESTADO ES ON CI.SG_ESTADO = ES.SG_ESTADO
JOIN 
    DB_PEDIDO P ON C.NR_CLIENTE = P.NR_CLIENTE
WHERE 
    EXTRACT(YEAR FROM P.DT_PEDIDO) = 2019
GROUP BY 
    C.NR_CLIENTE, C.NM_CLIENTE, C.DS_EMAIL, PF.NR_CLIENTE, PJ.NR_CLIENTE, CI.NM_CIDADE, ES.SG_ESTADO
HAVING 
    COUNT(P.NR_PEDIDO) > 5
ORDER BY 
    nome_cliente;

    

    
    