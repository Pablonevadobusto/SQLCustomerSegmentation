
select COUNT(*)
FROM[dbo].['Online Retail']

--What is the distribution of order values across all customers in the dataset?


SELECT InvoiceNo,
	SUM(Quantity * UnitPrice) as Revenue
FROM [dbo].['Online Retail']
GROUP BY InvoiceNo
ORDER BY InvoiceNo
/*
-- Invoice is NULL and Quantity is Negative
SELECT Checker
		,COUNT(*)
FROM (
select * ,
		CASE WHEN Quantity <0 THEN 'Negative'
		ELSE 'Positive'
		END as QuantityChecker
FROM [dbo].['Online Retail']
where InvoiceNo is null) as a
GROUP BY Checker


select *
FROM [dbo].['Online Retail']
WHERE StockCode = '22593'
and CustomerID = '16546'

-- Invoice is NOT NULL and Qty is Negative
SELECT *
FROM [dbo].['Online Retail']
where InvoiceNo is not null
and Quantity <=0
order by InvoiceNo

select *
FROM [dbo].['Online Retail']
WHERE StockCode = '21349'
and InvoiceNo = '537454'
*/
--How many unique products has each customer purchased?

SELECT CustomerID
		,COUNT(distinct StockCode) as Products
FROM [dbo].['Online Retail']
WHERE CustomerID is not NULL
GROUP BY CustomerID
ORDER BY Products desc

--Which customers have only made a single purchase from the company? (I'll take "single purchase" as one-off purchase, regardless the quantity)
;WITH CTE as 
(
SELECT CustomerID
		,COUNT(InvoiceDate) as Times
FROM [dbo].['Online Retail']
GROUP BY CustomerID
)
,Once as(
SELECT * 
FROM CTE
WHERE Times = 1)

SELECT *
FROM [dbo].['Online Retail']
WHERE CustomerID in (SELECT CustomerID
					FROM Once)
order by InvoiceNo

--Which products are most commonly purchased together by customers in the dataset?

SELECT a.StockCode,
		b.StockCode,
		COUNT(*) as Times_Bought_Together
FROM [dbo].['Online Retail'] as a
	INNER JOIN [dbo].['Online Retail'] as b
		ON a.InvoiceNo = b.InvoiceNo
		and a.StockCode <> b.StockCode
GROUP BY a.StockCode,
		b.StockCode
ORDER BY Times_Bought_Together desc
 
		
