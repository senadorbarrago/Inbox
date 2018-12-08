DO $$ 
DECLARE
  -- Parameters
  book_code bigint = 1;
  gl_trcode text = '0010000000';
  branch_code text = '';
  trdate date = '2018-11-16';
  
  -- Currency field
  currency record;
  
  -- Query Builders
  query text 					= '';
  main_select text      		= 'SELECT tbl1.*, tbl2.otherCurrenciesInUSD ';  
  main_from_statement text 	    = 'FROM '; 
  
  -- tbl1
  tbl1_select_query text 		= '(select tbl1.item as item, tbl1.trcode as trcode, ';
  tbl1_select_base text    		= 'from(select a.description as item, a.code || ''0000000'' as trcode, ';
  tbl1_from_statement text 		= 'FROM ref_daily_summary a ';
  tbl1_join_statement text 		= '
									LEFT JOIN txn_data b ON
										left(b.trcode,2) = left(a.code,2) AND
										b.is_deleted = false
									LEFT JOIN ref_currency c ON 
										c.alpha_code = b.curcde1 AND 
										c.is_deleted = false 
									LEFT JOIN ref_daily_summary_currency z ON 
										z.fk_currency = c.id AND
										z.is_deleted = false ';
  tbl1_where_statement text     = 'WHERE a.is_deleted = false AND a.code = '''||LEFT(gl_trcode,3)||''' AND b.bookcd = '||book_code||' AND b.trdate = '''||trdate||''' AND b.is_deleted = false ';  
  tbl1_closing_statement text   = 'GROUP BY a.description, a.code, b.curcde1)tbl1 group by tbl1.item, tbl1.trcode)tbl1 LEFT JOIN ';  
  
  -- tbl2
  tbl2_select_query text   		= '(select tbl1.trcode as trcode, to_char(tbl1.otherCurrencies, ''FM999999990.00'') as otherCurrenciesInUSD from( ';
  tbl2_select_base text 		= 'select a.description as item, a.code || ''0000000'' as trcode, SUM(b.amtorig1 * coalesce(rates.usd_rate, 0.00)) as otherCurrencies ';
  tbl2_from_statement text 		= 'FROM ref_daily_summary a ';
  tbl2_join_statement text 		= '
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
											  WHERE a.is_deleted = false AND trdate = '''||trdate||'''
											  GROUP BY a.curcde1
											 )baseRates ON 
										baseRates.curcde1 = b.curcde1
									LEFT JOIN txn_rates rates ON
										rates.id = baseRates.id ';
  tbl2_where_statement text     = 'WHERE a.is_deleted = false AND a.code = '''||LEFT(gl_trcode,3)||''' AND b.bookcd = '||book_code||' AND b.trdate = '''||trdate||''' AND b.is_deleted = false AND z.id IS NULL ';  
  tbl2_closing_statement text   = 'group by a.description, a.code)tbl1)tbl2 ON tbl1.trcode = tbl2.trcode ';  
  
BEGIN
	
	-- Daily Summary Currency Fields
	FOR currency IN 
		SELECT DISTINCT(b.alpha_code), a.id as alpha_code FROM ref_daily_summary_currency a
		JOIN ref_currency b ON
			b.id = a.fk_currency AND
			b.is_deleted = false
		JOIN ref_book c ON
			c.id = a.fk_book_code AND
			c.is_deleted = false AND
			c.id = book_code
		WHERE a.is_deleted = false	
		ORDER BY a.id
	LOOP
		-- Build Main Query
		tbl1_select_query := tbl1_select_query || 'SUM(tbl1.'|| currency.alpha_code || 'Amt) as "'|| currency.alpha_code ||'",';
		-- Build Sub Query
		tbl1_select_base := tbl1_select_base || 'case when TRIM(b.curcde1) = '''|| currency.alpha_code || ''' then sum(b.amtorig1) else 0.00 end  as '|| currency.alpha_code || 'Amt,';
	END LOOP;
	
	tbl1_select_query := SUBSTRING(tbl1_select_query, 0, LENGTH(tbl1_select_query))||' ';
	tbl1_select_base := SUBSTRING(tbl1_select_base, 0, LENGTH(tbl1_select_base))||' ';
	
	query := main_select || main_from_statement || tbl1_select_query || tbl1_select_base || tbl1_from_statement || tbl1_join_statement || tbl1_where_statement || tbl1_closing_statement 
			|| tbl2_select_query || tbl2_select_base || tbl2_from_statement || tbl2_join_statement || tbl2_where_statement || tbl2_closing_statement;
	
	RAISE INFO '#### query: %', query;
	
	/*
	SELECT 
		'NET PESO/FOREIGN ASSET POSITION - PREVIOUS DAY' :: text as item, tbl1.*, tbl2.otherCurrenciesInUSD
	FROM(
		select 
			'0010000000':: text as trcode,
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
			FROM txn_data b
			LEFT JOIN ref_currency c ON 
				c.alpha_code = b.curcde1 AND 
				c.is_deleted = false 
			LEFT JOIN ref_daily_summary_currency z ON 
				z.fk_currency = c.id AND
				z.is_deleted = false
			WHERE 
				left(b.trcode,2) = '00' AND 
				b.bookcd = 1 AND 
				b.trdate = '2018-11-16' AND
				b.is_deleted = false 
			group by
				b.curcde1
				)tbl1
		)tbl1 LEFT JOIN 
		(
		select 
			'0010000000':: text as trcode,
			to_char(SUM(tbl1.otherCurrencies * coalesce(tbl1.usdRate, 0.00)), 'FM999999999.00') as otherCurrenciesInUSD,
		from(
			select 
				sum(b.amtorig1) as otherCurrencies,
				rates.usd_rate as usdRate
			FROM txn_data b
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
				left(b.trcode,2) = '00' AND 
				b.bookcd = 1 AND 
				b.trdate = '2018-11-16' AND
				b.is_deleted = false AND
				z.id IS NULL
			group by
				b.curcde1,
				rates.usd_rate
				)tbl1
			group by tbl1.usdRate
		)tbl2 ON tbl1.trcode = tbl2.trcode

*/

END $$