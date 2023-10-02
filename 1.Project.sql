create database if not exists heart;
use heart;

/* To view the dataset - 8763 Records */
select * from heart_attack_prediction_dataset;

/*To view the datas where there is a risk of Heart Attack - 3139 RECORDS*/
select * 
from heart_attack_prediction_dataset
where `Heart Attack Risk` = 1;

select round(((3139/8763)*100)) as Percentage_Affected;

/*To check  the affected no of males and females*/
select sum(if(sex= "Male",1,0)) as Males, sum(if(sex= "Female",1,0)) as Females
from heart_attack_prediction_dataset
where `Heart Attack Risk` = 1;

/*To view the data and list the most affected continent*/
select Continent,count(continent)
from heart_attack_prediction_dataset
where `Heart Attack Risk` = 1 
group by 1
ORDER BY 2 DESC;
/*To view the data and list the most affected continent along with no of affected males and females*/
select Continent,count(case when Sex ="Male" then 1 end) as Males, count(case when Sex ="Female" then 1 end) as Females, count(sex) as Total
from heart_attack_prediction_dataset
where `Heart Attack Risk` = 1 
group by 1
order by 4 desc;

/* DEALING WITH ASIA*/

/*THE ONE WHO SMOKES ARE MORE LIKELY TO GET AFFECTED*/
select Smoking,count(*)
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
group by 1
order by 1 desc;

/*THE ONE WITH DIABETES ARE MORE LIKELY TO GET AFFECTED*/

select Diabetes,count(*),ROUND((COUNT(*)/900)*100) AS Percentage_Affected
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
group by 1;

/* No of Males and Females affected with Diabetes and are prone to Heart Attack*/

select Diabetes,Sex,COUNT(SEX) AS Affected_Persons
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1 AND Diabetes = 1
GROUP BY 2;
/*ANALYSING RECORDS OF SMOKING & DIABETES*/
select Smoking,count(Smoking),Diabetes,count(Diabetes)
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
group by 1,3
order by 1,3;
/*ANALYSING RECORDS OF ALCOHOL CONSUMPTION, SMOKING & DIABETES*/
SELECT `Alcohol Consumption`, COUNT(`Alcohol Consumption`), Smoking, COUNT(Smoking), Diabetes, COUNT(Diabetes)
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
GROUP BY 1,3,5
ORDER BY 1 DESC;
/*ANALYSING RECORDS OF DIET*/
SELECT  Diet,count(*)
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
group by 1;
/*FURTHER ANALYSIS ON DIET*/
SELECT  Diet,count(*), `Alcohol Consumption`, COUNT(`Alcohol Consumption`), Smoking, COUNT(Smoking), Diabetes, COUNT(Diabetes)
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
group by 1,3,5,7
order by 1;
/*OTHER FACTORS*/
WITH a as
(
SELECT *
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
)
SELECT Obesity,count(*)
FROM a
group by 1
order by 1;
WITH a as
(
SELECT *
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
)
SELECT `Family History`,count(*)
FROM a
group by 1
order by 1;
WITH a as
(
SELECT *
from heart_attack_prediction_dataset
where Continent = "Asia" and `Heart Attack Risk` = 1
)
SELECT `Previous Heart Problems`,count(*),`Alcohol Consumption`, COUNT(`Alcohol Consumption`), Smoking, COUNT(Smoking), Diabetes, COUNT(Diabetes)
FROM a
group by 1,3,5,7
order by 1;