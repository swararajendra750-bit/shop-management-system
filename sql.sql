-- -----------------------------------------------------
-- DATABASE: shopdb (for ConnectLocal / Local Vendor App)
-- -----------------------------------------------------
DROP DATABASE IF EXISTS shopdb;
CREATE DATABASE shopdb;
USE shopdb;

-- -----------------------------------------------------
-- USERS TABLE
-- -----------------------------------------------------
CREATE TABLE users (
  id BIGINT NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  full_name VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  language VARCHAR(50) DEFAULT 'English',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

-- Sample users/vendors
INSERT INTO users (email, full_name, password, language) VALUES
('swara@example.com', 'Swara', 'password', 'English'),
('khushi@example.com', 'Khushi', 'password', 'Marathi'),
('harshiv@example.com', 'Harshiv', 'password', 'English'),
('samarth@example.com', 'Samarth', 'password', 'Hindi');

-- -----------------------------------------------------
-- USER ROLES TABLE
-- -----------------------------------------------------
CREATE TABLE user_roles (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  role VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Assign all as vendors for now
INSERT INTO user_roles (user_id, role) VALUES
(1, 'ROLE_VENDOR'),
(2, 'ROLE_VENDOR'),
(3, 'ROLE_VENDOR'),
(4, 'ROLE_VENDOR');

-- -----------------------------------------------------
-- PRODUCTS TABLE
-- -----------------------------------------------------
CREATE TABLE products (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  vendor_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (vendor_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Sample products
INSERT INTO products (name, description, category, price, vendor_id) VALUES
('Jaggery', 'Organic jaggery – 1 kg (Swara)', 'Grocery', 100.00, 1),
('Jaggery', 'Organic jaggery – 1.5 kg (Khushi)', 'Grocery', 150.00, 2),
('Jaggery', 'Pure jaggery – 2 kg (Harshiv)', 'Grocery', 170.00, 3),
('Jaggery', 'Small pack 500g (Samarth)', 'Grocery', 200.00, 4),
('Soap', 'Neem herbal soap (Swara)', 'Personal Hygiene', 60.00, 1),
('Chips', 'Banana chips (Harshiv)', 'Snacks', 80.00, 3);

-- -----------------------------------------------------
-- CART TABLE
-- -----------------------------------------------------
CREATE TABLE cart (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- ORDERS TABLE
-- -----------------------------------------------------
CREATE TABLE orders (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) DEFAULT 'Pending',
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- PAYMENTS TABLE
-- -----------------------------------------------------
CREATE TABLE payments (
  id BIGINT NOT NULL AUTO_INCREMENT,
  order_id BIGINT NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  payment_status VARCHAR(50) DEFAULT 'Successful',
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
