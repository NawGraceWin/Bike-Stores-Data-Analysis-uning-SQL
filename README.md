## BikeStores Database Analysis Using SQL

 ### Project Title:
    BikeStores Database Analysis Using SQL

 ### Objectives:
     - Analyze sales performance across stores and products.
     - Understand customer demographics and purchasing patterns.
     - Assess inventory levels and turnover rates.
     
 ### Methodology:
   - Data Source: BikeStores database with tables for stores, customers, products, sales, and inventory.
   - Tools: SQL (MySQL)

### Key SQL Queries:

#### 1. products which are sold out

              select production.products.product_name, production.stocks.quantity
	      from production.products inner join production.stocks
	      on production.products.product_id = production.stocks.product_id
	      where quantity = 0

#### 2. Name of the staff from whose store order get delayed

	      select distinct concat_ws(' ',sales.staffs.first_name,sales.staffs.last_name)
	      from sales.orders inner join sales.staffs on sales.orders.staff_id = 
	      sales.staffs.staff_id 
              where DATEDIFF(day,sales.orders.required_date,sales.orders.shipped_date)<=1

#### 3. Products and the information of store where quantity <=10

              select pr.product_name,pst.product_id,pst.quantity,st.store_id,st.store_name,
	      st.city,st.state from production.products pr inner join production.stocks pst
	      on pr.product_id = pst.product_id inner join sales.stores st on
	      st.store_id = pst.store_id where pst.quantity <=10

#### 4. total quantity of the products by each store

              select production.stocks.store_id,SUM(production.stocks.quantity) total_qty,
	      sales.stores.store_name from sales.stores inner join production.stocks
	      on sales.stores.store_id = production.stocks.store_id
	      group by production.stocks.store_id,sales.stores.store_name

#### 5. stores which are active

              select distinct sales.stores.store_id,sales.stores.store_name from sales.stores inner join 
	      sales.staffs on sales.stores.store_id =sales.staffs.store_id
              where sales.staffs.active = 1

        
### Results and Insights:
     - Identified product sold out.
     - Analyzed staff from whose store order get delayed
     - Listed Products where quantity <=10
     - Analyzed Products Stock

### Recommendations:

    -Develop targeted sales strategies for underperforming stores.
    -Promote top-selling products and manage inventory effectively.
    -Tailor marketing strategies based on customer demographics.
    -Plan seasonal promotions to boost sales during low-performing months
    

This summary provides a concise overview of the BikeStores database analysis project using SQL, outlining objectives, key queries, results, and actionable recommendations
     







