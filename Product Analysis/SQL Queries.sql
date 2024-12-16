-- Tables

use productSales;
select * from Product_data;
select * from product_sales;
select * from discount_data;

-- Query

with productSales as (
			select 
				d.Product,
				d.Category,
				d.Brand,
				d.Description,
				d.Sale_Price,
				d.Cost_Price,
				d.Image_url,
				s.Customer_Type,
				s.Discount_Band,
				s.Units_Sold,
				Sale_Price * Units_Sold as Revenue,
				(Cost_Price * Units_Sold) as totalCost,
				FORMAT(Date, 'MMMM') as Month,
				FORMAT(Date, 'yyyy') as Year
			from Product_data d
			join product_sales s
			on d.Product_ID = s.Product)

select 
	*,
	(1 - (Discount * 1.0 / 100)) * Revenue as discountRevenue
from productSales s
join discount_data d
on s.Discount_Band = d.Discount_Band and s.Month = d.Month
