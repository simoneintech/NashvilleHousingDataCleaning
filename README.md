# NashvilleHousingDataCleaning

## In this repo:

I have used SQL Server to clean, Nashville Housing Data.

# First,

- I standardized the date. Using **CONVERT** to change the SaleDate to a standard Date format.

# Secondly, 

- I populated the property address, before breaking them out into individual columns (to avoid deleting date before creating the new columns). Using **SUBSTRING** and **PARSENAME** I was then able to seperate the columuns into their own, thus making the data more readable.

# Next,

- I changed Y and N to Yes and No, for more readability using **CASE** statements.

# Then,

- I removed duplicates using **ROW_NUMBER**, **CTE** and Windows function of **PARTITION BY**.

# Lastly,

- I used **ALTER TABLE** and **DROP COLUMN** to drop the coloumns from which I seperated and created new columns. Making data more readible, and removing unnneccesary columns.

