
# Normalize Sars_cov dataset to two tables as laboratory and sequence
CREATE TABLE `laboratory` (
  `IMS_ID` varchar(50) DEFAULT NULL,
  `DATE_DRAW` varchar(50) DEFAULT NULL,
  `OWN_FASTA_ID` varchar(50) DEFAULT NULL,
  `RECEIVE_DATE` varchar(50) DEFAULT NULL,
  `PROCESSING_DATE` varchar(50) DEFAULT NULL,
  `SENDING_LAB_PC` int DEFAULT NULL
) 


CREATE TABLE `sequence` (
  `IMS_ID` varchar(50) DEFAULT NULL,
  `SEQ_TYPE` varchar(50) DEFAULT NULL,
  `SEQ_REASON` varchar(50) DEFAULT NULL,
  `SAMPLE_TYPE` varchar(50) DEFAULT NULL,
  `SEQUENCING_LAB_PC` int DEFAULT null,
  `GISAID_ACCESSION` varchar(50) DEFAULT NULL
) 


# Insert data from Sarc_cove to table sequence
insert into sequence
select IMS_ID,  SEQ_TYPE , SEQ_REASON, SAMPLE_TYPE, SEQUENCING_LAB_PC, GISAID_ACCESSION
from sars_cov 


# Insert data from Sarc_cove to table laboratory
insert into laboratory
select IMS_ID,  DATE_DRAW , OWN_FASTA_ID, RECEIVE_DATE, PROCESSING_DATE, SENDING_LAB_PC
from sars_cov 


# CHECK duplicate IMS_ID values, as mentioned IMS_ID should be unique
SELECT
    IMS_ID, COUNT(*)
FROM
    sars_cov sc 
GROUP BY
    IMS_ID
HAVING 
    COUNT(*) > 1
    
    
# Check correctness of data for column SAMPLE_TYPE, and check rows that primary key IMS_ID maybe is null
 select IMS_ID ,DATE_DRAW ,SEQ_TYPE ,SEQ_REASON ,SAMPLE_TYPE ,OWN_FASTA_ID ,RECEIVE_DATE ,
	PROCESSING_DATE ,SENDING_LAB_PC ,SEQUENCING_LAB_PC,GISAID_ACCESSION from sars_cov
#where IMS_ID = null 
where not SAMPLE_TYPE  in ("S001","S002","S003","S004","S005","S006","S007","S008","S009","S010","S011","S012","S013","S014","S015","S016","S017", "X")



# chech the format of the date columns to be in specified format like as JJJJ-MM-TT
 SELECT count(*) FROM sars_cov 
 WHERE DATE(STR_TO_DATE(DATE_DRAW, '%Y-%m-%d')) IS not NULL

 SELECT count(*) FROM sars_cov 
 WHERE DATE(date_format(RECEIVE_DATE, '%Y-%m-%d')) is not null
 
  SELECT count(*) FROM sars_cov 
 WHERE DATE(date_format(PROCESSING_DATE, '%Y-%m-%d')) is  null
 
 
 
 # Chechk if there is space in ID contents columns
 SELECT * FROM sars_cov
 where  INSTR(OWN_FASTA_ID,' ') > 0 
 
  SELECT * FROM sars_cov
 where  INSTR(IMS_ID ,' ') > 0 
 
 
 # Chechk if there is \ characther in this GISAID_ACCESSION (considered slash enterd, so backslash is a worng charaction with this assumption)
 SELECT * from sars_cov
where GISAID_ACCESSION like '%\%';


# Since the length of date columns does not more than 10 then I checked that lengths does not bigger than 10
 select * from sars_cov
 where length (RECEIVE_DATE)>10


