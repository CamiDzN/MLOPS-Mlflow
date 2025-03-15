CREATE DATABASE IF NOT EXISTS mlflow_db;

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS training_data;
USE training_data;

-- *****************************************************************
-- Cargar los datos del archivo penguins_Iter.csv
-- *****************************************************************

-- Eliminar la tabla si existe para renovar la carga
DROP TABLE IF EXISTS raw_penguins_iter;

CREATE TABLE raw_penguins_iter (
    studyName          VARCHAR(100),
    sample_number      INT,
    species            VARCHAR(100),
    region             VARCHAR(50),
    island             VARCHAR(50),
    stage              VARCHAR(50),
    individual_id      VARCHAR(50),
    clutch_completion  VARCHAR(10),
    date_egg           DATE,
    culmen_length_mm   DECIMAL(5,2),
    culmen_depth_mm    DECIMAL(5,2),
    flipper_length_mm  DECIMAL(5,2),
    body_mass_g        DECIMAL(8,2),
    sex                VARCHAR(10),
    delta_15_n         DECIMAL(8,5),
    delta_13_c         DECIMAL(8,5),
    comments           TEXT
);

LOAD DATA LOCAL INFILE '/docker-entrypoint-initdb.d/penguins_Iter.csv'
INTO TABLE raw_penguins_iter
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@studyName, @sample_number, @species, @region, @island, @stage, @individual_id, @clutch_completion, @date_egg,
 @culmen_length_mm, @culmen_depth_mm, @flipper_length_mm, @body_mass_g, @sex, @delta_15_n, @delta_13_c, @comments)
SET 
    studyName         = @studyName,
    sample_number     = CAST(@sample_number AS UNSIGNED),
    species           = @species,
    region            = @region,
    island            = @island,
    stage             = @stage,
    individual_id     = @individual_id,
    clutch_completion = @clutch_completion,
    date_egg          = STR_TO_DATE(@date_egg, '%m/%d/%y'),
    culmen_length_mm  = CAST(@culmen_length_mm AS DECIMAL(5,2)),
    culmen_depth_mm   = CAST(@culmen_depth_mm AS DECIMAL(5,2)),
    flipper_length_mm = CAST(@flipper_length_mm AS DECIMAL(5,2)),
    body_mass_g       = CAST(@body_mass_g AS DECIMAL(8,2)),
    sex               = @sex,
    delta_15_n        = IF(@delta_15_n = '' OR @delta_15_n IS NULL, NULL, CAST(@delta_15_n AS DECIMAL(8,5))),
    delta_13_c        = IF(@delta_13_c = '' OR @delta_13_c IS NULL, NULL, CAST(@delta_13_c AS DECIMAL(8,5))),
    comments          = @comments;

-- *****************************************************************
-- Cargar los datos del archivo penguins_size.csv
-- *****************************************************************

DROP TABLE IF EXISTS raw_penguins_size;

CREATE TABLE raw_penguins_size (
    species            VARCHAR(100),
    island             VARCHAR(50),
    culmen_length_mm   DECIMAL(5,2),
    culmen_depth_mm    DECIMAL(5,2),
    flipper_length_mm  DECIMAL(5,2),
    body_mass_g        DECIMAL(8,2),
    sex                VARCHAR(10)
);

LOAD DATA LOCAL INFILE '/docker-entrypoint-initdb.d/penguins_size.csv'
INTO TABLE raw_penguins_size
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

