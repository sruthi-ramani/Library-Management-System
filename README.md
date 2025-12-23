# Library Management System (SQL Project)

## Project Overview
Libraries that rely on manual or unorganized records often face difficulties in tracking books, members, borrow and return status, and overdue information. These issues result in inaccurate data, poor book availability management, and slow reporting.

This project implements a SQL-based Library Management System to centralize library data, streamline operations, and enable fast and accurate decision-making.

---

## Objective of the Project
The primary objective of this project is to analyze a library database using SQL and extract meaningful insights.

The goals of the project include:
- Understanding the database structure and relationships
- Answering real-world business questions using SQL
- Analyzing book circulation, borrowers, and branch activity
- Providing useful recommendations for library management

---

## Database Overview
The database follows a relational design with proper normalization.

Key entities in the system:
- Books
- Authors
- Library Branches
- Borrowers
- Book Loans
- Book Copies

Primary and foreign keys are used to maintain data integrity and relationships between tables.

---

## ER Diagram and Schema Explanation
The ER diagram explains:
- Relationship between books and authors
- Availability of book copies across branches
- Borrowers and their loan records
- Branch-wise circulation of books

The schema design supports efficient querying and accurate reporting.

---

## Key Analysis Questions (Use Cases)
1. How many copies of the book titled **"The Lost Tribe"** are owned by the **Sharpstown** branch?
2. How many copies of **"The Lost Tribe"** does each library branch own?
3. Which borrowers currently do not have any books checked out?
4. For each book loaned from the **Sharpstown** branch with a due date of **02/03/2018**, retrieve the book title, borrower name, and borrower address.
5. For each library branch, retrieve the total number of books loaned out.
6. Retrieve borrower details for members who have checked out more than five books.
7. For books authored by **Stephen King**, retrieve the title and number of copies owned by the **Central** branch.

---

## SQL Queries and Results
All the above business questions are answered using SQL queries involving:
- JOIN operations
- WHERE and HAVING clauses
- GROUP BY statements
- Aggregate functions such as COUNT and SUM

Query results are validated using outputs and screenshots.

---

## Final Business Insights
- Book Distribution:  
  The book *The Lost Tribe* has an equal number of copies (5) at each branch.

- Branch Activity:  
  The Central branch has the highest number of books loaned out (11), closely followed by other branches.

- Heavy Borrowers:  
  Tom Li has the highest number of books checked out (13), followed by Joe Smith (7) and Tom Haverford (6).

- Inactive Borrower:  
  Jane Smith currently has no books checked out.

---

## Recommendations
- Introduce loyalty programs or special benefits for frequent borrowers to encourage continued engagement.
- Reach out to inactive members with personalized recommendations or notifications.
- Consider allocating more copies of popular books to high-activity branches such as Central.

---

## Conclusion
This project demonstrates how SQL can be effectively used to analyze library data and generate meaningful insights. The analysis shows balanced book distribution, identifies active and inactive borrowers, and highlights opportunities to improve library operations through data-driven decisions.

---

## About Me
Name: Ramani Sruthi  
Batch No: 435  

LinkedIn:  
https://www.linkedin.com/in/ramani-sruthi-70884a29b/

GitHub:  
https://github.com/sruthi-ramani

---

## Tools and Technologies Used
- MySQL
- SQL
- ER Modeling
- GitHub
