DROP TABLE 'client' IF EXISTS;

CREATE TABLE client(
    clientID VARCHAR PRIMARY KEY,
    clientName VARCHAR,
    category VARCHAR,
    'location' VARCHAR 
);

DROP TABLE 'location' IF EXISTS;

CREATE TABLE location(
    locationID VARCHAR PRIMARY KEY,
    region VARCHAR,
    ville VARCHAR,
    quartier VARCHAR
);

DROP TABLE 'MP' IF EXISTS;

CREATE TABLE MP(
    MPID VARCHAR PRIMARY KEY,
    MPName VARCHAR
)

DROP TABLE 'product' IF EXISTS;

CREATE TABLE product(
    productID VARCHAR PRIMARY KEY,
    category VARCHAR,
    subCategory1 VARCHAR,
    subCategory2 VARCHAR,
    productName VARCHAR,
    unitPrice INT,
);

DROP TABLE 'time' IF EXISTS;

CREATE TABLE time(
    DateID VARCHAR PRIMARY KEY,
    'date' DATE,
    'month' INT,
    'year' INT
);

DROP TABLE 'usine' IF EXISTS;

CREATE TABLE usine(
    usineID VARCHAR PRIMARY KEY,
    usineName VARCHAR,
    'location' VARCHAR
);

DROP TABLE 'vente' IF EXISTS;

CREATE TABLE vente(
    venteID SERIAL PRIMARY KEY,
    productID VARCHAR(50) NOT NULL,
    clientID VARCHAR(50) NOT NULL,
    locationID VARCHAR NOT NULL,
    salesDate DATE NOT NULL,
    salesVolume INT NOT NULL,
    salesAmount NUMERIC(10, 2) NOT NULL,

    FOREIGN KEY (productID) REFERENCES produit(productID),
    FOREIGN KEY (locationID) REFERENCES 'location'(locationID),
    FOREIGN KEY (clientID) REFERENCES client(clientID),
    FOREIGN KEY (salesDate) REFERENCES temps(date)
);

DROP TABLE 'fabrication' IF EXISTS;

CREATE TABLE fabrication (
    FabricationID SERIAL PRIMARY KEY,
    produitID VARCHAR(50) NOT NULL,
    usineID VARCHAR(50) NOT NULL,
    MPID VARCHAR(50) NOT NULL,
    dateProduction DATE NOT NULL,
    quantiteProduite INT NOT NULL,
    quantiteConditionnee INT NOT NULL,
    ecartFabrication INT,
    ecartConditionnement INT,
    quantiteMP INT NOT NULL,

    -- Définition des clés étrangères
    FOREIGN KEY (produitID) REFERENCES produit(productID),
    FOREIGN KEY (usineID) REFERENCES usine(usineID),
    FOREIGN KEY (MPID) REFERENCES matiere_premiere(mpid),
    FOREIGN KEY (dateProduction) REFERENCES temps(date)
);

DROP TABLE 'retour' IF EXISTS;

CREATE TABLE retour (
    retourID SERIAL PRIMARY KEY,
    produitID VARCHAR(50) NOT NULL,
    usineID VARCHAR(50) NOT NULL,
    dateRetour DATE NOT NULL,
    quantiteRetournée INT NOT NULL,

    -- Définition des clés étrangères
    FOREIGN KEY (produitID) REFERENCES produit(productID),
    FOREIGN KEY (usineID) REFERENCES usine(usineID),
    FOREIGN KEY (dateRetour) REFERENCES temps(date)
);

DROP TABLE 'ditribution' IF EXISTS;

CREATE TABLE distribution (
    distributionID SERIAL PRIMARY KEY,
    productID VARCHAR(50) NOT NULL,
    clientID VARCHAR(50) NOT NULL,
    locationID VARCHAR NOT NULL,
    distributionDate DATE NOT NULL,
    quantity INT NOT NULL,
    
    FOREIGN KEY (productID) REFERENCES produit(productID),
    FOREIGN KEY (clientID) REFERENCES client(clientID),
    FOREIGN KEY (distributionDate) REFERENCES temps(date),
    FOREIGN KEY (locationID) REFERENCES 'location'(locationID),
);