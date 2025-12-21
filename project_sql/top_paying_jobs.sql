-- Retrieve the top 10 highest-paying remote Data Analyst job postings and their associated companies


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
 limit 10
 
-- This query retrieves the top 10 highest-paying remote Data Analyst job postings with available annual salary data. 
-- It filters job listings to remote Data Analyst roles, excludes records without salary information, and joins company details to associate each role with its employer. 
-- Results are ranked by average yearly salary in descending order, producing a focused view of the highest-compensation remote Data Analyst opportunities.