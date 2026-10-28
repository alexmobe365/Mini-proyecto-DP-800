USE Cineteca;
GO

CREATE USER CinetecaAnalista WITHOUT LOGIN;
GO

CREATE ROLE RolAnalistaCineteca;
GO

GRANT SELECT ON Pelicula TO RolAnalistaCineteca;
GO

DENY INSERT, UPDATE, DELETE ON Pelicula TO RolAnalistaCineteca;
GO

ALTER ROLE RolAnalistaCineteca ADD MEMBER CinetecaAnalista;
GO