USE opskrifter2;

INSERT INTO Varekategori (varekategori_tekst)
VALUES ('Frugt & Grønt'),
	('Brød'), 
    ('Kød & Fisk'), 
    ('Tørvarer'), 
    ('Drikkevarer'), 
    ('Pålæg og færdigmad'), 
    ('Mejeri'), 
    ('Frost'), 
    ('Personlig Pleje'), 
    ('Konserves'), 
    ('Husholdning'), 
    ('Diverse');
    
INSERT INTO Varefunktion (varefunktion_tekst)
VALUES ('Hovedingrediens'),
	('Twist'), 
    ('Laver Rest'),
    ('Bruger Rest');
    
INSERT INTO Opskriftstype (opskriftstype_tekst)
VALUES ('Hovedret'),
	('Dessert'), 
    ('Tilbehør');