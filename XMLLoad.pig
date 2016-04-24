REGISTER /usr/local/pig/lib/piggybank.jar;

xmldata = LOAD '/user/enwiki.xml' USING org.apache.pig.piggybank.storage.XMLLoader('page') as (page:chararray);

xml2csv = FOREACH xmldata GENERATE FLATTEN (REGEX_EXTRACT_ALL(page,'<title>(.*)</title>\\s*<id>(.*)</id>\\s*<revision>\\n\\s*<id>(.*)</id>\\n\\s*<timestamp>(.*)</timestamp>\\s*<contributor>\\n\\s*<ip>(.*)</ip>\\n\\s*<username>(.*)</username>\\n\\s*<id>(.*)</id>\\s*</contributor>\\s*<comment>(.*)</comment>\\s*<text>(.*)</text>\\s*</revision>\\s*</page>')) AS (title:chararray,id:chararray,revisionid:chararray,timestamp:chararray,contribip:chararray,contribname:chararray,contribid:chararray,comment:chararray,text:chararray);

STORE data INTO '/xml2csv/' USING PigStorage(',');