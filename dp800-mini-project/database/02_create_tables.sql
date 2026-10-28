USE Cineteca;
GO

CREATE TABLE Pelicula (
    PeliculaID INT PRIMARY KEY,
    Titulo NVARCHAR(100) NOT NULL,
    Sinopsis NVARCHAR(MAX) NOT NULL,
    SinopsisVector VECTOR(384) NULL
);
GO