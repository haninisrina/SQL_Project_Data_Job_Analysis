
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
-- ex query for table company_dim
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


-- Count unique values in each column
SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'company_dim'
ORDER BY n_distinct DESC;

SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'job_postings_fact'
ORDER BY n_distinct DESC;

SELECT *
FROM job_postings_fact
LIMIT 15;

SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'skills_job_dim'
ORDER BY n_distinct DESC;

SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'skills_dim'
ORDER BY n_distinct DESC;

-- Check for duplicate records (based on all columns)
-- based on all colomns 

/*buat ngambil nama colom
SELECT format(
    'SELECT %s, COUNT(*) FROM company_dim GROUP BY %s HAVING COUNT(*) > 1;',
    string_agg(quote_ident(column_name), ', '),
    string_agg(quote_ident(column_name), ', ')
)
FROM information_schema.columns
WHERE table_name = 'company_dim';

*/

SELECT link, thumbnail, link_google, name, COUNT(*) 
FROM company_dim 
GROUP BY link, thumbnail, link_google, name 
HAVING COUNT(*) > 1;

SELECT 
    job_work_from_home, job_posted_date, job_no_degree_mention, 
    job_health_insurance, salary_year_avg, salary_hour_avg, 
    search_location, salary_rate, job_title_short, job_title, 
    job_location, job_via, job_schedule_type, job_country, 
    company_id, COUNT(*) 
FROM job_postings_fact 
GROUP BY 
    job_work_from_home, job_posted_date, job_no_degree_mention, 
    job_health_insurance, salary_year_avg, salary_hour_avg, 
    search_location, salary_rate, job_title_short, job_title, 
    job_location, job_via, job_schedule_type, job_country, 
    company_id
HAVING COUNT(*) > 1
ORDER BY company_id;

SELECT job_id,skill_id, COUNT(*)
FROM skills_job_dim
GROUP BY job_id,skill_id
HAVING COUNT(*) > 1;

SELECT skill_id,skills,type, COUNT(*)
FROM skills_dim
GROUP BY skill_id,skills,type
HAVING COUNT(*) > 1;

--or based on company_id (bisa dilakukan jika primary key tidak 100% unique(dilihat pada pengecekan sebelumnya))

WITH duplicates AS (
    SELECT company_id, COUNT(*)
    FROM company_dim
    GROUP BY company_id
    HAVING COUNT(*) > 1
)
SELECT c.*
FROM company_dim c
JOIN duplicates d ON c.company_id = d.company_id;


