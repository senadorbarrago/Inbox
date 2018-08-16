SELECT b.code, NULLIF(regexp_replace(c.code, '\D','','g'), ''), NULLIF(regexp_replace(a.trcode, '\D','','g'), '') FROM txn_data a
LEFT JOIN ref_schedule c ON
	NULLIF(regexp_replace(c.code, '\D','','g'), '') = NULLIF(regexp_replace(a.trcode, '\D','','g'), '')
LEFT JOIN ref_transaction_code b ON
	b.fk_schedule = c.id
WHERE b.code ISNULL									  



UPDATE txn_data
	SET trcode = tbl1.code
-- SELECT 	
-- 	a.trcode, 
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
-- 	b.code,
--     c.purpose_code,
--     c.code
FROM (SELECT c.code code, a.id id FROM txn_data a
	LEFT JOIN ref_schedule b ON
		NULLIF(regexp_replace(b.code, '\D','','g'), '') = SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2)
	LEFT JOIN ref_transaction_code c ON
		c.fk_schedule = b.id AND
		TRIM(LEADING '0' FROM c.purpose_code) = TRIM(LEADING '0' FROM SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))))
	WHERE a.trcode LIKE 'Q%' AND c.code IS NOT NULL) tbl1 
WHERE
	  tbl1.id = txn_data.id 



SELECT 	
	a.trcode, 
	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
	b.code,
    c.purpose_code,
    c.code
FROM txn_data a
LEFT JOIN ref_schedule b ON
	NULLIF(regexp_replace(b.code, '\D','','g'), '') = SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2)
LEFT JOIN ref_transaction_code c ON
	c.fk_schedule = b.id AND
    TRIM(LEADING '0' FROM c.purpose_code) = TRIM(LEADING '0' FROM SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))))
WHERE a.trcode LIKE 'Q%'

																														  
																														  
																														  
																														  
																														  
SELECT 	
	a.trcode, 
	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
	b.code,
    c.purpose_code,
    c.code
FROM txn_data a
LEFT JOIN ref_schedule b ON
	NULLIF(regexp_replace(b.code, '\D','','g'), '') = SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2)
LEFT JOIN ref_transaction_code c ON
	c.fk_schedule = b.id
WHERE a.trcode LIKE 'T%'																													  
																														  

																														  
UPDATE txn_data
	SET trcode = '0320000001'
-- SELECT 	
-- 	a.trcode, 
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
-- 	b.code,
--     c.purpose_code,
--     c.code
WHERE
	  trcode LIKE 'TRD10%'																											  
																														  
																														  

																	  
																	  
																	  
																	  
																	  
																	  
																	  
																	  
																	  
																	  


UPDATE txn_data
	SET trcode = tbl1.code
-- SELECT 	
-- 	a.trcode, 
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
-- 	b.code,
--     c.purpose_code,
--     c.code
FROM (SELECT c.code code, a.id id FROM txn_data a
	LEFT JOIN ref_schedule b ON
		NULLIF(regexp_replace(b.code, '\D','','g'), '') = SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2)
	LEFT JOIN ref_transaction_code c ON
		c.fk_schedule = b.id AND
		TRIM(LEADING '0' FROM c.purpose_code) = TRIM(LEADING '0' FROM SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))))
	WHERE a.trcode LIKE 'D%' AND c.code IS NOT NULL) tbl1 
WHERE
	  tbl1.id = txn_data.id 



SELECT 	
	a.trcode, 
	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
	b.code,
    c.purpose_code,
    c.code
FROM txn_data a
LEFT JOIN ref_schedule b ON
	NULLIF(regexp_replace(b.code, '\D','','g'), '') = SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2)
LEFT JOIN ref_transaction_code c ON
	c.fk_schedule = b.id AND
    TRIM(LEADING '0' FROM c.purpose_code) = TRIM(LEADING '0' FROM SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))))
WHERE a.trcode LIKE 'D%' 
																	  
																	  
																	  
																	  

																														  
																														  
																														  
																														  
																														  
UPDATE txn_data
	SET trcode = tbl1.code
-- SELECT 	
-- 	a.trcode, 
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 2, 2),
-- 	SUBSTRING(RTRIM(LTRIM(a.trcode)), 4, LENGTH(RTRIM(LTRIM(a.trcode)))),
-- 	b.code,
--     c.purpose_code,
--     c.code
FROM (SELECT c.code code, a.id id FROM txn_data a
	LEFT JOIN ref_transaction_code c ON
	TRIM(LEADING '0' FROM c.purpose_code) = TRIM(LEADING '0' FROM a.trcode)
	WHERE LENGTH(a.trcode) = 2) tbl1 
WHERE
	  tbl1.id = txn_data.id 



SELECT 	
	a.trcode, 
    c.purpose_code,
    c.code
FROM txn_data a
LEFT JOIN ref_transaction_code c ON
	TRIM(LEADING '0' FROM c.purpose_code) = TRIM(LEADING '0' FROM a.trcode)
WHERE LENGTH(a.trcode) = 4
																	 

UPDATE txn_data
     SET trcode = '1520000004'
WHERE trcode IS NULL AND filename LIKE 'OTHERFX%'
																														  
SELECT * FROM txn_data a
WHERE a.trcode IS NULL

																								  
SELECT * FROM txn_data a
WHERE LENGTH(a.trcode) < 10
																														  
SELECT * FROM ref_schedule a
WHERE a.code = '10'

SELECT * FROM ref_transaction_code a
WHERE a.fk_schedule = 10

																														  
SELECT * FROM txn_data a
																														  
INSERT INTO txn_data(
	transactionid,
    bkcode,
    trdate,
    trcode,
    bookcd,
    bsrate,
    curcde1,
    amtorig1,
    curcde2,
    amtorig2,
    ctrycd,
    dealdt,
    dealcd,
    expcde,
    dbtcde,
    remnme,
    invrnme,
    tin1,
    secrn01,
    dtirn01,
    psic1,
    impcde,
    crdcde,
    benenme,
    invsnme,
    tin2,
    secrn02,
    dtirn02,
    psic2,
    comcde,
    modpay,
    hctrycd,
    impscd,
    lcno,
    brn,
    bildte,
    omatdte,
    nmatdte,
    remchlcde,
    prvcde,
    owncde,
    bsrdno,
    cirno,
    ttfno,
    listcde,
    regtypcde,
    isin,
    secnme,
    resdbce,
    ctpbcd,
    ctpnme,
    ctptypcde,
    svldte,
    sfrate,
    ffxdte,
    fvldte,
    ffxrate,
    bspdan,
    cfccode,
    psic3,
    sscode,
    refno,
    indcode,
    rescode,
    brcode,
    rcrdtype,
    glcode,
    acctno,
    filename,
    status,
    date_created,
    created_by,
    date_last_modified,
    last_modified_by,
    is_deleted
)
SELECT 
	transactionid,
    bkcode,
    trdate,
    trcode,
    bookcd,
    bsrate,
    curcde1,
    amtorig1,
    curcde2,
    amtorig2,
    ctrycd,
    dealdt,
    dealcd,
    expcde,
    dbtcde,
    remnme,
    invrnme,
    tin1,
    secrn01,
    dtirn01,
    psic1,
    impcde,
    crdcde,
    benenme,
    invsnme,
    tin2,
    secrn02,
    dtirn02,
    psic2,
    comcde,
    modpay,
    hctrycd,
    impscd,
    lcno,
    brn,
    bildte,
    omatdte,
    nmatdte,
    remchlcde,
    prvcde,
    owncde,
    bsrdno,
    cirno,
    ttfno,
    listcde,
    regtypcde,
    isin,
    secnme,
    resdbce,
    ctpbcd,
    ctpnme,
    ctptypcde,
    svldte,
    sfrate,
    ffxdte,
    fvldte,
    ffxrate,
    bspdan,
    cfccode,
    psic3,
    sscode,
    refno,
    indcode,
    rescode,
    brcode,
    rcrdtype,
    glcode,
    acctno,
    filename,
    status,
    date_created,
    created_by,
    date_last_modified,
    last_modified_by,
    is_deleted																														  
FROM txn_data

SELECT * FROM ibs_source_profile
SELECT * FROM ibstrnmodeldata
