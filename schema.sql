-- DEFINE YOUR DATABASE SCHEMA HERE
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS frequencies CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  customer VARCHAR(255)
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  product VARCHAR(255)
);

CREATE TABLE frequencies (
  id SERIAL PRIMARY KEY,
  frequency VARCHAR(100)
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  invoice_no int,
  product_id int REFERENCES products(id),
  employee_id int REFERENCES employees(id),
  customer_id int REFERENCES customers(id),
  sale_date date,
  sale_amount money,
  units_sold int,
  frequency_id int REFERENCES frequencies(id)
);
