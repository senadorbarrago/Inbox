



SELECT 
	tbl1.*, tbl2.otherCurrenciesInUSD
FROM(
select 
	tbl1.item as item,
	tbl1.trcode as trcode,
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
	SUM(tbl1.CNYAmt) as "CNY"	
from(
	select 
		a.description as item,
		a.code || '0000000' as trcode,
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
		case when TRIM(b.curcde1) = 'CNY' then sum(b.amtorig1) else 0.00 end as CNYAmt
	FROM ref_daily_summary a
	LEFT JOIN txn_data b ON
		left(b.trcode,2) = left(a.code,2) AND
		b.is_deleted = false
	LEFT JOIN ref_currency c ON 
		c.alpha_code = b.curcde1 AND 
		c.is_deleted = false 
	LEFT JOIN ref_daily_summary_currency z ON 
		z.fk_currency = c.id AND
		z.is_deleted = false
	WHERE 
		a.is_deleted = false AND
		a.code = '001' AND 
		b.bookcd = 1 AND 
		b.trdate = '2018-11-16' AND
		b.is_deleted = false
	group by
		a.description,
		a.code,
		b.curcde1
		)tbl1
	group by tbl1.item, tbl1.trcode
)tbl1 LEFT JOIN 
(
select 
	tbl1.trcode as trcode,
	to_char(tbl1.otherCurrencies, 'FM999999990.00') as otherCurrenciesInUSD
from(
	select 
		a.description as item,
		a.code || '0000000' as trcode,
		SUM(b.amtorig1 * coalesce(rates.usd_rate, 0.00)) as otherCurrencies
	FROM ref_daily_summary a
	LEFT JOIN txn_data b ON
		left(b.trcode,2) = left(a.code,2) AND
		b.is_deleted = false
	LEFT JOIN ref_currency c ON 
		c.alpha_code = b.curcde1 AND 
		c.is_deleted = false 
	LEFT JOIN ref_daily_summary_currency z ON 
		z.fk_currency = c.id AND
		z.is_deleted = false
	LEFT JOIN(SELECT MAX(a.id)as id, a.curcde1 as curcde1 
			  FROM txn_rates a
			  WHERE a.is_deleted = false AND trdate = '2018-11-16'
			  GROUP BY a.curcde1
			 )baseRates ON 
		baseRates.curcde1 = b.curcde1
	LEFT JOIN txn_rates rates ON
		rates.id = baseRates.id
	WHERE 
		a.is_deleted = false AND
		a.code = '001' AND 
		b.bookcd = 1 AND 
		b.trdate = '2018-11-16' AND
		b.is_deleted = false AND
		z.id IS NULL
	group by
		a.description,
		a.code
		)tbl1
)tbl2 ON tbl1.trcode = tbl2.trcode

			
UNION ALL 
SELECT  'ADD: RECEIPTS' :: text, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null

UNION ALL			
			
SELECT 
	tbl1.*,
	tbl2.otherCurrenciesInUSD
FROM
(
	select 
	tbl1.item, 
	tbl1.TransCode as trcode,
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
	SUM(tbl1.CNYAmt) as "CNY"	
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
		case when TRIM(b.curcde1) = 'CNY' then sum(b.amtorig1) else 0.00 end as CNYAmt
	from ref_daily_summary a 
	LEFT JOIN txn_data b ON 
		left(b.trcode,3) = a.code AND 
		b.trdate = '2018-11-16' AND 
		b.bookcd = 1 AND
		b.is_deleted = false
	LEFT JOIN ref_currency c ON 
		c.alpha_code = b.curcde1 AND 
		c.is_deleted = false 
	LEFT JOIN ref_daily_summary_currency z ON 
		z.fk_currency = c.id AND
		z.is_deleted = false
	WHERE a.is_deleted = false AND a.fk_transaction_classification = 1 
	group by 
		a.description, 
		a.code || '0000000', 
		b.curcde1, z.fk_currency
		)tbl1 
group by 
	tbl1.item, 
	tbl1.TransCode
ORDER BY RIGHT(LEFT(tbl1.TransCode,3),1), tbl1.TransCode

)tbl1 JOIN 
(
select 
	tbl1.item, 
	tbl1.TransCode as trcode,
	to_char(SUM(tbl1.otherCurrencies), 'FM999999990.00') as otherCurrenciesInUSD
from(
	select 
		DISTINCT(a.description) as item, 
		a.code || '0000000' as TransCode,
		sum(coalesce(b.amtorig1, 0.00) * coalesce(rates.usd_rate, 0.00)) as otherCurrencies
	from ref_daily_summary a 
	LEFT JOIN txn_data b ON 
		left(b.trcode,3) = a.code AND 
		b.bookcd = 1 AND 
		b.trdate = '2018-11-16' AND
		b.is_deleted = false
	LEFT JOIN ref_currency c ON 
		c.alpha_code = b.curcde1 AND 
		c.is_deleted = false 
	LEFT JOIN ref_daily_summary_currency z ON 
		z.fk_currency = c.id AND 
		z.is_deleted = false
	LEFT JOIN(SELECT MAX(a.id)as id, a.curcde1 as curcde1 
			  FROM txn_rates a
			  WHERE a.is_deleted = false AND trdate = '2018-11-16'
			  GROUP BY a.curcde1
			 )baseRates ON 
		baseRates.curcde1 = b.curcde1
	LEFT JOIN txn_rates rates ON
		rates.id = baseRates.id
	WHERE a.is_deleted = false AND z.id IS NULL AND a.fk_transaction_classification = 1
	group by 
		a.description, 
		a.code || '0000000', 
		b.curcde1, z.fk_currency,
		rates.usd_rate
		)tbl1 
group by 
	tbl1.item, 
	tbl1.TransCode
ORDER BY RIGHT(LEFT(tbl1.TransCode,3),1), tbl1.TransCode
)tbl2 ON tbl2.trcode = tbl1.trcode
	

	
	
	
	
	
	
