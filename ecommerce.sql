CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT
);

CREATE TABLE Customer_Phone (
    phone_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    phone_number TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Category (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name TEXT
);

CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Product_Price (
    price_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER,
    price REAL,
    start_date TEXT,
    end_date TEXT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT DEFAULT CURRENT_TIMESTAMP,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Item (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price_at_purchase REAL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    method TEXT,
    amount REAL,
    payment_date TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Coupon (
    coupon_id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT,
    discount REAL
);

CREATE TABLE Order_Coupon (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    coupon_id INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (coupon_id) REFERENCES Coupon(coupon_id)
);
SELECT o.order_id, c.name, o.status
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id;
SELECT o.order_id, p.name, oi.quantity, oi.price_at_purchase
FROM Order_Item oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Product p ON oi.product_id = p.product_id;
SELECT o.order_id, p.method, p.amount
FROM Payment p
JOIN Orders o ON p.order_id = o.order_id;
SELECT p.name, c.category_name
FROM Product p
JOIN Category c ON p.category_id = c.category_id;
SELECT o.order_id, cp.code, cp.discount
FROM Order_Coupon oc
JOIN Orders o ON oc.order_id = o.order_id
JOIN Coupon cp ON oc.coupon_id = cp.coupon_id;
