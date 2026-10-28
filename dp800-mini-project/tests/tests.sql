USE Cineteca;
GO

EXECUTE AS USER = 'CinetecaAnalista';
GO

SELECT TOP 3 PeliculaID, Titulo FROM Pelicula;
GO

BEGIN TRY
    UPDATE Pelicula SET Titulo = 'Hackeo' WHERE PeliculaID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
GO

REVERT;
GO