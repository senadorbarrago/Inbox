/*
SELECT * FROM conf_data_field ORDER BY id;
SELECT * FROM conf_data_type;
SELECT * FROM conf_record_profile;


DELETE FROM ibstrnmodeldata;
ALTER SEQUENCE ibstrnmodeldata_id_seq RESTART;
DELETE FROM txn_data;
ALTER SEQUENCE txn_data_id_seq RESTART;
DELETE FROM ibs_file_log;
ALTER SEQUENCE ibs_file_log_id_seq RESTART;

SELECT * FROM ibstrnmodeldata WHERE TRIM(itmdmodelvalue) = '1046000015';
SELECT * FROM ibstrnmodeldata WHERE itmdtransid = 1532606475207;


SELECT * FROM ibstrnmodeldata WHERE itmdrecordtype = '1'

SELECT * FROM txn_data WHERE filename = 'MTIS 20171208.xls'
AND secnme <> '';

*/
SELECT * FROM ref_transaction_code a
WHERE LENGTH(a.code) > 9
SELECT FROM sp_ibs_model_data_transfer('ITRS', 'FRS_ITRS_20180710.csv', 'ITRS');
SELECT * FROM sp_get_data_field('ITRS', 'ITRS-002');
SELECT * FROM sp_ibs_model_data_prooflist_over_all_count('ITRS', 'CURRENTC.DBF', 'ITRS');
SELECT * FROM sp_ibs_model_data_prooflist_details('ITRS', 'CURRENTC.DBF', 'ITRS', 1, 1000);
WHERE LENGTH(CAST(crdcde AS TEXT)) > 11

SELECT * FROM sp_ibs_model_data_prooflist_details('CURRENTC.DBF','SRC-PROFILE-002', '7e250f3a-c10e-4ee7-b350-cffef4bd6182', 'ITRS', 'C140618008', 1, 1000);
SELECT * FROM sp_ibs_model_data_prooflist_over_all_count('CURRENTC.DBF','SRC-PROFILE-002', '5744196f-2f4e-422d-a4ae-d3e917d6c78d', 'ITRS', 'C140618008');
SELECT FROM sp_ibs_model_data_transfer('FRS_ITRS_20180803_conso.csv','SRC-PROFILE-015', 'd2c890a9-c5fb-458e-8554-b77473c4e077', 'ITRS', 'C140618008');
SELECT * FROM sp_ibs_log_file('CURRENTC.DBF','SRC-PROFILE-002', 'ITRS', 'C140618008');
SELECT FROM sp_ibs_update_execute('CURRENTC.DBF','SRC-PROFILE-002', '367de1fb-a1c8-40b9-a578-033b51442cc5', 'ITRS', 'C140618008');
SELECT FROM sp_ibs_validate_execute('CURRENTC.DBF','SRC-PROFILE-002', '367de1fb-a1c8-40b9-a578-033b51442cc5', 'ITRS', 'C140618008');
SELECT * FROM sp_ibs_get_data_field('SRC-PROFILE-002', 'ITRS', 'C140618008');
SELECT * FROM ibs_file_log;
SELECT * FROM txn_data;		  
SELECT * FROM ref_pscc
SELECT * FROM conf_data_field
SELECT * FROM conf_data_type
SELECT * FROM ref_bank a WHERE a.code = '50020'
SELECT * FROM ref_country WHERE code = '702';
SELECT * FROM ibstrnmodeldata a
WHERE a.itmdtransid = 1535445591893 
SELECT * FROM txn_data a
WHERE a.filename = 'FRS_ITRS_20180803_conso.csv'
SELECT * FROM ibstrnmodeldata a
WHERE TRIM(a.itmdrecordtype) = '1' AND
a.itmdjobinstance = 'd2c890a9-c5fb-458e-8554-b77473c4e077' 
SELECT * FROM ibstrnmodeldata a
ORDER BY a.id DESC
WHERE a.itmdmodelcolumn = 'expcde_raw'
				  
SELECT * FROM ref_participant
SELECT * FROM ref_exporter a
WHERE TRIM(a.code) IN ('637580015', '875230015', '299230015')
SELECT a.* FROM ibstrnmodeldata a ORDER BY a.itmdtransid
JOIN(SELECT b.itmdtransid transid FROM ibstrnmodeldata b
	WHERE UPPER(b.itmdmodelcolumn) = 'CTRYCD' AND
	LENGTH(b.itmdmodelvalue)>3)tbl1 ON
tbl1.transid = a.itmdtransid
				  
				  
				  
SELECT * FROM sp_report_itrs_output_extract('ITRS', 'c140618008', 'HO', 'ITRS-002', '2018-07-28', '2018-07-28', 1, 10000);

SELECT * FROM sp_report_itrs_output_extract_count('ITRS', 'c140618008', 'HO', 'ITRS-001', '2018-07-28', '2018-07-28');

SELECT * FROM ibs_updaters

SELECT 
	c.code,
	c.description,
	a.label,
	d.code,
	b.code 
FROM conf_map_record_profile_data_field a
JOIN conf_record_profile b ON
	b.id = a.fk_record_profile
JOIN conf_data_field c ON
	c.id = a.fk_data_field
JOIN conf_data_type d ON
	d.id = c.fk_datatype
WHERE 
	b.code = 'ITRS-001'
ORDER BY a.sequence_no ASC




SELECT SUBSTRING('D11010', 2, 2)
SELECT SUBSTRING('D11010', 4, LENGTH('D11010'))

SELECT RTRIM(LTRIM('   111   '))
SELECT * FROM ibs_reference_field
SELECT * FROM ibs_reference_table
SELECT * FROM ibs_source_system
SELECT * FROM ibs_source_profile
SELECT * FROM ref_branch
SELECT * FROM txn_data a
WHERE LENGTH(a.trcode)<10
DELETE FROM txn_data WHERE id > 30000
				   
				   
SELECT * FROM ibs_map_source_profile_validators
				   
SELECT
    information_schema.tables.code
FROM
    information_schema.tables
WHERE
    table_type = 'BASE TABLE'
AND
    table_schema NOT IN ('pg_catalog', 'information_schema')
AND 
information_schema.tables.table_name = 'ref_participant'
SELECT * FROM ref_pscc WHERE code='0' AND is_deleted = false
SELECT * FROM ref_currency WHERE alpha_code='USD' AND is_deleted = false

SELECT * FROM ibstrnmodeldata a
WHERE a.itmdtransid = '1533799402551'
				   
UPDATE ibstrnmodeldata
SET itmdmodelvalue = 'USD'
WHERE id = 204225
				   
SELECT
	DISTINCT a.itmdtransid, 
	a.itmdmodelcolumn, 
    a.itmdmodelvalue, 
    b.id 
FROM ibstrnmodeldata a
LEFT JOIN ref_currency b ON
	b.alpha_code = a.itmdmodelvalue AND
	b.is_deleted = false
WHERE
	a.itmdmodelcolumn = 'curcde1' AND
	a.itmdjobinstance = '5744196f-2f4e-422d-a4ae-d3e917d6c78d' AND
	a.dataset = 'ITRS' AND
	b.id IS NULL
				   
SELECT * FROM ibstrnmodeldata a
WHERE a.itmdtransid IN(
SELECT a.itmdtransid FROM ibstrnmodeldata a
WHERE a.itmdmodelcolumn IN ('status') AND
a.itmdmodelvalue = 	'REJECTED'
)AND a.itmdmodelcolumn = 'remarks'
AND a.itmdmodelvalue LIKE '%CURCDE1%'
SELECT * FROM ibstrnmodeldata a
WHERE a.itmdmodelcolumn IS NULL;

SELECT * FROM ref_schedule
				   
				   
SELECT * FROM ref_country a
WHERE a.code LIKE '%221%'
SELECT * FROM ref_pscc				   
SELECT FROM sp_ibs_add_status_and_remarks_field('5744196f-2f4e-422d-a4ae-d3e917d6c78d', 'ITRS', 'c140618008');
				   
SELECT b.code, a.* FROM conf_data_field a
JOIN conf_data_type b ON
b.id = fk_datatype AND
b.is_deleted = false
WHERE a.code = UPPER('bkcode')

SELECT * FROM ibs_reference_field
				   
SELECT * FROM ibstrnmodeldata a
WHERE a.itmdtransid = '1533799402551'
				   
UPDATE ibstrnmodeldata
	SET itmdmodelvalue = 20000.001
WHERE id = 204224 --"204227"

UPDATE ibstrnmodeldata
	SET itmdmodelvalue = 261
WHERE id = 204227

				   
UPDATE ibstrnmodeldata
	SET itmdmodelvalue = 35
WHERE id = 204233

UPDATE ibstrnmodeldata
	SET itmdmodelcolumn = 'bkcode'
WHERE id = 204233;

UPDATE ibstrnmodeldata
	SET itmdmodelcolumn = 'trdate'
WHERE id = 204230;


UPDATE ibstrnmodeldata
	SET itmdmodelcolumn = 'bookcd'
WHERE id = 204234;

UPDATE ibstrnmodeldata
	SET itmdmodelvalue = 3500000
WHERE id = 204233
				   
UPDATE ibstrnmodeldata
   SET itmdmodelvalue = '100.00'
WHERE id = '204224';				   

UPDATE ibstrnmodeldata
   SET itmdmodelvalue = 'XXXX'
WHERE id = '204225';				   


UPDATE ibstrnmodeldata
   SET itmdmodelvalue = ''
WHERE itmdmodelcolumn = 'remarks';  

SELECT * FROM ref_transaction_code WHERE code = '0610000006'
SELECT b.code 
FROM ref_map_schedule_data_field a
JOIN conf_data_field b ON
	b.id = a.fk_data_field AND
	b.is_deleted = false	
WHERE a.fk_schedule = 5
				   
UPDATE ibstrnmodeldata
   SET itmdmodelvalue = 'VALID'
WHERE itmdmodelcolumn = 'status';				   

UPDATE ibstrnmodeldata
   SET itmdmodelvalue = ''
WHERE itmdmodelcolumn = 'remarks';
				   
SELECT * FROM ibstrnmodeldata a
WHERE a.itmdtransid = '1533799402551'
ORDER BY a.id

SELECT a.* FROM ibstrnmodeldata a
JOIN(
SELECT DISTINCT a.itmdtransid transid FROM ibstrnmodeldata a
WHERE itmdmodelcolumn = 'remarks' AND itmdmodelvalue <> ''
)tbl1 ON tbl1.transid = a.itmdtransid
ORDER BY a.itmdtransid, a.id

SELECT a.* FROM ibstrnmodeldata a
JOIN(
SELECT DISTINCT a.itmdtransid transid FROM ibstrnmodeldata a
WHERE itmdmodelcolumn = 'status' AND itmdmodelvalue = 'REJECTED'
)tbl1 ON tbl1.transid = a.itmdtransid
ORDER BY a.itmdtransid, a.id

SELECT FROM sp_ibs_validate_data_field_length('SRC-PROFILE-002', '5744196f-2f4e-422d-a4ae-d3e917d6c78d', 'ITRS', 'C140618008');				   
SELECT FROM sp_ibs_validate_reference_field('SRC-PROFILE-002', '5744196f-2f4e-422d-a4ae-d3e917d6c78d', 'ITRS', 'C140618008');
SELECT FROM sp_ibs_validate_schedule_required_fields('SRC-PROFILE-002', '5744196f-2f4e-422d-a4ae-d3e917d6c78d', 'ITRS', 'C140618008');
SELECT * FROM sp_ibs_get_data_field('SRC-PROFILE-002', 'ITRS', 'C140618008');
				   
SELECT b.code, b.field_length, b.field_precision, b.field_scale, a.itmdmodelvalue, a.id FROM ibstrnmodeldata a
JOIN conf_data_field b ON
	b.code = UPPER(a.itmdmodelcolumn) AND
	b.is_deleted = false
WHERE a.itmdtransid = 1534937206494
	

SELECT * FROM ibs_map_target_profile_data_field a



SELECT b.code FROM ibs_map_target_profile_data_field a
JOIN conf_data_field b ON
	b.id = a.fk_data_field AND
	b.is_deleted = false
WHERE a.fk_target_profile = 1
ORDER BY a.sequence_no

				   
				   
SELECT * FROM conf_data_field
				   
SELECT * FROM conf_data_type

SELECT 
b.code,
a.*				   
FROM ibs_reference_field a
JOIN conf_data_field b ON
   b.id = a.fk_data_field	AND
   b.is_deleted = false
WHERE a.is_deleted = false AND
	a.fk_reference_table = 5
SELECT * FROM ibs_source_profile a
WHERE id = 14
				   
				   
SELECT * FROM ibs_updaters;
SELECT * FROM ibs_validators;
SELECT * FROM ibs_source_profile;
				   
SELECT 
	c.code, 
	c.description, 
	b.command_name 
FROM ibs_map_source_profile_updaters a
JOIN ibs_updaters b ON
	b.id = a.fk_updaters AND
	b.is_deleted = false
JOIN  ibs_source_profile c ON
	c.id = a.fk_source_profile AND
	c.is_deleted = false
WHERE a.is_deleted = false --AND
	--c.code = 'SRC-PROFILE-002'
ORDER BY c.code, a.seq_no
				   
				   
SELECT 
	c.code, 
	c.description, 
	b.command_name 
FROM ibs_map_source_profile_validators a
JOIN ibs_validators b ON
	b.id = a.fk_validators AND
	b.is_deleted = false
JOIN  ibs_source_profile c ON
	c.id = a.fk_source_profile AND
	c.is_deleted = false
WHERE a.is_deleted = false AND
	c.code = 'SRC-PROFILE-002'
ORDER BY a.seq_no
				   
SELECT * FROM ibs_map_source_profile_validators
				   
				   
SELECT * FROM conf_data_field
SELECT * FROM conf_data_type
SELECT TO_CHAR('20180808', 'yyyyMMdd') :: DATE

				   
SELECT '`87500.00`' :: TEXT
				   
				   
SELECT a.fk_schedule, b.code FROM ref_map_schedule_data_field a
JOIN conf_data_field b ON
	b.id = a.fk_data_field AND
	b.is_deleted = false
WHERE a.fk_schedule IN(9,8)
				   
				   
SELECT * FROM ibs_reference_field a
WHERE a.fk_data_field = 59

SELECT * FROM ibs_reference_table a
WHERE a.id = 6
SELECT * FROM ibs_updaters
SELECT * FROM ref_schedule
SELECT * FROM ref_transaction_code a
ORDER BY a.id
WHERE a.code = '0210000002' AND a.is_deleted = false
				   
SELECT * FROM ref_purpose_code a
WHERE a.fk_transaction_code IS NULL
SELECT * FROM conf_data_type
SELECT is_date('null');
SELECT is_numeric('0.1');
SELECT is_integer('1000000000000000000');
SELECT is_bigint('1000000000000000000');
SELECT is_boolean('true');
				   
SELECT * FROM conf_data_field a ORDER BY a.id WHERE LOWER(a.code) LIKE 'br%'--55
SELECT * FROM ibs_reference_field a WHERE a.fk_data_field = 55
SELECT * FROM ref_ownership
SELECT * FROM ref_pscc a WHERE code = '07269900'

SELECT * FROM ibstrnmodeldata a
WHERE a.itmdtransid = 1535182463713
				   
SELECT * FROM ref_currency a
ORDER BY a.alpha_code

SELECT * FROM ref_branch
				   
SELECT SUBSTRING(TRIM('Joyson/0043'), POSITION('/' IN TRIM('Joyson/0043'))+1, LENGTH(TRIM('Joyson/0043')))
SELECT * FROM ref_branch
																						  
SELECT * FROM ref_book
SELECT TRIM(LEADING '0' FROM '00023400')
																						  
																						  
SELECT * FROM ref_transaction_code a
WHERE a.code LIKE '%101001%'
																						  
SELECT * FROM ref_schedule 
																						  

																						  
SELECT * FROM ref_transaction_code a
WHERE a.fk_schedule = 16

SELECT * FROM conf_data_field a
ORDER BY a.id
SELECT * FROM ibs_reference_table
SELECT * FROM ibs_reference_field
SELECT '-99.99' :: NUMERIC(4, 2)
																						  
SELECT * FROM ref_provincial																						  

SELECT * FROM ref_branch a
WHERE a.code IN(
SELECT a.code FROM ref_branch a
GROUP BY a.code
HAVING COUNT(a.code) > 1
)																						  
																						  
																						  
INSERT INTO ref_branch(code, description, fk_provincial, created_by, date_created)																						  
SELECT a.code, a.description, 99, 'ITRS', a.date_created FROM ref_branch_2 a
WHERE TRIM(a.code) NOT IN (
	SELECT TRIM(b.code) FROM ref_branch b
	WHERE b.is_deleted = false
)
																						  
																						  
																						  
																						  
																						  