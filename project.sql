--table books

drop table if exists books;
create table books(
Book_ID	 int primary key,
Title varchar(100),
Author varchar(100),
Genre	varchar(100),
Published_Year integer,	
Price numeric,
Stock integer

);

--table customers

drop table if exists customer;
create table customer(
Customer_ID int primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(100),
City varchar(100),
Country varchar(100)
);

--table orders

drop table if exists orders;

create table orders(
Order_ID int primary key,
Customer_ID int not null references customer(Customer_ID ),
Book_ID int not null references books(Book_ID), 
Order_Date date,
Quantity int,
Total_Amount numeric

);
select*from books;
select*from customer;
select*from orders;

-- 1)Retrieve all books in the "Fiction" genre

select*from books 
where genre='Fiction';


-- 2)Find books published after the year 1950

select*from books 
where published_year>1950;



-- 3) List all customers from Canada
select*from customer
where Country='Canada';



-- 4) Show orders placed in November 2023

select*from orders 
where order_date between '2023-11-1' and '2023-11-30';




--  5) Retrieve the total stock of books available

select sum(stock) as total_books
from books;




-- 6)  Find the details of the most expensive book

select*from books order by price desc limit 1;




-- 7) Show all customers who ordered more than 1 quantity of a book
select *from orders
where quantity>=2;


select*from books;
select*from customer;
select*from orders;


-- 8) Retrieve all orders where the total amount exceeds $20

select *from orders
where total_amount>20;

-- 9) List all genres available in the Books table

select count(genre) as total_genre
from books;

select distinct genre from books;

--10) Find the book with the lowest stock
select  *from books order by stock asc  ;



-- 11) Calculate the total revenue generated from all orders

select sum(total_amount) as total_revenue
from orders;


-- advance querise


-- 1. Retrieve the total number of books sold for each genre
select genre , sum(quantity) from  orders
join books
on orders.book_id=books.book_id
group by genre;


-- 2. Find the average price of books in the "Fantasy" genre

select avg(price) as avg_price
from books
where genre='Fantasy';

-- 3. List customers who have placed at least 2 orders
select name  , quantity from  orders
join customer
on orders.customer_id=customer.customer_id
where quantity>=2;

select customer_id , count(order_id) as total_order
from orders
group by customer_id
having  count(order_id)>=2;

-- 4. Find the most frequently ordered book
select genre , sum(quantity)  as analysis 
from orders
join books
on orders.book_id=books.book_id
group by genre
order by analysis desc;


select book_id ,count(order_id) as order_book
from orders
group by book_id
order by order_book desc;



-- 5. Show the top 3 most expensive books of 'Fantasy' Genre

select genre, price as top_price
from books
where genre='Fantasy'
order by top_price desc limit 3;

select*from books
where genre='Fantasy'
order by price desc limit 3;


-- 6. Retrieve the total quantity of books sold by each author

select author, sum(quantity) as total_quantity
from orders
join books
on orders.book_id=books.book_id
group by author
order by total_quantity desc ;



-- 7. List the cities where customers who spent over $30 are located
select  distinct city, total_amount as spent_money
from orders
join customer
on orders.customer_id=customer.customer_id
where total_amount>30;

-- 8. Find the customer who spent the most on orders
select name, sum(total_amount) as total_money , sum(quantity) as spent_order
from orders
join customer
on orders.customer_id=customer.customer_id
group by name

order by total_money desc;


-- 9. Calculate the stock remaining after fulfilling all orders
select  title,author,genre,stock,quantity, sum(stock - quantity) as remaining_stock
from orders
join books
on orders.book_id=books.book_id
group by  title,author,genre,stock,quantity;



SELECT 
    b.book_id,
    b.title,
    b.stock,
    COALESCE(SUM(o.quantity),0) AS Order_quantity,
    b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o 
ON b.book_id = o.book_id
GROUP BY b.book_id;


select*from books;
select*from customer;
select*from orders;


