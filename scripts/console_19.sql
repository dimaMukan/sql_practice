-- CREATE DATABASE OOKP_labs;

DROP TABLE IF EXISTS stuff;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS NFT;
DROP TABLE IF EXISTS coin;
DROP TABLE IF EXISTS catalog;
DROP TABLE IF EXISTS places;


CREATE TABLE stuff
(
    id integer NOT NULL PRIMARY KEY,
    surname varchar(30) NOT NULL,
    name varchar(30) NOT NULL,
    patronymic varchar(30),
    age integer  NOT NULL,
    phone_number text NOT NULL,
    passport_info text NOT NULL,
    salary integer NOT NULL,
    coin_id integer,
    amount integer,
    work_experience integer NOT NULL
);

INSERT into stuff
VALUES
(1,'Vlada','Gusakova','Kirilivna',18,'+3785743839','76JIK90',19000,2,200,3),
(2,'Nikol','Geroivna','Dmitrivna',23,'+3942748390','9867UIC',22000,2,200,5),
(3,'Ira','Koval','Vasilivna',17,'+3983794932','97658YUO',9000,2,200,1),
(4,'Oleg','Novich','Vasiliovich',29,'+378263578','90KOP89',42000,2,200,9),
(5,'Dima','Mukan','Sergiyovich',21,'+37876527','89KOL00',21100,2,200,2),
(6,'Andrew','Buga','Dmitreevich',22,'+37785478','678RTT0',17000,2,200,1),
(7,'Tom','Kuleba','Ivanovich',41,'+37876553','12233IO9',12000,2,200,3),
(8,'Alina','Sokolova','Andreevna',24,'+3232874443','0999OP71',19000,2,200,3),
(9,'Lev','Levovich','Ivanovich',31,'+3778637249','OP98765I',41000,2,200,11),
(10,'Max','Egorov','Kirilivich',19,'+378764586','567YUY8',13000,2,200,2);




CREATE TABLE customer
(
    id integer NOT NULL PRIMARY KEY,
    surname varchar(30) NOT NULL,
    name varchar(30) NOT NULL,
    patronymic varchar(30),
    age integer  NOT NULL,
    city varchar(30) NOT NULL,
    phone_number text NOT NULL,
    email varchar(40),
    passport_info text NOT NULL,
    identity_number text NOT NULL,
    amount_coins integer,
    coin_id integer,
    amount_NFT integer,
    NFT_id integer,
    password text NOT NULL
);

INSERT into customer
VALUES
(1,'Alex','Lebedev','Levovicn',19,'Kyiv','+39893768','Alex@gmail.com','467YI78','543687674623',NULL,NULL,NULL,NULL,'12345'),
(2,'Max','Novikov','Markovich',21,'Lviv','+392339873','Max@gmail.com','4565JII','235745685',NULL,NULL,NULL,NULL,'12345'),
(3,'Eva','Morozov','Demidivna',20,'Ivano Frankivsk','+393271876','Eva@gmail.com','8721UII','65868842',NULL,NULL,NULL,NULL,'12345'),
(4,'Anna','Gumenuk','Andreevna',18,'Odessa','+390987645','Anna@gmail.com','2345HUK','E57686765',NULL,NULL,NULL,NULL,'12345'),
(5,'Daniil','Fedorov','Vasilivna',21,'Kyiv','+392134354','Daniil@gmail.com','867564BB','123445765',NULL,NULL,NULL,NULL,'12345'),
(6,'Anna','Volkova','Sergeevich',22,'Kyiv','+393453552','Anna@gmail.com','9788KOO','67545363',NULL,NULL,NULL,NULL,'12345'),
(7,'ALex','Pavlov','Irakliv',24,'Lviv','+3952352342','ALex@gmail.com','54657BC','23563646',NULL,NULL,NULL,NULL,'12345'),
(8,'Dima','Mukan','Georgivich',21,'Lviv','+391243463','Dima@gmail.com','13124IO','68986592Q',NULL,NULL,NULL,NULL,'12345'),
(9,'Ivan','Kozlov','Andreevich',18,'Kyiv','+39412256','Ivan@gmail.com','456OIHJ9','69065641422',NULL,NULL,NULL,NULL,'12345'),
(10,'Ivan','Andreev','Juriivna',19,'Odessa','+39354456564','Ivan1@gmail.com','4567BJI','125364657586',NULL,NULL,NULL,NULL,'12345');


CREATE TABLE NFT
(
    id integer NOT NULL PRIMARY KEY,
    cost_per_one integer NOT NULL,
    company_name text NOT NULL,
    amount integer NOT NULL,
    stuff_id integer NOT NULL
);

INSERT into NFT
VALUES
(1,4900,'Ducks',777,1),
(2,5600,'THE MERGE',777,2),
(3,1000,'STEPN',777,3),
(4,3000,'EVERYDAY`S',777,4),
(5,21000,'THE FIRST',777,5),
(6,72000,'NFT CLOCK',777,6),
(7,39000,'Human One',777,7),
(8,210450,'CryptoPunk',777,8),
(9,51000,'BYC',777,9),
(10,32000,'BAPE',777,10);



CREATE TABLE coin
(
    id integer NOT NULL PRIMARY KEY,
    identity_number text NOT NULL,
    coin_name text NOT NULL,
    cost_per_one float NOT NULL,
    amount integer NOT NULL
);

INSERT into coin
VALUES
(1,'432543654','Bitcoin',22000,10000),
(2,'354657463','Tether',1200,9000),
(3,'52346756464','USD Coin',1,1900000),
(4,'25657685523','BNB',2300,50000),
(5,'52334758655','Binance USD',2,5000000),
(6,'2534756525','XRP',35,400000),
(7,'2532475865','Solana',90,200000),
(8,'253465764','Polkadot',7,50000),
(9,'36454765867','DOGE',0.3,50000000),
(10,'5647346346','Shiba Inu',0.09,80000000);


CREATE TABLE catalog
(
    id integer NOT NULL PRIMARY KEY,
    coin_id integer NOT NULL,
    NFT_id integer NOT NULL,
    customer_id integer ,
    stuff_id integer,
    coin_total_amount integer NOT NULL,
    NFT_total_amount integer NOT NULl
);

INSERT into catalog
VALUES
(1,1,1,3,1,420000,5000),
(2,2,2,2,2,21300000,1),
(3,3,3,3,3,7000000,10300),
(4,4,4,7,4,1000000,5),
(5,5,5,5,5,21000000,300),
(6,6,6,6,6,3000000,2900),
(7,7,7,7,7,1200000,80000),
(8,8,8,9,8,450000,500),
(9,9,9,9,9,120000000,4000),
(10,10,10,10,10,300000000,7390);



CREATE TABLE places
(
    id integer NOT NULL PRIMARY KEY,
    name_place text NOT NULL,
    percent_commission integer NOT NULL,
    phone_number text NOT NULL,
    email varchar(40),
    official bool NOT NULL
);

INSERT into places
VALUES
(1,'Kuna',3,'+8654634647','kuna@gmail.com',TRUE),
(2,'EO',3,'+8746345246758','EO@gmail.com',FALSE),
(3,'Bestchanger',3,'+2536475869','Bestchanger@gmail.com',TRUE),
(4,'NEXO',3,'+897856746','NEXO@gmail.com',FALSE),
(5,'META',3,'+5687698709','META@gmail.com',TRUE),
(6,'AIN',3,'+66543675456','AIN@gmail.com',FALSE),
(7,'Ledger',3,'+3465475869','Ledger@gmail.com',TRUE),
(8,'Payeer',3,'+3245464758697','Payeer@gmail.com',FALSE),
(9,'CScalp',3,'+44435246758','CScalp@gmail.com',TRUE),
(10,'With',3,'+3465475869','With@gmail.com',TRUE);


UPDATE places
SET percent_commission = percent_commission+1;

UPDATE customer
SET password = 'MyNameIsAlex'
WHERE name = 'Alex';

UPDATE stuff
SET salary = salary+1500
WHERE work_experience>3;

ALTER table places
ADD column Is_In_Ukraine bool;

UPDATE places
SET Is_In_Ukraine = true
WHERE official = true;

UPDATE places
SET Is_In_Ukraine = false
WHERE official = false;

ALTER table places
ADD column closed bool;

ALTER TABLE places
DROP COLUMN closed;

SELECT coin.coin_name,coin.cost_per_one,coin.amount,coin.cost_per_one*coin.amount
FROM coin;

SELECT coin.coin_name,coin.cost_per_one,coin.amount,coin.cost_per_one*coin.amount
FROM coin
WHERE coin.cost_per_one*coin.amount>50000;

SELECT coin.coin_name,coin.cost_per_one,coin.amount,coin.cost_per_one*coin.amount
FROM coin
WHERE coin.cost_per_one*coin.amount<5000;

SELECT coin.coin_name,coin.cost_per_one
FROM coin
WHERE coin.cost_per_one>1000;

SELECT coin.coin_name,coin.cost_per_one*coin.amount
FROM coin;

SELECT sum(amount)
FROM coin;

SELECT coin.coin_name,coin.cost_per_one*coin.amount
FROM coin
WHERE coin.cost_per_one*coin.amount > 10000000;

SELECT catalog.customer_id,customer.name,customer.passport_info,customer.email,customer.amount_coins,stuff.name,stuff.work_experience
FROM catalog
JOIN customer on customer.id = catalog.customer_id
JOIN stuff on stuff.id = customer.id;

SELECT catalog.coin_id,coin.coin_name,catalog.coin_total_amount - coin.amount
FROM catalog
JOIN coin on coin.id = catalog.coin_id








