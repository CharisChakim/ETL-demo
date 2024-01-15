-- Data penjualan berdasarkan produk
SELECT
    product_id,
    product_name,
    product_category_name,
    SUM(qty) AS Total_qty_Sold,
    SUM(unit_sales) AS Total_Sales
FROM
    dbt_fact.fct_transactions
GROUP BY
    product_id, product_name, product_category_name
ORDER BY Total_Sales DESC
LIMIT 5;

-- Data penjualan berdasarkan provinsi
SELECT
    province_id,
    province_names,
    SUM(qty) AS Total_qty_Sold,
    SUM(unit_sales) AS Total_Sales
FROM
    dbt_fact.fct_transactions
GROUP BY
    province_id, province_names
ORDER BY Total_Sales DESC
LIMIT 5;

-- Data penjualan berdasarkan waktu (bulan)
SELECT
    DATE_TRUNC('month',order_date) AS Month,
    SUM(qty) AS Total_qty_Sold,
    SUM(unit_sales) AS Total_Sales
FROM
    dbt_fact.fct_transactions
GROUP BY
    Month
ORDER BY
    Month;

-- Analisis Pelanggan:
-- Total belanja per pelanggan.
-- Jumlah pesanan per pelanggan.
-- Produk paling sering dibeli oleh pelanggan.
SELECT
    customer_id,
    name,
    COUNT(order_id) AS Total_Orders,
    SUM(unit_sales) AS Total_Sales
FROM
    dbt_fact.fct_transactions
GROUP BY
    customer_id, name
ORDER BY Total_Sales DESC
LIMIT 5;

-- Analisis Kategori Produk:
-- Total penjualan per kategori produk.
-- Jumlah produk terjual per kategori.
SELECT
    product_category_id,
    product_category_name,
    SUM(unit_sales) AS Total_Sales,
    COUNT(DISTINCT product_id) AS Total_Products_Sold
FROM
    dbt_fact.fct_transactions
GROUP BY
    product_category_id, product_category_name;

-- Analisis Waktu:
-- Jumlah pesanan dan penjualan bulanan
SELECT
    DATE_TRUNC('month', order_date) AS Month,
    COUNT(order_id) AS Total_Orders,
    SUM(unit_sales) AS Total_Sales
FROM
    dbt_fact.fct_transactions
GROUP BY
    Month
ORDER BY
    Month DESC;

-- Analisis Kinerja Produk:
-- Produk terlaris berdasarkan jumlah terjual.
-- Produk dengan pendapatan tertinggi.
SELECT
    product_id,
    product_name,
    SUM(od.qty) AS Total_qty_Sold,
    SUM(od.unit_sales) AS Total_Sales
FROM
    fct_transactions
GROUP BY
    product_id, product_name
ORDER BY
    Total_qty_Sold DESC;
