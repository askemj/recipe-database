/* Test forbindelsen */ 
SHOW databases;
USE opskrifter2;
SELECT * FROM Vare;

/* Læs opskriftsdetaljer fra Ret-tabel */ 

SET @retnavn = 'TEST Pastinakfad';
SELECT * FROM Ret WHERE Ret.ret_navn = @retnavn;
SET @retID = (SELECT Ret.ret_id FROM Ret WHERE Ret.ret_navn = @retnavn); /* FIXME man kan nok tage det fra outputtet før med SET @retid= ??? */

/* ...  Læs Tags ... */
SET @retID = 1; /* Slet hvis hele scriptet køres */

SELECT Ret.ret_navn, Tag.tag_tekst FROM Ret 
INNER JOIN RetTag ON Ret.ret_id = RetTag.Ret_ret_id
INNER JOIN Tag ON Tag.tag_id = RetTag.Tag_tag_id WHERE Ret.ret_id = @retID;

/* ... Læs varer ... */
SET @retID = 1; /* Slet hvis hele scriptet køres */
/* FIXME her skal der bruges et join statement af en art */ 

SELECT Vare.vare_navn FROM /* FixMe */
INNER JOIN /* FixMe */