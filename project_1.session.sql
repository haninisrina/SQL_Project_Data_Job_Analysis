/*
Data Job Market Trend Analysis

Questions to Answer:
    - Monthly Trends in Job Postings
    - Which countries have the highest demand for data-related jobs?
    - Which job posting platforms (job_via) are the most popular?

/*
/*
--Monthly Trends in Job Postings
Use SQL to count job postings based on posting date (job_posted_date) and country (job_country)
*/


SELECT EXTRACT (MONTH FROM job_posted_date) as month,
    job_country,COUNT(job_id)
FROM job_postings_fact
GROUP BY month, job_country
ORDER BY month, count DESC

SELECT *
FROM job_postings_fact
WHERE job_country= 'Indonesia'

