/*
Growth of Data-Related Job Roles in Indonesia (2023)

❓ Question to Answer:
How has the demand for data-related job roles in Indonesia changed throughout 2023?

📊 What to Analyze:
- Quarterly growth trends of key data-related roles.
- Seasonal hiring patterns for data-related jobs.
- Differences in hiring trends between emerging and established roles.
- The demand for junior vs. senior roles.

🎯 Objective:
Provide insights into the demand trends for data-related roles in Indonesia to help job seekers make informed career decisions. Understanding hiring trends allows professionals to identify in-demand skills and employers to align recruitment strategies accordingly.
*/

*/
-- 🔹 Identifying the Most Demanded Data-Related Jobs in Indonesia
SELECT 
    job_title,
    job_title_short,
    COUNT(*)
FROM job_postings_fact AS job
WHERE job_country = 'Indonesia' 
GROUP BY job_title_short, job_title
ORDER BY count DESC

-- 🔹 Growth Analysis: Quarterly Job Posting Trends
WITH job_postings_indonesia AS (
    SELECT 
        job_title_short, 
        EXTRACT(QUARTER FROM job_posted_date::DATE) AS quarter, 
        COUNT(*) AS job_count
    FROM 
        job_postings_fact AS job
    WHERE 
        job_country = 'Indonesia' 
    GROUP BY quarter, job_title_short
),
growth_calculation AS (
    SELECT 
        job_title_short, 
        quarter, 
        job_count,
        LAG(job_count) OVER (PARTITION BY job_title_short ORDER BY quarter) AS prev_quarter_count,
        ROUND(
            100.0 * (job_count - LAG(job_count) OVER (PARTITION BY job_title_short ORDER BY quarter)) 
            / NULLIF(LAG(job_count) OVER (PARTITION BY job_title_short ORDER BY quarter), 0),
            2
        ) AS growth_percentage
    FROM job_postings_indonesia
)

SELECT * FROM growth_calculation;

/*
🔍 Key Findings:

📌 Growth Rate of Job Postings Per Role
- **Data Analyst** grew **152.27%** from Q3 (88) to Q4 (222).
- **Software Engineer** saw a **293.18%** increase from Q3 (44) to Q4 (173).
- **Data Engineer** rose by **52.44%** from Q3 (225) to Q4 (343).
- **Cloud Engineer** had the highest percentage growth (**285.71%**), from Q3 (14) to Q4 (54).

📌 Seasonal Hiring Patterns
- **Q4 consistently shows the highest hiring spike** across most roles.
- **Q2 tends to have the lowest number of postings**.

📌 Emerging vs. Established Roles
- **High-demand roles**: Data Engineer, Data Scientist, and Data Analyst show **stable demand**.
- **Emerging roles**: Machine Learning Engineer and Cloud Engineer have **lower job postings** but show **sharp growth in Q4**, suggesting they are gaining traction.

📌 Junior vs. Senior Role Growth
- **Junior and mid-level roles** see much faster growth than Senior Data Analyst, Senior Data Engineer, and Senior Data Scientist roles.
- This suggests companies are prioritizing **hiring entry-level and mid-level talent** rather than focusing on experienced professionals.

[
  {
    "job_title_short": "Business Analyst",
    "quarter": "1",
    "job_count": "29",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Business Analyst",
    "quarter": "2",
    "job_count": "28",
    "prev_quarter_count": "29",
    "growth_percentage": "-3.45"
  },
  {
    "job_title_short": "Business Analyst",
    "quarter": "3",
    "job_count": "26",
    "prev_quarter_count": "28",
    "growth_percentage": "-7.14"
  },
  {
    "job_title_short": "Business Analyst",
    "quarter": "4",
    "job_count": "32",
    "prev_quarter_count": "26",
    "growth_percentage": "23.08"
  },
  {
    "job_title_short": "Cloud Engineer",
    "quarter": "1",
    "job_count": "17",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Cloud Engineer",
    "quarter": "2",
    "job_count": "16",
    "prev_quarter_count": "17",
    "growth_percentage": "-5.88"
  },
  {
    "job_title_short": "Cloud Engineer",
    "quarter": "3",
    "job_count": "14",
    "prev_quarter_count": "16",
    "growth_percentage": "-12.50"
  },
  {
    "job_title_short": "Cloud Engineer",
    "quarter": "4",
    "job_count": "54",
    "prev_quarter_count": "14",
    "growth_percentage": "285.71"
  },
  {
    "job_title_short": "Data Analyst",
    "quarter": "1",
    "job_count": "81",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Data Analyst",
    "quarter": "2",
    "job_count": "70",
    "prev_quarter_count": "81",
    "growth_percentage": "-13.58"
  },
  {
    "job_title_short": "Data Analyst",
    "quarter": "3",
    "job_count": "88",
    "prev_quarter_count": "70",
    "growth_percentage": "25.71"
  },
  {
    "job_title_short": "Data Analyst",
    "quarter": "4",
    "job_count": "222",
    "prev_quarter_count": "88",
    "growth_percentage": "152.27"
  },
  {
    "job_title_short": "Data Engineer",
    "quarter": "1",
    "job_count": "285",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Data Engineer",
    "quarter": "2",
    "job_count": "192",
    "prev_quarter_count": "285",
    "growth_percentage": "-32.63"
  },
  {
    "job_title_short": "Data Engineer",
    "quarter": "3",
    "job_count": "225",
    "prev_quarter_count": "192",
    "growth_percentage": "17.19"
  },
  {
    "job_title_short": "Data Engineer",
    "quarter": "4",
    "job_count": "343",
    "prev_quarter_count": "225",
    "growth_percentage": "52.44"
  },
  {
    "job_title_short": "Data Scientist",
    "quarter": "1",
    "job_count": "165",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Data Scientist",
    "quarter": "2",
    "job_count": "93",
    "prev_quarter_count": "165",
    "growth_percentage": "-43.64"
  },
  {
    "job_title_short": "Data Scientist",
    "quarter": "3",
    "job_count": "142",
    "prev_quarter_count": "93",
    "growth_percentage": "52.69"
  },
  {
    "job_title_short": "Data Scientist",
    "quarter": "4",
    "job_count": "250",
    "prev_quarter_count": "142",
    "growth_percentage": "76.06"
  },
  {
    "job_title_short": "Machine Learning Engineer",
    "quarter": "1",
    "job_count": "14",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Machine Learning Engineer",
    "quarter": "2",
    "job_count": "9",
    "prev_quarter_count": "14",
    "growth_percentage": "-35.71"
  },
  {
    "job_title_short": "Machine Learning Engineer",
    "quarter": "3",
    "job_count": "17",
    "prev_quarter_count": "9",
    "growth_percentage": "88.89"
  },
  {
    "job_title_short": "Machine Learning Engineer",
    "quarter": "4",
    "job_count": "26",
    "prev_quarter_count": "17",
    "growth_percentage": "52.94"
  },
  {
    "job_title_short": "Senior Data Analyst",
    "quarter": "1",
    "job_count": "10",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Senior Data Analyst",
    "quarter": "2",
    "job_count": "4",
    "prev_quarter_count": "10",
    "growth_percentage": "-60.00"
  },
  {
    "job_title_short": "Senior Data Analyst",
    "quarter": "3",
    "job_count": "13",
    "prev_quarter_count": "4",
    "growth_percentage": "225.00"
  },
  {
    "job_title_short": "Senior Data Analyst",
    "quarter": "4",
    "job_count": "25",
    "prev_quarter_count": "13",
    "growth_percentage": "92.31"
  },
  {
    "job_title_short": "Senior Data Engineer",
    "quarter": "1",
    "job_count": "35",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Senior Data Engineer",
    "quarter": "2",
    "job_count": "26",
    "prev_quarter_count": "35",
    "growth_percentage": "-25.71"
  },
  {
    "job_title_short": "Senior Data Engineer",
    "quarter": "3",
    "job_count": "26",
    "prev_quarter_count": "26",
    "growth_percentage": "0.00"
  },
  {
    "job_title_short": "Senior Data Engineer",
    "quarter": "4",
    "job_count": "32",
    "prev_quarter_count": "26",
    "growth_percentage": "23.08"
  },
  {
    "job_title_short": "Senior Data Scientist",
    "quarter": "1",
    "job_count": "30",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Senior Data Scientist",
    "quarter": "2",
    "job_count": "27",
    "prev_quarter_count": "30",
    "growth_percentage": "-10.00"
  },
  {
    "job_title_short": "Senior Data Scientist",
    "quarter": "3",
    "job_count": "16",
    "prev_quarter_count": "27",
    "growth_percentage": "-40.74"
  },
  {
    "job_title_short": "Senior Data Scientist",
    "quarter": "4",
    "job_count": "38",
    "prev_quarter_count": "16",
    "growth_percentage": "137.50"
  },
  {
    "job_title_short": "Software Engineer",
    "quarter": "1",
    "job_count": "47",
    "prev_quarter_count": null,
    "growth_percentage": null
  },
  {
    "job_title_short": "Software Engineer",
    "quarter": "2",
    "job_count": "25",
    "prev_quarter_count": "47",
    "growth_percentage": "-46.81"
  },
  {
    "job_title_short": "Software Engineer",
    "quarter": "3",
    "job_count": "44",
    "prev_quarter_count": "25",
    "growth_percentage": "76.00"
  },
  {
    "job_title_short": "Software Engineer",
    "quarter": "4",
    "job_count": "173",
    "prev_quarter_count": "44",
    "growth_percentage": "293.18"
  }
]

📌 Next Steps:
- Compare hiring trends across multiple years to confirm seasonal patterns.
- Analyze required skills per role to identify in-demand qualifications.
- Investigate industry sectors that drive demand for data-related roles.

*/