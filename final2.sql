declare @maxbal int
declare @maxbalname varchar(20)
SELECT top 1 @maxbal=cast(balance as int) ,@maxbalname=[name] from Building_Management bm order by cast(balance as int) desc, [name] asc

if @maxbal>=10
	begin
	UPDATE Building_Management 
	SET  responsible='Not Incharge'
	WHERE responsible='incharge'

	UPDATE Building_Management 
	SET balance = @maxbal-10, responsible='incharge'
	WHERE [name]=@maxbalname 
	end
if @maxbal<10
	begin 
	UPDATE Building_Management 
	SET  responsible='Not Incharge'
	WHERE responsible='incharge'
	end
select * from Building_Management


