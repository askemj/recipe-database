SET @retnavn = 'TEST Pastinakfad',
	@noter = 'En velsmagende test',
    @totaltid = 45, @forberedelsestid = 15, 
    @antalPortioner = 2, @opskriftstype = "Hovedret";
INSERT INTO Ret (Ret.ret_navn, Ret.noter, Ret.forberedelsestid_tid,
	Ret.totaltid_tid, Ret.antal_portioner, Ret.Opskriftstype_opskriftstype_id )
VALUES (@retnavn, @noter, @forberedelsestid, @totaltid, @antalPortioner, 
    (SELECT opskriftstype_id FROM Opskriftstype WHERE opskriftstype_tekst = @opskriftstype))
ON DUPLICATE KEY UPDATE
	Ret.ret_navn = @retnavn,
    Ret.noter = @noter, 
    Ret.forberedelsestid_tid = @forberedelsestid,
    Ret.totaltid_tid = @totaltid,
    Ret.antal_portioner = @antalPortioner,
    Ret.Opskriftstype_opskriftstype_id = (SELECT opskriftstype_id FROM Opskriftstype WHERE opskriftstype_tekst = @opskriftstype);
SELECT last_insert_id(); /* så retID returneres til brug ved indsættelse af tags og varer etc. */
SET @retID = (SELECT last_insert_id() ); /* Bruges kun til at køre dette script for sig selv */

/* ... Indsæt Tag ... */

SET @tag = 'Ovnret';
INSERT INTO Tag (Tag.tag_tekst)
VALUES (@tag)
ON DUPLICATE KEY UPDATE
	Tag.tag_tekst = @tag;
SET @tagID = last_insert_id();

INSERT INTO RetTag (RetTag.Ret_ret_id, RetTag.Tag_tag_id)
VALUES (@retID, @tagID);

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

INSERT INTO Enhed (enhed_navn)
VALUES (@enhed)
ON DUPLICATE KEY UPDATE
	Enhed.enhed_navn = @enhed;
SET @enhedID = last_insert_id();

INSERT INTO RetVare (maengde, Enhed_enhed_id, Ret_ret_id, Vare_vare_id, Varefunktion_Varefunktion_id) 
VALUES (@maengde, @enhedID, @retID, @vareID, @varefunktion)
ON DUPLICATE KEY UPDATE
	RetVare.maengde = @maengde,
    RetVare.Enhed_enhed_id = @enhedID, 
    RetVare.Ret_ret_id = @retID, 
    RetVare.Vare_vare_id = @vareID,
    RetVare.Varefunktion_Varefunktion_id = @varefunktion;