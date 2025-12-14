-- Query 1. Faturamento total por ano
SELECT SUBSTR(order_date, -4, 4) AS ano,
	ROUND(SUM(sales), 2) AS somaVendas
FROM superstore
GROUP BY ano
ORDER BY ano
;

-- Query 2. Top 10 pordutos mais vendidos (em quantidade)
SELECT product_name,
	SUM(quantity) AS quantidade
FROM superstore
GROUP BY product_name
ORDER BY quantidade DESC
LIMIT 10;
;

-- Query 3. Ticket médio por região
SELECT region,
	ROUND(AVG(sales), 2) AS mediaVendas
FROM superstore
GROUP BY region
;

-- Query 4. Lucro por categoria
SELECT category, ROUND(SUM(profit), 2) AS lucro
FROM superstore
GROUP BY category
;

-- Query 5. Produtos com desconto médio acima de 0.1
SELECT product_name, AVG(discount) AS desconto
FROM superstore
GROUP BY product_name
HAVING desconto > 0.1
;

-- Query 6. Top 1 produto mais lucrativo por category
WITH lucro AS
(SELECT category,
	product_name,
    ROUND(SUM(profit), 2) AS lucroTotal,
    ROW_NUMBER() OVER(
		PARTITION BY category
        ORDER BY SUM(profit) DESC
    ) rn
FROM superstore
GROUP BY category, product_name
)
SELECT *
FROM lucro
WHERE rn = '1'
;

-- Query 7. Total de pedidos por região
SELECT region, COUNT(order_id) AS contagem
FROM superstore
GROUP BY region
ORDER BY contagem DESC
;

-- Query 8. Vendas totais por categoria
SELECT category, ROUND(SUM(sales), 2) AS somaVendas
FROM superstore
GROUP BY category
ORDER BY somaVendas DESC
;

-- Query 9. Lucro total por sub-categoria (top 10)
SELECT sub_category, ROUND(SUM(profit), 2) AS soma_lucro
FROM superstore
GROUP BY sub_category
ORDER BY soma_lucro DESC
LIMIT 10
;

-- Query 10. Número de clientes único por estado (top 10)
SELECT state, COUNT(DISTINCT customer_id) AS contagemID
FROM superstore
GROUP BY state
ORDER BY contagemID DESC
LIMIT 10
;

-- Query 11. Desconto médio por modo de envio
SELECT ship_mode, ROUND(AVG(discount), 3) AS desconto_medio
FROM superstore
GROUP BY ship_mode
ORDER BY desconto_medio DESC
;

-- Query 12. Quantidade média vendida por produto (top 10)
SELECT product_name, ROUND(AVG(quantity), 2) AS media_vendas
FROM superstore
GROUP BY product_name
ORDER BY media_vendas DESC
LIMIT 10
;

-- Query 13. Vendas por segmento de cliente
SELECT segment, ROUND(SUM(sales), 2) AS soma_vendas
FROM superstore
GROUP BY segment
ORDER BY soma_vendas DESC
;

-- Query 14. Estados com prejuízo (lucro < 0)
SELECT state, ROUND(SUM(profit), 2) AS lucroTotal
FROM superstore
GROUP BY state
HAVING lucroTotal < 0
ORDER BY lucroTotal ASC
;

-- Query 15. Categorias com prejuízo (lucro < 0)
SELECT category, ROUND(SUM(profit), 2) AS lucroTotal
FROM superstore
GROUP BY category
HAVING lucroTotal < 0
ORDER BY lucroTotal ASC
;
