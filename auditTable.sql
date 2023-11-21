alter proc sp_auditEntries
@userID nvarchar(50) 
as 
begin
	declare @lockedtime datetime
	select @lockedtime = customerx.[lockoutTime] from customerx where customerx.[login id] =@userID
	if(@lockedtime is null)
	begin 
		select @lockedtime = EMPLOYEE.[lockoutTime] from EMPLOYEE where employee.[loginid] =@userID
	end

	IF @lockedtime IS NOT NULL AND @lockedtime > GETDATE()
    BEGIN
        insert into auditTable values (@userID,'Account is locked till. Please try again later.')
    END
	else
	BEGIN
        insert into auditTable values (@userID,'Transaction done')
    END

end

execute sp_auditEntries 'skmdk@E1#'

CREATE TABLE AuditTable (
    ID nvarchar(50),
    TransactionStatus VARCHAR(255)
);

select * from audittable