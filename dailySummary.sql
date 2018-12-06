select 
	a.description as item,
	left(b.trcode,3) || '0000000' as TransCode, 
	b.curcde1
-- 	case when b.curcde1 = 'AUD' then sum(b.amtorig1) else 0.00 end  as AUDAmt,
-- 	case when b.curcde1 = 'ALL' then sum(b.amtorig1) else 0.00 end  as ALLAmt,
-- 	case when b.curcde1 = 'USD' then sum(b.amtorig1) else 0.00 end  as USDAmt
from ref_daily_summary a
LEFT JOIN txn_data b ON 
	left(b.trcode,3) = a.code AND
	a.is_deleted = false
where b.bookcd = 1 and b.trcode not like '00%' and a.is_deleted = false
group by a.description, left(b.trcode,3), b.curcde1	







select 
	tbl1.item,
	tbl1.TransCode, 
	tbl1.AUDAmt,
	tbl1.ALLAmt,
	tbl1.USDAmt,
	tbl1.PABAmt
from(
select 
	DISTINCT(a.description) as item,
	a.code || '0000000' as TransCode, 
	case when TRIM(b.curcde1) = 'AUD' then sum(b.amtorig1) else 0.00 end  as AUDAmt,
 	case when TRIM(b.curcde1) = 'ALL' then sum(b.amtorig1) else 0.00 end  as ALLAmt,
	case when TRIM(b.curcde1) = 'USD' then sum(b.amtorig1) else 0.00 end  as USDAmt,
	case when TRIM(b.curcde1) = 'PAB' then sum(b.amtorig1) else 0.00 end  as PABAmt
from ref_daily_summary a
LEFT JOIN txn_data b ON
	left(b.trcode,3) = a.code AND
	b.is_deleted = false
LEFT JOIN ref_currency c ON
	c.alpha_code = b.curcde1 AND
	c.is_deleted = false
WHERE a.is_deleted = false
	AND SUBSTRING(a.code, 3, 1) = '1'
group by a.description, a.code || '0000000', b.curcde1
ORDER BY a.code || '0000000'
)tbl1 
group by 
	tbl1.item, 
	tbl1.TransCode, 
	tbl1.AUDAmt,
	tbl1.ALLAmt,
	tbl1.USDAmt,
	tbl1.PABAmt
ORDER BY tbl1.TransCode









select substring('01200000', 3,1)

select curcde1, amtorig1 from txn_data where trcode like '051%'

	
	
LEFT JOIN ref_currency c ON
	c.alpha_code = b.curcde1 AND
	c.is_deleted = false
LEFT JOIN ref_daily_summary_currency d ON
	d.fk_currency = c.id AND
	d.fk_book_code = b.bookcd AND
	d.is_deleted = false
where b.bookcd = 1 and b.trcode not like '00%' and a.is_deleted = false
group by a.description, left(b.trcode,3), b.curcde1











