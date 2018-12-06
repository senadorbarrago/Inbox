DO $$ 
DECLARE
  book_code bigint = 1;
  data_field record;
  
  -- Query Builders
  query text 					= '';
  main_select_query text 		= '';
  main_select_base text 	    = 'select tbl1.item, tbl1.TransCode,';
  main_from_statement text 	    = 'from('; 
  main_closing_statement text   = '
									group by 
										tbl1.item, 
										tbl1.TransCode, 
										tbl1.usdRate
									ORDER BY RIGHT(LEFT(tbl1.TransCode,3),1), tbl1.TransCode';
  tbl1_select_query text 		= '';
  tbl1_select_base text    		= '	select DISTINCT(a.description) as item, a.code || ''0000000'' as TransCode,';
  tbl1_from_statement text 		= ' from ref_daily_summary a ';
  tbl1_join_statement text 		= '
									LEFT JOIN txn_data b ON
										left(b.trcode,3) = a.code AND
										b.is_deleted = false AND
										b.bookcd ='||book_code||'
									LEFT JOIN ref_currency c ON
										c.alpha_code = b.curcde1 AND
										c.is_deleted = false
									LEFT JOIN (SELECT MAX(id)as id, trdate as trdate, curcde1 as curcde1 FROM txn_rates 
											WHERE is_deleted = false GROUP BY trdate, curcde1
										  )baseRates ON baseRates.trdate = b.trdate AND baseRates.curcde1 = b.curcde1
									LEFT JOIN txn_rates rates ON
										rates.id = baseRates.id ';
  tbl1_where_statement text     = 'WHERE a.is_deleted = false ';  
  tbl1_closing_statement text   = 'group by a.description, a.code || ''0000000'', b.curcde1, rates.usd_rate)tbl1';  
  
BEGIN
	
	-- Daily Summary Currency Fields
	FOR data_field IN 
		SELECT b.alpha_code as alpha_code FROM ref_daily_summary_currency a
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
		main_select_query := main_select_query || 'SUM(tbl1.'|| data_field.alpha_code || 'Amt) as "'|| data_field.alpha_code ||'",';
		-- Build Sub Query
		tbl1_select_query := tbl1_select_query || 'case when TRIM(b.curcde1) = '''|| data_field.alpha_code || ''' then sum(b.amtorig1) else 0.00 end  as '|| data_field.alpha_code || 'Amt,';
	END LOOP;
	
	main_select_query := main_select_query || ' tbl1.usdRate as usdRate ';
	tbl1_select_query := tbl1_select_query || ' rates.usd_rate as usdRate ';
	
	query := main_select_base || main_select_query ||  main_from_statement || tbl1_select_base || tbl1_select_query || tbl1_from_statement || tbl1_join_statement || tbl1_where_statement || tbl1_closing_statement || main_closing_statement;
	
	RAISE INFO '#### query: %', query;
	
	/*
	select 
		tbl1.item,
		tbl1.TransCode, 
		SUM(tbl1.AUDAmt) as AUDAmt,
		SUM(tbl1.ALLAmt) as AUDAmt,
		SUM(tbl1.USDAmt) as USDAmt,
		SUM(tbl1.PABAmt) as PABAmt, 
		usdRate as usdRate 
	from(
	select 
		DISTINCT(a.description) as item,
		a.code || '0000000' as TransCode,  
		case when TRIM(b.curcde1) = 'AUD' then sum(b.amtorig1) else 0.00 end  as AUDAmt,
		case when TRIM(b.curcde1) = 'ALL' then sum(b.amtorig1) else 0.00 end  as ALLAmt,
		case when TRIM(b.curcde1) = 'USD' then sum(b.amtorig1) else 0.00 end  as USDAmt,
		case when TRIM(b.curcde1) = 'PAB' then sum(b.amtorig1) else 0.00 end  as PABAmt, 
		rates.usd_rate as usdRate
	from ref_daily_summary a
	LEFT JOIN txn_data b ON
		left(b.trcode,3) = a.code AND
		b.is_deleted = false
	LEFT JOIN ref_currency c ON
		c.alpha_code = b.curcde1 AND
		c.is_deleted = false
	LEFT JOIN (SELECT MAX(id)as id, trdate as trdate, curcde1 as curcde1 FROM txn_rates 
			   	WHERE is_deleted = false GROUP BY curcde1, trdate, usd_rate
			  )baseRates ON baseRates.trdate = b.trdate AND baseRates.curcde1 = b.curcde1
	JOIN txn_rates rates ON
			rates.id = baseRates.id
	WHERE a.is_deleted = false
	group by a.description, a.code || '0000000', b.curcde1, rates.usdRate
	)tbl1 
	group by 
		tbl1.item, 
		tbl1.TransCode, 
		rates.usd_rate
	ORDER BY RIGHT(LEFT(tbl1.TransCode,3),1), tbl1.TransCode
*/

END $$