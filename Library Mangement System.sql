CREATE database library;

USE library;

-------- Publisher Table ---------------
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

-------- Book Table ---------------------
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

-------- Authours Tabel --------------------
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

-------- Library Branch Tabel ---------------
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

-------- Book Copies TAbel -----------------
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

-------- Borrower Tabel ----------------
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

-------- Books Loan Tabel ---------------
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut VARCHAR(10),
    book_loans_DueDate VARCHAR(10),
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);
DROP table tbl_book_loans;

UPDATE tbl_book_loans
SET book_loans_DueDate = STR_TO_DATE(book_loans_DueDate, '%c/%e/%y');

UPDATE tbl_book_loans
SET book_loans_DateOut = STR_TO_DATE(book_loans_DateOut, '%c/%e/%y');




-------- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
SELECT 
    c.book_copies_No_Of_Copies AS number_of_copies
FROM
    tbl_book_copies c
        JOIN
    tbl_book b ON b.book_BookID = c.book_copies_BookID
        JOIN
    tbl_library_branch lb ON lb.library_branch_BranchID = c.book_copies_BranchID
WHERE
    b.book_Title = 'The Lost Tribe'
        AND lb.library_branch_BranchName = 'Sharpstown';
        
        
        
-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?
        
SELECT 
    lb.library_branch_BranchName,
    SUM(c.book_copies_No_Of_Copies)
FROM
    tbl_book_copies c
        JOIN
    tbl_book b ON b.book_BookID = c.book_copies_BookID
        JOIN
    tbl_library_branch lb ON lb.library_branch_BranchID = c.book_copies_BranchID
WHERE
    b.book_Title = 'The Lost Tribe'
GROUP BY lb.library_branch_BranchName;

-- 3.Retrieve the names of all borrowers who do not have any books checked out.
SELECT 
    b.borrower_BorrowerName
FROM
    tbl_borrower b
        LEFT JOIN
    tbl_book_loans l ON b.borrower_CardNo = l.book_loans_CardNo
WHERE
    l.book_loans_LoansID IS NULL;


-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 

SELECT 
    b.book_Title,
    br.borrower_BorrowerName,
    br.borrower_BorrowerAddress
FROM
    tbl_book b
        JOIN
    tbl_book_loans bl ON bl.book_loans_BookID = b.book_BookID
        JOIN
    tbl_library_branch lb ON lb.library_branch_BranchID = bl.book_loans_BranchID
        JOIN
    tbl_borrower br ON br.borrower_CardNo = bl.book_loans_CardNo
WHERE
    lb.library_branch_BranchName = 'Sharpstown'
        AND bl.book_loans_DueDate = '2018-02-03';

-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

SELECT 
    lb.library_branch_BranchName, COUNT(bl.book_loans_BookID)
FROM
    tbl_library_branch lb
        JOIN
    tbl_book_loans bl ON lb.library_branch_BranchID = bl.book_loans_BranchID
GROUP BY lb.library_branch_BranchName;

-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

SELECT b.borrower_BorrowerName,
       b.borrower_BorrowerAddress,
       COUNT(bl.book_loans_BookID)
FROM tbl_borrower b
JOIN tbl_book_loans bl
  ON b.borrower_CardNo = bl.book_loans_CardNo
GROUP BY b.borrower_BorrowerAddress,
         b.borrower_BorrowerName
HAVING COUNT(bl.book_loans_BookID) > 5;

-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

SELECT book_authors_AuthorName,
       book_Title,
       book_copies_No_Of_Copies,
       library_branch_BranchName
FROM tbl_book_authors a
JOIN tbl_book_copies c ON a.book_authors_BookID = c.book_copies_BookID
JOIN tbl_book b ON b.book_BookID = c.book_copies_BookID
JOIN tbl_library_branch lb ON lb.library_branch_BranchID = c.book_copies_BranchID
WHERE a.book_authors_AuthorName = 'Stephen King'
AND lb.library_branch_BranchName = 'Central';

