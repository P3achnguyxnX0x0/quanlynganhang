Bài toán: Quản lý Ngân hàng
Sinh Viên : Đào Nguyễn Phú Quý 57KMT K215480106041

Mô tả bài toán
Hệ thống Ngân hàng cần quản lý các thông tin và hoạt động liên quan đến khách hàng, tài khoản, giao dịch, khoản vay, nhân viên và chi nhánh ngân hàng. Các chức năng chính của hệ thống bao gồm:
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/c21918c2-8e89-4a02-8bb2-27a37a5822ec)



Quản lý khách hàng:

Đăng ký tài khoản khách hàng mới
Cập nhật thông tin khách hàng
Xóa tài khoản khách hàng
Đăng nhập vào tài khoản khách hàng


Quản lý tài khoản ngân hàng:

Mở tài khoản mới cho khách hàng (Saving, Checking, ...)
Cập nhật thông tin tài khoản
Đóng tài khoản
Xem số dư tài khoản


Quản lý giao dịch:

Gửi tiền vào tài khoản
Rút tiền từ tài khoản
Chuyển khoản giữa các tài khoản
Xem lịch sử giao dịch của tài khoản


Quản lý khoản vay:

Đăng ký khoản vay mới (Home Loan, Car Loan, Personal Loan, ...)
Cập nhật thông tin khoản vay
Trả nợ khoản vay
Xem lịch sử trả nợ khoản vay


Quản lý nhân viên ngân hàng:

Thêm nhân viên mới
Cập nhật thông tin nhân viên
Xóa nhân viên
Phân công nhân viên cho các chi nhánh


Quản lý chi nhánh ngân hàng:

Thêm chi nhánh mới
Cập nhật thông tin chi nhánh
Xóa chi nhánh


Báo cáo và thống kê:

Báo cáo tổng số dư tài khoản
Báo cáo tổng số giao dịch trong khoảng thời gian
Báo cáo khách hàng có khoản vay lớn nhất
Báo cáo chi nhánh có nhiều khách hàng nhất
Báo cáo nhân viên phụ trách nhiều khách hàng nhất
Các báo cáo và thống kê khác theo yêu cầu



Hệ thống Ngân hàng cần đảm bảo tính bảo mật, toàn vẹn dữ liệu và khả năng mở rộng để đáp ứng nhu cầu phát triển trong tương lai.
Cấu trúc cơ sở dữ liệu

Bảng Customers (Khách hàng)
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/6163ce22-444f-495a-af5e-b25b00d7c307)

CustomerID (VARCHAR(10), PRIMARY KEY): Mã khách hàng
Name (NVARCHAR(100), NOT NULL): Tên khách hàng
PhoneNumber (VARCHAR(15)): Số điện thoại
Address (NVARCHAR(200)): Địa chỉ
Email (NVARCHAR(100)): Email
DateOfBirth (DATE): Ngày sinh


Bảng Branches (Chi nhánh ngân hàng)
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/c0b09a84-0c62-46be-9e4a-4e71ddb3d298)

BranchID (VARCHAR(10), PRIMARY KEY): Mã chi nhánh
BranchName (NVARCHAR(100), NOT NULL): Tên chi nhánh
BranchAddress (NVARCHAR(200), NOT NULL): Địa chỉ chi nhánh
PhoneNumber (VARCHAR(15)): Số điện thoại


Bảng Accounts (Tài khoản ngân hàng)
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/f2f35914-52dd-43e0-aa1c-9d9c5d95695b)

AccountID (VARCHAR(10), PRIMARY KEY): Mã tài khoản
CustomerID (VARCHAR(10), FOREIGN KEY REFERENCES Customers(CustomerID)): Mã khách hàng
Balance (DECIMAL(18, 2) NOT NULL, CHECK (Balance >= 0)): Số dư tài khoản (không được âm)
AccountType (NVARCHAR(50), NOT NULL): Loại tài khoản (Saving, Checking, ...)
CreatedDate (DATE, NOT NULL): Ngày tạo tài khoản


Bảng Transactions (Giao dịch)
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/71ee66a0-fe08-4cab-a213-9182c04a823b)

TransactionID (VARCHAR(10), PRIMARY KEY): Mã giao dịch
AccountID (VARCHAR(10), FOREIGN KEY REFERENCES Accounts(AccountID)): Mã tài khoản
Amount (DECIMAL(18, 2) NOT NULL, CHECK (Amount > 0)): Số tiền giao dịch (phải lớn hơn 0)
TransactionType (NVARCHAR(50), NOT NULL): Loại giao dịch (Deposit, Withdrawal, Transfer, ...)
TransactionDate (DATE, NOT NULL): Ngày giao dịch
Description (NVARCHAR(200)): Mô tả giao dịch


Bảng Employees (Nhân viên ngân hàng)
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/d8b247bb-7c2b-4ea2-b812-3a8bfd2676f7)

EmployeeID (VARCHAR(10), PRIMARY KEY): Mã nhân viên
Name (NVARCHAR(100), NOT NULL): Tên nhân viên
Position (NVARCHAR(50), NOT NULL): Vị trí công việc
BranchID (VARCHAR(10), FOREIGN KEY REFERENCES Branches(BranchID)): Mã chi nhánh
PhoneNumber (VARCHAR(15)): Số điện thoại
Email (NVARCHAR(100)): Email


Bảng Loans (Khoản vay)
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/5129ccc4-5c33-4c29-9ec3-f1fe49029f62)

LoanID (VARCHAR(10), PRIMARY KEY): Mã khoản vay
CustomerID (VARCHAR(10), FOREIGN KEY REFERENCES Customers(CustomerID)): Mã khách hàng
Amount (DECIMAL(18, 2) NOT NULL, CHECK (Amount > 0)): Số tiền vay (phải lớn hơn 0)
LoanType (NVARCHAR(50), NOT NULL): Loại khoản vay (Home Loan, Car Loan, Personal Loan, ...)
StartDate (DATE, NOT NULL): Ngày bắt đầu vay
EndDate (DATE, NOT NULL): Ngày kết thúc vay
InterestRate (DECIMAL(5, 2) NOT NULL, CHECK (InterestRate > 0)): Lãi suất (phải lớn hơn 0)



Stored Procedures và Functions
Chúng ta sẽ cần viết các Stored Procedures và Functions để xử lý các chức năng và báo cáo của hệ thống. Dưới đây là một số ví dụ (dựa trên file mẫu đã cung cấp):
Stored Procedures

SP_addCustomer: Thêm khách hàng mới
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/464414cc-8e79-4f27-b3d2-f7bc6d5f6210)

SP_addAccount: Thêm tài khoản mới
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/094eaeb1-07d7-4f93-9351-1beb1455dae2)

SP_addTransaction: Thêm giao dịch mới
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/2a6adf38-f51b-4b0b-bdf7-8cb1ddba1758)

SP_addBranch: Thêm chi nhánh mới
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/3683e6ae-8178-4e1a-9f67-85fb88b66596)

SP_addEmployee: Thêm nhân viên mới
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/8bdb64cb-8b08-4746-b6e7-651cf79c8267)

SP_addLoan: Thêm khoản vay mới
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/60511285-a521-405a-b5a5-bdb8cf56ec7d)

SP_DepositMoney: Gửi tiền vào tài khoản
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/d8832457-6548-4886-b490-1766afc0e001)

SP_WithdrawMoney: Rút tiền từ tài khoản
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/a26802e8-658f-4897-943f-035619179ba1)


Functions
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/6348be05-889e-4a04-8f2f-4fe2ad8e7610)

FN_GetAccountBalance: Lấy số dư của một tài khoản
FN_GetDailyTransactionTotal: Lấy tổng số tiền giao dịch trong một ngày của một tài khoản
FN_totalBalance: Lấy tổng số dư của tất cả tài khoản
FN_totalTransactions: Lấy tổng số tiền giao dịch trong một khoảng thời gian
FN_totalLoanAmount: Lấy tổng số tiền vay của một khách hàng
-- Scripts để Test Stored Procedures 
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/f5247e0d-b78c-4988-91b5-68dbdd40e34e)


-- Thêm dữ liệu mẫu vào các bảng
 ![image](https://github.com/P3achnguyxnX0x0/quanlynganhang/assets/168555011/86c7a1dc-5dd5-4534-8e2f-12a046353042)

Báo cáo và thống kê
Chúng ta có thể sử dụng các Functions đã viết để tạo ra các báo cáo và thống kê sau:

Báo cáo tổng số dư tài khoản: Sử dụng FN_totalBalance()
Báo cáo tổng số giao dịch trong khoảng thời gian: Sử dụng FN_totalTransactions(@StartDate, @EndDate)
Báo cáo khách hàng có khoản vay lớn nhất: Sử dụng FN_totalLoanAmount(@CustomerID) và tìm giá trị lớn nhất
Báo cáo chi nhánh có nhiều khách hàng nhất: Đếm số lượng khách hàng theo BranchID trong bảng Accounts hoặc Employees
Báo cáo nhân viên phụ trách nhiều khách hàng nhất: Đếm số lượng khách hàng theo EmployeeID trong bảng Accounts hoặc Employees

Ngoài ra, chúng ta có thể viết thêm các Stored Procedures và Functions khác để tạo ra các báo cáo và thống kê mới theo yêu cầu.
Yêu cầu bảo mật và toàn vẹn dữ liệu
Để đảm bảo tính bảo mật và toàn vẹn dữ liệu của hệ thống, chúng ta cần thực hiện các biện pháp sau:

Mã hóa mật khẩu khách hàng và nhân viên trước khi lưu trữ
Kiểm tra quyền truy cập dữ liệu theo vai trò người dùng
Thiết lập các ràng buộc dữ liệu (PRIMARY KEY, FOREIGN KEY, CHECK, ...) để đảm bảo tính toàn vẹn
Sử dụng các cơ chế backup và phục hồi dữ liệu
Áp dụng các biện pháp bảo mật mạng và hệ thống để ngăn chặn truy cập trái phép

Khả năng mở rộng
Hệ thống Ngân hàng cần được thiết kế với khả năng mở rộng để đáp ứng nhu cầu phát triển trong tương lai. Chúng ta có thể xem xét các tính năng mới sau:

Quản lý tài khoản tiết kiệm có kỳ hạn
Quản lý thẻ tín dụng và giao dịch thẻ
Quản lý kế hoạch đầu tư
Quản lý dịch vụ ngân hàng điện tử (Internet Banking, Mobile Banking)
Quản lý quỹ tín dụng
Tích hợp với các hệ thống bên ngoài (như hệ thống thanh toán, hệ thống quản lý tín dụng, ...)

Khi có nhu cầu mới, chúng ta có thể mở rộng cơ sở dữ liệu bằng cách thêm các bảng mới và cập nhật các Stored Procedures và Functions tương ứng.

