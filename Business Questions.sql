--BUSINESS QUESTIONS

--Get the Owner names and their contacts, for the properties whose Payment is not settled as of now.
SELECT DimProperty.Address, DimBuyer.First_Name, DimBuyer.Last_Name, DimBuyer.Contact
FROM Real_Estate.DimProperty
LEFT JOIN Real_Estate.DimBuyer ON
DimProperty.[Buyer_ID] = DimBuyer.[Buyer_ID]
WHERE DimBuyer.Payment_Settled  = 0

--Get the Towns with highest sum of Assessed Property Values, based on this we can also conclude which would be the most expensive town to live in
SELECT DimTown.Town, SUM(FactReal_Estate.Assessed_Value) AS Total_Assessed_Value
FROM Real_Estate.DimTown
INNER JOIN Real_Estate.DimProperty ON
DimTown.Town_ID = DimProperty.Town_ID
INNER JOIN Real_Estate.FactReal_Estate ON
DimProperty.Property_ID = FactReal_Estate.Property_ID
GROUP BY DimTown.Town
ORDER BY Total_Assessed_Value DESC