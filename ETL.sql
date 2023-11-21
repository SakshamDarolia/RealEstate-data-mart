USE Real_Estate

--Inserting "Town" values in Town dimension, Town_ID is Auto increment
INSERT INTO Real_Estate.DimTown([Town])
    SELECT
    DISTINCT [Town]
    FROM Real_Estate.Staging
    ORDER BY [Town] ASC

--As Buyer Dimension was self created, just adding some sample data in the table so that we can work with something
INSERT INTO Real_Estate.DimBuyer(Buyer_ID, First_Name, Last_Name, Contact, Payment_Mode, Payment_Settled) VALUES
(1,'Saksham', 'Darolia', '8139666643', 'eCheque', 1),
(2, 'John', 'Doe', '8139666643', 'eCheque', 1),
(3,'James', 'White', '8139646643', 'eCheque', 0),
(4,'Harry', 'Potter', '8139666223', 'eCheque', 1),
(5,'Albus', 'Dumbledore', '8112666643', 'eCheque', 0)

--Inserting values to all the columns in Property Dimension except the Town_ID and Buyer_ID as those will be done later on from Staging table
INSERT INTO Real_Estate.DimProperty([Address],[Property_Type],[Residential_Type],[Assessor_Remarks])
    SELECT [Address],[Property_Type],[Residential_Type],[Assessor_Remarks]
    FROM Real_Estate.Staging

--Inserting values to all the columns in YearDate Dimension except the ID
INSERT INTO Real_Estate.DimYearDate([List_Year],[Date_Recorded])
    SELECT [List_Year],[Date_Recorded]
    FROM Real_Estate.Staging

--At this point we have all of the data 
--Updating the Staging table with Town_ID based on the join on Town, as it's a common column
UPDATE Real_Estate.Staging
SET Real_Estate.Staging.[Town_ID] = Real_Estate.DimTown.[Town_ID]
FROM Real_Estate.Staging
INNER JOIN Real_Estate.DimTown ON
Real_Estate.Staging.[Town] = Real_Estate.DimTown.[Town]

--Updating the Staging table with Property_ID based on the join on Address
UPDATE Real_Estate.Staging
SET Real_Estate.Staging.[Property_ID] = Real_Estate.DimProperty.[Property_ID]
FROM Real_Estate.Staging
INNER JOIN Real_Estate.DimProperty ON
Real_Estate.Staging.[Address] = Real_Estate.DimProperty.[Address]

--Updating the Staging table with YearDate_ID based on the join on Date_Recorded which has a datatype of datetime, so we can uniquely identify each row and there will be no repititions in newly populated YearDate_ID column. 
UPDATE Real_Estate.Staging
SET Real_Estate.Staging.[YearDate_ID] = Real_Estate.DimYearDate.[YearDate_ID]
FROM Real_Estate.Staging
INNER JOIN Real_Estate.DimYearDate ON
Real_Estate.Staging.[Date_Recorded] = Real_Estate.DimYearDate.[Date_Recorded]

--Updating Staging table with a random Buyer_ID (from 1 to 5). As we donot have plenty of data in Buyer Dimension, I found this option to be a good workaround
--It iterates in the whole Staging table and updates each row with some random value of Buyer_ID ranging from 1 to 5.
DECLARE @Counter INT 
SET @Counter=1
WHILE ( @Counter <= (SELECT COUNT(*) FROM Real_Estate.Staging))
BEGIN
    UPDATE Real_Estate.Staging
    SET Buyer_ID = CAST(FLOOR(RAND() * 5) + 1 AS INT)
    WHERE Staging_ID = @Counter;
    
    SET @Counter = @Counter + 1;
END

--Now with the help of Staging table we can populate the Town_ID and Buyer_ID in Property Dimension
--We had to do all of this first in Staging as it has all the columns which helps us to make Joins and populate the IDs
UPDATE Real_Estate.DimProperty
SET Real_Estate.DimProperty.Town_ID = Real_Estate.Staging.Town_ID
FROM Real_Estate.DimProperty
INNER JOIN Real_Estate.Staging ON
Real_Estate.DimProperty.[Property_ID] = Real_Estate.Staging.[Property_ID]

UPDATE Real_Estate.DimProperty
SET Real_Estate.DimProperty.Buyer_ID = Real_Estate.Staging.Buyer_ID
FROM Real_Estate.DimProperty
INNER JOIN Real_Estate.Staging ON
Real_Estate.DimProperty.[Property_ID] = Real_Estate.Staging.[Property_ID]

--At the last we are going to populate all the columns in Fact table in one go
INSERT INTO Real_Estate.FactReal_Estate(Serial_Number, Property_ID, YearDate_ID, Assessed_Value, Sale_Amount, Sales_Ratio, [Location])
    SELECT Serial_Number, Property_ID, YearDate_ID, Assessed_Value, Sale_Amount, Sales_Ratio, [Location]
    FROM Real_Estate.Staging