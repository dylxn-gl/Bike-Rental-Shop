--Creacion de la base de datos
CREATE DATABASE bikeRentalShop;

--Creacion de las tablas
CREATE TABLE Bike (
  id SERIAL PRIMARY KEY,
  model VARCHAR,
  brand VARCHAR,
  type VARCHAR,
  color VARCHAR,
  price INT,
  available BOOLEAN
);

CREATE TABLE Clients (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  mail VARCHAR,
  cellphonenumber INT,
  country VARCHAR
);

CREATE TABLE Rent (
  id SERIAL PRIMARY KEY,
  client INT,
  bike INT,
  rentdate TIMESTAMP,
  returndate TIMESTAMP,
  totalamount DECIMAL
);
