CREATE FUNCTION updatebalance (
    @accountID as INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @newBalance DECIMAL(10, 2),
			@amount DECIMAL(10, 2)

	select @amount = amount from customerx where Customerx.[Customer ID]=@accountID
    
    IF @amount > 10000
        SET @newBalance = @amount + (@amount * 0.02); 
    ELSE
        SET @newBalance = @amount - 500;
    
    RETURN @newBalance;
END

alter proc balanceUpdate
as 
begin
	declare @presentDate date= '2023-10-31',
			@eom date = EOMONTH(GETDATE()),
			@custCount int,
			@Counter int =1,
			@custID int=500001
	select @custCount = COUNT(customerx.[Customer ID]) from Customerx
	IF @presentDate = @eom
	WHILE @Counter <= @custCount
	BEGIN
		 DECLARE @newBalance DECIMAL(10, 2);
         SELECT @newBalance= [dbo].[updatebalance](@custID);

         UPDATE Customerx 
         SET Amount = @newBalance 
         WHERE [Customer ID] = @custID;

         SET @custID = @custID + 1;
         SET @Counter = @Counter + 1;
	END
end

execute balanceUpdate

select * from Customerx