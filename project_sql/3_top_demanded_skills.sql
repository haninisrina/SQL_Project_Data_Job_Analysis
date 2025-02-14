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
WHERE job_title_short = 'Data Analyst' AND  job_location= 'Anywhere'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/* 
Insights on the Top 10 Most In-Demand Data Analyst Skills (Latest Data)
📌SQL (7,291 job postings) → Still the #1 SkillSQL remains the most in-demand skill for data analysts, proving that database querying and management are fundamental in this field.Although demand has decreased compared to previous data, SQL remains a must-have skill for any data analyst.

📌 Excel (4,611 job postings) → Excel’s Relevance ContinuesDespite the rise of programming languages, Excel remains crucial for quick data analysis, reporting, and financial modeling.Companies still rely heavily on Excel, solidifying its place as a top skill for data analysts.

📌Python (4,330 job postings) → Essential for Automation & Data ProcessingPython maintains a strong position, highlighting its importance for data manipulation, automation, and advanced analytics.Its demand is close to Excel, reinforcing its growing necessity in the field.

📌 Tableau (3,745 job postings) → Leading in Data VisualizationTableau remains the top visualization tool, emphasizing the continued need for interactive dashboards and visual analytics.Companies continue to prioritize BI tools, making Tableau a must-have for data storytelling.

📌Power BI (2,609 job postings) → A Strong Competitor to TableauPower BI maintains high demand, especially in organizations using Microsoft’s ecosystem.The demand for both Tableau & Power BI suggests that visualization skills are essential for analysts.

[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]