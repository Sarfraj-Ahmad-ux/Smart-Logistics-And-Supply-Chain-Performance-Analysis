


-- 1. How many total logistics records are present in the dataset, and how many unique assets are being tracked?
select 
    count(distinct timestamp) as Logistic_Records,
    count(distinct asset_id) as Unique_Assets
from
    logistics;
    

-- 2. What are the minimum, maximum, and average values of inventory level, asset utilization, and demand forecast?
select 
    min(inventory_level) as Minimum_Inventry_Level,
    min(asset_utilization) as Minimum_Asset_Utilization,
    min(demand_forecast) as Minimum_Demand_Forecast,
    max(inventory_level) as Maximum_Inventry_Level,
    max(asset_utilization) as Maximum_Asset_Utilization,
    max(demand_forecast) as Maximum_Demand_Forecast,
    avg(inventory_level) as Avg_Inventry_Level,
    avg(asset_utilization) as Avg_Asset_Utilization,
    avg(demand_forecast) as Avg_Demand_Forecast
from
    logistics;
    

-- 3. What percentage of the total logistics records experienced a logistics delay?
select 
    round((sum(case
                when logistics_delay = 1 then 1
                else 0
            end) * 100.0) / count(timestamp),
            2) as Logistics_Delay_Percentage
from
    logistics;
    

-- 4. What is the overall average asset utilization and average inventory level across all records?
select 
    avg(asset_utilization) as Avg_Asset_Utilization,
    avg(inventory_level) as Avg_Inventory_Level
from
    logistics;


-- 5. Which assets have the highest average asset utilization?
select 
    asset_id,
    round(avg(asset_utilization), 2) as Avg_Utilization_Percentage
from
    logistics
group by asset_id
order by Avg_Utilization_Percentage desc
limit 5;


-- 6. Which assets have the lowest average asset utilization?
select 
    asset_id,
    round(avg(asset_utilization), 2) as Avg_Utilization_Percentage
from
    logistics
group by asset_id
order by Avg_Utilization_Percentage asc
limit 5;


-- 7. Which assets have experienced the highest number of logistics delays?
select 
    asset_id,
    sum(case
        when logistics_delay = 1 then 1
        else 0
    end) as Logistic_Delays
from
    logistics
group by asset_id
order by Logistic_Delays desc;


-- 8. What is the average inventory level for each asset, and which assets have inventory levels below the overall average?
select
	asset_id,
	avg(inventory_level) as Avg_Inventory_Level,
	(select avg(inventory_level) from logistics) as Overall_Avg_Inventory_Level,
	case 
		when avg(Inventory_Level)< (select avg(inventory_level) from logistics)
		then 'Below_Average' 
		else 'Equal/Above_Average'
	end as Inventory_Status
from logistics
group by asset_id
order by asset_id asc;


-- 9. Which assets have both above-average utilization and above-average logistics delays?
with asset_avg as
		(select
			asset_id,
			avg(asset_utilization) as Avg_Asset_Utilization,
			avg(logistics_delay) as Avg_Logistics_Delay
			from logistics
			group by asset_id)
select
	asset_id,
    Avg_Asset_Utilization,
    Avg_Logistics_Delay
    from asset_avg
		where
			Avg_Asset_Utilization> (select avg(asset_utilization) from logistics)
		and
	        Avg_Logistics_Delay> (select avg(logistics_delay) from logistics);
    
	
-- 10. What is the average logistics delay rate for different inventory-level ranges?
select
	case 
		when inventory_level between 1 and 150 then 'Low_1-150'
		when inventory_level between 151 and 300 then 'Medium_151-300'
		else 'High_300+'
	 end as Inventory_Level_Category,
	 sum(logistics_delay)*100/count(asset_id) as Delay_Rate
from logistics
group by Inventory_Level_Category
order by Delay_Rate desc;
     

-- 11. Which records have low inventory levels but high demand forecasts, indicating potential stockout risk?
select
	timestamp,
    asset_id,
    inventory_level,
    demand_forecast
from logistics
where
	inventory_level< demand_forecast;


-- 12. Which assets have the highest average inventory levels?
select
	asset_id,
    avg(inventory_level) as Avg_Inventory_Level
from logistics
group by asset_id
order by Avg_Inventory_Level desc;


-- 13. What percentage of records fall into Low, Medium, and High inventory categories?
select
	count(timestamp)*100/1000 as Records_Percentage,
	case
		when inventory_level between 1 and 150 then 'Low_1-150'
        when inventory_level between 151 and 300 then 'Medium_151-300'
        else 'High_300+'
	 end as Inventory_Level_Category
from logistics
group by Inventory_Level_Category;     
     
	
-- 14. What is the average demand forecast for each month?
select
	month as Month_Order,
	month_name as Month_Name,
	avg(demand_forecast) as Avg_Demand_Forecast
from logistics
group by Month_Order,Month_Name
order by Month_Order asc;


-- 15. Which month has the highest average demand forecast?
select
	avg(demand_forecast) as Avg_Demand_Forecast,
    month_name as Month
from logistics
group by month_name
order by Avg_Demand_Forecast desc
limit 1;


-- 16. Which assets operate under the highest average demand forecast?
select 
	asset_id as Assets,
    avg(demand_forecast) as Avg_Demand_Forecast
from logistics
group by asset_id
order by Avg_Demand_Forecast desc
limit 1;


-- 17. How does logistics delay rate vary between low-, medium-, and high-demand forecast categories?
select
	sum(logistics_delay)*100/count(timestamp) as Logistics_Delay_Rate_Percentage,
    case
		when demand_forecast between 1 and 100 then 'Low_1-100'
        when demand_forecast between 101 and 200 then 'Medium_101-200'
        else 'High_200+'
	 end as Demand_Forcaste_Level
from logistics
group by case
		when demand_forecast between 1 and 100 then 'Low_1-100'
        when demand_forecast between 101 and 200 then 'Medium_101-200'
        else 'High_200+' end
order by Logistics_Delay_Rate_Percentage desc;


-- 18. How many records fall into each utilization category: Low, Medium, and High Utilization?
select
	count(timestamp) as Records,
	asset_utilization_category as Utilization_Category
from logistics
group by Utilization_Category;


-- 19. What is the average logistics delay rate for each asset utilization category?
select
	asset_utilization_category as Utilization_Category,
    round(avg(logistics_delay)*100/count(timestamp),3) as Logistic_Delay_Rate_Percentage
from logistics
group by Utilization_Category;


-- 20. Which assets have an average utilization above the overall fleet average?
with AvgSummary as
			(select
				asset_id as Asset_ID,
				avg(asset_utilization) as Avg_Asset_Utilization
			from logistics
			group by Asset_ID)
select
	Asset_ID,
    Avg_Asset_Utilization
from AvgSummary
where
	Avg_Asset_Utilization>(select avg(asset_utilization) from logistics);


-- 21. Which month has the highest number of logistics delays?
select
	month_name as Month_Name,
	sum(logistics_delay) as Total_Logistics_Delays
from logistics
group by month_name
order by Total_Logistics_Delays desc
limit 1;

    
-- 22. Which day of the week has the highest logistics delay rate?
select 
	day_of_week as Day,
	sum(logistics_delay)*100/count(timestamp) as Logistics_Delay_Rate
from logistics
group by day_of_week
order by Logistics_Delay_Rate desc
limit 1;


-- 23. During which hours of the day do logistics delays occur most frequently?
select
	hour as Hour,
    sum(logistics_delay) as Total_Logistics_Delays
from logistics
group by hour
order by Total_Logistics_Delays desc;


-- 24. How does average asset utilization change month by month?
select
	month as Month_Order,
	month_name as Month_Name,
    round(avg(asset_utilization),2) as Avg_Asset_Utilization
from logistics
group by Month_Order, month_name
order by Month_Order;


-- 25. How do assets rank based on average utilization, inventory level, and logistics delay rate?
select
	asset_id as Asset_ID,
    avg(asset_utilization) as Avg_Asset_Utilization_Rate,
    sum(inventory_level) as Inventory_Level,
    sum(logistics_delay)*100/count(logistics_delay) as Delay_Rate,
rank() over(
		order by
			 avg(asset_utilization) desc,
             sum(inventory_level) desc,
           sum(logistics_delay)*100/count(logistics_delay) asc
             )
as Performance_Rank
from logistics
group by asset_id
order by Performance_Rank asc;



                    
					 
                    

