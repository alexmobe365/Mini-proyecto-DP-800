USE Cineteca;
GO

CREATE VIEW vw_PeliculasVectorizadas AS 
SELECT PeliculaID, Titulo, Sinopsis 
FROM Pelicula 
WHERE SinopsisVector IS NOT NULL;
GO