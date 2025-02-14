/*
Companies Hiring the Most Data Analysts in Indonesia 
- **Question to answer:** Which companies in Indonesia have the highest number of job postings for Data Analysts?
- **What to Analyze:** The top hiring companies, whether they are startups, tech firms, or large corporations, and any hiring trends.
- **Objective:** Helps job seekers target their applications toward companies that frequently hire Data Analysts, increasing their chances of securing a job.
*/

-- 🔹 Job posting in Indonesia
WITH job_postings_indonesia AS (
    SELECT 
        *
    FROM 
        job_postings_fact AS job
    WHERE 
        job_country = 'Indonesia' 
)

SELECT 
    company.company_id,
    company.name,
    COUNT(*)
FROM job_postings_indonesia
RIGHT JOIN company_dim AS company 
    ON job_postings_indonesia.company_id= company.company_id
GROUP BY company.company_id, company.name
ORDER BY count DESC;


-- 🔹 more compact query 
SELECT 
    company.company_id,
    company.name,
    COUNT(*)
FROM job_postings_fact AS job
RIGHT JOIN company_dim AS company 
    ON job.company_id= company.company_id
WHERE job_country = 'Indonesia' 
GROUP BY company.company_id, company.name
ORDER BY count DESC
LIMIT 10;
/*

Top Employers: Posloker, Grab, and Monroe Consulting Group have the most Data Analyst job openings in Indonesia.
Diverse Hiring Landscape: Companies range from tech firms (Grab, GO-JEK) to recruitment agencies (Michael Page, Monroe Consulting).
Finance & Consulting Demand: Firms like BFI Finance and Asian Technology Solutions actively seek Data Analysts, highlighting strong demand in finance and IT consulting.

[
  {
    "company_id": 359415,
    "name": "Posloker",
    "count": "30"
  },
  {
    "company_id": 15305,
    "name": "Grab",
    "count": "27"
  },
  {
    "company_id": 3607,
    "name": "Monroe Consulting Group",
    "count": "25"
  },
  {
    "company_id": 44929,
    "name": "Asian Technology Solutions",
    "count": "25"
  },
  {
    "company_id": 119434,
    "name": "PT BFI Finance Indonesia Tbk",
    "count": "23"
  },
  {
    "company_id": 28938,
    "name": "Accord Innovations",
    "count": "22"
  },
  {
    "company_id": 44637,
    "name": "Glints",
    "count": "22"
  },
  {
    "company_id": 72638,
    "name": "Diksha Teknologi Indonesia",
    "count": "19"
  },
  {
    "company_id": 18296,
    "name": "GO-JEK",
    "count": "19"
  },
  {
    "company_id": 692,
    "name": "Michael Page",
    "count": "18"
  }
]