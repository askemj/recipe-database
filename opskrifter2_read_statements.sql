/* Test forbindelsen */ 
SHOW databases;
USE opskrifter2;
SELECT * FROM Vare;

/* Læs opskriftsdetaljer fra Ret-tabel */ 

SET @retnavn = 'TEST Pastinakfad';
SELECT * FROM Ret WHERE Ret.ret_navn = @retnavn;
SET @retID = (SELECT Ret.ret_id FROM Ret WHERE Ret.ret_navn = @retnavn); /* FIXME man kan nok tage det fra outputtet før med SET @retid= ??? */

/* ... Indsæt Tag ... */
SET @retID = 1; /* Slet hvis hele scriptet køres */
/* FIXME her skal der bruges et join statement af en art */ 

/* NB NB NB NB NB NB NB NB NB NB NB der er ikke rettet yderligere i denne fil herfra, nedenstående skal slettes til fordel for de rigtige read statements */ 
/* .. Indsæt Vare ... */ 

SET @retID = 1, /* NB slet hvis scriptet køres ud i et */
	@varenavn = 'agurk', 
    @basisvare = 0,
	@varekategoriID = (SELECT varekategori_id FROM Varekategori WHERE varekategori_tekst = 'Frugt & Grønt'),
    @enhed = 'stk.',
    @maengde = 3,
    @varefunktion = (SELECT varefunktion_id FROM Varefunktion WHERE varefunktion_tekst = 'Hovedingrediens'); 
INSERT INTO Vare (vare_navn, basisvare, Varekategori_varekategori_id) /*DER ER ET PROBLEM HER LIGE NU */
VALUES (@varenavn, @basisvare, @varekategoriID)
ON DUPLICATE KEY UPDATE
	Vare.vare_navn = @varenavn,
    Vare.basisvare = @basisvare,
    Vare.Varekategori_varekategori_id = @varekategoriID;
SET @vareID = last_insert_id();


/* Indsæt Enhed */
INSERT INTO Enhed (enhed_navn)
VALUES (@enhed)
ON DUPLICATE KEY UPDATE
	Enhed.enhed_navn = @enhed;
SET @enhedID = last_insert_id();

/* Link vare til opskrift */
INSERT INTO RetVare (maengde, Enhed_enhed_id, Ret_ret_id, Vare_vare_id, Varefunktion_Varefunktion_id) 
VALUES (@maengde, @enhedID, @retID, @vareID, @varefunktion)
ON DUPLICATE KEY UPDATE
	RetVare.maengde = @maengde,
    RetVare.Enhed_enhed_id = @enhedID, 
    RetVare.Ret_ret_id = @retID, 
    RetVare.Vare_vare_id = @vareID,
    RetVare.Varefunktion_Varefunktion_id = @varefunktion;
