alter PROCEDURE sp_InsertEmployeeAndCustomer
@Designation NVARCHAR(50),
@EmployeeName NVARCHAR(50),
@EmployeeAddress NVARCHAR(50),
@EmployeeDesignation NVARCHAR(50),
@EmployeeAge int,	
@EmployeeJoiningDate Date,


@CustomerName NVARCHAR(50),
@CustomerAccountNumber int,
@CustomerAddress NVARCHAR(50),
@amount int


AS
BEGIN
	if(@Designation='Employee')
	begin
		declare @EmployeeLoginID NVARCHAR(50)
		declare @EmployeePassword NVARCHAR(50)
		
		SET @EmployeeLoginID = @EmployeeName+'@'+CHAR(65 + CAST(RAND() * 26 AS INT)) + CHAR(48 + CAST(RAND() * 10 AS INT)) + CHAR(33 + CAST(RAND() * 14 AS INT))

		set @EmployeePassword=CHAR(65 + CAST(RAND() * 26 AS INT)) + CHAR(48 + CAST(RAND() * 10 AS INT)) + CHAR(33 + CAST(RAND() * 14 AS INT))
		insert into Employee ([Name],[Address],[Designation],[Age],[Join Date],[LoginID],[Password]) values (@EmployeeName,@EmployeeAddress,@EmployeeDesignation,@EmployeeAge,@EmployeeJoiningDate,@EmployeeLoginID,@EmployeePassword)

	end
	ELSE IF (@Designation = 'Customer')
    BEGIN
        declare @CustLoginID NVARCHAR(50)
		declare @CustPassword NVARCHAR(50)
        
        SET @CustLoginID = @CustomerName+'@'+CHAR(65 + CAST(RAND() * 26 AS INT)) + CHAR(48 + CAST(RAND() * 10 AS INT)) + CHAR(33 + CAST(RAND() * 14 AS INT))
		

		set @CustPassword=CHAR(65 + CAST(RAND() * 26 AS INT)) + CHAR(48 + CAST(RAND() * 10 AS INT)) + CHAR(33 + CAST(RAND() * 14 AS INT))
		INSERT INTO Customerx ([Name], [Account number], [Address],[Login Id],[Password],[Amount]) values (@CustomerName,@CustomerAccountNumber,@CustomerAddress,@CustLoginID,@CustPassword,@amount);
    END


end


execute sp_InsertEmployeeAndCustomer @Designation='Employee',@EmployeeName='amisha',@EmployeeAddress='Kanakpura',@EmployeeDesignation='manager',@EmployeeAge=18,@EmployeeJoiningDate='',@CustomerName='',@CustomerAccountNumber='',@CustomerAddress='',@amount=''

execute sp_InsertEmployeeAndCustomer @Designation='Customer',@EmployeeName='',@EmployeeAddress='',@EmployeeDesignation='',@EmployeeAge='',@EmployeeJoiningDate='',@CustomerName='John',@CustomerAccountNumber=43256,@CustomerAddress='France',@amount=5000



select * from employee
