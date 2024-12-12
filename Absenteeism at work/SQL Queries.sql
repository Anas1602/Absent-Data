-- TABLES
use Work
select * from dbo.Absenteeism_at_work;
select * from dbo.Reasons;
select * from compensation;

-- CREATE A JOIN TABLE
select * from dbo.Absenteeism_at_work a
left join dbo.compensation c
on a.ID = c.ID
left join dbo.Reasons r
on a.Reason_for_absence = r.Number

-- Find The Healthiest Employees for the Bonus
select 
	*
from dbo.Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25
and Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from dbo.Absenteeism_at_work)

-- Compensation rate increase for non smokers / budget 983,221 so .68 increase per hour / $1414.4 per year
select COUNT(*) as nonSmokers from dbo.Absenteeism_at_work
where Social_smoker = 0

-- Query Optimization
select 
	a.ID,
	r.Reason,
	Month_of_absence,
	Body_mass_index,
	case 
		when Body_mass_index < 18.5 then 'Underweight'
		when Body_mass_index between 18.5 and 25 then 'Healthy Weight'
		when Body_mass_index between 25 and 30 then 'Overweight'
		when Body_mass_index > 30 then 'Obese'
		else 'Unknown'
	end as BMI_category,
	case
		when Month_of_absence in (12, 1, 2) then 'Winter'
		when Month_of_absence in (3, 4, 5) then 'Spring'
		when Month_of_absence in (6, 7, 8) then 'Summer'
		when Month_of_absence in (9, 10, 11) then 'Fall'
		Else 'Unknown'
	end as seasonsNames,
	Month_of_absence,
	Day_of_the_week,
	Transportation_expense,
	Education,
	Son,
	Social_drinker,
	Social_smoker,
	Pet,
	Disciplinary_failure,
	Age,
	Work_load_Average_day,
	Absenteeism_time_in_hours
from dbo.Absenteeism_at_work a
left join dbo.compensation c
on a.ID = c.ID
left join dbo.Reasons r
on a.Reason_for_absence = r.Number

