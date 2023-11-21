alter proc sp_Login
@Username nvarchar(50),
@password nvarchar(50)

as
begin
	declare @loginAttempts int,
			@UserID VARCHAR(50),
			@StoredPassword VARCHAR(50),
			@table nvarchar(50)
	
	select @UserID=Customerx.[Login Id] ,@StoredPassword= Customerx.[password] , @loginAttempts=Customerx.[loginAttempts] from Customerx where Customerx.[Login ID]= @Username

		print @userID

	if(@UserID is NULL)
	begin
		set @table='employee'
		select @UserID=logt1.[LoginId] ,@StoredPassword= logt1.[password] , @loginAttempts=logt1.[loginAttempts] from Employee logt1  where logt1.[LoginID]= @Username
	end

	if(@UserID is null)
	begin
		print('user not found')
		return
	end

	IF @LoginAttempts >= 3
    BEGIN
        PRINT 'Maximum login attempts exceeded. You cannot login.'
		execute sp_auditEntries @username
        RETURN
    END

	IF @Password = @StoredPassword
		BEGIN
			PRINT 'Login successful'
			if @table='employee'
				begin
				select e.[name],e.[address],e.[age],e.[join date],e.[loginID] from employee e where e.[loginid]=@username
				end
			else
				begin
				select c.[name],c.[account number],c.[address],[login Id],[amount] from customerx c where c.[login id]=@username
				end
		
        -- Reset login attempts
			UPDATE Customerx
			SET LoginAttempts = 0
			WHERE [login ID] = @UserID

			UPDATE Employee
			SET LoginAttempts = 0
			WHERE loginID = @UserID

			execute sp_auditEntries @username
		END
    ELSE
		BEGIN
        PRINT 'Incorrect password'

        -- Increment login attempts
		UPDATE Customerx
        SET LoginAttempts = 1 + @loginAttempts
        WHERE [login ID] = @UserID

		UPDATE Employee
        SET LoginAttempts = 1+ @loginAttempts
        WHERE loginID = @UserID
        
		UPDATE Customerx
        SET lockoutTime = DATEADD(day,5,getdate())
        WHERE [login ID] = @UserID

		UPDATE Employee
        SET lockoutTime = DATEADD(day,5,getdate())
        WHERE loginID = @UserID
		END

		
END

execute sp_Login 'George@X7+','H4!'



select * from Customerx
select * from Employee

ALTER TABLE employee
ADD lockoutTime datetime
