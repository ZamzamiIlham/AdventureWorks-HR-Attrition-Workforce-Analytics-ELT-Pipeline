CREATE EXTENSION "uuid-ossp";


CREATE UNIQUE INDEX "AK_Department_Name" ON "HumanResources"."Department"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_Employee_LoginID" ON "HumanResources"."Employee"
(
    "LoginID" ASC
);

CREATE UNIQUE INDEX "AK_Employee_NationalIDNumber" ON "HumanResources"."Employee"
(
    "NationalIDNumber" ASC
);

CREATE UNIQUE INDEX "AK_Employee_rowguid" ON "HumanResources"."Employee"
(
    "rowguid" ASC
);

CREATE INDEX "IX_Employee_OrganizationLevel_OrganizationNode" ON "HumanResources"."Employee"
(
    "OrganizationLevel" ASC,
    "OrganizationNode" ASC
);

CREATE INDEX "IX_Employee_OrganizationNode" ON "HumanResources"."Employee"
(
    "OrganizationNode" ASC
);

CREATE INDEX "IX_EmployeeDepartmentHistory_DepartmentID" ON "HumanResources"."EmployeeDepartmentHistory"
(
    "DepartmentID" ASC
);

CREATE INDEX "IX_EmployeeDepartmentHistory_ShiftID" ON "HumanResources"."EmployeeDepartmentHistory"
(
    "ShiftID" ASC
);

CREATE INDEX "IX_JobCandidate_BusinessEntityID" ON "HumanResources"."JobCandidate"
(
    "BusinessEntityID" ASC
);

CREATE UNIQUE INDEX "AK_Shift_Name" ON "HumanResources"."Shift"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_Shift_StartTime_EndTime" ON "HumanResources"."Shift"
(
    "StartTime" ASC,
    "EndTime" ASC
);

CREATE UNIQUE INDEX "AK_Address_rowguid" ON "Person"."Address"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode" ON "Person"."Address"
(
    "AddressLine1" ASC,
    "AddressLine2" ASC,
    "City" ASC,
    "StateProvinceID" ASC,
    "PostalCode" ASC
);

CREATE INDEX "IX_Address_StateProvinceID" ON "Person"."Address"
(
    "StateProvinceID" ASC
);

CREATE UNIQUE INDEX "AK_AddressType_Name" ON "Person"."AddressType"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_AddressType_rowguid" ON "Person"."AddressType"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_BusinessEntity_rowguid" ON "Person"."BusinessEntity"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_BusinessEntityAddress_rowguid" ON "Person"."BusinessEntityAddress"
(
    "rowguid" ASC
);

CREATE INDEX "IX_BusinessEntityAddress_AddressID" ON "Person"."BusinessEntityAddress"
(
    "AddressID" ASC
);

CREATE INDEX "IX_BusinessEntityAddress_AddressTypeID" ON "Person"."BusinessEntityAddress"
(
    "AddressTypeID" ASC
);

CREATE UNIQUE INDEX "AK_BusinessEntityContact_rowguid" ON "Person"."BusinessEntityContact"
(
    "rowguid" ASC
);

CREATE INDEX "IX_BusinessEntityContact_ContactTypeID" ON "Person"."BusinessEntityContact"
(
    "ContactTypeID" ASC
);

CREATE INDEX "IX_BusinessEntityContact_PersonID" ON "Person"."BusinessEntityContact"
(
    "PersonID" ASC
);

CREATE UNIQUE INDEX "AK_ContactType_Name" ON "Person"."ContactType"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_CountryRegion_Name" ON "Person"."CountryRegion"
(
    "Name" ASC
);

CREATE INDEX "IX_EmailAddress_EmailAddress" ON "Person"."EmailAddress"
(
    "EmailAddress" ASC
);

CREATE UNIQUE INDEX "AK_Person_rowguid" ON "Person"."Person"
(
    "rowguid" ASC
);

CREATE INDEX "IX_Person_LastName_FirstName_MiddleName" ON "Person"."Person"
(
    "LastName" ASC,
    "FirstName" ASC,
    "MiddleName" ASC
);

CREATE INDEX "IX_PersonPhone_PhoneNumber" ON "Person"."PersonPhone"
(
    "PhoneNumber" ASC
);

CREATE UNIQUE INDEX "AK_StateProvince_Name" ON "Person"."StateProvince"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_StateProvince_rowguid" ON "Person"."StateProvince"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_StateProvince_StateProvinceCode_CountryRegionCode" ON "Person"."StateProvince"
(
    "StateProvinceCode" ASC,
    "CountryRegionCode" ASC
);

CREATE INDEX "IX_BillOfMaterials_UnitMeasureCode" ON "Production"."BillOfMaterials"
(
    "UnitMeasureCode" ASC
);

CREATE UNIQUE INDEX "AK_Culture_Name" ON "Production"."Culture"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_Document_DocumentLevel_DocumentNode" ON "Production"."Document"
(
    "DocumentLevel" ASC,
    "DocumentNode" ASC
);

CREATE UNIQUE INDEX "AK_Document_rowguid" ON "Production"."Document"
(
    "rowguid" ASC
);

CREATE INDEX "IX_Document_FileName_Revision" ON "Production"."Document"
(
    "FileName" ASC,
    "Revision" ASC
);

CREATE UNIQUE INDEX "AK_Location_Name" ON "Production"."Location"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_Product_Name" ON "Production"."Product"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_Product_ProductNumber" ON "Production"."Product"
(
    "ProductNumber" ASC
);

CREATE UNIQUE INDEX "AK_Product_rowguid" ON "Production"."Product"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_ProductCategory_Name" ON "Production"."ProductCategory"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_ProductCategory_rowguid" ON "Production"."ProductCategory"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_ProductDescription_rowguid" ON "Production"."ProductDescription"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_ProductModel_Name" ON "Production"."ProductModel"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_ProductModel_rowguid" ON "Production"."ProductModel"
(
    "rowguid" ASC
);

CREATE INDEX "IX_ProductReview_ProductID_Name" ON "Production"."ProductReview"
(
    "ProductID" ASC,
    "ReviewerName" ASC
)
INCLUDE("Comments") ;

CREATE UNIQUE INDEX "AK_ProductSubcategory_Name" ON "Production"."ProductSubcategory"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_ProductSubcategory_rowguid" ON "Production"."ProductSubcategory"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_ScrapReason_Name" ON "Production"."ScrapReason"
(
    "Name" ASC
);

CREATE INDEX "IX_TransactionHistory_ProductID" ON "Production"."TransactionHistory"
(
    "ProductID" ASC
);

CREATE INDEX "IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID" ON "Production"."TransactionHistory"
(
    "ReferenceOrderID" ASC,
    "ReferenceOrderLineID" ASC
);

CREATE INDEX "IX_TransactionHistoryArchive_ProductID" ON "Production"."TransactionHistoryArchive"
(
    "ProductID" ASC
);

CREATE INDEX "IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID" ON "Production"."TransactionHistoryArchive"
(
    "ReferenceOrderID" ASC,
    "ReferenceOrderLineID" ASC
);

CREATE UNIQUE INDEX "AK_UnitMeasure_Name" ON "Production"."UnitMeasure"
(
    "Name" ASC
);

CREATE INDEX "IX_WorkOrder_ProductID" ON "Production"."WorkOrder"
(
    "ProductID" ASC
);

CREATE INDEX "IX_WorkOrder_ScrapReasonID" ON "Production"."WorkOrder"
(
    "ScrapReasonID" ASC
);

CREATE INDEX "IX_WorkOrderRouting_ProductID" ON "Production"."WorkOrderRouting"
(
    "ProductID" ASC
);

CREATE INDEX "IX_ProductVendor_BusinessEntityID" ON "Purchasing"."ProductVendor"
(
    "BusinessEntityID" ASC
);

CREATE INDEX "IX_ProductVendor_UnitMeasureCode" ON "Purchasing"."ProductVendor"
(
    "UnitMeasureCode" ASC
);

CREATE INDEX "IX_PurchaseOrderDetail_ProductID" ON "Purchasing"."PurchaseOrderDetail"
(
    "ProductID" ASC
);

CREATE INDEX "IX_PurchaseOrderHeader_EmployeeID" ON "Purchasing"."PurchaseOrderHeader"
(
    "EmployeeID" ASC
);

CREATE INDEX "IX_PurchaseOrderHeader_VendorID" ON "Purchasing"."PurchaseOrderHeader"
(
    "VendorID" ASC
);

CREATE UNIQUE INDEX "AK_ShipMethod_Name" ON "Purchasing"."ShipMethod"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_ShipMethod_rowguid" ON "Purchasing"."ShipMethod"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_Vendor_AccountNumber" ON "Purchasing"."Vendor"
(
    "AccountNumber" ASC
);

CREATE INDEX "IX_CountryRegionCurrency_CurrencyCode" ON "Sales"."CountryRegionCurrency"
(
    "CurrencyCode" ASC
);

CREATE UNIQUE INDEX "AK_CreditCard_CardNumber" ON "Sales"."CreditCard"
(
    "CardNumber" ASC
);

CREATE UNIQUE INDEX "AK_Currency_Name" ON "Sales"."Currency"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode" ON "Sales"."CurrencyRate"
(
    "CurrencyRateDate" ASC,
    "FromCurrencyCode" ASC,
    "ToCurrencyCode" ASC
);

CREATE UNIQUE INDEX "AK_Customer_AccountNumber" ON "Sales"."Customer"
(
    "AccountNumber" ASC
);

CREATE UNIQUE INDEX "AK_Customer_rowguid" ON "Sales"."Customer"
(
    "rowguid" ASC
);

CREATE INDEX "IX_Customer_TerritoryID" ON "Sales"."Customer"
(
    "TerritoryID" ASC
);

CREATE UNIQUE INDEX "AK_SalesOrderDetail_rowguid" ON "Sales"."SalesOrderDetail"
(
    "rowguid" ASC
);

CREATE INDEX "IX_SalesOrderDetail_ProductID" ON "Sales"."SalesOrderDetail"
(
    "ProductID" ASC
);

CREATE UNIQUE INDEX "AK_SalesOrderHeader_rowguid" ON "Sales"."SalesOrderHeader"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_SalesOrderHeader_SalesOrderNumber" ON "Sales"."SalesOrderHeader"
(
    "SalesOrderNumber" ASC
);

CREATE INDEX "IX_SalesOrderHeader_CustomerID" ON "Sales"."SalesOrderHeader"
(
    "CustomerID" ASC
);

CREATE INDEX "IX_SalesOrderHeader_SalesPersonID" ON "Sales"."SalesOrderHeader"
(
    "SalesPersonID" ASC
);

CREATE UNIQUE INDEX "AK_SalesPerson_rowguid" ON "Sales"."SalesPerson"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_SalesPersonQuotaHistory_rowguid" ON "Sales"."SalesPersonQuotaHistory"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_SalesTaxRate_rowguid" ON "Sales"."SalesTaxRate"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_SalesTaxRate_StateProvinceID_TaxType" ON "Sales"."SalesTaxRate"
(
    "StateProvinceID" ASC,
    "TaxType" ASC
);

CREATE UNIQUE INDEX "AK_SalesTerritory_Name" ON "Sales"."SalesTerritory"
(
    "Name" ASC
);

CREATE UNIQUE INDEX "AK_SalesTerritory_rowguid" ON "Sales"."SalesTerritory"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_SalesTerritoryHistory_rowguid" ON "Sales"."SalesTerritoryHistory"
(
    "rowguid" ASC
);

CREATE INDEX "IX_ShoppingCartItem_ShoppingCartID_ProductID" ON "Sales"."ShoppingCartItem"
(
    "ShoppingCartID" ASC,
    "ProductID" ASC
);

CREATE UNIQUE INDEX "AK_SpecialOffer_rowguid" ON "Sales"."SpecialOffer"
(
    "rowguid" ASC
);

CREATE UNIQUE INDEX "AK_SpecialOfferProduct_rowguid" ON "Sales"."SpecialOfferProduct"
(
    "rowguid" ASC
);

CREATE INDEX "IX_SpecialOfferProduct_ProductID" ON "Sales"."SpecialOfferProduct"
(
    "ProductID" ASC
);

CREATE UNIQUE INDEX "AK_Store_rowguid" ON "Sales"."Store"
(
    "rowguid" ASC
);

CREATE INDEX "IX_Store_SalesPersonID" ON "Sales"."Store"
(
    "SalesPersonID" ASC
);
ALTER TABLE "public"."AWBuildVersion" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "public"."ErrorLog" ALTER COLUMN "ErrorTime" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."Department" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."Employee" ALTER COLUMN "SalariedFlag" SET DEFAULT (true); 
ALTER TABLE "HumanResources"."Employee" ALTER COLUMN "VacationHours" SET DEFAULT ((0)); 
ALTER TABLE "HumanResources"."Employee" ALTER COLUMN "SickLeaveHours" SET DEFAULT ((0)); 
ALTER TABLE "HumanResources"."Employee" ALTER COLUMN "CurrentFlag" SET DEFAULT (true); 
ALTER TABLE "HumanResources"."Employee" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "HumanResources"."Employee" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."EmployeeDepartmentHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."EmployeePayHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."JobCandidate" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."Shift" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."Address" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."Address" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."AddressType" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."AddressType" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."BusinessEntity" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."BusinessEntity" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."BusinessEntityAddress" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."BusinessEntityAddress" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."BusinessEntityContact" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."BusinessEntityContact" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."ContactType" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."CountryRegion" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."EmailAddress" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."EmailAddress" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."Password" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."Password" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."Person" ALTER COLUMN "NameStyle" SET DEFAULT ((0)); 
ALTER TABLE "Person"."Person" ALTER COLUMN "EmailPromotion" SET DEFAULT ((0)); 
ALTER TABLE "Person"."Person" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."Person" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."PersonPhone" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."PhoneNumberType" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Person"."StateProvince" ALTER COLUMN "IsOnlyStateProvinceFlag" SET DEFAULT (true); 
ALTER TABLE "Person"."StateProvince" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Person"."StateProvince" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."BillOfMaterials" ALTER COLUMN "StartDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."BillOfMaterials" ALTER COLUMN "PerAssemblyQty" SET DEFAULT ((1.00)); 
ALTER TABLE "Production"."BillOfMaterials" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."Culture" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."Document" ALTER COLUMN "FolderFlag" SET DEFAULT (false); 
ALTER TABLE "Production"."Document" ALTER COLUMN "ChangeNumber" SET DEFAULT ((0)); 
ALTER TABLE "Production"."Document" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."Document" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."Illustration" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."Location" ALTER COLUMN "CostRate" SET DEFAULT ((0.00)); 
ALTER TABLE "Production"."Location" ALTER COLUMN "Availability" SET DEFAULT ((0.00)); 
ALTER TABLE "Production"."Location" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."Product" ALTER COLUMN "MakeFlag" SET DEFAULT (1); 
ALTER TABLE "Production"."Product" ALTER COLUMN "FinishedGoodsFlag" SET DEFAULT (1); 
ALTER TABLE "Production"."Product" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."Product" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductCategory" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."ProductCategory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductCostHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductDescription" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."ProductDescription" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductDocument" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductInventory" ALTER COLUMN "Quantity" SET DEFAULT ((0)); 
ALTER TABLE "Production"."ProductInventory" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."ProductInventory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductListPriceHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductModel" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."ProductModel" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductModelIllustration" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductModelProductDescriptionCulture" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductPhoto" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductProductPhoto" ALTER COLUMN "Primary" SET DEFAULT (false); 
ALTER TABLE "Production"."ProductProductPhoto" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductReview" ALTER COLUMN "ReviewDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductReview" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ProductSubcategory" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Production"."ProductSubcategory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."ScrapReason" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."TransactionHistory" ALTER COLUMN "ReferenceOrderLineID" SET DEFAULT ((0)); 
ALTER TABLE "Production"."TransactionHistory" ALTER COLUMN "TransactionDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."TransactionHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."TransactionHistoryArchive" ALTER COLUMN "ReferenceOrderLineID" SET DEFAULT ((0)); 
ALTER TABLE "Production"."TransactionHistoryArchive" ALTER COLUMN "TransactionDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."TransactionHistoryArchive" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."UnitMeasure" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."WorkOrder" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Production"."WorkOrderRouting" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Purchasing"."ProductVendor" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "RevisionNumber" SET DEFAULT ((0)); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "Status" SET DEFAULT ((1)); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "OrderDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "SubTotal" SET DEFAULT ((0.00)); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "TaxAmt" SET DEFAULT ((0.00)); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "Freight" SET DEFAULT ((0.00)); 
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Purchasing"."ShipMethod" ALTER COLUMN "ShipBase" SET DEFAULT ((0.00)); 
ALTER TABLE "Purchasing"."ShipMethod" ALTER COLUMN "ShipRate" SET DEFAULT ((0.00)); 
ALTER TABLE "Purchasing"."ShipMethod" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Purchasing"."ShipMethod" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Purchasing"."Vendor" ALTER COLUMN "PreferredVendorStatus" SET DEFAULT (true); 
ALTER TABLE "Purchasing"."Vendor" ALTER COLUMN "ActiveFlag" SET DEFAULT (true); 
ALTER TABLE "Purchasing"."Vendor" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."CountryRegionCurrency" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."CreditCard" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."Currency" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."CurrencyRate" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."Customer" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."Customer" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."PersonCreditCard" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesOrderDetail" ALTER COLUMN "UnitPriceDiscount" SET DEFAULT ((0.0)); 
ALTER TABLE "Sales"."SalesOrderDetail" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesOrderDetail" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "RevisionNumber" SET DEFAULT ((0)); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "OrderDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "Status" SET DEFAULT ((1)); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "OnlineOrderFlag" SET DEFAULT (true); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "SubTotal" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "TaxAmt" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "Freight" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesOrderHeader" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesOrderHeaderSalesReason" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesPerson" ALTER COLUMN "Bonus" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesPerson" ALTER COLUMN "CommissionPct" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesPerson" ALTER COLUMN "SalesYTD" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesPerson" ALTER COLUMN "SalesLastYear" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesPerson" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesPerson" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesPersonQuotaHistory" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesPersonQuotaHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesReason" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesTaxRate" ALTER COLUMN "TaxRate" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesTaxRate" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesTaxRate" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesTerritory" ALTER COLUMN "SalesYTD" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesTerritory" ALTER COLUMN "SalesLastYear" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesTerritory" ALTER COLUMN "CostYTD" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesTerritory" ALTER COLUMN "CostLastYear" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SalesTerritory" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesTerritory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SalesTerritoryHistory" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SalesTerritoryHistory" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."ShoppingCartItem" ALTER COLUMN "Quantity" SET DEFAULT ((1)); 
ALTER TABLE "Sales"."ShoppingCartItem" ALTER COLUMN "DateCreated" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."ShoppingCartItem" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SpecialOffer" ALTER COLUMN "DiscountPct" SET DEFAULT ((0.00)); 
ALTER TABLE "Sales"."SpecialOffer" ALTER COLUMN "MinQty" SET DEFAULT ((0)); 
ALTER TABLE "Sales"."SpecialOffer" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SpecialOffer" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."SpecialOfferProduct" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."SpecialOfferProduct" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "Sales"."Store" ALTER COLUMN "rowguid" SET DEFAULT (uuid_generate_v4()); 
ALTER TABLE "Sales"."Store" ALTER COLUMN "ModifiedDate" SET DEFAULT (CURRENT_DATE); 
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "FK_Employee_Person_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "HumanResources"."EmployeeDepartmentHistory" ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY("DepartmentID")
    REFERENCES "HumanResources"."Department" ("DepartmentID");
ALTER TABLE "HumanResources"."EmployeeDepartmentHistory" ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "HumanResources"."Employee" ("BusinessEntityID");
ALTER TABLE "HumanResources"."EmployeeDepartmentHistory" ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY("ShiftID")
    REFERENCES "HumanResources"."Shift" ("ShiftID");
ALTER TABLE "HumanResources"."EmployeePayHistory" ADD CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "HumanResources"."Employee" ("BusinessEntityID");
ALTER TABLE "HumanResources"."JobCandidate" ADD CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "HumanResources"."Employee" ("BusinessEntityID");
ALTER TABLE "Person"."Address" ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY("StateProvinceID")
    REFERENCES "Person"."StateProvince" ("StateProvinceID");
ALTER TABLE "Person"."BusinessEntityAddress" ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY("AddressID")
    REFERENCES "Person"."Address" ("AddressID");
ALTER TABLE "Person"."BusinessEntityAddress" ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY("AddressTypeID")
    REFERENCES "Person"."AddressType" ("AddressTypeID");
ALTER TABLE "Person"."BusinessEntityAddress" ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."BusinessEntity" ("BusinessEntityID");
ALTER TABLE "Person"."BusinessEntityContact" ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."BusinessEntity" ("BusinessEntityID");
ALTER TABLE "Person"."BusinessEntityContact" ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY("ContactTypeID")
    REFERENCES "Person"."ContactType" ("ContactTypeID");
ALTER TABLE "Person"."BusinessEntityContact" ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY("PersonID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "Person"."EmailAddress" ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "Person"."Password" ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "Person"."Person" ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."BusinessEntity" ("BusinessEntityID");
ALTER TABLE "Person"."PersonPhone" ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "Person"."PersonPhone" ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY("PhoneNumberTypeID")
    REFERENCES "Person"."PhoneNumberType" ("PhoneNumberTypeID");
ALTER TABLE "Person"."StateProvince" ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY("CountryRegionCode")
    REFERENCES "Person"."CountryRegion" ("CountryRegionCode");
ALTER TABLE "Person"."StateProvince" ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY("TerritoryID")
    REFERENCES "Sales"."SalesTerritory" ("TerritoryID");
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY("ComponentID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY("ProductAssemblyID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY("UnitMeasureCode")
    REFERENCES "Production"."UnitMeasure" ("UnitMeasureCode");
ALTER TABLE "Production"."Document" ADD CONSTRAINT "FK_Document_Employee_Owner" FOREIGN KEY("Owner")
    REFERENCES "HumanResources"."Employee" ("BusinessEntityID");
ALTER TABLE "Production"."Product" ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY("ProductModelID")
    REFERENCES "Production"."ProductModel" ("ProductModelID");
ALTER TABLE "Production"."Product" ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY("ProductSubcategoryID")
    REFERENCES "Production"."ProductSubcategory" ("ProductSubcategoryID");
ALTER TABLE "Production"."Product" ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY("SizeUnitMeasureCode")
    REFERENCES "Production"."UnitMeasure" ("UnitMeasureCode");
ALTER TABLE "Production"."Product" ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY("WeightUnitMeasureCode")
    REFERENCES "Production"."UnitMeasure" ("UnitMeasureCode");
ALTER TABLE "Production"."ProductCostHistory" ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."ProductDocument" ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY("DocumentNode")
    REFERENCES "Production"."Document" ("DocumentNode");
ALTER TABLE "Production"."ProductDocument" ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."ProductInventory" ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY("LocationID")
    REFERENCES "Production"."Location" ("LocationID");
ALTER TABLE "Production"."ProductInventory" ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."ProductListPriceHistory" ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."ProductModelIllustration" ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY("IllustrationID")
    REFERENCES "Production"."Illustration" ("IllustrationID");
ALTER TABLE "Production"."ProductModelIllustration" ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY("ProductModelID")
    REFERENCES "Production"."ProductModel" ("ProductModelID");
ALTER TABLE "Production"."ProductModelProductDescriptionCulture" ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY("CultureID")
    REFERENCES "Production"."Culture" ("CultureID");
ALTER TABLE "Production"."ProductModelProductDescriptionCulture" ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID" FOREIGN KEY("ProductDescriptionID")
    REFERENCES "Production"."ProductDescription" ("ProductDescriptionID");
ALTER TABLE "Production"."ProductModelProductDescriptionCulture" ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID" FOREIGN KEY("ProductModelID")
    REFERENCES "Production"."ProductModel" ("ProductModelID");
ALTER TABLE "Production"."ProductProductPhoto" ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."ProductProductPhoto" ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY("ProductPhotoID")
    REFERENCES "Production"."ProductPhoto" ("ProductPhotoID");
ALTER TABLE "Production"."ProductReview" ADD CONSTRAINT "FK_ProductReview_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."ProductSubcategory" ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY("ProductCategoryID")
    REFERENCES "Production"."ProductCategory" ("ProductCategoryID");
ALTER TABLE "Production"."TransactionHistory" ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."WorkOrder" ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Production"."WorkOrder" ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY("ScrapReasonID")
    REFERENCES "Production"."ScrapReason" ("ScrapReasonID");
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY("LocationID")
    REFERENCES "Production"."Location" ("LocationID");
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY("WorkOrderID")
    REFERENCES "Production"."WorkOrder" ("WorkOrderID");
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY("UnitMeasureCode")
    REFERENCES "Production"."UnitMeasure" ("UnitMeasureCode");
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Purchasing"."Vendor" ("BusinessEntityID");
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY("PurchaseOrderID")
    REFERENCES "Purchasing"."PurchaseOrderHeader" ("PurchaseOrderID");
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID" FOREIGN KEY("EmployeeID")
    REFERENCES "HumanResources"."Employee" ("BusinessEntityID");
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY("ShipMethodID")
    REFERENCES "Purchasing"."ShipMethod" ("ShipMethodID");
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY("VendorID")
    REFERENCES "Purchasing"."Vendor" ("BusinessEntityID");
ALTER TABLE "Purchasing"."Vendor" ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."BusinessEntity" ("BusinessEntityID");
ALTER TABLE "Sales"."CountryRegionCurrency" ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY("CountryRegionCode")
    REFERENCES "Person"."CountryRegion" ("CountryRegionCode");
ALTER TABLE "Sales"."CountryRegionCurrency" ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY("CurrencyCode")
    REFERENCES "Sales"."Currency" ("CurrencyCode");
ALTER TABLE "Sales"."CurrencyRate" ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY("FromCurrencyCode")
    REFERENCES "Sales"."Currency" ("CurrencyCode");
ALTER TABLE "Sales"."CurrencyRate" ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY("ToCurrencyCode")
    REFERENCES "Sales"."Currency" ("CurrencyCode");
ALTER TABLE "Sales"."Customer" ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY("PersonID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "Sales"."Customer" ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY("TerritoryID")
    REFERENCES "Sales"."SalesTerritory" ("TerritoryID");
ALTER TABLE "Sales"."Customer" ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY("StoreID")
    REFERENCES "Sales"."Store" ("BusinessEntityID");
ALTER TABLE "Sales"."PersonCreditCard" ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY("CreditCardID")
    REFERENCES "Sales"."CreditCard" ("CreditCardID");
ALTER TABLE "Sales"."PersonCreditCard" ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."Person" ("BusinessEntityID");
ALTER TABLE "Sales"."SalesOrderDetail" ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY("SalesOrderID")
    REFERENCES "Sales"."SalesOrderHeader" ("SalesOrderID")
ON DELETE CASCADE;
ALTER TABLE "Sales"."SalesOrderDetail" ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY("SpecialOfferID", "ProductID")
    REFERENCES "Sales"."SpecialOfferProduct" ("SpecialOfferID", "ProductID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY("BillToAddressID")
    REFERENCES "Person"."Address" ("AddressID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY("ShipToAddressID")
    REFERENCES "Person"."Address" ("AddressID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY("CreditCardID")
    REFERENCES "Sales"."CreditCard" ("CreditCardID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY("CurrencyRateID")
    REFERENCES "Sales"."CurrencyRate" ("CurrencyRateID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY("CustomerID")
    REFERENCES "Sales"."Customer" ("CustomerID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY("SalesPersonID")
    REFERENCES "Sales"."SalesPerson" ("BusinessEntityID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY("TerritoryID")
    REFERENCES "Sales"."SalesTerritory" ("TerritoryID");
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY("ShipMethodID")
    REFERENCES "Purchasing"."ShipMethod" ("ShipMethodID");
ALTER TABLE "Sales"."SalesOrderHeaderSalesReason" ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY("SalesOrderID")
    REFERENCES "Sales"."SalesOrderHeader" ("SalesOrderID")
ON DELETE CASCADE;
ALTER TABLE "Sales"."SalesOrderHeaderSalesReason" ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY("SalesReasonID")
    REFERENCES "Sales"."SalesReason" ("SalesReasonID");
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "HumanResources"."Employee" ("BusinessEntityID");
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY("TerritoryID")
    REFERENCES "Sales"."SalesTerritory" ("TerritoryID");
ALTER TABLE "Sales"."SalesPersonQuotaHistory" ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Sales"."SalesPerson" ("BusinessEntityID");
ALTER TABLE "Sales"."SalesTaxRate" ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY("StateProvinceID")
    REFERENCES "Person"."StateProvince" ("StateProvinceID");
ALTER TABLE "Sales"."SalesTerritory" ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY("CountryRegionCode")
    REFERENCES "Person"."CountryRegion" ("CountryRegionCode");
ALTER TABLE "Sales"."SalesTerritoryHistory" ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Sales"."SalesPerson" ("BusinessEntityID");
ALTER TABLE "Sales"."SalesTerritoryHistory" ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY("TerritoryID")
    REFERENCES "Sales"."SalesTerritory" ("TerritoryID");
ALTER TABLE "Sales"."ShoppingCartItem" ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Sales"."SpecialOfferProduct" ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY("ProductID")
    REFERENCES "Production"."Product" ("ProductID");
ALTER TABLE "Sales"."SpecialOfferProduct" ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY("SpecialOfferID")
    REFERENCES "Sales"."SpecialOffer" ("SpecialOfferID");
ALTER TABLE "Sales"."Store" ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY("BusinessEntityID")
    REFERENCES "Person"."BusinessEntity" ("BusinessEntityID");
ALTER TABLE "Sales"."Store" ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY("SalesPersonID")
    REFERENCES "Sales"."SalesPerson" ("BusinessEntityID");
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "CK_Employee_BirthDate" CHECK  (("BirthDate">='1930-01-01' AND "BirthDate"<=(CURRENT_DATE + INTERVAL '-18 year')));
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "CK_Employee_Gender" CHECK  ((upper("Gender")='F' OR upper("Gender")='M'));
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "CK_Employee_HireDate" CHECK  (("HireDate">='1996-07-01' AND "HireDate"<=(CURRENT_DATE + INTERVAL '1 day')));
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "CK_Employee_MaritalStatus" CHECK  ((upper("MaritalStatus")='S' OR upper("MaritalStatus")='M'));
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "CK_Employee_SickLeaveHours" CHECK  (("SickLeaveHours">=(0) AND "SickLeaveHours"<=(120)));
ALTER TABLE "HumanResources"."Employee" ADD CONSTRAINT "CK_Employee_VacationHours" CHECK  (("VacationHours">=(-40) AND "VacationHours"<=(240)));
ALTER TABLE "HumanResources"."EmployeeDepartmentHistory" ADD CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK  (("EndDate">="StartDate" OR "EndDate" IS NULL));
ALTER TABLE "HumanResources"."EmployeePayHistory" ADD CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK  (("PayFrequency"=(2) OR "PayFrequency"=(1)));
ALTER TABLE "HumanResources"."EmployeePayHistory" ADD CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK  (("Rate">=(6.50) AND "Rate"<=(200.00)));
ALTER TABLE "Person"."Person" ADD CONSTRAINT "CK_Person_EmailPromotion" CHECK  (("EmailPromotion">=(0) AND "EmailPromotion"<=(2)));
ALTER TABLE "Person"."Person" ADD CONSTRAINT "CK_Person_PersonType" CHECK  (("PersonType" IS NULL OR (upper("PersonType")='GC' OR upper("PersonType")='SP' OR upper("PersonType")='EM' OR upper("PersonType")='IN' OR upper("PersonType")='VC' OR upper("PersonType")='SC')));
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK  (("ProductAssemblyID" IS NULL AND "BOMLevel"=(0) AND "PerAssemblyQty"=(1.00) OR "ProductAssemblyID" IS NOT NULL AND "BOMLevel">=(1)));
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK  (("EndDate">"StartDate" OR "EndDate" IS NULL));
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK  (("PerAssemblyQty">=(1.00)));
ALTER TABLE "Production"."BillOfMaterials" ADD CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK  (("ProductAssemblyID"<>"ComponentID"));
ALTER TABLE "Production"."Document" ADD CONSTRAINT "CK_Document_Status" CHECK  (("Status">=(1) AND "Status"<=(3)));
ALTER TABLE "Production"."Location" ADD CONSTRAINT "CK_Location_Availability" CHECK  (("Availability">=(0.00)));
ALTER TABLE "Production"."Location" ADD CONSTRAINT "CK_Location_CostRate" CHECK  (("CostRate">=(0.00)));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_Class" CHECK  ((upper("Class")='H' OR upper("Class")='M' OR upper("Class")='L' OR "Class" IS NULL));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_DaysToManufacture" CHECK  (("DaysToManufacture">=(0)));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_ListPrice" CHECK  (("ListPrice">=(0.00)));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_ProductLine" CHECK  ((upper("ProductLine")='R' OR upper("ProductLine")='M' OR upper("ProductLine")='T' OR upper("ProductLine")='S' OR "ProductLine" IS NULL));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_ReorderPoint" CHECK  (("ReorderPoint">(0)));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_SafetyStockLevel" CHECK  (("SafetyStockLevel">(0)));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_SellEndDate" CHECK  (("SellEndDate">="SellStartDate" OR "SellEndDate" IS NULL));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_StandardCost" CHECK  (("StandardCost">=(0.00)));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_Style" CHECK  ((upper("Style")='U' OR upper("Style")='M' OR upper("Style")='W' OR "Style" IS NULL));
ALTER TABLE "Production"."Product" ADD CONSTRAINT "CK_Product_Weight" CHECK  (("Weight">(0.00)));
ALTER TABLE "Production"."ProductCostHistory" ADD CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK  (("EndDate">="StartDate" OR "EndDate" IS NULL));
ALTER TABLE "Production"."ProductCostHistory" ADD CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK  (("StandardCost">=(0.00)));
ALTER TABLE "Production"."ProductInventory" ADD CONSTRAINT "CK_ProductInventory_Bin" CHECK  (("Bin">=(0) AND "Bin"<=(100)));
-- ALTER TABLE "Production"."ProductInventory" ADD CONSTRAINT "CK_ProductInventory_Shelf" CHECK  (("Shelf" like '"A-Za-z"' OR "Shelf"='N/A'));
ALTER TABLE "Production"."ProductListPriceHistory" ADD CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK  (("EndDate">="StartDate" OR "EndDate" IS NULL));
ALTER TABLE "Production"."ProductListPriceHistory" ADD CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK  (("ListPrice">(0.00)));
ALTER TABLE "Production"."ProductReview" ADD CONSTRAINT "CK_ProductReview_Rating" CHECK  (("Rating">=(1) AND "Rating"<=(5)));
ALTER TABLE "Production"."TransactionHistory" ADD CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK  ((upper("TransactionType")='P' OR upper("TransactionType")='S' OR upper("TransactionType")='W'));
ALTER TABLE "Production"."TransactionHistoryArchive" ADD CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK  ((upper("TransactionType")='P' OR upper("TransactionType")='S' OR upper("TransactionType")='W'));
ALTER TABLE "Production"."WorkOrder" ADD CONSTRAINT "CK_WorkOrder_EndDate" CHECK  (("EndDate">="StartDate" OR "EndDate" IS NULL));
ALTER TABLE "Production"."WorkOrder" ADD CONSTRAINT "CK_WorkOrder_OrderQty" CHECK  (("OrderQty">(0)));
ALTER TABLE "Production"."WorkOrder" ADD CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK  (("ScrappedQty">=(0)));
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK  (("ActualCost">(0.00)));
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK  (("ActualEndDate">="ActualStartDate" OR "ActualEndDate" IS NULL OR "ActualStartDate" IS NULL));
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK  (("ActualResourceHrs">=(0.0000)));
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK  (("PlannedCost">(0.00)));
ALTER TABLE "Production"."WorkOrderRouting" ADD CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK  (("ScheduledEndDate">="ScheduledStartDate"));
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK  (("AverageLeadTime">=(1)));
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK  (("LastReceiptCost">(0.00)));
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK  (("MaxOrderQty">=(1)));
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK  (("MinOrderQty">=(1)));
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK  (("OnOrderQty">=(0)));
ALTER TABLE "Purchasing"."ProductVendor" ADD CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK  (("StandardPrice">(0.00)));
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ADD CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK  (("OrderQty">(0)));
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ADD CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK  (("ReceivedQty">=(0.00)));
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ADD CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK  (("RejectedQty">=(0.00)));
ALTER TABLE "Purchasing"."PurchaseOrderDetail" ADD CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK  (("UnitPrice">=(0.00)));
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "CK_PurchaseOrderHeader_Freight" CHECK  (("Freight">=(0.00)));
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK  (("ShipDate">="OrderDate" OR "ShipDate" IS NULL));
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "CK_PurchaseOrderHeader_Status" CHECK  (("Status">=(1) AND "Status"<=(4)));
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK  (("SubTotal">=(0.00)));
ALTER TABLE "Purchasing"."PurchaseOrderHeader" ADD CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK  (("TaxAmt">=(0.00)));
ALTER TABLE "Purchasing"."ShipMethod" ADD CONSTRAINT "CK_ShipMethod_ShipBase" CHECK  (("ShipBase">(0.00)));
ALTER TABLE "Purchasing"."ShipMethod" ADD CONSTRAINT "CK_ShipMethod_ShipRate" CHECK  (("ShipRate">(0.00)));
ALTER TABLE "Purchasing"."Vendor" ADD CONSTRAINT "CK_Vendor_CreditRating" CHECK  (("CreditRating">=(1) AND "CreditRating"<=(5)));
ALTER TABLE "Sales"."SalesOrderDetail" ADD CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK  (("OrderQty">(0)));
ALTER TABLE "Sales"."SalesOrderDetail" ADD CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK  (("UnitPrice">=(0.00)));
ALTER TABLE "Sales"."SalesOrderDetail" ADD CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK  (("UnitPriceDiscount">=(0.00)));
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK  (("DueDate">="OrderDate"));
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK  (("Freight">=(0.00)));
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK  (("ShipDate">="OrderDate" OR "ShipDate" IS NULL));
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "CK_SalesOrderHeader_Status" CHECK  (("Status">=(0) AND "Status"<=(8)));
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK  (("SubTotal">=(0.00)));
ALTER TABLE "Sales"."SalesOrderHeader" ADD CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK  (("TaxAmt">=(0.00)));
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "CK_SalesPerson_Bonus" CHECK  (("Bonus">=(0.00)));
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK  (("CommissionPct">=(0.00)));
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK  (("SalesLastYear">=(0.00)));
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK  (("SalesQuota">(0.00)));
ALTER TABLE "Sales"."SalesPerson" ADD CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK  (("SalesYTD">=(0.00)));
ALTER TABLE "Sales"."SalesPersonQuotaHistory" ADD CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK  (("SalesQuota">(0.00)));
ALTER TABLE "Sales"."SalesTaxRate" ADD CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK  (("TaxType">=(1) AND "TaxType"<=(3)));
ALTER TABLE "Sales"."SalesTerritory" ADD CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK  (("CostLastYear">=(0.00)));
ALTER TABLE "Sales"."SalesTerritory" ADD CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK  (("CostYTD">=(0.00)));
ALTER TABLE "Sales"."SalesTerritory" ADD CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK  (("SalesLastYear">=(0.00)));
ALTER TABLE "Sales"."SalesTerritory" ADD CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK  (("SalesYTD">=(0.00)));
ALTER TABLE "Sales"."SalesTerritoryHistory" ADD CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK  (("EndDate">="StartDate" OR "EndDate" IS NULL));
ALTER TABLE "Sales"."ShoppingCartItem" ADD CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK  (("Quantity">=(1)));
ALTER TABLE "Sales"."SpecialOffer" ADD CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK  (("DiscountPct">=(0.00)));
ALTER TABLE "Sales"."SpecialOffer" ADD CONSTRAINT "CK_SpecialOffer_EndDate" CHECK  (("EndDate">="StartDate"));
ALTER TABLE "Sales"."SpecialOffer" ADD CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK  (("MaxQty">=(0)));
ALTER TABLE "Sales"."SpecialOffer" ADD CONSTRAINT "CK_SpecialOffer_MinQty" CHECK  (("MinQty">=(0)));
