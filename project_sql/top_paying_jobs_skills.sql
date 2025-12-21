-- Identify the most in-demand skills required for the highest-paying remote Data Analyst roles

with top_paying_jobs AS (
    SELECT
salary_year_avg as salary,
job_id,
job_title_short,
company_dim.name

 FROM job_postings_fact
 LEFT JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
 where job_title_short like '%Data%Analyst%'
 AND salary_year_avg is not null
 and job_work_from_home = TRUE
 order by salary DESC 
 limit 10)
 SELECT
  count(skills_dim.skills) as skill_count,
  skills_dim.skills

  from top_paying_jobs
  INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
  GROUP BY skills_dim.skills
  ORDER BY skill_count DESC 
  /*
-- This query analyzes the skill requirements of the highest-paying remote Data Analyst roles. 
-- It first isolates the top 10 remote Data Analyst job postings with valid annual salary data, ranked by average yearly compensation. 
-- These roles are then joined to their associated skills through a junction table, allowing skill frequency to be aggregated across top-paying positions.
-- The final output highlights which technical skills are most commonly required among high-compensation remote Data Analyst roles, providing insight into the skill sets most strongly associated with top-tier salaries.
*/
