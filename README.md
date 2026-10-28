# Cineteca Inteligente: Búsqueda Semántica con SQL Server 2025 y AI Local

## Descripción
Este proyecto resuelve el problema de la búsqueda tradicional por palabras clave en catálogos de cine, implementando una **Cineteca Inteligente**. Utiliza SQL Server 2025 junto con capacidades de Inteligencia Artificial ejecutadas en local para almacenar sinopsis de películas y convertirlas en representaciones vectoriales, sentando las bases para un motor de búsqueda semántica.

## Arquitectura# Cineteca Inteligente: Búsqueda Semántica con SQL Server 2025 y AI Local

## Descripción
Este proyecto resuelve el problema de la búsqueda tradicional por palabras clave en catálogos de cine, implementando un motor de búsqueda semántica. Utiliza SQL Server 2025 junto con capacidades de Inteligencia Artificial locales para almacenar sinopsis de películas y convertirlas en representaciones vectoriales, permitiendo buscar películas por su "significado" y no por coincidencia de palabras.

## Arquitectura
```text
                    ┌───────────────────┐
                    │      Usuario      │
                    └─────────┬─────────┘
                              │
                              ▼
                 ┌─────────────────────────┐
                 │    SQL Server 2025      │
                 │                         │
                 │ - Tablas (Pelicula)     │
                 │ - Roles y Seguridad     │
                 │ - Columna VECTOR(384)   │
                 └───────────┬─────────────┘
                             │
             (Script Python: vectorizar.py)
                             │
                             ▼
                    ┌──────────────────┐
                    │   Modelo local   │
                    │ Ollama (API REST)│
                    │ Mod: all-minilm  │
                    └──────────────────┘
```

## Tecnologías y Requisitos
* **Sistema Operativo:** Windows 11
* **Motor de BD:** SQL Server 2025 Developer Edition
* **Lenguajes:** T-SQL, Python 3.12+
* **Entorno:** Visual Studio Code, PowerShell, Git, GitHub
* **IA / Modelos:** Ollama (modelo `all-minilm` de 384 dimensiones)

## Instalación y Ejecución
1. Clonar este repositorio localmente y abrirlo en Visual Studio Code.
2. Instalar y arrancar Ollama localmente con el modelo: `ollama run all-minilm`.
3. Abrir SQL Server Management Studio (SSMS) y conectarse a la instancia local.
4. Ejecutar secuencialmente los scripts de la carpeta `database/` (del `01` al `07`).
5. Abrir PowerShell en la raíz del proyecto e instalar las dependencias de Python: `pip install pyodbc requests`.
6. Ejecutar el puente de integración para poblar los vectores: `python ai/vectorizar.py`.

## Base de Datos
**Tabla Principal:** `Pelicula`
* `PeliculaID` (INT, Primary Key)
* `Titulo` (NVARCHAR(100))
* `Sinopsis` (NVARCHAR(MAX))
* `SinopsisVector` (VECTOR(384)) - Almacena los embeddings generados por la IA.

## Funcionalidades DP-800 Implementadas
* ✓ **Bloque A (Diseño):** Tablas, constraints y nuevos tipos de datos (VECTOR).
* ✓ **Bloque C (Seguridad):** Implementación del principio de mínimo privilegio creando el rol `RolAnalistaCineteca` con permisos granulares (`GRANT SELECT`, `DENY UPDATE/DELETE`).
* ✓ **Bloque E (Modelos y Embeddings):** Vectorización externa mediante Python y almacenamiento vectorial nativo en SQL Server.
* ✓ **Bloque F (Intelligent Search):** Búsqueda semántica calculando distancias entre vectores usando `VECTOR_DISTANCE` y la función de similitud de coseno.

## Ejemplos de uso
Para buscar una película sobre "viajes en el espacio" sin usar las palabras exactas, revisar el script en `ai/vector_search.sql`. La base es la siguiente:
```sql
DECLARE @q VECTOR(384) = '[0.01, -0.02, ... ]'; -- Simulación del vector de consulta
SELECT TOP 3 Titulo, VECTOR_DISTANCE('cosine', SinopsisVector, @q) AS Similitud
FROM Pelicula
ORDER BY Similitud ASC;
```

## Conclusiones
* **Aprendizaje:** Se ha asimilado la integración de modelos de IA locales (Ollama) con motores relacionales (SQL Server 2025) superando las barreras de tipos de datos al transformar texto libre en representaciones matemáticas persistidas de forma nativa.
* **Problemas encontrados:** La habilitación del motor nativo de Machine Learning en SQL Server Developer presentó conflictos de licencias y dependencias de Windows (error en Launchpad).
* **Solución:** Se implementó una arquitectura desacoplada utilizando un script de Python (ODBC) que interactúa con la API REST de Ollama, logrando una ejecución limpia, modular y robusta.pipeline automatizado que conecta el motor relacional con un modelo de IA local:
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
