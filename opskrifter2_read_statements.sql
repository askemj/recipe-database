/* Test forbindelsen */ 
SHOW databases;
USE opskrifter2;
SELECT * FROM Vare;

/* Læs opskriftsdetaljer fra Ret-tabel */ 

SET @retnavn = 'TEST Pastinakfad';
SELECT * FROM Ret WHERE Ret.ret_navn = @retnavn;
SET @retID = (SELECT Ret.ret_id FROM Ret WHERE Ret.ret_navn = @retnavn); /* FIXME man kan nok tage det fra outputtet før med SET @retid= ??? */

SELECT Ret.ret_id, Ret.ret_navn, Ret.noter, Ret.antal_portioner, Ret.forberedelsestid_tid, Ret.totaltid_tid, Opskriftstype.opskriftstype_tekst
FROM Ret
INNER JOIN Opskriftstype ON Ret.Opskriftstype_opskriftstype_id = Opskriftstype.opskriftstype_id
WHERE Ret.ret_id = 1;

/* ...  Læs Tags ... */
SET @retID = 1; /* Slet hvis hele scriptet køres */

SELECT Ret.ret_navn, Tag.tag_tekst FROM Ret 
INNER JOIN RetTag ON Ret.ret_id = RetTag.Ret_ret_id
INNER JOIN Tag ON Tag.tag_id = RetTag.Tag_tag_id WHERE Ret.ret_id = @retID;

/* ... Læs varer ... */
SET @retID = 1; /* Slet hvis hele scriptet køres */

SELECT RetVare.maengde, Enhed.enhed_navn, Vare.vare_navn, Varekategori.varekategori_tekst, Vare.basisvare, Varefunktion.Varefunktion_tekst FROM RetVare 
INNER JOIN Enhed ON RetVare.Enhed_enhed_id = Enhed.enhed_id
INNER JOIN Vare ON RetVare.Vare_vare_id = Vare.vare_id
INNER JOIN Varekategori ON  RetVare.Vare_vare_id = Vare.vare_id AND Vare.vare_id = Varekategori.varekategori_id
INNER JOIN Varefunktion ON Varefunktion_Varefunktion_id = Varefunktion_id /* FixMe Varefunktion_id burde være med småt */
WHERE RetVare.Ret_ret_id = @retID; 