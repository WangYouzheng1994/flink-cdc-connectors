-- Copyright 2022 Ververica Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--   http://www.apache.org/licenses/LICENSE-2.0
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, either express or implied.  See the License for the
-- specific language governing permissions and limitations
-- under the License.

-- ----------------------------------------------------------------------------------------------------------------
-- DATABASE:  inventory
-- ----------------------------------------------------------------------------------------------------------------

-- Create and populate our products using a single insert with many rows
CREATE TABLE products (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL DEFAULT 'flink',
  description VARCHAR(512),
  weight FLOAT
);
ALTER TABLE products AUTO_INCREMENT = 101;

INSERT INTO products
VALUES (default,"scooter","Small 2-wheel scooter",3.14),
       (default,"car battery","12V car battery",8.1),
       (default,"12-pack drill bits","12-pack of drill bits with sizes ranging from #40 to #3",0.8),
       (default,"hammer","12oz carpenter's hammer",0.75),
       (default,"hammer","14oz carpenter's hammer",0.875),
       (default,"hammer","16oz carpenter's hammer",1.0),
       (default,"rocks","box of assorted rocks",5.3),
       (default,"jacket","water resistent black wind breaker",0.1),
       (default,"spare tire","24 inch spare tire",22.2);

-- Create and populate our products using a single insert with many rows
CREATE TABLE products_no_pk (
  type INTEGER ,
  name VARCHAR(255) DEFAULT 'flink',
  description VARCHAR(512),
  weight FLOAT
);

INSERT INTO products_no_pk
VALUES (100,"scooter","Small 2-wheel scooter",3.14),
       (101,"car battery","12V car battery",8.1),
       (102,"12-pack drill bits","12-pack of drill bits with sizes ranging from #40 to #3",0.8),
       (102,"12-pack drill bits","12-pack of drill bits with sizes ranging from #40 to #3",0.8),
       (103,"hammer","12oz carpenter's hammer",0.75),
       (103,"hammer","14oz carpenter's hammer",0.875),
       (103,"hammer","16oz carpenter's hammer",1.0),
       (104,"rocks","box of assorted rocks",5.3),
       (104,"rocks","box of assorted rocks",5.3),
       (104,"rocks","box of assorted rocks",5.3),
       (105,"jacket","water resistent black wind breaker",0.1),
       (106,"spare tire","24 inch spare tire",22.2);

-- Create and populate the products on hand using multiple inserts
CREATE TABLE products_on_hand (
  product_id INTEGER NOT NULL PRIMARY KEY,
  quantity INTEGER NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO products_on_hand VALUES (101,3);
INSERT INTO products_on_hand VALUES (102,8);
INSERT INTO products_on_hand VALUES (103,18);
INSERT INTO products_on_hand VALUES (104,4);
INSERT INTO products_on_hand VALUES (105,5);
INSERT INTO products_on_hand VALUES (106,0);
INSERT INTO products_on_hand VALUES (107,44);
INSERT INTO products_on_hand VALUES (108,2);
INSERT INTO products_on_hand VALUES (109,5);

-- Create some customers ...
CREATE TABLE customers (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE KEY
) AUTO_INCREMENT=1001;


INSERT INTO customers
VALUES (default,"Sally","Thomas","sally.thomas@acme.com"),
       (default,"George","Bailey","gbailey@foobar.com"),
       (default,"Edward","Walker","ed@walker.com"),
       (default,"Anne","Kretchmar","annek@noanswer.org");

-- Create some very simple orders
CREATE TABLE orders (
  order_number INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_date DATE NOT NULL,
  purchaser INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  FOREIGN KEY order_customer (purchaser) REFERENCES customers(id),
  FOREIGN KEY ordered_product (product_id) REFERENCES products(id)
) AUTO_INCREMENT = 10001;

INSERT INTO orders
VALUES (default, '2016-01-16', 1001, 1, 102),
       (default, '2016-01-17', 1002, 2, 105),
       (default, '2016-02-18', 1004, 3, 109),
       (default, '2016-02-19', 1002, 2, 106),
       (default, '16-02-21', 1003, 1, 107);

CREATE TABLE category
(
    id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE `varbinary_pk_table`
(
    `order_id`   varbinary(8) NOT NULL,
    `order_date` date         NOT NULL,
    `quantity`   int(11) NOT NULL,
    `product_id` int(11) NOT NULL,
    `purchaser`  varchar(512) NOT NULL,
    PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO varbinary_pk_table
VALUES (b'0000010000000100000001000000010000000100000001000000010000000000', '2021-03-08', 0, 0, 'flink'),
       (b'0000010000000100000001000000010000000100000001000000010000000001', '2021-03-08', 10, 100, 'flink'),
       (b'0000010000000100000001000000010000000100000001000000010000000010', '2021-03-08', 20, 200, 'flink'),
       (b'0000010000000100000001000000010000000100000001000000010000000011', '2021-03-08', 30, 300, 'flink'),
       (b'0000010000000100000001000000010000000100000001000000010000000100', '2021-03-08', 40, 400, 'flink');