/* Top-Demanded Skills for Data Analyst
Question to answer: What are the most skills are required for data analyst jobs?
Objective: helping data analyst job seekers understand which skills to develop that align with demand in job market

What to Analyze: 
- Identify the top 5 in demand skills for a data analyst

*/

   
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
Insights on the Top 10 Most In-Demand Data Analyst Skills (Latest Data)
1️⃣ **SQL (92,628 job postings) → Still the #1 Skill
SQL remains the most in-demand skill for data analysts, proving that database querying and management are fundamental in this field.
No significant change in demand, meaning SQL is a must-have skill for any data analyst.

2️⃣ **Excel (67,031 job postings) → Excel’s Relevance Stays Strong
Despite the rise of programming languages, Excel remains a staple for quick data analysis, reporting, and financial modeling.
Companies still rely heavily on Excel, making it the second most sought-after skill.

3️⃣ **Python (57,326 job postings) → Essential for Automation & Data Processing
Python maintains a strong position, highlighting its importance for data manipulation, automation, and advanced analytics.
Still behind Excel, meaning not all analyst roles require coding, but it’s becoming increasingly important.

4️⃣ **Tableau (46,554 job postings) → Leading in Data Visualization
Tableau remains the top visualization tool, reinforcing the demand for interactive dashboards and visual analytics.
Companies continue to prioritize BI tools, making Tableau a must-have for data storytelling.

5️⃣ **Power BI (39,468 job postings) → A Strong Competitor to Tableau
Power BI’s demand remains high, especially in organizations that use the Microsoft ecosystem.
Demand for both Tableau & Power BI suggests that visualization skills are critical for analysts.

6️⃣ **R (30,075 job postings) → Still Relevant in Statistical & Research Roles
While Python is more dominant, R remains crucial in finance, healthcare, and academia for statistical computing.
Niche but still valuable for roles requiring deep statistical analysis.

7️⃣ **SAS (28,068 job postings) → Used in Legacy & Regulated Industries
SAS holds a market share, especially in industries like banking and pharmaceuticals where legacy systems and compliance matter.
Less popular than open-source tools, but still valuable for specific industries.

8️⃣ **PowerPoint (13,848 job postings) → Storytelling with Data is Essential
The fact that PowerPoint ranks above coding tools like R and SAS suggests that communicating insights effectively is just as important as analyzing data.
Strong presentation skills remain a key differentiator for analysts.

9️⃣ **Word (13,591 job postings) → Reporting & Documentation Still Matter
Similar to PowerPoint, Word’s presence highlights that written communication and documentation are crucial for analysts.
Reports, methodologies, and insights must be well-documented for business decision-making.

🔟 **SAP (11,297 job postings) → ERP Analytics is Still in Demand
SAP skills indicate a demand for analysts working with enterprise data systems.
Mostly required in large organizations managing financial, supply chain, and operational data.

[
  {
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skills": "power bi",
    "demand_count": "39468"
  },
  {
    "skills": "r",
    "demand_count": "30075"
  },
  {
    "skills": "sas",
    "demand_count": "28068"
  },
  {
    "skills": "powerpoint",
    "demand_count": "13848"
  },
  {
    "skills": "word",
    "demand_count": "13591"
  },
  {
    "skills": "sap",
    "demand_count": "11297"
  }
]
*/
