/*
SELECT * FROM conf_data_field ORDER BY id;
SELECT * FROM conf_data_type;
SELECT * FROM conf_record_profile;


DELETE FROM ibstrnmodeldata;
ALTER SEQUENCE ibstrnmodeldata_id_seq RESTART;
DELETE FROM txn_data;
ALTER SEQUENCE txn_data_id_seq RESTART;

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

SELECT * FROM ref_pscc
SELECT * FROM conf_data_field

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
SET itmdmodelvalue = 'XXX'
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
)
SELECT * FROM ibstrnmodeldata a
WHERE a.itmdmodelcolumn IS NULL;
				   
SELECT FROM sp_ibs_add_status_and_remarks_field('5744196f-2f4e-422d-a4ae-d3e917d6c78d', 'ITRS', 'c140618008');
				   