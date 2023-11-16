# NashvilleHousingDataCleaning

## Overview

This project focuses on cleaning and preparing housing data from the "Housing-Data-Cleaning-Project" database, specifically the "nashvilleHousing" table. The data cleaning process involves addressing issues such as date formatting, handling missing values, populating null addresses, splitting address and owner information, and transforming categorical data.

# Data Cleaning Steps

### 1) Load the Data:
The first step involves loading the initial dataset from the "nashvilleHousing" table. This provides an overview of the data structure and helps identify potential issues.

### 2) Date Format:
The "SaleDate" column is reviewed to ensure a consistent date format. This step involves converting the date to a standard format, facilitating easier analysis and interpretation of temporal trends.

### 3) Populate Property Address Data:
Identifying and addressing missing property addresses is crucial for a comprehensive housing analysis. The "PropertyAddress" column is examined to determine the extent of missing data and develop strategies to populate these gaps.

### 4) Populate Null Addresses Using Reference Point:
Utilizing a reference point, in this case, the "ParcelID," missing property addresses are populated where possible. This step enhances the completeness of the dataset and provides more accurate information for analysis.

### 5) Separate Address into Individual Columns (Address, City, State):
Breaking down the "PropertyAddress" into individual columns such as address, city, and state improves data structure and facilitates more granular analysis. This step enhances the interpretability of the data.

### 6) Split Owner Address:
Similar to the property address, the owner's address is split into separate columns for state, city, and address. This improves the granularity of owner information and supports more detailed analysis.

### 7) Change 'Y' and 'N' to 'Yes' and 'No' in "Sold as Vacant" Field:
Standardizing values in the "SoldAsVacant" field improves clarity and consistency. This step ensures that the data accurately reflects whether a property was sold as vacant, enhancing the interpretability of this categorical variable.

### 8) Remove Duplicates:
Identifying and removing duplicate records is essential for maintaining data integrity. The process involves partitioning the data based on several key fields and retaining only unique records.

### 9) Delete Unused Columns:
Removing unnecessary columns, such as "OwnerAddress," "TaxDistrict," and "SaleDate," streamlines the dataset. This practice adheres to the principle of keeping only relevant information, reducing redundancy, and improving the efficiency of subsequent analyses.

## Contributing 
Contributions to this data cleaning project are welcome. Whether it's suggesting improvements, reporting issues, or submitting pull requests, your collaboration is highly valued.
