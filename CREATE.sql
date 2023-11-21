Use Real_Estate

CREATE TABLE Real_Estate.DimTown(
    Town_ID int IDENTITY(1,1) NOT NULL,
    Town varchar(50) NULL
    CONSTRAINT PK_Town_ID PRIMARY KEY (Town_ID)
)

CREATE TABLE Real_Estate.DimBuyer(
    Buyer_ID int NOT NULL,
    First_Name varchar(50) NULL,
    Last_Name varchar(50) NULL,
    Contact varchar(50) NULL,
    Payment_Mode varchar(50) NULL,
    Payment_Settled bit NULL
    CONSTRAINT PK_Buyer_ID PRIMARY KEY (Buyer_ID)
)

CREATE TABLE Real_Estate.DimProperty(
    Property_ID int IDENTITY(1,1) NOT NULL,
    [Address] varchar(200) NULL,
    Property_Type varchar(50) NULL,
    Residential_Type varchar(50) NULL,
    Assessor_Remarks varchar(300) NULL,
    Town_ID int,
    Buyer_ID int
    CONSTRAINT PK_Property_ID PRIMARY KEY (Property_ID),
    CONSTRAINT FK_Town_ID FOREIGN KEY (Town_ID) REFERENCES Real_Estate.DimTown(Town_ID),
    CONSTRAINT FK_Buyer_ID FOREIGN KEY (Buyer_ID) REFERENCES Real_Estate.DimBuyer(Buyer_ID)
)

CREATE TABLE Real_Estate.DimYearDate(
    YearDate_ID int IDENTITY(1,1) NOT NULL,
    List_Year int NULL,
    Date_Recorded datetime NULL
    CONSTRAINT PK_YearDate_ID PRIMARY KEY (YearDate_ID)
)

CREATE TABLE Real_Estate.FactReal_Estate(
    Real_Estate_ID int IDENTITY(1,1) NOT NULL,
    Serial_Number int NULL,
    Property_ID int NULL,
    YearDate_ID int NULL,
    Assessed_Value numeric(20,2) NULL,
    Sale_Amount numeric(20,2) NULL,
    Sales_Ratio decimal(20,10) NULL,
    [Location] varchar(50) NULL
    CONSTRAINT PK_Real_Estate_ID PRIMARY KEY (Real_Estate_ID),
    CONSTRAINT FK_Property_ID FOREIGN KEY (Property_ID) REFERENCES Real_Estate.DimProperty(Property_ID),
    CONSTRAINT FK_YearDate_ID FOREIGN KEY (YearDate_ID) REFERENCES Real_Estate.DimYearDate(YearDate_ID),
)

CREATE TABLE Real_Estate.Staging(
    Staging_ID int IDENTITY(1,1) NOT NULL,
    Serial_Number int NULL,
    Property_ID int NULL,
    YearDate_ID int NULL,
    Buyer_ID int NULL,
    List_Year int NULL,
    Date_Recorded datetime NULL,
    Town_ID int,
    Town varchar(50) NULL,
    [Address] varchar(200) NULL,
    Assessed_Value numeric(20,2) NULL,
    Sale_Amount numeric(20,2) NULL,
    Sales_Ratio decimal(20,10) NULL,
    Property_Type varchar(50) NULL,
    Residential_Type varchar(50) NULL,
    Assessor_Remarks varchar(300) NULL,
    [Location] varchar(50) NULL
    CONSTRAINT PK_Staging_ID PRIMARY KEY (Staging_ID)
)