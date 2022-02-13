# PRACTICAL 4

# Name: Munzhelele Tshimangadzo

# Student Number: u18142274

library(sqldf)
library(stringr)
library(readr)
library(RH2)
library(lubridate)
library(rJava)
library(RJDBC)

orion_customer <- read_csv("orion_customer.csv") 
orion_product_dim <- read_csv("orion_product_dim.csv") 
orion_order_fact <- read_csv("orion_order_fact.csv") 
orion_sales <- read_csv("orion_sales.csv") 
orion_employee_addresses <- read_csv("orion_employee_addresses.csv") 


ultimate_employee <- read_csv("ultimate_employee.csv")
ultimate_flat_unit <- read_csv("ultimate_flat_unit.csv")
ultimate_building <- read_csv("ultimate_building.csv")
ultimate_suburb <- read_csv("ultimate_suburb.csv")
ultimate_city <- read_csv("ultimate_city.csv")

#QUESTION 1
Q1 <- sqldf("SELECT a.Product_ID, a.Product_Name, COUNT(b.Quantity_Ordered) AS COUNT
                      FROM orion_product_dim AS a
                      INNER JOIN orion_order_fact AS b
                      ON a.Product_ID = b.Product_ID
                      WHERE year(Order_Delivered) >= '2011' AND YEAR(Order_Delivered) <= '2012'
                      GROUP BY Quantity_Ordered, Product_Name")


#QUESTION 2
Q2 <- sqldf("SELECT b.Employee_Name , b.City, a.Job_Title
            FROM orion_sales AS a
            LEFT JOIN orion_employee_addresses AS b
            ON a.Employee_ID = b.Employee_ID
            WHERE a.Gender = 'F' AND a.Job_Title LIKE '%Sales%'
            ORDER BY City, Job_Title, Employee_Name")


#QUESTION 3
Q3 <- sqldf("SELECT b.Product_ID, b.Product_Name, a.Quantity_Ordered
       FROM orion_order_fact AS a
       LEFT JOIN orion_product_dim AS b
       ON b.Product_ID = a.Product_ID")
#WHERE Quantity_Ordered = 0


#QUESTION 4
Q4 <- sqldf("SELECT  Customer_Name, COUNT(Quantity_Ordered) AS Count
            FROM orion_product_dim AS a
            LEFT JOIN orion_order_fact AS b
            LEFT JOIN orion_customer AS c
            WHERE a.Product_ID = b.Product_ID
            AND b.Customer_ID = c.Customer_ID
            AND Employee_ID = 99999999 AND a.Supplier_Country != Customer_Country
            AND Customer_Country = 'US' OR Customer_Country = 'AU'
            GROUP BY Customer_Name
            ORDER BY Count DESC, Customer_Name")


#QUESTION 5
Q5 <- sqldf("SELECT Emp_Name, Emp_Email, Sub_Name, City_Name
            FROM ultimate_employee AS a
            INNER JOIN ultimate_suburb AS b
            ON a.Sub_ID = b.Sub_ID
            INNER JOIN ultimate_city AS c
            ON a.City_ID = c.City_ID
            WHERE Emp_Email LIKE '%ymail%' OR Emp_Email LIKE '%shaimail%'")


#QUESTION 6
Q6 <- sqldf("SELECT Flat_Unit_Number, Bld_Name, Sub_Name, City_Name
            FROM ultimate_flat_unit AS a
            INNER JOIN ultimate_building AS b
            ON a.City_ID = b.City_ID
            INNER JOIN ultimate_suburb AS c
            ON a.Sub_ID = c.Sub_ID
            INNER JOIN ultimate_city AS d
            ON a.City_ID = d.City_ID")

