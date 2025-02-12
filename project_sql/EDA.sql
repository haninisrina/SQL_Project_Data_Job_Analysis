
-- 1. Understanding Data Structure 
--Check available tables
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

--View table structure
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'company_dim';

SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'job_postings_fact';

SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'skills_job_dim';

SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'skills_dim';

-- Check the number of rows and columns:
SELECT COUNT(*) AS total_rows FROM company_dim;

SELECT COUNT(*) 
FROM information_schema.columns 
WHERE table_name = 'company_dim';

SELECT COUNT(*) AS total_rows FROM job_postings_fact;

SELECT COUNT(*) 
FROM information_schema.columns 
WHERE table_name = 'job_postings_fact';

SELECT COUNT(*) AS total_rows FROM skills_job_dim;

SELECT COUNT(*) 
FROM information_schema.columns 
WHERE table_name = 'skills_job_dim';

SELECT COUNT(*) AS total_rows FROM skills_dim;

SELECT COUNT(*) 
FROM information_schema.columns 
WHERE table_name = 'skills_dim';

--2.Assessing Data Quality
-- Check missing values per column

SELECT column_name, null_count
FROM (
    SELECT unnest(array[
        'company_id', 'name', 'link', 'link_google', 'thumbnail'
    ]) AS column_name,
    unnest(array[
        (SELECT COUNT(*) FROM company_dim WHERE company_id IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE name IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE link IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE link_google IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE thumbnail IS NULL)
    ]) AS null_count
) AS subquery
ORDER BY null_count DESC;
--or

SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM company_dim WHERE row_to_json(company_dim) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'company_dim'
ORDER BY null_count DESC;

SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM job_postings_fact WHERE row_to_json(job_postings_fact) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'job_postings_fact'
ORDER BY null_count DESC;

SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM skills_job_dim WHERE row_to_json(skills_job_dim) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'skills_job_dim'
ORDER BY null_count DESC;

SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM skills_dim WHERE row_to_json(skills_dim) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'skills_dim'
ORDER BY null_count DESC;

-- Check for duplicate records (based on all columns)
-- Check for duplicate values in a specific column
-- Count unique values in a column
