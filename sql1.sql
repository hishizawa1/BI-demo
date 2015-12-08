use AdventureWorks2012; /*Set current database*/

select OrderDate
from Sales.SalesOrderHeader

/*Display the total amount collected from the orders for each order date.*/
select OrderDate, sum(TotalDue) as DailyAmount, COUNT(SalesOrderID)
from sales.SalesOrderHeader
group by OrderDate
order by sum(TotalDue);  /*sum(Totaldue)*/

/*Display the total amount collected after selling the products, 774 and 777.*/
select ProductID, 
	sum(LineTotal) as Total_Amount, 
	avg(UnitPrice) as Average_Unit_Price, 
	MAX(UnitPrice) as Max_Unit_Price, 
	MIN(UnitPrice) as Min_Unit_Price, 
	SUM(OrderQty) as Total_Number_of_Units
from Sales.SalesOrderDetail
where ProductID=774 or ProductID=777 /*We can also use "Product IN (774, 777)"*/
group by ProductID;

/*Write a query to display the sales person BusinessEntityID and last name and first name of all the sales persons and the name of the territory to which they belong.*/
select p.BusinessEntityID, t.Name as Territory_Name, pp.Lastname, pp.Firstname
from Sales.SalesPerson as p join Sales.SalesTerritory as t
	on p.TerritoryID = t.TerritoryID
	join Person.Person as pp
	on p.BusinessEntityID = pp.BusinessEntityID;

/*Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
select pc.BusinessEntityID, p.FirstName, p.LastName, c.CardType
from Sales.PersonCreditCard as pc join Sales.CreditCard as c 
	on pc.CreditCardID = c.CreditCardID
	 join Person.Person as p
	on pc.BusinessEntityID = p.BusinessEntityID
where CardType ='Vista'

/*Write a query to display all the country region codes along with their corresponding territory IDs.*/
select c.CountryRegionCode, t.TerritoryID
from Sales.CountryRegionCurrency as c left outer join Sales.Salesterritory as t
on c.CountryRegionCode=t.CountryRegionCode;

/*Find out the average of the total dues of all the orders.*/
select AVG(TotalDue)
from Sales.SalesOrderHeader

/*Write a query to report the sales order ID of those orders where the total value is greater than the average of the total value of all the orders.*/
select SalesOrderID, TotalDue
from Sales.SalesOrderHeader
where TotalDue >  (select AVG(TotalDue)
from Sales.SalesOrderHeader)