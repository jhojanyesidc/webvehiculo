-- Script de base de datos para WebFlotaVehiculo
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS concesionario;
USE concesionario;

-- Crear usuario si no existe
CREATE USER IF NOT EXISTS 'concesionario'@'localhost' IDENTIFIED BY 'TuClaveFuerte123!';
GRANT ALL PRIVILEGES ON concesionario.* TO 'concesionario'@'localhost';
FLUSH PRIVILEGES;

-- Tabla tipos de vehículo
CREATE TABLE IF NOT EXISTS tipovehi (
    IdTv INT PRIMARY KEY,
    nomTv VARCHAR(50) NOT NULL
);

-- Tabla vehículos
CREATE TABLE IF NOT EXISTS vehiculo (
    placa VARCHAR(10) PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    referencia VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    id_tv INT NOT NULL,
    FOREIGN KEY (id_tv) REFERENCES tipovehi(IdTv)
);

-- Insertar algunos tipos de vehículo de ejemplo
INSERT INTO tipovehi (IdTv, nomTv) VALUES
(1, 'Automóvil'),
(2, 'Motocicleta'),
(3, 'Camión'),
(4, 'Bus'),
(5, 'Camioneta')
ON DUPLICATE KEY UPDATE nomTv = VALUES(nomTv);

-- Insertar algunos vehículos de ejemplo
INSERT INTO vehiculo (placa, marca, referencia, modelo, id_tv) VALUES
('ABC123', 'Toyota', 'Corolla', '2023', 1),
('XYZ789', 'Honda', 'Civic', '2022', 1),
('DEF456', 'Yamaha', 'MT-03', '2021', 2)
ON DUPLICATE KEY UPDATE marca = VALUES(marca);
