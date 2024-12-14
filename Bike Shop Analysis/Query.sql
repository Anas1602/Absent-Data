-- TABLES
use bikeData
select * from dbo.bike_share_yr_0;
select * from dbo.bike_share_yr_1;
select * from dbo.cost_table;


with cte as (
		select * from dbo.bike_share_yr_0
		union
		select * from dbo.bike_share_yr_1
		)
select
	dteday,
	season,
	cte.yr,
	weekday,
	hr,
	rider_type,
	riders,
	price,
	COGS,
	riders * price as revenue,
	riders * price - COGS as profit
from cte
left join dbo.cost_table c
on cte.yr = c.yr