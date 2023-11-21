# RealEstate-data-mart

This is a **small scale Data Mart** which is essentially a part of Analytical Database, also known as OLAP (Online Analytical Processing) schema database. A Data Mart is a subset of a data warehouse focused on a particular line of business, department, or subject area. It is a smaller, more focused repository of data that is derived from the larger, centralized data warehouse.

### This Data Mart is created using the following two datasets:

**Real Estate Dataset:** (Link: [https://catalog.data.gov/dataset/real-estate-sales-2001-2018](url))
1. Serial Number
2. List Year
3. Date Recorded
4. Town
5. Address
6. Assessed Value
7. Sale Amount
8. Sales Ratio
9. Property Type
10. Residential Type
11. Non Use Code
12. Assessor Remarks
13. OPM Remarks
14. Location

**Buyers Dataset:**
1. Buyer_ID
2. First_Name
3. Last_Name
4. Contact
5. Payment_Mode
6. Payment_Settled

### This repository consists of 4 files:
1. CREATE.sql:
   Has the SQL code to create all the dimensions, FACT and Staging Table.
3. ETL.sql:
   Has the SQL code for Extract, Transform and Load of data from the two datasets into Staging, using which Dimensions and FACT Table are populated.
5. Business Questions.sql:
   Two Business Questions from the designed Analytical Database.
7. Business Question Report.png:
   A report of the Business Questions (created in **Tableau**). For simplicity and ease of readability, a .png exported file of the report is uploaded.

A Data Mart consists of a FACT Table and dimensions, which are connected to FACT Table.

**FACT Table:**
A fact table in a data mart contains numerical data (facts) representing business metrics like sales or quantities. It's linked to dimension tables, which provide context and descriptive attributes about the facts, such as product details or customer information.

**Dimensions:**
Dimensions are categorical and hierarchical, offering a structured view of the data. They help in organizing, categorizing, and providing meaning to the data stored in a data mart.

Together, fact tables and dimensions form the core structure of a data mart, enabling efficient analysis and reporting for specific business functions.

A high level idea for creating Data Mart is as follows:
1. Decide on the architecture of Data Mart, dividing into FACT Table and dimensions.
2. Identify Data source.
3. Create a Staging Table, containing all the columns in source data with reference ID columns from all dimensions in Data Mart.
4. Import the data into Staging Table.
5. Populate all the dimensions from Staging Table.
6. Update ID reference columns (for dimensions) in Staging Table
7. Populate all columns in FACT Table using Staging Table
