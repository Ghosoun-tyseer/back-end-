CREATE DATABASE OYIL2;
Use OYIL2;

Create Table Users
(
    UserID int Primary key identity(1,1),
    Email Nvarchar(50) unique,
    Password Nvarchar (50) Not Null,
    Name Nvarchar (50) Not Null,
    Role Nvarchar (50) Default 'User'
);

Create Table Products 
(
    ProductID int Primary Key Identity (1,1),
    Name Nvarchar (50) Not Null ,
    Description Nvarchar (100) Not Null ,
    ImageURL Nvarchar (500),
    CategoryID int,
    Foreign key (CategoryID) References Categories (CategoryID) 
);

Create Table Categories 
(
    CategoryID int Primary Key Identity (1,1),
    Name Nvarchar (50) Not Null ,
    Description Nvarchar (100) Not Null ,
    ImageURL Nvarchar (500) 
)

INSERT INTO Categories (Name, Description, ImageURL)
VALUES
(
    'Electronics',
    'Electronic devices and accessories',
    'https://tse1.mm.bing.net/th/id/OIP.cM0KvpQE60itWpBbrZdTpwHaEJ?r=0&rs=1&pid=ImgDetMain&o=7&rm=3'
),
(
    'Fashion',
    'Clothing and fashion products',
    'https://img.magnific.com/premium-photo/designer-clothing-boutique-with-fashion-product-displays_1060272-2859.jpg'
),
(
    'Books',
    'Educational and entertainment books',
    'https://tse1.mm.bing.net/th/id/OIP.zQ2DyzNFYF7oDjn82QKrdwAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3'
);


INSERT INTO Products (Name, Description, ImageURL, CategoryID)
VALUES
(
    'Laptop',
    'Dell Core i7 Laptop',
    'https://i5.walmartimages.com/asr/297cc572-6332-4873-bfdc-90ff9317d8cb_1.1efa9985e513bde8b3026cb692146458.jpeg',
    1
),
(
    'T-Shirt',
    'Black Cotton T-Shirt', 
    'https://tse2.mm.bing.net/th/id/OIP.Qx63yI6IleXwHEzzUEx3MwHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3', 
    2
),
(
    'C# Book',
    'Learn ASP.NET MVC',
    'https://content.packt.com/B05364/cover_image.jpg',
    3
);
select * from Products;


INSERT INTO Users ( Email ,  Password,  Name,  Role )
VALUES
(
    'admin@oyil.com',
    '123456',
    'Admin User',
    'Admin'
);


INSERT INTO Users ( Email ,  Password,  Name )
VALUES
(
    'ghosoun@oyil.com',
    '1322002',
    'Ghosoun'
    
),


(
    'zainab@oyil.com',
    '112233',
    'zainab'
    
);


