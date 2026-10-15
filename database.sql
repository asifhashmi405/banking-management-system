-- ========================================================
-- Banking Management System Database Script
-- Database Name: banking_db
-- ========================================================

-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

-- Step 2: Create users table for Login Authentication
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL
);

-- Step 3: Create customers table
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0.00
);

-- Step 4: Create transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(20) NOT NULL,
    type VARCHAR(20) NOT NULL, -- 'DEPOSIT' or 'WITHDRAW'
    amount DECIMAL(15,2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_number) REFERENCES customers(account_number) ON DELETE CASCADE
);

-- ========================================================
-- Insert Sample Demonstration Data
-- ========================================================

-- Insert Sample Administrator Login Account
-- Default Credentials -> Username: admin | Password: admin123
INSERT INTO users (username, password) VALUES 
('admin', 'admin123')
ON DUPLICATE KEY UPDATE password='admin123';

-- Insert Sample Customers
INSERT INTO customers (name, phone, address, account_number, balance) VALUES
('Rahul Sharma', '9876543210', '402 MG Road, Mumbai', 'ACC1001', 5000.00),
('Priya Patel', '9123456780', '15 FC Road, Pune', 'ACC1002', 12000.00),
('Amit Kumar', '9988776655', '88 Park Street, Kolkata', 'ACC1003', 3500.00)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Insert Initial Demonstration Transactions
INSERT INTO transactions (account_number, type, amount, transaction_date) VALUES
('ACC1001', 'DEPOSIT', 5000.00, NOW() - INTERVAL 2 DAY),
('ACC1002', 'DEPOSIT', 15000.00, NOW() - INTERVAL 3 DAY),
('ACC1002', 'WITHDRAW', 3000.00, NOW() - INTERVAL 1 DAY),
('ACC1003', 'DEPOSIT', 3500.00, NOW() - INTERVAL 1 DAY);
