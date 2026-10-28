# Cineteca Inteligente: Búsqueda Semántica con SQL Server 2025 y AI Local

## Descripción
Este proyecto resuelve el problema de la búsqueda tradicional por palabras clave en catálogos de cine, implementando una **Cineteca Inteligente**. Utiliza SQL Server 2025 junto con capacidades de Inteligencia Artificial ejecutadas en local para almacenar sinopsis de películas y convertirlas en representaciones vectoriales, sentando las bases para un motor de búsqueda semántica.

## Arquitectura
La solución se basa en un pipeline automatizado que conecta el motor relacional con un modelo de IA local:
1. **Base de Datos:** SQL Server 2025 almacena los datos estructurados y los vectores (tipo `VECTOR`).
2. **Motor de IA Local:** Ollama con el modelo `all-minilm` genera los embeddings.
3. **Pipeline de Integración:** Un script en Python conecta mediante `pyodbc` con SQL Server, extrae los textos, consulta a Ollama y persiste los resultados matemáticos.

## Tecnologías
*   SQL Server 2025 Developer Edition
*   T-SQL y SQL Server Management Studio (SSMS)
*   Python (Librerías: `pyodbc`, `requests`)
*   Ollama (Modelo de embeddings: `all-minilm`)
*   Git y GitHub

## Instalación y Ejecución
1. Clonar el repositorio localmente.
2. Iniciar el servicio local de Ollama asegurando que el modelo `all-minilm` está disponible (`ollama run all-minilm`).
3. Ejecutar los scripts de la carpeta `database/` en SSMS siguiendo su orden numérico para crear la estructura, insertar datos y aplicar seguridad.
4. Instalar las dependencias de Python: `pip install pyodbc requests`.
5. Ejecutar el puente de integración: `python vectorizar.py`.

## Base de datos
La base de datos principal (`Cineteca`) consta de una tabla central llamada `Pelicula` con la siguiente estructura:
*   `PeliculaID` (INT, Primary Key)
*   `Titulo` (NVARCHAR)
*   `Sinopsis` (NVARCHAR)
*   `SinopsisVector` (VECTOR(384)) - Almacena la representación matemática generada por la IA.

## Funcionalidades DP-800 implementadas
*   ✓ **Bloque A - Diseño de base de datos:** Creación de esquema, restricciones relacionales y soporte para tipos de datos modernos.
*   ✓ **Bloque C - Seguridad:** Implementación del principio de mínimo privilegio creando el rol `RolAnalistaCineteca` con permisos limitados a lectura (`GRANT SELECT`) y denegación explícita de modificación (`DENY UPDATE, DELETE`).
*   ✓ **Bloque E - Modelos y embeddings:** Transformación de texto libre a vectores de 384 dimensiones mediante LLMs locales persistidos en la base de datos de forma nativa.

## Ejemplos de uso
Para visualizar los vectores integrados en el motor relacional, ejecutar la siguiente consulta:
```sql
SELECT PeliculaID, Titulo, SinopsisVector FROM Pelicula;
