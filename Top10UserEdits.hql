SELECT COUNT(*), contributor_name FROM (SELECT * FROM xmldata WHERE contributor_name is NOT NULL)a GROUP BY contributor_name;
