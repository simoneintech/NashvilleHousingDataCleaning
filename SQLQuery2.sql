--cleaning data

select * 
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

-- date format

select SaleDate, CONVERT(date,SaleDate) 
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

update nashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

-- populate property address data

select PropertyAddress
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

-- to see null property addresses

select * 
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
where PropertyAddress is null 

-- try to populate null addresses using reference point

select *
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
order by ParcelID

-- if parcelid has address, and one does not, we can populate
-- it with the null address, as parcelid and addresses matches up


-- self join to look at if parcelid is equal to propertyaddress 
-- then null propertyaddress needs to equal to parcelid address

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing as A
JOIN [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing as B
	 on a.ParcelID = b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing as A
JOIN [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing as B
	 on a.ParcelID = b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing as A
JOIN [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing as B
	 on a.ParcelID = b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null

-- checking to make sure no null property addresses

select *
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing	
where PropertyAddress is null

-- seperate address into individual columns (Address, City, State)

select PropertyAddress
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

-- adding tables to split property addresses/cities tables 

Alter table nashvilleHousing
add PropertyAddressSplit Nvarchar(255);

Update nashvilleHousing
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter table nashvilleHousing
add PropertySplitCity Nvarchar(255);

Update nashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

-- checking tables were added 

select * 
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing


-- splitting owner address


select OwnerAddress
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

-- adding in the table
 
Alter table nashvilleHousing
add OwnerAddressSplit Nvarchar(255);

Alter table nashvilleHousing
add OwnerSplitCity Nvarchar(255);

Alter table nashvilleHousing
add OwnerSplitState Nvarchar(255);

Update nashvilleHousing
SET OwnerAddressSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

Update nashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

Update nashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

-- checking queries 

select *
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing	


-- changing y and no to yes and no boolean in "sold as vacant" field 

select distinct(SoldAsVacant)
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
Group by SoldAsVacant
order by 2

select SoldASVacant
, CASE when SoldAsVacant = 'Y' then 'Yes'
	   when SoldAsVacant = 'N' then 'No'
	   ELSE SoldAsVacant
	   END
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing


UPDATE nashvilleHousing
SET SoldAsVacant =
CASE when SoldAsVacant = 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
	 ELSE SoldAsVacant
	 END

-- checking update

select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
Group by SoldAsVacant
order by 2

-- remove duplicates (not standard practice, just practicing cleaning data solely in SQL)

-- to see what we need to pratition data by
select *
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing


select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID
				 ) as Row_Num
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
ORDER BY ParcelID

-- using cte to see where row_num is > 1

WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID
					) Row_Num
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
)

SELECT * 
from RowNumCTE
where row_num > 1
order by PropertyAddress

------------ removing duplicates 

WITH RowNumCTE AS(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID
					) Row_Num
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
)

DELETE
from RowNumCTE
where row_num > 1


-- delete unused columns (not best practice, just practicing cleaning data in sql)

select *
from [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing

alter table [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

alter table [Housing-Data-Cleaning-Porject].dbo.nashvilleHousing
DROP COLUMN SaleDate














































