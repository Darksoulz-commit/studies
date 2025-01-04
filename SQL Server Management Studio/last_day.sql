USE BikeStores

declare @Firstname as varchar(100)

	,@LastName as varchar(100)

	,@MiddleName as varchar(100)
 
set @Firstname = '  Mahindra  '
set @MiddleName = '  Singh  '
set @LastName = '  Dhoni  '
 
select CONCAT(LTRIM(RTRIM(@Firstname)), ' '

				,LTRIM(RTRIM(@MiddleName)),' '

				,LTRIM(RTRIM(@LastName))

				) as [Full Name]
 
select CONCAT(@Firstname,' ',@MiddleName,' ',@LastName);

--TABLE VALUED FUNCTIONS

DECLARE @Product Table(
	ProdId INT NOT NULL,
	Prod_Name VARCHAR(100) NOT NULL,
	UnitPrice DECIMAL(10,2) NOT NULL
	)
 
 --Another way if Inserting values in to Table/TableVariable
 
 INSERT INTO @Product(ProdId, Prod_Name, UnitPrice)
 SELECT Product_id, product_name, list_price FROM production.products;

 SELECT * FROM @Product



CREATE OR ALTER FUNCTION udf_tb1_PrgCourse(
	@Course AS VARCHAR(500)
)
RETURNS @CourseTable TABLE(
				CourseName VARCHAR(100)
				)
AS
BEGIN
	DECLARE
		@lString AS VARCHAR(100),
		@rString AS VARCHAR(100),
		@mString AS VARCHAR(100),
		@EndString AS VARCHAR(100)

	SET @lString = LEFT(@Course, CHARINDEX(',', @Course)-1)
	SET @rString = SUBSTRING(@Course, CHARINDEX(',', @Course)+1, LEN(@Course))
	SET @mString = LEFT(@rString, CHARINDEX(',',@Course)+2)
	SET @EndString = SUBSTRING(@rString, CHARINDEX(',',@rString)+1, LEN(@rString))


	 INSERT INTO @CourseTable (CourseName)
    VALUES (@lString), (@mString), (@EndString)

	

    RETURN
END


DECLARE @Course VARCHAR(500) = 'SQL, BootStrap, Python';
SELECT * FROM udf_tb1_PrgCourse(@Course);

-- Dynamic

CREATE OR ALTER FUNCTION udf_tb1_PgCourse(
	@Data AS VARCHAR(500), @DeLimiter CHAR(1)
)
RETURNS @CourseTable TABLE(
				CourseName VARCHAR(200)
				)
AS
BEGIN
		DECLARE @PositionDeLimiter AS INT = -1

		WHILE (LEN(@Data) > 0)
		BEGIN
			SET @PositionDeLimiter = CHARINDEX(@Delimiter,@Data)

			IF ((@PositionDeLimiter = 0) and (LEN(@Data)>0))
			BEGIN
				INSERT INTO @CourseTable(CourseName)
				VALUES (@Data)
				BREAK
			END

			IF (@PositionDeLimiter > 1)
			BEGIN
				INSERT INTO @CourseTable(CourseName)
				VALUES (LEFT(@Data,@PositionDeLimiter-1))

				SET @Data= RIGHT(@Data,(LEN(@Data) - @PositionDeLimiter))

			END
			ELSE
			BEGIN
				SET @Data = RIGHT(@Data,(LEN(@Data) - @PositionDeLimiter))
			END
			
		END
		RETURN
END

DECLARE @Data VARCHAR(500) = 'SQL, BootStrap, Python, CSS';
DECLARE @DeLimiter CHAR(1) = ',';
SELECT * FROM [dbo].udf_tb1_PgCourse(@Data,@DeLimiter);

--Dynamic SQl


DECLARE @Select VARCHAR(100),
        @TableName VARCHAR(50),
        @sql VARCHAR(500);

-- Set variable values
SET @Select = 'SELECT * FROM ';
SET @TableName = 'production.products';
SET @sql = @Select + ' ' + @TableName;  -- Ensure space between 'FROM' and the table name
  
-- Print the dynamic SQL query
PRINT @sql;

-- Execute the dynamic SQL query
EXEC (@sql);


with cte_sales_2019 AS(
	SELECT
		xMonth,
		SUM(net_sales) net_sales
	FROM
		vw_netsales_brands

	)
