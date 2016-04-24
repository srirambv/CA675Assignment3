ADD jar /usr/local/hive/lib/hivexmlserde-1.0.5.1.jar;


CREATE TABLE HIVEXML(str STRING);

LOAD DATA INPATH '/home/ubuntu/enwiki.xml' INTO TABLE HIVEXML;

CREATE EXTERNAL TABLE xmldata (page_id STRING, revision_id STRING, contributor_ip STRING, contributor_name STRING, contributor_id STRING) 
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.page_id"="/page/page_id/text()",
"column.xpath.revision_id"="/page/revision/id/text()",
"column.xpath.contributor_ip"="/page/revision/contributor/ip/text()",
"column.xpath.contributor_name"="/page/revision/contributor/username/text()",
"column.xpath.contirbutor_id"="/page/revision/contributor/id/text()" )
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
LOCATION "/user/hive/warehouse/"
TBLPROPERTIES (
"xmlinput.start"="<page ",
"xmlinput.end"="</page>"
);


INSERT OVERWRITE TABLE xmldata SELECT xpath_string(str, 'page/id'), xpath_string(str, 'page/revision/id'), xpath_string(str, 'page/revision/contributor/ip'), xpath_string(str, 'page/revision/username'), xpath_string(str, 'page/revision/contributor/id') from HIVEXML;
