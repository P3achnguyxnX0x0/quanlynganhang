CREATE DATABASE [QuanLyNganHang];
USE [QuanLyNganHang];
GO
-- Tạo bảng
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(100),
    PhoneNumber VARCHAR(15),
    Address NVARCHAR(200),
    Email NVARCHAR(100),
    DateOfBirth DATE
);
CREATE TABLE Branches (
    BranchID VARCHAR(10) PRIMARY KEY,
    BranchName NVARCHAR(100),
    BranchAddress NVARCHAR(200),
    PhoneNumber VARCHAR(15)
);
CREATE TABLE Accounts (
    AccountID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID),
    Balance DECIMAL(18, 2),
    AccountType NVARCHAR(50),
    CreatedDate DATE
);
CREATE TABLE Transactions (
    TransactionID VARCHAR(10) PRIMARY KEY,
    AccountID VARCHAR(10) FOREIGN KEY REFERENCES Accounts(AccountID),
    Amount DECIMAL(18, 2),
    TransactionType NVARCHAR(50),
    TransactionDate DATE,
    Description NVARCHAR(200)
);
CREATE TABLE Employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(50),
    BranchID VARCHAR(10) FOREIGN KEY REFERENCES Branches(BranchID),
    PhoneNumber VARCHAR(15),
    Email NVARCHAR(100)
);
CREATE TABLE Loans (
    LoanID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID),
    Amount DECIMAL(18, 2),
    LoanType NVARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    InterestRate DECIMAL(5, 2)
);
GO

-- Functions
CREATE FUNCTION FN_GetAccountBalance
(
    @AccountID VARCHAR(10)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Balance DECIMAL(18, 2);
    SELECT @Balance = Balance FROM Accounts WHERE AccountID = @AccountID;
    RETURN @Balance;
END
GO

CREATE FUNCTION FN_GetDailyTransactionTotal
(
    @AccountID VARCHAR(10),
    @TransactionDate DATE
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(18, 2);
    SELECT @Total = SUM(Amount)
    FROM Transactions
    WHERE AccountID = @AccountID
    AND CONVERT(DATE, TransactionDate) = @TransactionDate
    AND TransactionType IN ('Deposit', 'Withdrawal');

    RETURN @Total;
END
GO

CREATE FUNCTION FN_totalBalance()
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @totalBalance DECIMAL(18, 2);
    SELECT @totalBalance = SUM(Balance) FROM Accounts;
    RETURN @totalBalance;
END;
GO

CREATE FUNCTION FN_totalTransactions(@StartDate DATE, @EndDate DATE)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @totalTransactions DECIMAL(18, 2);
    SELECT @totalTransactions = SUM(Amount)
    FROM Transactions
    WHERE TransactionDate BETWEEN @StartDate AND @EndDate;
    RETURN @totalTransactions;
END;
GO

CREATE FUNCTION FN_totalLoanAmount(@CustomerID VARCHAR(10))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @totalLoanAmount DECIMAL(18, 2);
    SELECT @totalLoanAmount = SUM(Amount)
    FROM Loans
    WHERE CustomerID = @CustomerID;
    RETURN @totalLoanAmount;
END;
GO

-- Stored Procedures
CREATE PROCEDURE SP_addCustomer
    @CustomerID VARCHAR(10),
    @Name NVARCHAR(100),
    @PhoneNumber VARCHAR(15),
    @Address NVARCHAR(200),
    @Email NVARCHAR(100),
    @DateOfBirth DATE
AS
BEGIN
    INSERT INTO Customers (CustomerID, Name, PhoneNumber, Address, Email, DateOfBirth)
    VALUES (@CustomerID, @Name, @PhoneNumber, @Address, @Email, @DateOfBirth);
END;
GO

CREATE PROCEDURE SP_addAccount
    @AccountID VARCHAR(10),
    @CustomerID VARCHAR(10),
    @Balance DECIMAL(18, 2),
    @AccountType NVARCHAR(50),
    @CreatedDate DATE
AS
BEGIN
    INSERT INTO Accounts (AccountID, CustomerID, Balance, AccountType, CreatedDate)
    VALUES (@AccountID, @CustomerID, @Balance, @AccountType, @CreatedDate);
END;
GO

CREATE PROCEDURE SP_addTransaction
    @TransactionID VARCHAR(10),
    @AccountID VARCHAR(10),
    @Amount DECIMAL(18, 2),
    @TransactionType NVARCHAR(50),
    @TransactionDate DATE,
    @Description NVARCHAR(200)
AS
BEGIN
    INSERT INTO Transactions (TransactionID, AccountID, Amount, TransactionType, TransactionDate, Description)
    VALUES (@TransactionID, @AccountID, @Amount, @TransactionType, @TransactionDate, @Description);
END;
GO

CREATE PROCEDURE SP_addBranch
    @BranchID VARCHAR(10),
    @BranchName NVARCHAR(100),
    @BranchAddress NVARCHAR(200),
    @PhoneNumber VARCHAR(15)
AS
BEGIN
    INSERT INTO Branches (BranchID, BranchName, BranchAddress, PhoneNumber)
    VALUES (@BranchID, @BranchName, @BranchAddress, @PhoneNumber);
END;
GO

CREATE PROCEDURE SP_addEmployee
    @EmployeeID VARCHAR(10),
    @Name NVARCHAR(100),
    @Position NVARCHAR(50),
    @BranchID VARCHAR(10),
    @PhoneNumber VARCHAR(15),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO Employees (EmployeeID, Name, Position, BranchID, PhoneNumber, Email)
    VALUES (@EmployeeID, @Name, @Position, @BranchID, @PhoneNumber, @Email);
END;
GO

CREATE PROCEDURE SP_addLoan
    @LoanID VARCHAR(10),
    @CustomerID VARCHAR(10),
    @Amount DECIMAL(18, 2),
    @LoanType NVARCHAR(50),
    @StartDate DATE,
    @EndDate DATE,
    @InterestRate DECIMAL(5, 2)
AS
BEGIN
    INSERT INTO Loans (LoanID, CustomerID, Amount, LoanType, StartDate, EndDate, InterestRate)
    VALUES (@LoanID, @CustomerID, @Amount, @LoanType, @StartDate, @EndDate, @InterestRate);
END;
GO

CREATE PROCEDURE SP_DepositMoney
	@TransactionID VARCHAR(10),
    @AccountID VARCHAR(10),
    @Amount DECIMAL(18, 2),
    @Description NVARCHAR(500)
AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + @Amount
    WHERE AccountID = @AccountID;

    INSERT INTO Transactions (TransactionID, AccountID, Amount, TransactionType, TransactionDate, Description)
    VALUES (@TransactionID, @AccountID, @Amount, 'Deposit', GETDATE(), @Description);
END
GO

CREATE PROCEDURE SP_WithdrawMoney
	@TransactionID VARCHAR(10),
    @AccountID VARCHAR(10),
    @Amount DECIMAL(18, 2),
    @Description NVARCHAR(500)
AS
BEGIN
    DECLARE @CurrentBalance DECIMAL(18, 2);
    SELECT @CurrentBalance = Balance FROM Accounts WHERE AccountID = @AccountID;

    IF @CurrentBalance >= @Amount
    BEGIN
        UPDATE Accounts
        SET Balance = Balance - @Amount
        WHERE AccountID = @AccountID;

        INSERT INTO Transactions (TransactionID, AccountID, Amount, TransactionType, TransactionDate, Description)
        VALUES (@TransactionID, @AccountID, @Amount, 'Withdrawal', GETDATE(), @Description);
    END
    ELSE
    BEGIN
        RAISERROR ('Insufficient funds', 16, 1);
    END
END
GO

-- Thêm dữ liệu mẫu vào các bảng
INSERT INTO Customers (CustomerID, Name, PhoneNumber, Address, Email, DateOfBirth)
VALUES
    ('C001', 'Nguyen Van A', '0912345678', '123 Phan Dinh Phung, Hanoi', 'a@example.com', '1990-01-01'),
    ('C002', 'Tran Thi B', '0987654321', '456 Le Loi, Ho Chi Minh City', 'b@example.com', '1985-05-10'),
    ('C003', 'Pham Van C', '0911223344', '789 Nguyen Hue, Da Nang', 'c@example.com', '1995-12-20');
GO

INSERT INTO Accounts (AccountID, CustomerID, Balance, AccountType, CreatedDate)
VALUES
    ('A001', 'C001', 1000000, 'Saving', '2024-06-19'),
    ('A002', 'C002', 500000, 'Checking', '2024-06-20'),
    ('A003', 'C003', 2000000, 'Saving', '2024-06-21');
GO

INSERT INTO Transactions (TransactionID, AccountID, Amount, TransactionType, TransactionDate, Description)
VALUES
    ('T001', 'A001', 500000, 'Deposit', '2024-06-19', 'Initial deposit'),
    ('T002', 'A002', 200000, 'Withdrawal', '2024-06-20', 'ATM withdrawal'),
    ('T003', 'A003', 1000000, 'Transfer', '2024-06-21', 'Transfer to another account');
GO

INSERT INTO Branches (BranchID, BranchName, BranchAddress, PhoneNumber)
VALUES
    ('B001', 'Branch 1', '123 Tran Hung Dao, Hanoi', '0911223344'),
    ('B002', 'Branch 2', '456 Le Loi, Ho Chi Minh City', '0987654321'),
    ('B003', 'Branch 3', '789 Nguyen Hue, Da Nang', '0912345678');
GO

INSERT INTO Employees (EmployeeID, Name, Position, BranchID, PhoneNumber, Email)
VALUES
    ('E001', 'Le Van B', 'Manager', 'B001', '0911555777', 'b@example.com'),
    ('E002', 'Tran Thi D', 'Teller', 'B002', '0988777666', 'd@example.com'),
    ('E003', 'Nguyen Van E', 'Customer Service', 'B003', '0911222333', 'e@example.com');

INSERT INTO Loans (LoanID, CustomerID, Amount, LoanType, StartDate, EndDate, InterestRate)
VALUES
    ('L001', 'C001', 50000000, 'Home Loan', '2024-06-19', '2034-06-19', 5.5),
    ('L002', 'C002', 20000000, 'Car Loan', '2024-06-20', '2030-06-20', 4.75),
    ('L003', 'C003', 10000000, 'Personal Loan', '2024-06-21', '2029-06-21', 6.0);
GO

-- Scripts để Test Stored Procedures và Functions
-- Test SP_addCustomer
EXEC SP_addCustomer 'C003', 'Nguyen Van C', '0912345689', '123 Hanoi', 'c@example.com', '1990-05-01';
SELECT * FROM Customers WHERE CustomerID = 'C003';

-- Test SP_addAccount
EXEC SP_addAccount 'A004', 'C002', 1000000, 'Saving', '2024-06-19';
SELECT * FROM Accounts WHERE AccountID = 'A004';

-- Test SP_addTransaction
EXEC SP_addTransaction 'T001', 'A001', 500000, 'Deposit', '2024-06-19', 'Initial deposit';
SELECT * FROM Transactions WHERE TransactionID = 'T001';

-- Test SP_addBranch
EXEC SP_addBranch 'B004', 'Branch 1', '123 Tran Hung Dao, Hanoi', '0911223344';
SELECT * FROM Branches WHERE BranchID = 'B004';

-- Test SP_addEmployee
EXEC SP_addEmployee 'E004', 'Le Van D', 'Manager', 'B004', '0911555777', 'd@example.com';
SELECT * FROM Employees WHERE EmployeeID = 'E004';

-- Test SP_addLoan
EXEC SP_addLoan 'L004', 'C003', 50000000, 'Home Loan', '2024-06-19', '2029-06-19', 5.5;
SELECT * FROM Loans WHERE LoanID = 'L004';

-- Test SP_DepositMoney
EXEC dbo.SP_DepositMoney
	'T002',
    'A001',
    1000.00,
    'Nap tien vao tai khoan';

-- Test SP_WithdrawMoney
EXEC dbo.SP_WithdrawMoney
	'T003',
    'A001',
    52000.00,
    'Rut tien tu tai khoan';

SELECT * FROM Transactions WHERE AccountID = 'A001';
-- Test Functions
-- Test FN_GetAccountBalance
SELECT dbo.FN_GetAccountBalance('A001') AS CurrentBalance;

-- Test FN_GetDailyTransactionTotal
SELECT dbo.FN_GetDailyTransactionTotal('A001', '2024-06-19') AS DailyTransactionTotal;

-- Test FN_totalBalance
SELECT dbo.FN_totalBalance() AS TotalBalance;

-- Test FN_totalTransactions
SELECT dbo.FN_totalTransactions('2024-06-01', '2024-06-30') AS TotalTransactions;

-- Test FN_totalLoanAmount
SELECT dbo.FN_totalLoanAmount('C001') AS TotalLoanAmount;
