## Task_1.1
SELECT 
# selecting columns from product table 
    product.ProductId, 
    product.Name AS ProductName, 
    product.ProductNumber, 
    product.Size, 
    product.Color, 
    product.ProductSubcategoryId, 
    products.Name AS SubcategoryName
FROM 
# indicating where to find columns
    `adwentureworks_db.product` AS product
JOIN 
# join subatagory with an alias
    `adwentureworks_db.productsubcategory` AS products 
    ON product.ProductSubcategoryId = products.ProductSubcategoryId
WHERE 
# selecting non-empty entries
    product.ProductSubcategoryId IS NOT NULL
ORDER BY 
#organize by name
    products.Name;

## Task_1.2
SELECT 
# selecting columns from table
    product.ProductId, 
    product.Name AS ProductName, 
    product.ProductNumber, 
    product.Size, 
    product.Color, 
    product.ProductSubcategoryId, 
    products.Name AS SubcategoryName,
    productc.Name AS CategoryName
FROM 
# indicating where columns are found
    `adwentureworks_db.product` product
JOIN 
# join subcategory through keys
     `adwentureworks_db.productsubcategory` products ON product.ProductSubcategoryId = products.ProductSubcategoryId
JOIN
# join category through keys
     `adwentureworks_db.productcategory` productc ON products.ProductCategoryId = productc.ProductCategoryId
WHERE 
# selecting non-empty entries
    product.ProductSubcategoryId IS NOT NULL
ORDER BY 
# organize by name of product
    productc.Name;

## Task_1.3
SELECT 
# selecting columns from product table 
    product.ProductId, 
    product.Name AS ProductName, 
    product.ProductNumber, 
    product.Size, 
    product.Color, 
    product.ProductSubcategoryId, 
    products.Name AS SubcategoryName,
    productc.Name AS CategoryName,
    product.ListPrice
FROM 
# indicating where to find columns
    `adwentureworks_db.product` AS product
JOIN 
# join subcategory through keys
    `adwentureworks_db.productsubcategory` products ON product.ProductSubcategoryId = products.ProductSubcategoryId
JOIN 
#  join category through keys
    `adwentureworks_db.productcategory` productc ON products.ProductCategoryId = productc.ProductCategoryId
WHERE 
# selecting condition of price greater than 2000 and bikes are actively sold
    product.ListPrice > 2000 
    AND product.SellEndDate IS NULL
ORDER BY 
# organize by price 
    product.ListPrice DESC;

## Task_2.1
SELECT 
    LocationId,
    COUNT(DISTINCT WorkOrderId) AS UniqueWorkOrders,
    COUNT(DISTINCT ProductId) AS UniqueProducts,
    SUM(ActualCost) AS TotalActualCost
FROM
    `tc-da-1.adwentureworks_db.workorderrouting`
WHERE
    ActualStartDate BETWEEN '2004-01-01' AND '2004-01-31'
GROUP BY
    LocationId
ORDER BY
    TotalActualCost DESC;

## Task_2.2
SELECT 
    wr.LocationId,
    l.Name AS LocationName,
    COUNT(DISTINCT wr.WorkOrderId) AS UniqueWorkOrders,
    COUNT(DISTINCT wr.ProductId) AS UniqueProducts,
    SUM(wr.ActualCost) AS TotalActualCost,
    ROUND(AVG(DATE_DIFF(wr.ActualEndDate, wr.ActualStartDate, DAY)), 2) AS AvgDaysDuration
FROM 
    `tc-da-1.adwentureworks_db.workorderrouting` AS wr
JOIN 
    `tc-da-1.adwentureworks_db.location` AS l
ON 
    wr.LocationId = l.LocationId
WHERE 
    wr.ActualStartDate BETWEEN '2004-01-01' AND '2004-01-31'
GROUP BY 
    wr.LocationId, l.Name
ORDER BY 
    TotalActualCost DESC;

## Task_2.3
SELECT 
    WorkOrderId,
    SUM(ActualCost) AS TotalActualCost,
FROM 
    `tc-da-1.adwentureworks_db.workorderrouting`
WHERE 
    ActualStartDate BETWEEN '2004-01-01' AND '2004-01-31'
GROUP BY
    WorkOrderID
HAVING
    TotalActualCost > 300

## Task_3.1
SELECT 
# issue in join function formatting
    sales_detail.SalesOrderId,
    sales_detail.OrderQty,
    sales_detail.UnitPrice,
    sales_detail.LineTotal,
    sales_detail.ProductId,
    sales_detail.SpecialOfferID,
    spec_offer_product.ModifiedDate,
    spec_offer.Category,
    spec_offer.Description
FROM 
    `tc-da-1.adwentureworks_db.salesorderdetail` AS sales_detail
LEFT JOIN 
    `tc-da-1.adwentureworks_db.specialofferproduct` AS spec_offer_product
ON 
    sales_detail.ProductId = spec_offer_product.ProductID
	AND sales_detail.SpecialOfferID = spec_offer_product.SpecialOfferID
LEFT JOIN 
    `tc-da-1.adwentureworks_db.specialoffer` AS spec_offer
ON 
    sales_detail.SpecialOfferID = spec_offer.SpecialOfferID
ORDER BY 
    LineTotal DESC;

## Task_3.2
SELECT 
# alias issue : incorrect alias usage and typos (e.g., vendor.VendorId should be a.VendorId).
# join function: incorrect join conditions

    a.VendorId AS Id, 
    vendor_contact.ContactId, 
    vendor_contact.ContactTypeId, 
    a.Name, 
    a.CreditRating, 
    a.ActiveFlag, 
    c.AddressId, 
    d.City
FROM 
    `tc-da-1.adwentureworks_db.vendor` AS a
LEFT JOIN 
    `tc-da-1.adwentureworks_db.vendorcontact` AS vendor_contact 
ON 
    a.VendorId = vendor_contact.VendorId
LEFT JOIN 
    `tc-da-1.adwentureworks_db.vendoraddress` AS c 
ON 
    a.VendorId = c.VendorId
LEFT JOIN 
    `tc-da-1.adwentureworks_db.address` AS d 
ON 
    c.AddressId = d.AddressId;

