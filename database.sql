Rem Copyright (c) 2018 by Fandi Ahmad
Rem SimpleCRUD (CodeIgniter + Oracle Database)
Rem Created : 21/Juni/2018

SET TERMOUT OFF
SET ECHO OFF

--
-- Membuat User Oracle Database
--

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO FORUM IDENTIFIED BY FNDIAMD;
ALTER USER FORUM DEFAULT TABLESPACE USERS;
ALTER USER FORUM TEMPORARY TABLESPACE TEMP;
CONNECT FORUM/FNDIAMD

--
-- STRUKTUR TABEL USER
--

DROP TABLE TBLUSER PURGE;
CREATE TABLE TBLUSER (
	ID_USER NUMBER(11) NOT NULL CONSTRAINT PK_USER PRIMARY KEY,
	NAMA_USER VARCHAR2(100) NOT NULL,
	EMAIL VARCHAR2(150) NOT NULL,
	PASSWORD VARCHAR2(150) NOT NULL,
	STATUS NUMBER(11) NOT NULL
);

--
-- SEQUENCE AUTO INCREMENT ID USER
--

DROP SEQUENCE user_seq;
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER AUTO_USER_ID
BEFORE INSERT ON TBLUSER
FOR EACH ROW
BEGIN
	SELECT user_seq.NEXTVAL
	INTO :new.id_user
	FROM dual;
END;
/

--
-- STRUKTUR TABEL ADMIN
--

DROP TABLE TBLADMIN PURGE;
CREATE TABLE TBLADMIN(
	ID_ADMIN NUMBER(11) NOT NULL CONSTRAINT PK_ADMIN PRIMARY KEY,
	NAMA_ADMIN VARCHAR2(100) NOT NULL,
	EMAIL VARCHAR2(150) NOT NULL,
	PASSWORD VARCHAR2(150) NOT NULL,
	AKSES	NUMBER(11) NOT NULL
);

--
-- SEQUENCE AUTO INCREMENT ID ADMIN
--

DROP SEQUENCE admin_seq;
CREATE SEQUENCE admin_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER AUTO_ADMIN_ID
BEFORE INSERT ON TBLADMIN
FOR EACH ROW
BEGIN
	SELECT admin_seq.NEXTVAL
	INTO :new.id_admin
	FROM dual;
END;
/

INSERT INTO TBLADMIN VALUES(1, 'Admin Ganteng', 'admin@forum.com', '$2y$10$LoSI2Tafx.XSYocw1enWNezXWhB5YBEUqH9w/beC8ua6EQ77tGRwK', 1);

--
-- STRUKTUR TABEL ARTIKEL
--

DROP TABLE TBLARTIKEL PURGE;
CREATE TABLE TBLARTIKEL(
	ID_ARTIKEL NUMBER(11) NOT NULL CONSTRAINT PK_ARTIKEL PRIMARY KEY,
	ID_USER NUMBER(11) NOT NULL,
	GAMBAR VARCHAR2(150),
	JUDUL VARCHAR2(150) NOT NULL,
	ISI_ARTIKEL CLOB NOT NULL,
	TANGGAL DATE NOT NULL,
	STATUS NUMBER(11) NOT NULL
);

--
-- SEQUENCE AUTO INCREMENT ID ARTIKEL
--

DROP SEQUENCE artikel_seq;
CREATE SEQUENCE artikel_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER AUTO_ARTIKEL_ID
BEFORE INSERT ON TBLARTIKEL
FOR EACH ROW
BEGIN
	SELECT artikel_seq.NEXTVAL
	INTO :new.id_artikel
	FROM dual;
END;
/

DROP TABLE TBLKOMENTAR PURGE;
CREATE TABLE TBLKOMENTAR(
	ID_KOMENTAR NUMBER(11) NOT NULL CONSTRAINT PK_KOMENTAR PRIMARY KEY,
	ID_USER NUMBER(11) NOT NULL,
	ID_ARTIKEL NUMBER(11) NOT NULL,
	ISI_KOMENTAR CLOB NOT NULL,
	TANGGAL DATE NOT NULL
);

--
-- SEQUENCE AUTO INCREMENT ID KOMENTAR
--

DROP SEQUENCE komentar_seq;
CREATE SEQUENCE komentar_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER AUTO_KOMENTAR_ID
BEFORE INSERT ON TBLKOMENTAR
FOR EACH ROW
BEGIN
	SELECT komentar_seq.NEXTVAL
	INTO :new.id_komentar
	FROM dual;
END;
/


COMMIT;

SET TERMOUT ON
SET ECHO ON

