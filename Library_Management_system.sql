CREATE DATABASE library_management;
USE library_management;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    membership_date DATE NOT NULL
);
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    quantity INT NOT NULL,
    available_quantity INT NOT NULL
);
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    
    status ENUM('Issued', 'Returned') DEFAULT 'Issued',
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
show tables;
INSERT INTO users
(name, email, phone, membership_date)
VALUES
('Janaranjan', 'janaranjan@gmail.com', '9876543210', '2026-01-10'),
('Arun Kumar', 'arun@gmail.com', '9876543211', '2026-02-15'),
('Priya', 'priya@gmail.com', '9876543212', '2026-03-05'),
('Karthik', 'karthik@gmail.com', '9876543213', '2026-04-12'),
('Rahul', 'rahul@gmail.com', '9876543214', '2026-05-20');
select * from users;
insert into books
(title, author, category, quantity, available_quantity)
VALUES
('Java Programming', 'James Gosling', 'Programming', 5, 5),
('Clean Code', 'Robert C. Martin', 'Programming', 3, 3),
('The Alchemist', 'Paulo Coelho', 'Fiction', 4, 4),
('Database Management Systems', 'Raghu Ramakrishnan', 'Database', 2, 2),
('Atomic Habits', 'James Clear', 'Self Help', 5, 5),
('Python Programming', 'Mark Lutz', 'Programming', 4, 4),
('The Psychology of Money', 'Morgan Housel', 'Finance', 3, 3);
select * from books;
select * from books where book_id = 1 	and available_Quantity>1;
select * from books;
INSERT INTO transactions
(user_id, book_id, issue_date, due_date, status)
VALUES
(1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Issued');
UPDATE books
SET available_quantity = available_quantity - 1
WHERE book_id = 1
AND available_quantity > 0;
select * from transactions;
SELECT
    t.transaction_id,
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date,
    t.due_date,
    t.return_date,
    t.status
FROM transactions t
JOIN users u
    ON t.user_id = u.user_id
JOIN books b
    ON t.book_id = b.book_id;
    UPDATE transactions
SET
    return_date = CURDATE(),
    status = 'Returned'
WHERE transaction_id = 1;
UPDATE books
SET available_quantity = available_quantity + 1
WHERE book_id = 1;
SELECT
    t.transaction_id,
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date,
    t.due_date,
    t.return_date,
    t.status
FROM transactions t
JOIN users u
    ON t.user_id = u.user_id
JOIN books b
    ON t.book_id = b.book_id;
    SELECT *
FROM books
WHERE book_id = 2
AND available_quantity > 0;
INSERT INTO transactions
(user_id, book_id, issue_date, due_date, status)
VALUES
(2, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Issued');
UPDATE books
SET available_quantity = available_quantity - 1
WHERE book_id = 2
AND available_quantity > 0;
SELECT
    t.transaction_id,
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date,
    t.due_date
FROM transactions t
JOIN users u
    ON t.user_id = u.user_id
JOIN books b
    ON t.book_id = b.book_id
WHERE t.status = 'Issued';
SELECT
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date,
    t.due_date
FROM transactions t
JOIN users u
    ON t.user_id = u.user_id
JOIN books b
    ON t.book_id = b.book_id
WHERE t.status = 'Issued'
AND t.due_date < CURDATE();
SELECT *
FROM books
WHERE title LIKE '%Java%';
SELECT *
FROM books
WHERE author LIKE '%James%';
SELECT
    book_id,
    title,
    author,
    category,
    available_quantity
FROM books
WHERE available_quantity > 0;
select * from books;
SELECT
    t.transaction_id,
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date,
    t.due_date,
    t.return_date,
    t.status
FROM transactions t
JOIN users u
    ON t.user_id = u.user_id
JOIN books b
    ON t.book_id = b.book_id
ORDER BY t.transaction_id;
SELECT SUM(quantity) AS total_books
FROM books;
SELECT SUM(available_quantity) AS available_books
FROM books;
SELECT COUNT(*) AS currently_issued
FROM transactions
WHERE status = 'Issued';
SELECT
    b.title,
    COUNT(t.transaction_id) AS times_borrowed
FROM transactions t
JOIN books b
    ON t.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY times_borrowed DESC;
SELECT
    u.name,
    COUNT(t.transaction_id) AS total_borrowed
FROM users u
JOIN transactions t
    ON u.user_id = t.user_id
GROUP BY u.user_id, u.name
ORDER BY total_borrowed DESC;
select * from users;