CREATE TABLE Account
(
    IdAccount INT IDENTITY PRIMARY KEY,
    Username  VARCHAR(50) UNIQUE NOT NULL,
    Password  VARCHAR(255)       NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Role
(
    IdRole      INT IDENTITY PRIMARY KEY,
    RoleName    VARCHAR(50) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);

CREATE TABLE Permission
(
    IdPermission   INT IDENTITY PRIMARY KEY,
    PermissionName VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Account_Role
(
    IdAccount INT NOT NULL,
    IdRole    INT NOT NULL,
    PRIMARY KEY (IdAccount, IdRole)
);

CREATE TABLE Role_Permission
(
    IdRole       INT NOT NULL,
    IdPermission INT NOT NULL,
    PRIMARY KEY (IdRole, IdPermission)
);
