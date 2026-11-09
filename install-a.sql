DO LANGUAGE plpgsql $$
BEGIN
    CREATE EXTENSION IF NOT EXISTS postgis;
    CREATE EXTENSION IF NOT EXISTS postgis_topology;
EXCEPTION
    WHEN OTHERS THEN RETURN;
END $$;

CREATE SCHEMA "HumanResources";
CREATE SCHEMA "Person";
CREATE SCHEMA "Production";
CREATE SCHEMA "Purchasing";
CREATE SCHEMA "Sales";

CREATE TABLE "public"."AWBuildVersion" (
    "SystemInformationID" SERIAL NOT NULL,
    "Database Version" VARCHAR(25) NOT NULL,
    "VersionDate" TIMESTAMP NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_AWBuildVersion_SystemInformationID" PRIMARY KEY ("SystemInformationID")
);

CREATE TABLE "public"."DatabaseLog" (
    "DatabaseLogID" SERIAL NOT NULL,
    "PostTime" TIMESTAMP NOT NULL,
    "DatabaseUser" VARCHAR(256) NOT NULL,
    "Event" VARCHAR(256) NOT NULL,
    "Schema" VARCHAR(256) NULL,
    "Object" VARCHAR(256) NULL,
    "TSQL" TEXT NOT NULL,
    "XmlEvent" XML NOT NULL,
    CONSTRAINT "PK_DatabaseLog_DatabaseLogID" PRIMARY KEY ("DatabaseLogID")
);

CREATE TABLE "public"."ErrorLog" (
    "ErrorLogID" SERIAL NOT NULL,
    "ErrorTime" TIMESTAMP NOT NULL,
    "UserName" VARCHAR(256) NOT NULL,
    "ErrorNumber" INT NOT NULL,
    "ErrorSeverity" INT NULL,
    "ErrorState" INT NULL,
    "ErrorProcedure" VARCHAR(126) NULL,
    "ErrorLine" INT NULL,
    "ErrorMessage" VARCHAR(4000) NOT NULL,
    CONSTRAINT "PK_ErrorLog_ErrorLogID" PRIMARY KEY ("ErrorLogID")
);

CREATE TABLE "HumanResources"."Department" (
    "DepartmentID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "GroupName" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY ("DepartmentID")
);

CREATE TABLE "HumanResources"."Employee" (
    "BusinessEntityID" INT NOT NULL,
    "NationalIDNumber" VARCHAR(15) NOT NULL,
    "LoginID" VARCHAR(256) NOT NULL,
    "OrganizationNode" TEXT NULL,
    "OrganizationLevel" INT NULL,
    "JobTitle" VARCHAR(50) NOT NULL,
    "BirthDate" DATE NOT NULL,
    "MaritalStatus" CHAR(1) NOT NULL,
    "Gender" CHAR(1) NOT NULL,
    "HireDate" DATE NOT NULL,
    "SalariedFlag" BOOLEAN NOT NULL,
    "VacationHours" SMALLINT NOT NULL,
    "SickLeaveHours" SMALLINT NOT NULL,
    "CurrentFlag" BOOLEAN NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Employee_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);

CREATE TABLE "HumanResources"."EmployeeDepartmentHistory" (
    "BusinessEntityID" INT NOT NULL,
    "DepartmentID" SMALLINT NOT NULL,
    "ShiftID" SMALLINT NOT NULL,
    "StartDate" DATE NOT NULL,
    "EndDate" DATE NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID" PRIMARY KEY
(
    "BusinessEntityID",
    "StartDate",
    "DepartmentID",
    "ShiftID"
)
);

CREATE TABLE "HumanResources"."EmployeePayHistory" (
    "BusinessEntityID" INT NOT NULL,
    "RateChangeDate" TIMESTAMP NOT NULL,
    "Rate" NUMERIC(19,4) NOT NULL,
    "PayFrequency" SMALLINT NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY
(
    "BusinessEntityID",
    "RateChangeDate"
)
);

CREATE TABLE "HumanResources"."JobCandidate" (
    "JobCandidateID" SERIAL NOT NULL,
    "BusinessEntityID" INT NULL,
    "Resume" XML NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY ("JobCandidateID")
);

CREATE TABLE "HumanResources"."Shift" (
    "ShiftID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "StartTime" TIME(7) NOT NULL,
    "EndTime" TIME(7) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY ("ShiftID")
);

DO LANGUAGE plpgsql $$
BEGIN
    IF EXISTS(SELECT * FROM pg_extension WHERE extname='postgis_topology') THEN
        CREATE TABLE "Person"."Address" (
            "AddressID" SERIAL NOT NULL,
            "AddressLine1" VARCHAR(60) NOT NULL,
            "AddressLine2" VARCHAR(60) NULL,
            "City" VARCHAR(30) NOT NULL,
            "StateProvinceID" INT NOT NULL,
            "PostalCode" VARCHAR(15) NOT NULL,
            "SpatialLocation" GEOGRAPHY(POINT) NULL,
            "rowguid" UUID NOT NULL,
            "ModifiedDate" TIMESTAMP NOT NULL,
            CONSTRAINT "PK_Address_AddressID" PRIMARY KEY ("AddressID")
        );
    ELSE
        --postgis* extensions not installed, probably not supported (arm32/64).
        --mock the function used for now as text.
        CREATE FUNCTION ST_GeomFromText(input TEXT)
            RETURNS TEXT
            RETURN input;
        CREATE TABLE "Person"."Address" (
            "AddressID" SERIAL NOT NULL,
            "AddressLine1" VARCHAR(60) NOT NULL,
            "AddressLine2" VARCHAR(60) NULL,
            "City" VARCHAR(30) NOT NULL,
            "StateProvinceID" INT NOT NULL,
            "PostalCode" VARCHAR(15) NOT NULL,
            "SpatialLocation" TEXT NULL,
            "rowguid" UUID NOT NULL,
            "ModifiedDate" TIMESTAMP NOT NULL,
            CONSTRAINT "PK_Address_AddressID" PRIMARY KEY ("AddressID")
        );
    END IF;
END $$;


CREATE TABLE "Person"."AddressType" (
    "AddressTypeID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY ("AddressTypeID")
);

CREATE TABLE "Person"."BusinessEntity" (
    "BusinessEntityID" SERIAL NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);

CREATE TABLE "Person"."BusinessEntityAddress" (
    "BusinessEntityID" INT NOT NULL,
    "AddressID" INT NOT NULL,
    "AddressTypeID" INT NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID" PRIMARY KEY
(
    "BusinessEntityID",
    "AddressID",
    "AddressTypeID"
)
);

CREATE TABLE "Person"."BusinessEntityContact" (
    "BusinessEntityID" INT NOT NULL,
    "PersonID" INT NOT NULL,
    "ContactTypeID" INT NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID" PRIMARY KEY
(
    "BusinessEntityID",
    "PersonID",
    "ContactTypeID"
)
);

CREATE TABLE "Person"."ContactType" (
    "ContactTypeID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY ("ContactTypeID")
);

CREATE TABLE "Person"."CountryRegion" (
    "CountryRegionCode" VARCHAR(3) NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY ("CountryRegionCode")
);

CREATE TABLE "Person"."EmailAddress" (
    "BusinessEntityID" INT NOT NULL,
    "EmailAddressID" SERIAL NOT NULL,
    "EmailAddress" VARCHAR(50) NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY
(
    "BusinessEntityID",
    "EmailAddressID"
)
);

CREATE TABLE "Person"."Password" (
    "BusinessEntityID" INT NOT NULL,
    "PasswordHash" VARCHAR(128) NOT NULL,
    "PasswordSalt" VARCHAR(10) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);

CREATE TABLE "Person"."Person" (
    "BusinessEntityID" INT NOT NULL,
    "PersonType" CHAR(2) NOT NULL,
    "NameStyle" VARCHAR(256) NOT NULL,
    "Title" VARCHAR(8) NULL,
    "FirstName" VARCHAR(256) NOT NULL,
    "MiddleName" VARCHAR(256) NULL,
    "LastName" VARCHAR(256) NOT NULL,
    "Suffix" VARCHAR(10) NULL,
    "EmailPromotion" INT NOT NULL,
    "AdditionalContactInfo" XML NULL,
    "Demographics" XML NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);

CREATE TABLE "Person"."PersonPhone" (
    "BusinessEntityID" INT NOT NULL,
    "PhoneNumber" VARCHAR(64) NOT NULL,
    "PhoneNumberTypeID" INT NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID" PRIMARY KEY
(
    "BusinessEntityID",
    "PhoneNumber",
    "PhoneNumberTypeID"
)
);

CREATE TABLE "Person"."PhoneNumberType" (
    "PhoneNumberTypeID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY ("PhoneNumberTypeID")
);

CREATE TABLE "Person"."StateProvince" (
    "StateProvinceID" SERIAL NOT NULL,
    "StateProvinceCode" CHAR(3) NOT NULL,
    "CountryRegionCode" VARCHAR(3) NOT NULL,
    "IsOnlyStateProvinceFlag" BOOLEAN NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "TerritoryID" INT NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY ("StateProvinceID")
);

CREATE TABLE "Production"."BillOfMaterials" (
    "BillOfMaterialsID" SERIAL NOT NULL,
    "ProductAssemblyID" INT NULL,
    "ComponentID" INT NOT NULL,
    "StartDate" TIMESTAMP NOT NULL,
    "EndDate" TIMESTAMP NULL,
    "UnitMeasureCode" CHAR(3) NOT NULL,
    "BOMLevel" SMALLINT NOT NULL,
    "PerAssemblyQty" NUMERIC(8, 2) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY ("BillOfMaterialsID")
);

CREATE UNIQUE INDEX "AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate" ON "Production"."BillOfMaterials"
(
    "ProductAssemblyID",
    "ComponentID",
    "StartDate"
);

CREATE TABLE "Production"."Culture" (
    "CultureID" CHAR(6) NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY ("CultureID")
);

CREATE TABLE "Production"."Document" (
    "DocumentNode" VARCHAR(128) NOT NULL,
    "DocumentLevel" INT NULL,
    "Title" VARCHAR(50) NOT NULL,
    "Owner" INT NOT NULL,
    "FolderFlag" BOOLEAN NOT NULL,
    "FileName" VARCHAR(400) NOT NULL,
    "FileExtension" VARCHAR(8) NOT NULL,
    "Revision" CHAR(5) NOT NULL,
    "ChangeNumber" INT NOT NULL,
    "Status" SMALLINT NOT NULL,
    "DocumentSummary" TEXT NULL,
    "Document" BYTEA NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY ("DocumentNode"),
UNIQUE ("rowguid")
);

CREATE TABLE "Production"."Illustration" (
    "IllustrationID" SERIAL NOT NULL,
    "Diagram" XML NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY ("IllustrationID")
);

CREATE TABLE "Production"."Location" (
    "LocationID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "CostRate" NUMERIC(8, 2) NOT NULL,
    "Availability" NUMERIC(8, 2) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Location_LocationID" PRIMARY KEY ("LocationID")
);

CREATE TABLE "Production"."Product" (
    "ProductID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ProductNumber" VARCHAR(25) NOT NULL,
    "MakeFlag" SMALLINT NOT NULL,
    "FinishedGoodsFlag" SMALLINT NOT NULL,
    "Color" VARCHAR(15) NULL,
    "SafetyStockLevel" SMALLINT NOT NULL,
    "ReorderPoint" SMALLINT NOT NULL,
    "StandardCost" NUMERIC(19,4) NOT NULL,
    "ListPrice" NUMERIC(19,4) NOT NULL,
    "Size" VARCHAR(5) NULL,
    "SizeUnitMeasureCode" CHAR(3) NULL,
    "WeightUnitMeasureCode" CHAR(3) NULL,
    "Weight" NUMERIC(8, 2) NULL,
    "DaysToManufacture" INT NOT NULL,
    "ProductLine" CHAR(2) NULL,
    "Class" CHAR(2) NULL,
    "Style" CHAR(2) NULL,
    "ProductSubcategoryID" INT NULL,
    "ProductModelID" INT NULL,
    "SellStartDate" TIMESTAMP NOT NULL,
    "SellEndDate" TIMESTAMP NULL,
    "DiscontinuedDate" TIMESTAMP NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Product_ProductID" PRIMARY KEY ("ProductID")
);

CREATE TABLE "Production"."ProductCategory" (
    "ProductCategoryID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY ("ProductCategoryID")
);

CREATE TABLE "Production"."ProductCostHistory" (
    "ProductID" INT NOT NULL,
    "StartDate" TIMESTAMP NOT NULL,
    "EndDate" TIMESTAMP NULL,
    "StandardCost" NUMERIC(19,4) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY
(
    "ProductID",
    "StartDate"
)
);

CREATE TABLE "Production"."ProductDescription" (
    "ProductDescriptionID" SERIAL NOT NULL,
    "Description" VARCHAR(400) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY ("ProductDescriptionID")
);

CREATE TABLE "Production"."ProductDocument" (
    "ProductID" INT NOT NULL,
    "DocumentNode" VARCHAR(128) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY
(
    "ProductID",
    "DocumentNode"
)
);

CREATE TABLE "Production"."ProductInventory" (
    "ProductID" INT NOT NULL,
    "LocationID" SMALLINT NOT NULL,
    "Shelf" VARCHAR(10) NOT NULL,
    "Bin" SMALLINT NOT NULL,
    "Quantity" SMALLINT NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY
(
    "ProductID",
    "LocationID"
)
);

CREATE TABLE "Production"."ProductListPriceHistory" (
    "ProductID" INT NOT NULL,
    "StartDate" TIMESTAMP NOT NULL,
    "EndDate" TIMESTAMP NULL,
    "ListPrice" NUMERIC(19,4) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY
(
    "ProductID",
    "StartDate"
)
);

CREATE TABLE "Production"."ProductModel" (
    "ProductModelID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "CatalogDescription" XML NULL,
    "Instructions" XML NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY ("ProductModelID")
);

CREATE TABLE "Production"."ProductModelIllustration" (
    "ProductModelID" INT NOT NULL,
    "IllustrationID" INT NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY
(
    "ProductModelID",
    "IllustrationID"
)
);

CREATE TABLE "Production"."ProductModelProductDescriptionCulture" (
    "ProductModelID" INT NOT NULL,
    "ProductDescriptionID" INT NOT NULL,
    "CultureID" CHAR(6) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID" PRIMARY KEY
(
    "ProductModelID",
    "ProductDescriptionID",
    "CultureID"
)
);

CREATE TABLE "Production"."ProductPhoto" (
    "ProductPhotoID" SERIAL NOT NULL,
    "ThumbNailPhoto" BYTEA NULL,
    "ThumbnailPhotoFileName" VARCHAR(50) NULL,
    "LargePhoto" BYTEA NULL,
    "LargePhotoFileName" VARCHAR(50) NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY ("ProductPhotoID")
);

CREATE TABLE "Production"."ProductProductPhoto" (
    "ProductID" INT NOT NULL,
    "ProductPhotoID" INT NOT NULL,
    "Primary" BOOLEAN NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY
(
    "ProductID",
    "ProductPhotoID"
)
);

CREATE TABLE "Production"."ProductReview" (
    "ProductReviewID" SERIAL NOT NULL,
    "ProductID" INT NOT NULL,
    "ReviewerName" VARCHAR(256) NOT NULL,
    "ReviewDate" TIMESTAMP NOT NULL,
    "EmailAddress" VARCHAR(50) NOT NULL,
    "Rating" INT NOT NULL,
    "Comments" VARCHAR(3850) NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY ("ProductReviewID")
);

CREATE TABLE "Production"."ProductSubcategory" (
    "ProductSubcategoryID" SERIAL NOT NULL,
    "ProductCategoryID" INT NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY ("ProductSubcategoryID")
);

CREATE TABLE "Production"."ScrapReason" (
    "ScrapReasonID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY ("ScrapReasonID")
);

CREATE TABLE "Production"."TransactionHistory" (
    "TransactionID" SERIAL NOT NULL,
    "ProductID" INT NOT NULL,
    "ReferenceOrderID" INT NOT NULL,
    "ReferenceOrderLineID" INT NOT NULL,
    "TransactionDate" TIMESTAMP NOT NULL,
    "TransactionType" CHAR(1) NOT NULL,
    "Quantity" INT NOT NULL,
    "ActualCost" NUMERIC(19,4) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY ("TransactionID")
);

CREATE TABLE "Production"."TransactionHistoryArchive" (
    "TransactionID" INT NOT NULL,
    "ProductID" INT NOT NULL,
    "ReferenceOrderID" INT NOT NULL,
    "ReferenceOrderLineID" INT NOT NULL,
    "TransactionDate" TIMESTAMP NOT NULL,
    "TransactionType" CHAR(1) NOT NULL,
    "Quantity" INT NOT NULL,
    "ActualCost" NUMERIC(19,4) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY ("TransactionID")
);

CREATE TABLE "Production"."UnitMeasure" (
    "UnitMeasureCode" CHAR(3) NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY ("UnitMeasureCode")
);

CREATE TABLE "Production"."WorkOrder" (
    "WorkOrderID" SERIAL NOT NULL,
    "ProductID" INT NOT NULL,
    "OrderQty" INT NOT NULL,
    "StockedQty" INT NULL,
    "ScrappedQty" SMALLINT NOT NULL,
    "StartDate" TIMESTAMP NOT NULL,
    "EndDate" TIMESTAMP NULL,
    "DueDate" TIMESTAMP NOT NULL,
    "ScrapReasonID" SMALLINT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY ("WorkOrderID")
);

CREATE TABLE "Production"."WorkOrderRouting" (
    "WorkOrderID" INT NOT NULL,
    "ProductID" INT NOT NULL,
    "OperationSequence" SMALLINT NOT NULL,
    "LocationID" SMALLINT NOT NULL,
    "ScheduledStartDate" TIMESTAMP NOT NULL,
    "ScheduledEndDate" TIMESTAMP NOT NULL,
    "ActualStartDate" TIMESTAMP NULL,
    "ActualEndDate" TIMESTAMP NULL,
    "ActualResourceHrs" NUMERIC(9, 4) NULL,
    "PlannedCost" NUMERIC(19,4) NOT NULL,
    "ActualCost" NUMERIC(19,4) NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY
(
    "WorkOrderID",
    "ProductID",
    "OperationSequence"
)
);

CREATE TABLE "Purchasing"."ProductVendor" (
    "ProductID" INT NOT NULL,
    "BusinessEntityID" INT NOT NULL,
    "AverageLeadTime" INT NOT NULL,
    "StandardPrice" NUMERIC(19,4) NOT NULL,
    "LastReceiptCost" NUMERIC(19,4) NULL,
    "LastReceiptDate" TIMESTAMP NULL,
    "MinOrderQty" INT NOT NULL,
    "MaxOrderQty" INT NOT NULL,
    "OnOrderQty" INT NULL,
    "UnitMeasureCode" CHAR(3) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY
(
    "ProductID",
    "BusinessEntityID"
)
);

CREATE TABLE "Purchasing"."PurchaseOrderDetail" (
    "PurchaseOrderID" INT NOT NULL,
    "PurchaseOrderDetailID" SERIAL NOT NULL,
    "DueDate" TIMESTAMP NOT NULL,
    "OrderQty" SMALLINT NOT NULL,
    "ProductID" INT NOT NULL,
    "UnitPrice" NUMERIC(19,4) NOT NULL,
    "LineTotal" NUMERIC(19,4) NULL,
    "ReceivedQty" NUMERIC(8, 2) NOT NULL,
    "RejectedQty" NUMERIC(8, 2) NOT NULL,
    "StockedQty" NUMERIC(8,4) NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY
(
    "PurchaseOrderID",
    "PurchaseOrderDetailID"
)
);

CREATE TABLE "Purchasing"."PurchaseOrderHeader" (
    "PurchaseOrderID" SERIAL NOT NULL,
    "RevisionNumber" SMALLINT NOT NULL,
    "Status" SMALLINT NOT NULL,
    "EmployeeID" INT NOT NULL,
    "VendorID" INT NOT NULL,
    "ShipMethodID" INT NOT NULL,
    "OrderDate" TIMESTAMP NOT NULL,
    "ShipDate" TIMESTAMP NULL,
    "SubTotal" NUMERIC(19,4) NOT NULL,
    "TaxAmt" NUMERIC(19,4) NOT NULL,
    "Freight" NUMERIC(19,4) NOT NULL,
    "TotalDue" NUMERIC(19,4) NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY ("PurchaseOrderID")
);

CREATE TABLE "Purchasing"."ShipMethod" (
    "ShipMethodID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ShipBase" NUMERIC(19,4) NOT NULL,
    "ShipRate" NUMERIC(19,4) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY ("ShipMethodID")
);

CREATE TABLE "Purchasing"."Vendor" (
    "BusinessEntityID" INT NOT NULL,
    "AccountNumber" VARCHAR(128) NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "CreditRating" SMALLINT NOT NULL,
    "PreferredVendorStatus" BOOLEAN NOT NULL,
    "ActiveFlag" BOOLEAN NOT NULL,
    "PurchasingWebServiceURL" VARCHAR(1024) NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);

CREATE TABLE "Sales"."CountryRegionCurrency" (
    "CountryRegionCode" VARCHAR(3) NOT NULL,
    "CurrencyCode" CHAR(3) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY
(
    "CountryRegionCode",
    "CurrencyCode"
)
);

CREATE TABLE "Sales"."CreditCard" (
    "CreditCardID" SERIAL NOT NULL,
    "CardType" VARCHAR(50) NOT NULL,
    "CardNumber" VARCHAR(25) NOT NULL,
    "ExpMonth" SMALLINT NOT NULL,
    "ExpYear" SMALLINT NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY ("CreditCardID")
);

CREATE TABLE "Sales"."Currency" (
    "CurrencyCode" CHAR(3) NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY ("CurrencyCode")
);

CREATE TABLE "Sales"."CurrencyRate" (
    "CurrencyRateID" SERIAL NOT NULL,
    "CurrencyRateDate" TIMESTAMP NOT NULL,
    "FromCurrencyCode" CHAR(3) NOT NULL,
    "ToCurrencyCode" CHAR(3) NOT NULL,
    "AverageRate" NUMERIC(19,4) NOT NULL,
    "EndOfDayRate" NUMERIC(19,4) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY ("CurrencyRateID")
);

CREATE TABLE "Sales"."Customer" (
    "CustomerID" SERIAL NOT NULL,
    "PersonID" INT NULL,
    "StoreID" INT NULL,
    "TerritoryID" INT NULL,
    "AccountNumber" VARCHAR(128) NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY ("CustomerID")
);

CREATE TABLE "Sales"."PersonCreditCard" (
    "BusinessEntityID" INT NOT NULL,
    "CreditCardID" INT NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY
(
    "BusinessEntityID",
    "CreditCardID"
)
);

CREATE TABLE "Sales"."SalesOrderDetail" (
    "SalesOrderID" INT NOT NULL,
    "SalesOrderDetailID" SERIAL NOT NULL,
    "CarrierTrackingNumber" VARCHAR(25) NULL,
    "OrderQty" SMALLINT NOT NULL,
    "ProductID" INT NOT NULL,
    "SpecialOfferID" INT NOT NULL,
    "UnitPrice" NUMERIC(19,4) NOT NULL,
    "UnitPriceDiscount" NUMERIC(19,4) NOT NULL,
    "LineTotal" NUMERIC(19,4) NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY
(
    "SalesOrderID",
    "SalesOrderDetailID"
)
);

CREATE TABLE "Sales"."SalesOrderHeader" (
    "SalesOrderID" SERIAL NOT NULL,
    "RevisionNumber" SMALLINT NOT NULL,
    "OrderDate" TIMESTAMP NOT NULL,
    "DueDate" TIMESTAMP NOT NULL,
    "ShipDate" TIMESTAMP NULL,
    "Status" SMALLINT NOT NULL,
    "OnlineOrderFlag" BOOLEAN NOT NULL,
    "SalesOrderNumber" VARCHAR(128) NULL,
    "PurchaseOrderNumber" VARCHAR(128) NULL,
    "AccountNumber" VARCHAR(128) NULL,
    "CustomerID" INT NOT NULL,
    "SalesPersonID" INT NULL,
    "TerritoryID" INT NULL,
    "BillToAddressID" INT NOT NULL,
    "ShipToAddressID" INT NOT NULL,
    "ShipMethodID" INT NOT NULL,
    "CreditCardID" INT NULL,
    "CreditCardApprovalCode" VARCHAR(15) NULL,
    "CurrencyRateID" INT NULL,
    "SubTotal" NUMERIC(19,4) NOT NULL,
    "TaxAmt" NUMERIC(19,4) NOT NULL,
    "Freight" NUMERIC(19,4) NOT NULL,
    "TotalDue" NUMERIC(19,4) NULL,
    "Comment" VARCHAR(128) NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY ("SalesOrderID")
);

CREATE TABLE "Sales"."SalesOrderHeaderSalesReason" (
    "SalesOrderID" INT NOT NULL,
    "SalesReasonID" INT NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY
(
    "SalesOrderID",
    "SalesReasonID"
)
);

CREATE TABLE "Sales"."SalesPerson" (
    "BusinessEntityID" INT NOT NULL,
    "TerritoryID" INT NULL,
    "SalesQuota" NUMERIC(19,4) NULL,
    "Bonus" NUMERIC(19,4) NOT NULL,
    "CommissionPct" NUMERIC(8, 2) NOT NULL,
    "SalesYTD" NUMERIC(19,4) NOT NULL,
    "SalesLastYear" NUMERIC(19,4) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);

CREATE TABLE "Sales"."SalesPersonQuotaHistory" (
    "BusinessEntityID" INT NOT NULL,
    "QuotaDate" TIMESTAMP NOT NULL,
    "SalesQuota" NUMERIC(19,4) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY
(
    "BusinessEntityID",
    "QuotaDate"
)
);

CREATE TABLE "Sales"."SalesReason" (
    "SalesReasonID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "ReasonType" VARCHAR(256) NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY ("SalesReasonID")
);

CREATE TABLE "Sales"."SalesTaxRate" (
    "SalesTaxRateID" SERIAL NOT NULL,
    "StateProvinceID" INT NOT NULL,
    "TaxType" SMALLINT NOT NULL,
    "TaxRate" NUMERIC(8, 2) NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY ("SalesTaxRateID")
);

CREATE TABLE "Sales"."SalesTerritory" (
    "TerritoryID" SERIAL NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "CountryRegionCode" VARCHAR(3) NOT NULL,
    "Group" VARCHAR(50) NOT NULL,
    "SalesYTD" NUMERIC(19,4) NOT NULL,
    "SalesLastYear" NUMERIC(19,4) NOT NULL,
    "CostYTD" NUMERIC(19,4) NOT NULL,
    "CostLastYear" NUMERIC(19,4) NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY ("TerritoryID")
);

CREATE TABLE "Sales"."SalesTerritoryHistory" (
    "BusinessEntityID" INT NOT NULL,
    "TerritoryID" INT NOT NULL,
    "StartDate" TIMESTAMP NOT NULL,
    "EndDate" TIMESTAMP NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY
(
    "BusinessEntityID",
    "StartDate",
    "TerritoryID"
)
);

CREATE TABLE "Sales"."ShoppingCartItem" (
    "ShoppingCartItemID" SERIAL NOT NULL,
    "ShoppingCartID" VARCHAR(50) NOT NULL,
    "Quantity" INT NOT NULL,
    "ProductID" INT NOT NULL,
    "DateCreated" TIMESTAMP NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY ("ShoppingCartItemID")
);

CREATE TABLE "Sales"."SpecialOffer" (
    "SpecialOfferID" SERIAL NOT NULL,
    "Description" VARCHAR(255) NOT NULL,
    "DiscountPct" NUMERIC(8, 2) NOT NULL,
    "Type" VARCHAR(50) NOT NULL,
    "Category" VARCHAR(50) NOT NULL,
    "StartDate" TIMESTAMP NOT NULL,
    "EndDate" TIMESTAMP NOT NULL,
    "MinQty" INT NOT NULL,
    "MaxQty" INT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY ("SpecialOfferID")
);

CREATE TABLE "Sales"."SpecialOfferProduct" (
    "SpecialOfferID" INT NOT NULL,
    "ProductID" INT NOT NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY
(
    "SpecialOfferID",
    "ProductID"
)
);

CREATE TABLE "Sales"."Store" (
    "BusinessEntityID" INT NOT NULL,
    "Name" VARCHAR(256) NOT NULL,
    "SalesPersonID" INT NULL,
    "Demographics" XML NULL,
    "rowguid" UUID NOT NULL,
    "ModifiedDate" TIMESTAMP NOT NULL,
    CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY ("BusinessEntityID")
);