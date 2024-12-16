use master 
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TMDT1')
BEGIN
    DROP DATABASE TMDT1;
END;

create database TMDT1
go 
use TMDT1
go 

-- Tạo bảng Customer
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100),
    address VARCHAR(100),
    phone_number VARCHAR(100)
);

-- Tạo bảng Category
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Tạo bảng Product
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    SKU VARCHAR(100),
    description VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    Category_category_id INT,
    FOREIGN KEY (Category_category_id) REFERENCES Category(category_id)
);

-- Tạo bảng Payment
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    payment_date DATETIME,
    payment_method VARCHAR(100),
    amount DECIMAL(10, 2),
    Customer_customer_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id)
);

-- Tạo bảng Shipment
CREATE TABLE Shipment (
    shipment_id INT PRIMARY KEY,
    shipment_date DATETIME,
    address VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(20),
    country VARCHAR(50),
    zip_code VARCHAR(10),
    Customer_customer_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id)
);

-- Tạo bảng Order
CREATE TABLE [Order] (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    total_price DECIMAL(10, 2),
    Customer_customer_id INT,
    Payment_payment_id INT,
    Shipment_shipment_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (Payment_payment_id) REFERENCES Payment(payment_id),
    FOREIGN KEY (Shipment_shipment_id) REFERENCES Shipment(shipment_id)
);

-- Tạo bảng Cart
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    quantity INT,
    Customer_customer_id INT,
    Product_product_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (Product_product_id) REFERENCES Product(product_id)
);

-- Tạo bảng Wishlist
CREATE TABLE Wishlist (
    wishlist_id INT PRIMARY KEY,
    Customer_customer_id INT,
    Product_product_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (Product_product_id) REFERENCES Product(product_id)
);

-- Tạo bảng Order_Item
CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY,
    quantity INT,
    price DECIMAL(10, 2),
    Product_product_id INT,
    Order_order_id INT,
    FOREIGN KEY (Product_product_id) REFERENCES Product(product_id),
    FOREIGN KEY (Order_order_id) REFERENCES [Order](order_id)
);

-- 1. Thêm cột Image vào bảng Product
ALTER TABLE Product ADD Image VARCHAR(100);

-- 2. Nhập ít nhất 2 danh mục (category)
INSERT INTO Category (category_id, name) VALUES (1, 'Electronics'), (2, 'Clothing');

-- 3. Nhập mỗi danh mục ít nhất 5 sản phẩm (product)
INSERT INTO Product (product_id, SKU, description, price, stock, Category_category_id, Image)
VALUES 
(1, 'ELEC001', 'Smartphone', 500.00, 10, 1, 'phone.jpg'),
(2, 'ELEC002', 'Laptop', 1200.00, 5, 1, 'laptop.jpg'),
(3, 'ELEC003', 'Tablet', 300.00, 20, 1, 'tablet.jpg'),
(4, 'ELEC004', 'Headphones', 150.00, 30, 1, 'headphones.jpg'),
(5, 'ELEC005', 'Smartwatch', 200.00, 15, 1, 'watch.jpg'),
(6, 'CLOT001', 'T-Shirt', 20.00, 50, 2, 'tshirt.jpg'),
(7, 'CLOT002', 'Jeans', 40.00, 25, 2, 'jeans.jpg'),
(8, 'CLOT003', 'Jacket', 100.00, 10, 2, 'jacket.jpg'),
(9, 'CLOT004', 'Sweater', 60.00, 15, 2, 'sweater.jpg'),
(10, 'CLOT005', 'Cap', 15.00, 35, 2, 'cap.jpg');

-- 4. Hiển thị top 3 sản phẩm mới nhất
SELECT TOP 3 * FROM Product ORDER BY product_id DESC;

-- 5. Hiển thị các sản phẩm thuộc về danh mục 1
SELECT * FROM Product WHERE Category_category_id = 1;

-- 6. Hiển thị sản phẩm có giá cao nhất
SELECT TOP 1 * FROM Product ORDER BY price DESC;

-- 7. Hiển thị 3 sản phẩm có giá cao nhất
SELECT TOP 3 * FROM Product ORDER BY price DESC;

-- 8. Nhập 3 khách hàng A, B, C
INSERT INTO Customer (customer_id, first_name, last_name, email, password, address, phone_number)
VALUES 
(1, 'A', 'Customer', 'a@gmail.com', 'password', 'Address A', '123456789'),
(2, 'B', 'Customer', 'b@gmail.com', 'password', 'Address B', '987654321'),
(3, 'C', 'Customer', 'c@gmail.com', 'password', 'Address C', '555666777');

-- 9. Cho khách hàng A đặt 4 sản phẩm vào giỏ hàng (cart)
INSERT INTO Cart (cart_id, quantity, Customer_customer_id, Product_product_id)
VALUES 
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 2, 1, 3),
(4, 1, 1, 4);

-- 10. Hiển thị giỏ hàng của khách hàng A
SELECT * FROM Cart WHERE Customer_customer_id = 1;

-- 11. Cho khách hàng B đặt 2 sản phẩm vào giỏ hàng (cart)
INSERT INTO Cart (cart_id, quantity, Customer_customer_id, Product_product_id)
VALUES 
(5, 1, 2, 5),
(6, 2, 2, 6);

-- 12. Hiển thị giỏ hàng của khách hàng B
SELECT * FROM Cart WHERE Customer_customer_id = 2;

-- 13. Cho khách hàng C đặt 1 sản phẩm vào giỏ hàng (cart)
INSERT INTO Cart (cart_id, quantity, Customer_customer_id, Product_product_id)
VALUES 
(7, 1, 3, 7);

-- 14. Cho khách hàng A đặt hàng 3 sản phẩm (order và order_item)
INSERT INTO [Order] (order_id, order_date, total_price, Customer_customer_id) VALUES (1, GETDATE(), 950.00, 1);

INSERT INTO Order_Item (order_item_id, quantity, price, Product_product_id, Order_order_id)
VALUES 
(1, 1, 500.00, 1, 1),
(2, 1, 200.00, 5, 1),
(3, 1, 250.00, 3, 1);

-- 15. Hiển thị các đơn hàng của khách hàng A
SELECT * FROM [Order] 
inner join Shipment on [Order].Order_id = Shipment.Shipment_id
WHERE [Order].Customer_customer_id = 1;

-- 16. Hiển thị tổng tiền đơn hàng của khách hàng A
SELECT SUM(total_price) AS TotalAmount FROM [Order] WHERE Customer_customer_id = 1;

-- 17. Cho khách hàng B đặt hàng 2 sản phẩm (order và order_item)
INSERT INTO [Order] (order_id, order_date, total_price, Customer_customer_id) VALUES (2, GETDATE(), 60.00, 2);

INSERT INTO Order_Item (order_item_id, quantity, price, Product_product_id, Order_order_id)
VALUES 
(4, 1, 40.00, 7, 2),
(5, 1, 20.00, 6, 2);

-- 18. Hiển thị các đơn hàng của khách hàng B
SELECT * FROM [Order] WHERE Customer_customer_id = 2;

-- 19. Hiển thị tổng tiền đơn hàng của khách hàng B
SELECT SUM(total_price) AS TotalAmount FROM [Order] WHERE Customer_customer_id = 2;

-- 20. Sử dụng inner join hiển thị tất cả dữ liệu có trong bảng Category, Customer, Order, Order_Item
SELECT * 
FROM Category
INNER JOIN Product ON Category.category_id = Product.Category_category_id
INNER JOIN Order_Item ON Product.product_id = Order_Item.Product_product_id
INNER JOIN [Order] ON Order_Item.Order_order_id = [Order].order_id
INNER JOIN Customer ON [Order].Customer_customer_id = Customer.customer_id;

-- 21. Hiển thị sản phẩm được khách hàng mua nhiều nhất
SELECT TOP 1 Product_product_id, SUM(quantity) AS TotalQuantity
FROM Order_Item
GROUP BY Product_product_id
ORDER BY TotalQuantity DESC;

-- 22. Hiển thị khách hàng mua hàng nhiều nhất
SELECT TOP 1 Customer_customer_id, SUM(total_price) AS TotalSpent
FROM [Order]
GROUP BY Customer_customer_id
ORDER BY TotalSpent DESC;
