CREATE DATABASE db_movies;
USE db_movies;
CREATE TABLE movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    yr INT,
    director VARCHAR(100),
    budget DECIMAL(15, 2),
    gross DECIMAL(15, 2)
);
CREATE TABLE actor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE casting (
    movieid INT,
    actorid INT,
    ord INT, -- 'ord' indica el orden de importancia o aparición del actor en la película
    PRIMARY KEY (movieid, actorid), -- La clave primaria compuesta evita duplicados
    FOREIGN KEY (movieid) REFERENCES movie(id), -- Enlace a la tabla 'movie'
    FOREIGN KEY (actorid) REFERENCES actor(id)  -- Enlace a la tabla 'actor'
);
-- Películas
INSERT INTO movie (title, yr, director, budget, gross) VALUES
('Pulp Fiction', 1994, 'Quentin Tarantino', 8000000, 213900000),
('Inception', 2010, 'Christopher Nolan', 160000000, 825500000),
('The Godfather', 1972, 'Francis Ford Coppola', 6000000, 245000000);

-- Actores
INSERT INTO actor (name) VALUES
('John Travolta'),          -- id 1
('Samuel L. Jackson'),      -- id 2
('Leonardo DiCaprio'),      -- id 3
('Joseph Gordon-Levitt'),   -- id 4
('Al Pacino'),              -- id 5
('Marlon Brando');          -- id 6

-- Casting (Relaciones)
INSERT INTO casting (movieid, actorid, ord) VALUES
(1, 1, 1), -- Pulp Fiction -> John Travolta (principal)
(1, 2, 2), -- Pulp Fiction -> Samuel L. Jackson (secundario)
(2, 3, 1), -- Inception -> Leonardo DiCaprio (principal)
(2, 4, 2), -- Inception -> Joseph Gordon-Levitt (secundario)
(3, 5, 2), -- The Godfather -> Al Pacino (secundario)
(3, 6, 1); -- The Godfather -> Marlon Brando (principal)
DELIMITER $$

CREATE PROCEDURE sp_buscar_peliculas_por_actor(IN actor_nombre VARCHAR(100))
BEGIN
    -- El parámetro 'IN' significa que es un valor de entrada.

    -- Esta consulta une las tres tablas para encontrar las películas.
    SELECT
        m.title AS 'Título de la Película',
        m.yr AS 'Año'
    FROM actor a
    JOIN casting c ON a.id = c.actorid
    JOIN movie m ON c.movieid = m.id
    WHERE a.name = actor_nombre; -- Filtramos por el nombre del actor que recibimos.

END$$

-- Volvemos a poner el delimitador por defecto.
DELIMITER ;
CALL sp_buscar_peliculas_por_actor('Leonardo DiCaprio');
DELIMITER $$

CREATE PROCEDURE sp_calcular_ganancia_pelicula(
    IN pelicula_id INT,
    OUT titulo_pelicula VARCHAR(255),
    OUT ganancia DECIMAL(15, 2)
)
BEGIN
    -- Los parámetros 'OUT' son variables que el procedimiento "devuelve".

    -- Seleccionamos el título y calculamos la ganancia.
    -- Usamos 'INTO' para guardar los resultados en nuestras variables de salida.
    SELECT
        title,
        (gross - budget)
    INTO
        titulo_pelicula,
        ganancia
    FROM movie
    WHERE id = pelicula_id;

END$$

DELIMITER ;
CALL sp_calcular_ganancia_pelicula(1, @titulo, @ganancia);
SELECT @titulo AS 'Película', @ganancia AS 'Ganancia Neta';
-- Creamos la vista.
CREATE VIEW v_peliculas_con_actor_principal AS
SELECT
    m.title AS 'pelicula',
    m.yr AS 'año',
    a.name AS 'actor_principal'
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE c.ord = 1; -- Filtramos solo para obtener el actor principal (orden 1).


-- ¿Cómo la usamos?
-- La consultamos como si fuera una tabla normal.
SELECT * FROM v_peliculas_con_actor_principal;

-- Podemos incluso agregarle condiciones.
SELECT * FROM v_peliculas_con_actor_principal WHERE año > 2000;
CREATE TABLE log_auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255),
    fecha_hora DATETIME
);
DELIMITER $$

CREATE TRIGGER trg_auditar_nueva_pelicula
AFTER INSERT ON movie -- Se ejecutará DESPUÉS de un INSERT en la tabla 'movie'.
FOR EACH ROW -- Se ejecutará por cada fila que sea insertada.
BEGIN
    -- 'NEW' es una palabra clave que nos da acceso a los datos de la fila que se acaba de insertar.
    INSERT INTO log_auditoria (descripcion, fecha_hora)
    VALUES (
        CONCAT('Se agregó una nueva película: ', NEW.title),
        NOW() -- La función NOW() devuelve la fecha y hora actual.
    );
END$$

DELIMITER ;
INSERT INTO movie (title, yr, director, budget, gross)
VALUES ('Fight Club', 1999, 'David Fincher', 63000000, 100900000);
SELECT * FROM log_auditoria;






