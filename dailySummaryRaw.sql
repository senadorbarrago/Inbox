select 
	tbl1.item, 
	tbl1.TransCode,
	SUM(tbl1.USDAmt) as "USD",
	SUM(tbl1.JPYAmt) as "JPY",
	SUM(tbl1.GBPAmt) as "GBP",
	SUM(tbl1.HKDAmt) as "HKD",
	SUM(tbl1.CHFAmt) as "CHF",
	SUM(tbl1.CADAmt) as "CAD",
	SUM(tbl1.SGDAmt) as "SGD",
	SUM(tbl1.AUDAmt) as "AUD",
	SUM(tbl1.BHDAmt) as "BHD",
	SUM(tbl1.KWDAmt) as "KWD",
	SUM(tbl1.SARAmt) as "SAR",
	SUM(tbl1.BNDAmt) as "BND",
	SUM(tbl1.IDRAmt) as "IDR",
	SUM(tbl1.THBAmt) as "THB",
	SUM(tbl1.AEDAmt) as "AED",
	SUM(tbl1.EURAmt) as "EUR",
	SUM(tbl1.KRWAmt) as "KRW",
	SUM(tbl1.CNYAmt) as "CNY", 
	SUM(OtherForeignCurrencies) as "OtherForeignCurrencies"
	--tbl1.usdRate as usdRate 
from(
	select 
		DISTINCT(a.description) as item, 
		a.code || '0000000' as TransCode,
		case when TRIM(b.curcde1) = 'USD' then sum(b.amtorig1) else 0.00 end as USDAmt,
		case when TRIM(b.curcde1) = 'JPY' then sum(b.amtorig1) else 0.00 end as JPYAmt,
		case when TRIM(b.curcde1) = 'GBP' then sum(b.amtorig1) else 0.00 end as GBPAmt,
		case when TRIM(b.curcde1) = 'HKD' then sum(b.amtorig1) else 0.00 end as HKDAmt,
		case when TRIM(b.curcde1) = 'CHF' then sum(b.amtorig1) else 0.00 end as CHFAmt,
		case when TRIM(b.curcde1) = 'CAD' then sum(b.amtorig1) else 0.00 end as CADAmt,
		case when TRIM(b.curcde1) = 'SGD' then sum(b.amtorig1) else 0.00 end as SGDAmt,
		case when TRIM(b.curcde1) = 'AUD' then sum(b.amtorig1) else 0.00 end as AUDAmt,
		case when TRIM(b.curcde1) = 'BHD' then sum(b.amtorig1) else 0.00 end as BHDAmt,
		case when TRIM(b.curcde1) = 'KWD' then sum(b.amtorig1) else 0.00 end as KWDAmt,
		case when TRIM(b.curcde1) = 'SAR' then sum(b.amtorig1) else 0.00 end as SARAmt,
		case when TRIM(b.curcde1) = 'BND' then sum(b.amtorig1) else 0.00 end as BNDAmt,
		case when TRIM(b.curcde1) = 'IDR' then sum(b.amtorig1) else 0.00 end as IDRAmt,
		case when TRIM(b.curcde1) = 'THB' then sum(b.amtorig1) else 0.00 end as THBAmt,
		case when TRIM(b.curcde1) = 'AED' then sum(b.amtorig1) else 0.00 end as AEDAmt,
		case when TRIM(b.curcde1) = 'EUR' then sum(b.amtorig1) else 0.00 end as EURAmt,
		case when TRIM(b.curcde1) = 'KRW' then sum(b.amtorig1) else 0.00 end as KRWAmt,
		case when TRIM(b.curcde1) = 'CNY' then sum(b.amtorig1) else 0.00 end as CNYAmt, 
		case when z.fk_currency IS null then sum(b.amtorig1) else 0.00 end as OtherForeignCurrencies
		--rates.usd_rate as usdRate 
	from ref_daily_summary a 
	LEFT JOIN txn_data b ON 
		left(b.trcode,3) = a.code AND 
		b.is_deleted = false AND 
		b.bookcd = 1 
	LEFT JOIN ref_currency c ON 
		c.alpha_code = b.curcde1 AND 
		c.is_deleted = false 
	LEFT JOIN ref_daily_summary_currency z ON 
		z.fk_currency = c.id
	
	LEFT JOIN(SELECT MAX(a.id)as id, a.curcde1 as curcde1 
			  FROM txn_rates a
			  WHERE a.is_deleted = false AND  trdate = '2018-11-16'
			  GROUP BY a.curcde1
			 )baseRates ON 
		baseRates.curcde1 = b.curcde1	
		
	WHERE a.is_deleted = false  
	group by 
		a.description, 
		a.code || '0000000', 
		b.curcde1, z.fk_currency
		--rates.usd_rate
		)tbl1 
group by 
	tbl1.item, 
	tbl1.TransCode--, 
	--tbl1.usdRate 
ORDER BY RIGHT(LEFT(tbl1.TransCode,3),1), tbl1.TransCode

-- select ISNULL(NULL)

-- select * From txn_data where trdate = '2018-11-16'
-- select * From txn_rates where trdate = '2018-11-16' order by curcde1

-- SELECT MAX(a.id)as id,  a.curcde1 as curcde1 
-- 			  FROM txn_rates a
-- 			  JOIN ref_currency c ON 
-- 					c.alpha_code = a.curcde1 AND 
-- 					c.is_deleted = false 
-- 			  JOIN ref_daily_summary_currency x ON
-- 					x.fk_currency = c.id AND
-- 					x.fk_book_code = 1 AND
-- 					x.is_deleted = false
-- 			  WHERE a.is_deleted = false and a.trdate = '2018-11-16'
-- 			  GROUP BY a.curcde1
-- 			  ORDER BY a.curcde1

