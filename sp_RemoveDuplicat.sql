IF EXISTS (SELECT * 
           FROM   dbo.sysobjects 
           WHERE  id = Object_id(N'[dbo].[sp_ReDup]') 
                  AND Objectproperty(id, N'IsProcedure') = 1) 
  DROP PROCEDURE [dbo].[sp_ReDup] 

go 

SET ansi_nulls ON 

go 

SET quoted_identifier ON 

go 

CREATE PROCEDURE [dbo].[Sp_redup](@table_name VARCHAR(max), 
                                  @clmname    VARCHAR(255)) 
AS 
  BEGIN 
      DECLARE @tablename VARCHAR(max)=@table_name; 
      DECLARE @statement VARCHAR(max); 

      SET @statement = 'WITH tblTemp as (select ROW_NUMBER() over(partition by ' 
                       + @clmname + ' order by ' + @clmname 
                       + ') as RowNumber ,* from ' + @tablename 
                       + ') DELETE FROM tblTemp where RowNumber >1' 

      EXECUTE(@statement); 
  END 