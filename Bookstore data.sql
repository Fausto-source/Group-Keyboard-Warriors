-- creating database Bookstore
create database Bookstore;

-- Selecting the database to use
use Bookstore;

-- Creating table for book language
CREATE TABLE book_language (
    id INT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

INSERT INTO book_language (id, language_name) VALUES
(1, 'English'),
(2, 'French'),
(3, 'Spanish'),
(4, 'German');

-- Creating table for publisher
CREATE TABLE publisher (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

INSERT INTO publisher (id, name, country) VALUES
(1, 'Penguin Random House', 'USA'),
(2, 'HarperCollins', 'UK'),
(3, 'Hachette Livre', 'France'),
(4, 'Macmillan Publishers', 'Germany');

-- Creating table for Author
CREATE TABLE author ( 
    id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL
);

INSERT INTO author (id, full_name) VALUES
(1, 'George Orwell'),
(2, 'Jane Austen'),
(3, 'Gabriel García Márquez'),
(4, 'J.K. Rowling');

-- Creating table for books available
CREATE TABLE book (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    published_year INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(id),
    FOREIGN KEY (language_id) REFERENCES book_language(id)
);

INSERT INTO book (id, title, publisher_id, language_id, published_year) VALUES
(1, '1984', 1, 1, 1949),
(2, 'Pride and Prejudice', 2, 1, 1813),
(3, 'One Hundred Years of Solitude', 3, 3, 1967),
(4, 'Harry Potter and the Chamber of Secrets', 4, 1, 1997);

-- Creating table for book author relationship
-- This table establishes a many-to-many relationship between books and authors
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Creating table for country
CREATE TABLE country (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO country (id, name) VALUES
(1, 'USA'),
(2, 'UK'),
(3, 'France'),
(4, 'Germany');

-- Creating table for address
CREATE TABLE address (
    id INT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(id)
);

INSERT INTO address (id, street, city, postal_code, country_id) VALUES
(1, '123 Main St', 'New York', '10001', 1),
(2, '456 Oxford Rd', 'London', 'SW1A 1AA', 2),
(3, '22 Rue Cler', 'Paris', '75007', 3),
(4, '78 Berliner Str.', 'Berlin', '10115', 4);

-- Creating table for Address status
CREATE TABLE address_status (
    id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

INSERT INTO address_status (id, status_name) VALUES
(1, 'Current'),
(2, 'Old');

-- Creating table for customer
CREATE TABLE customer (
    id INT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255)
);

INSERT INTO customer (id, full_name, email) VALUES
(1, 'Alice Johnson', 'alice@gmail.com'),
(2, 'Bob Smith', 'bob@gmail.com');

-- Creating table for customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (status_id) REFERENCES address_status(id)
);

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);

-- Create table for shipping_method
CREATE TABLE shipping_method (
    id INT PRIMARY KEY,
    method_name VARCHAR(100)
);

INSERT INTO shipping_method (id, method_name) VALUES
(1, 'Standard Shipping'),
(2, 'Express Delivery'),
(3, 'Pickup in Store');

-- Creating table for order_status
CREATE TABLE order_status (
    id INT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO order_status (id, status_name) VALUES
(1, 'Pending'),
(2, 'Shipped'),
(3, 'Delivered'),
(4, 'Cancelled');

-- Creating table for cust_order
CREATE TABLE cust_order (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id)
);

INSERT INTO cust_order (id, customer_id, order_date, shipping_method_id, status_id) VALUES
(1, 1, '2025-04-01', 1, 1),
(2, 2, '2025-04-03', 2, 3);

-- Creating table for order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(id),
    FOREIGN KEY (book_id) REFERENCES book(id)
);

INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 4, 1);

-- Creating table for order_history
CREATE TABLE order_history (
    id INT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id)
);

INSERT INTO order_history (id, order_id, status_id, change_date) VALUES
(1, 1, 1, '2025-04-01 10:00:00'),
(2, 2, 1, '2025-04-03 12:00:00'),
(3, 2, 3, '2025-04-05 14:30:00');