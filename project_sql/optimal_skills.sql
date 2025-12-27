
--Analyse Data Analyst job postings to identify the most in-demand skills associated with above-average-paying remote roles.

with top_paying_jobs AS 
(select
 * 
 from 
 job_postings_fact 
 where job_title_short LIKE '%Data%Analyst%' and salary_year_avg is not null
 and salary_year_avg > (SELECT AVG(salary_year_avg)

 FROM job_postings_fact
 where job_title_short LIKE '%Data%Analyst%'
 and salary_year_avg is not null))
SELECT 
skills_job_dim.skill_id,
skills_dim.skills,
count(skills_job_dim.skill_id) as skill_count
from 
top_paying_jobs

INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where top_paying_jobs.job_work_from_home = TRUE

GROUP BY skills_job_dim.skill_id, skills_dim.skills

order by skill_count DESC
LIMIT 10

--This query filters Data Analyst job postings to those with non-null salaries that pay above the average for the role, establishing a relative definition of high-paying positions.
-- It then joins skill mapping tables to associate each job with its required skills and restricts results to remote roles only.
-- Finally, it aggregates and ranks skills by frequency to identify the most in-demand skills among higher-paying remote Data Analyst positions.