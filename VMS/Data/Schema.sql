/*
    Title: Visitor Management System Database Schema
    Author: Ahmed Ibrahim
    Date: 2025-07-09
    Description:
        This schema defines the core tables for a flexible Visitor Management System (VMS).
        It supports secure user authentication and authorization, tracks visitor check-ins
        and check-outs, supports multi-location setups, and allows for future expansion
        such as frequent visitor profiles and role-based permissions.
*/

-- 1. Create the Database
CREATE DATABASE VisitorManagementDB;
GO

-- Use the database
USE VisitorManagementDB;
GO

-- 2. Create Users Table
CREATE TABLE Users (
    UserID NVARCHAR(20) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL, -- e.g., Admin, Guard, Receptionist
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- 3. Create Roles Table (optional for more granular permission system)
CREATE TABLE Roles (
    RoleName NVARCHAR(20) PRIMARY KEY,
    Description NVARCHAR(100)
);
GO

-- Optional FK if you want to connect Users to Roles table (skip if Role is free-text)
-- ALTER TABLE Users
-- ADD CONSTRAINT FK_Users_Roles FOREIGN KEY (Role)
-- REFERENCES Roles(RoleName);
-- GO

-- 4. Create Locations Table (optional, for multi-wing/multi-building support)
CREATE TABLE Locations (
    LocationID NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(200)
);
GO

-- 5. Create Visitors Table (optional, useful for frequent or known visitors)
CREATE TABLE Visitors (
    VisitorID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(150),
    ContactNumber NVARCHAR(20),
    IDProof NVARCHAR(50), -- e.g., Aadhaar, Passport, etc.
    IDNumber NVARCHAR(50)
);
GO

-- 6. Create VisitorEntries Table (main visitor log)
CREATE TABLE VisitorEntries (
    EntryID INT PRIMARY KEY IDENTITY(1,1),
    VisitorName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(150),
    ReasonForVisit NVARCHAR(200),
    WhomToMeet NVARCHAR(100),
    VisitDateTime DATETIME DEFAULT GETDATE(),
    CheckedOutAt DATETIME NULL,
    FlatOrRoom NVARCHAR(20),
    EntryBy NVARCHAR(20), -- FK to Users(UserID)
    Notes NVARCHAR(300),

    CONSTRAINT FK_VisitorEntries_Users FOREIGN KEY (EntryBy)
        REFERENCES Users(UserID)
);
GO