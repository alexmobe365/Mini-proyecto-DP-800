USE Cineteca;
GO

DECLARE @queryVector VECTOR(384) = '[0.012, -0.045, 0.083, 0.001]';

SELECT TOP 3 
    Titulo, 
    VECTOR_DISTANCE('cosine', SinopsisVector, @queryVector) AS SimilitudSemantica
FROM Pelicula
WHERE SinopsisVector IS NOT NULL
ORDER BY SimilitudSemantica ASC;
GO