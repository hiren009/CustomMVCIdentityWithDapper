USE [CustomIdentityAuthDemo]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserRoleID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[RoleID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Status] [int] NOT NULL DEFAULT ((0)),
	[CreatedOnDate] [datetime] NULL CONSTRAINT [DF_Users_CreatedOnDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'06EAAC15-8A96-4D3D-92BB-CB9C60808330', N'Administrator')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'E5172501-C118-4438-987C-E75B384A8F4B', N'Member')
INSERT [dbo].[UserRoles] ([UserRoleID], [UserID], [RoleID]) VALUES (N'7AE7258E-3A63-41F1-8CF6-1064F2A0FE7C', N'EA165941-A5BF-4E84-8FF2-C8095AD657E5', N'06EAAC15-8A96-4D3D-92BB-CB9C60808330')
INSERT [dbo].[UserRoles] ([UserRoleID], [UserID], [RoleID]) VALUES (N'EB2CB647-D8DF-4AC6-9018-C91F74F51584', N'A8F56268-354A-4B1F-9855-56C4A05CF33D', N'E5172501-C118-4438-987C-E75B384A8F4B')
INSERT [dbo].[Users] ([Id], [Username], [Email], [Password], [Status], [CreatedOnDate]) VALUES (N'A8F56268-354A-4B1F-9855-56C4A05CF33D', N'member', N'member@example.com', N'1234567', 1, CAST(N'2019-04-10 20:45:41.050' AS DateTime))
INSERT [dbo].[Users] ([Id], [Username], [Email], [Password], [Status], [CreatedOnDate]) VALUES (N'EA165941-A5BF-4E84-8FF2-C8095AD657E5', N'admin', N'admin@example.com', N'1234567', 1, CAST(N'2019-04-10 20:45:41.050' AS DateTime))
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteUser]
	-- Add the parameters for the stored procedure here
	@ID nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Users
	WHERE ID = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUser]
	-- Add the parameters for the stored procedure here
	@ID nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users
	WHERE ID = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsername]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserByUsername]
	-- Add the parameters for the stored procedure here
	@Username nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserRoles]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserRoles]
	@UserID nvarchar(50)
AS
BEGIN
	
	SELECT R.Name As RoleName
	FROM UserRoles UR
	INNER JOIN Roles R
	ON UR.RoleID = R.Id
	WHERE UR.UserID = @UserID
	
END

GO
/****** Object:  StoredProcedure [dbo].[NewUser]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewUser]
	-- Add the parameters for the stored procedure here
	@ID nvarchar(50),
	@UserName nvarchar(50),
	@Email nvarchar(50),
	@Password nvarchar(50),
	@Status int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Users(
		ID,
		UserName ,
		Email ,
		Password ,
		Status 
	)VALUES(
		@ID,
		@UserName ,
		@Email ,
		@Password ,
		@Status 
	)
END

GO
/****** Object:  StoredProcedure [dbo].[NewUserRole]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[NewUserRole]
	@UserID nvarchar(50),
	@RoleName nvarchar(50)
AS
BEGIN
	DECLARE @UserRoleID nvarchar(50)
	DECLARE @RoleID nvarchar(50)
	
	SELECT @RoleID = Id
	FROM Roles
	WHERE Name = @RoleName
	
	IF @RoleID IS NULL
		BEGIN
			INSERT INTO Roles(
				Id,
				Name
			)VALUES(
				NEWID(),
				@RoleName
			)
			
			SELECT @RoleID = Id
			FROM Roles
			WHERE Name = @RoleName
		END
	
	SELECT @UserRoleID = UserRoleID
	FROM UserRoles
	WHERE UserID = @UserID AND RoleID = @RoleID
	
	IF @UserRoleID IS NULL
		BEGIN
			INSERT INTO UserRoles(
				UserRoleID,
				UserID,
				RoleID
			)VALUES(
				NEWID(),
				@UserID,
				@RoleID
			)
		END 

END

GO
/****** Object:  StoredProcedure [dbo].[RemoveUserRole]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RemoveUserRole]
	@UserID nvarchar(50),
	@RoleName nvarchar(50)
AS
BEGIN
	DECLARE @RoleID nvarchar(50)
	
	SELECT @RoleID = Id
	FROM Roles
	WHERE Name = @RoleName
	
	IF @RoleID IS NULL
		BEGIN
			Delete FROM UserRoles
			WHERE RoleID = @RoleID AND UserID = @UserID
		END

END

GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 4/11/2019 5:47:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateUser]
	-- Add the parameters for the stored procedure here
	@UserName nvarchar(50),
	@Email nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Users
	SET Email = @Email
	WHERE UserName = @UserName
END

GO
