

 create database Bikestores
 use Bikestores

--Execute create Bikestores date file

--Execute load Bikestores date file


--1. Get the brand_id, category_id, product_id for the products with list_price > 4500 for year 2016,2017.
   
    Select brand_id, category_id, product_id from production.products where list_price > 4500 and model_year in (2016,2017)


--2. Get the net sales of those orders which were shipped without any delay.,

	select SUM(sales.order_items.quantity*sales.order_items.list_price
	*(1-sales.order_items.discount)) from sales.order_items inner join sales.orders
	on sales.order_items.order_id = sales.orders.order_id
	where DATEDIFF(day,sales.orders.required_date,sales.orders.shipped_date)<=0


--3. Get those products and the information of store where quantity <=10.

	select pr.product_name,pst.product_id,pst.quantity,st.store_id,st.store_name,
	st.city,st.state from production.products pr inner join production.stocks pst
	on pr.product_id = pst.product_id inner join sales.stores st on
	st.store_id = pst.store_id where pst.quantity <=10


--4. Get the total quantity of the products by each store.

	select production.stocks.store_id,SUM(production.stocks.quantity) total_qty,
	sales.stores.store_name from sales.stores inner join production.stocks
	on sales.stores.store_id = production.stocks.store_id
	group by production.stocks.store_id,sales.stores.store_name


--5. How many stores are managed by each manager.

	select manager_id,COUNT(store_id) from sales.staffs group by manager_id
	having manager_id is not NULL


--6. Get the full name of the staff from whose store order get delayed.

	select distinct concat_ws(' ',sales.staffs.first_name,sales.staffs.last_name)
	--DATEDIFF(day,sales.orders.required_date,sales.orders.shipped_date)
	from sales.orders inner join sales.staffs on sales.orders.staff_id = 
	sales.staffs.staff_id where DATEDIFF(day,sales.orders.required_date,sales.orders.shipped_date)<=1


--7. Give me the list of the products which are having list price more than average list price.

	select product_name,product_id from production.products
	where list_price >(select AVG(list_price) from production.products)


--8. Get the top 20 percent of the products by list_price

	select top 20 percent production.products.product_name,list_price
	from production.products order by list_price desc


--9. Give me the name of the products which are sold out.

	select production.products.product_name, production.stocks.quantity
	from production.products inner join production.stocks
	on production.products.product_id = production.stocks.product_id
	where quantity = 0


--10. Get all the details of those stores which are active.

	select distinct sales.stores.store_id,sales.stores.store_name from sales.stores inner join 
	sales.staffs on sales.stores.store_id =sales.staffs.store_id
    where sales.staffs.active = 1
