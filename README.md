Bài toán: Quản lý Ngân hàng
Sinh Viên : Đào Nguyễn Phú Quý 57KMT K215480106041

QUẢN LÝ NGÂN HÀNG
#### Các chức năng của bài toán
Dự án quản lý ngân hàng có thể bao gồm các chức năng sau:
- Quản lý khách hàng và tài khoản ngân hàng.
- Giao dịch với tài khoản (nạp tiền, rút tiền, chuyển khoản).
- Quản lý các khoản vay và các khoản vay đang chờ duyệt.
- Báo cáo tài chính và thống kê.
- Quản lý nhân viên và chi nhánh.

#### Các chỗ cần nhập/xuất/báo cáo
- Nhập: Thêm/sửa/xóa thông tin khách hàng, tài khoản, giao dịch, khoản vay, nhân viên, chi nhánh.
- Xuất: Hiển thị thông tin chi tiết và tổng hợp về khách hàng, tài khoản, giao dịch, khoản vay, báo cáo tài chính.
- Báo cáo: Báo cáo tài chính, báo cáo về các giao dịch, thống kê số dư tài khoản, danh sách khách hàng, nhân viên, chi nhánh.

#### Các bảng dữ liệu cần thiết
Dự án quản lý ngân hàng có thể cần các bảng dữ liệu sau đây:

- Bảng Khách Hàng (Customers):
  - PK: CustomerID
  - Name, PhoneNumber, Address, Email, DateOfBirth
  
- Bảng Tài Khoản (Accounts):
  - PK: AccountID
  - FK: CustomerID (tới bảng Customers)
  - Balance, AccountType, CreatedDate
  
- Bảng Giao Dịch (Transactions):
  - PK: TransactionID
  - FK: AccountID (tới bảng Accounts)
  - Amount, TransactionType, TransactionDate, Description
  
- Bảng Chi Nhánh (Branches):
  - PK: BranchID
  - BranchName, BranchAddress, PhoneNumber
  
- Bảng Nhân Viên (Employees):
  - PK: EmployeeID
  - FK: BranchID (tới bảng Branches)
  - Name, Position, PhoneNumber, Email
  
- Bảng Khoản Vay (Loans):
  - PK: LoanID
  - FK: CustomerID (tới bảng Customers)
  - Amount, LoanType, StartDate, EndDate, InterestRate

Trên đây là các bảng cơ bản có thể được sử dụng trong dự án quản lý ngân hàng. Mỗi bảng được đề cập đến các khóa chính (Primary Key - PK), các khóa ngoại (Foreign Key - FK) (nếu có), và các ràng buộc khác như ràng buộc duy nhất (Unique Constraint - CK).

### Thiết kế cơ sở dữ liệu mở rộng
#### 1.1. Bảng Khách Hàng (Customers)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/80a373a4-6845-459c-b0eb-83570b51e340)

CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(100),
    PhoneNumber VARCHAR(15),
    Address NVARCHAR(200),
    Email NVARCHAR(100),
    DateOfBirth DATE
);
#### 1.2. Bảng Tài Khoản (Accounts)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/4c4793ae-4fd1-433e-9d36-9461c9fff067)

CREATE TABLE Accounts (
    AccountID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID),
    Balance DECIMAL(18, 2),
    AccountType NVARCHAR(50),
    CreatedDate DATE
);
#### 1.3. Bảng Giao Dịch (Transactions)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/d1bd9245-1e54-4655-8dfe-9d23c16c4375)

CREATE TABLE Transactions (
    TransactionID VARCHAR(10) PRIMARY KEY,
    AccountID VARCHAR(10) FOREIGN KEY REFERENCES Accounts(AccountID),
    Amount DECIMAL(18, 2),
    TransactionType NVARCHAR(50),
    TransactionDate DATE,
    Description NVARCHAR(200)
);
#### 1.4. Bảng Chi Nhánh (Branches)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/d729714d-227a-4c0d-a21c-d447a7c7f5f1)

CREATE TABLE Branches (
    BranchID VARCHAR(10) PRIMARY KEY,
    BranchName NVARCHAR(100),
    BranchAddress NVARCHAR(200),
    PhoneNumber VARCHAR(15)
);
#### 1.5. Bảng Nhân Viên (Employees)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/1ff66757-38eb-4223-81a3-6f0215d2a2a6)

CREATE TABLE Employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(50),
    BranchID VARCHAR(10) FOREIGN KEY REFERENCES Branches(BranchID),
    PhoneNumber VARCHAR(15),
    Email NVARCHAR(100)
);
#### 1.6. Bảng Khoản Vay (Loans)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/b04fc524-2b2f-4418-9768-18bc22cc0492)

CREATE TABLE Loans (
    LoanID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID),
    Amount DECIMAL(18, 2),
    LoanType NVARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    InterestRate DECIMAL(5, 2)
);
### Stored Procedures
#### 2.1. Thêm khách hàng (Add Customer)
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

#### 2.2. Thêm tài khoản (Add Account)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/ce97d526-822f-4350-ace2-34c68817fb7c)

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

#### 2.3. Thêm giao dịch (Add Transaction)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/8a1ab26f-4fe4-46d9-ac4f-f85af0deed62)

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

#### 2.4. Thêm chi nhánh (Add Branch)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/82491a62-7772-428c-911a-b449c5dcad64)

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

#### 2.5. Thêm nhân viên (Add Employee)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/a4924da2-7067-4b4b-9d7b-d2246a01067a)

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

#### 2.6. Thêm khoản vay (Add Loan)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/f879c133-f479-4a26-9705-23c11ca6a0dd)

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

#### 2.7. Nạp tiền
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/3dbbc5cc-0cbc-432f-9dc3-fcb284187dea)

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

#### 2.8. Rút tiền
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/cd958539-bfbb-4d83-a99b-cba590d879ee)

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

### Functions
#### 3.1. Tính tổng số dư của tất cả tài khoản (Total Balance)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/0f43dbf8-6619-4517-b7ab-162bd69e96f8)

CREATE FUNCTION FN_totalBalance()
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @totalBalance DECIMAL(18, 2);
    SELECT @totalBalance = SUM(Balance) FROM Accounts;
    RETURN @totalBalance;
END;

#### 3.2. Tính tổng giao dịch trong khoảng thời gian (Total Transactions)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/d15e0a25-b564-4ee9-9df7-905ed71fa684)

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

#### 3.3. Tính tổng khoản vay của một khách hàng (Total Loan Amount)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/6f259466-b993-48db-a9c5-b6dc3b6cce63)

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

#### 3.4. Tính số dư của một khách hàng
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/e28676f8-fd9a-4cfe-b7ff-3427877f4665)

CREATE FUNCTION FN_GetAccountBalance
(
    @AccountID INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Balance DECIMAL(18, 2);
    SELECT @Balance = Balance FROM Accounts WHERE AccountID = @AccountID;
    RETURN @Balance;
END

#### 3.5. Tính số dư của một khách hàng
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/51430794-bc8d-48ad-9c28-6dc61cd071b7)

CREATE FUNCTION FN_GetDailyTransactionTotal
(
    @AccountID INT,
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

### Thêm dữ liệu mẫu vào các bảng
#### 1. Thêm dữ liệu mẫu vào bảng Khách Hàng (Customers)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/f842a6f8-ada5-4d29-b72a-83db694475ec)

INSERT INTO Customers (CustomerID, Name, PhoneNumber, Address, Email, DateOfBirth)
VALUES
    ('C001', 'Nguyen Van A', '0912345678', '123 Phan Dinh Phung, Hanoi', 'a@example.com', '1990-01-01'),
    ('C002', 'Tran Thi B', '0987654321', '456 Le Loi, Ho Chi Minh City', 'b@example.com', '1985-05-10'),
    ('C003', 'Pham Van C', '0911223344', '789 Nguyen Hue, Da Nang', 'c@example.com', '1995-12-20');

#### 2. Thêm dữ liệu mẫu vào bảng Tài Khoản (Accounts)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/2b200f85-bf6f-446f-a1ce-8b605ff1e8f4)

INSERT INTO Accounts (AccountID, CustomerID, Balance, AccountType, CreatedDate)
VALUES
    ('A001', 'C001', 1000000, 'Saving', '2024-06-19'),
    ('A002', 'C002', 500000, 'Checking', '2024-06-20'),
    ('A003', 'C003', 2000000, 'Saving', '2024-06-21');

#### 3. Thêm dữ liệu mẫu vào bảng Giao Dịch (Transactions)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/5c288974-a6ba-40a8-9c93-9a20498c0443)

INSERT INTO Transactions (TransactionID, AccountID, Amount, TransactionType, TransactionDate, Description)
VALUES
    ('T001', 'A001', 500000, 'Deposit', '2024-06-19', 'Initial deposit'),
    ('T002', 'A002', 200000, 'Withdrawal', '2024-06-20', 'ATM withdrawal'),
    ('T003', 'A003', 1000000, 'Transfer', '2024-06-21', 'Transfer to another account');

#### 4. Thêm dữ liệu mẫu vào bảng Chi Nhánh (Branches)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/cd3a1b5f-7629-477d-9224-92ff7265a6d0)

INSERT INTO Branches (BranchID, BranchName, BranchAddress, PhoneNumber)
VALUES
    ('B001', 'Branch 1', '123 Tran Hung Dao, Hanoi', '0911223344'),
    ('B002', 'Branch 2', '456 Le Loi, Ho Chi Minh City', '0987654321'),
    ('B003', 'Branch 3', '789 Nguyen Hue, Da Nang', '0912345678');

#### 5. Thêm dữ liệu mẫu vào bảng Nhân Viên (Employees)
INSERT INTO Employees (EmployeeID, Name, Position, BranchID, PhoneNumber, Email)
VALUES
    ('E001', 'Le Van B', 'Manager', 'B001', '0911555777', 'b@example.com'),
    ('E002', 'Tran Thi D', 'Teller', 'B002', '0988777666', 'd@example.com'),
    ('E003', 'Nguyen Van E', 'Customer Service', 'B003', '0911222333', 'e@example.com');

#### 6. Thêm dữ liệu mẫu vào bảng Khoản Vay (Loans)
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/26914635-bb52-42bf-8d17-c956a62f49d2)

INSERT INTO Loans (LoanID, CustomerID, Amount, LoanType, StartDate, EndDate, InterestRate)
VALUES
    ('L001', 'C001', 50000000, 'Home Loan', '2024-06-19', '2034-06-19', 5.5),
    ('L002', 'C002', 20000000, 'Car Loan', '2024-06-20', '2030-06-20', 4.75),
    ('L003', 'C003', 10000000, 'Personal Loan', '2024-06-21', '2029-06-21', 6.0);

### Scripts để Test Stored Procedures và Functions
#### 4.1. Test Stored Procedures
##### Thêm khách hàng
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/c6ef2d72-b9cb-4573-bcc2-c87594315c31)

-- Test SP_addCustomer
EXEC SP_addCustomer 'C001', 'Nguyen Van A', '0912345678', '123 Phan Dinh Phung, Hanoi', 'a@example.com', '1990-01-01';
SELECT * FROM Customers WHERE CustomerID = 'C001';

##### Thêm tài khoản
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/a331f4cc-30af-4a4a-a12d-d64db76c57d7)

-- Test SP_addAccount
EXEC SP_addAccount 'A001', 'C001', 1000000, 'Saving', '2024-06-19';
SELECT * FROM Accounts WHERE AccountID = 'A001';

##### Thêm giao dịch
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/92a740b3-13fc-4ae6-894e-9c947f53291f)

-- Test SP_addTransaction
EXEC SP_addTransaction 'T001', 'A001', 500000, 'Deposit', '2024-06-19', 'Initial deposit';
SELECT * FROM Transactions WHERE TransactionID = 'T001';

##### Thêm chi nhánh
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/80691646-8829-4304-a9ff-8a3595dbaefb)

-- Test SP_addBranch
EXEC SP_addBranch 'B001', 'Branch 1', '123 Tran Hung Dao, Hanoi', '0911223344';
SELECT * FROM Branches WHERE BranchID = 'B001';

##### Thêm nhân viên
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/23f20651-f129-443d-9280-6eaa0dd72df5)

-- Test SP_addEmployee
EXEC SP_addEmployee 'E001', 'Le Van B', 'Manager', 'B001', '0911555777', 'b@example.com';
SELECT * FROM Employees WHERE EmployeeID = 'E001';

##### Thêm khoản vay
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/f8109977-bcbe-4132-a618-4bfe42968d14)

-- Test SP_addLoan
EXEC SP_addLoan 'L001', 'C001', 50000000, 'Home Loan', '2024-06-19', '2029-06-19', 5.5;
SELECT * FROM Loans WHERE LoanID = 'L001';

##### Thêm khoản vay
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/de6205e5-779f-44d3-ab2e-82441256eea9)

-- Test SP_DepositMoney
EXEC dbo.SP_DepositMoney
    'T002',
    'A001',
    1000.00,
    'Nap tien vao tai khoan';

##### Thêm khoản vay
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/5c2cef0d-d4ff-4094-8c63-94eaf54048be)

-- Test SP_WithdrawMoney
EXEC dbo.SP_WithdrawMoney
    'T003',
    'A001',
    50.00,
    'Rut tien tu tai khoan';

#### 4.2. Test Functions
##### Tính tổng số dư của tài khoản
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/03342936-b5ef-412a-a4ed-5eb9e94faba6)

-- Test FN_GetAccountBalance
SELECT dbo.FN_GetAccountBalance('A001') AS CurrentBalance;

##### Tính tổng số tiền giao dịch trong một ngày
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/40d2486d-247e-4788-86cd-ac098a7cf01e)

-- Test FN_GetDailyTransactionTotal
SELECT dbo.FN_GetDailyTransactionTotal('A001', '2024-06-19') AS DailyTransactionTotal;

##### Tính tổng số dư của tất cả tài khoản
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/1f535f2e-9daf-458a-82e5-55b7fd1685d4)

-- Test FN_totalBalance
SELECT dbo.FN_totalBalance() AS TotalBalance;

##### Tính tổng giao dịch trong khoảng thời gian
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/ad4c20a3-b059-4a28-bb37-4bc6da9d2740)

-- Test FN_totalTransactions
SELECT dbo.FN_totalTransactions('2024-06-01', '2024-06-30') AS TotalTransactions;

##### Tính tổng khoản vay của một khách hàng
![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/3a635f81-fea2-4e4e-911f-14a40ba67a82)

-- Test FN_totalLoanAmount
SELECT dbo.FN_totalLoanAmount('C001') AS TotalLoanAmount;
