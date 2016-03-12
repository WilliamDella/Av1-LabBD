CREATE DATABASE av1_lab_bd
GO 
USE av1_lab_bd

/*
� preciso tamb�m, persistir as escolas de samba, por um id, nome e
total de pontos
*/
CREATE TABLE escola_de_samba
(
	id_escola INT PRIMARY KEY,
	nome VARCHAR(100),
	total_de_pontos DECIMAL(7,2)
)

INSERT INTO escola_de_samba VALUES
	(1, 'Acad�micos do Tatuap�', 0),
	(2, 'Rosas de Ouro', 0),
	(3, 'Mancha Verde', 0),
	(4, 'Vai-Vai', 0),
	(5, 'X-9 Paulistana', 0),
	(6, 'Drag�es da Real', 0),
	(7, '�guia de Ouro', 0),
	(8, 'Nen� de Vila Matilde', 0),
	(9, 'Gavi�es da Fiel', 0),
	(10, 'Mocidade Alegre', 0),
	(11, 'Tom Maior', 0),
	(12, 'Unidos de Vila Maria', 0),
	(13, 'Acad�micos do Tucuruvi', 0),
	(14, 'Imp�rio de Casa Verde', 0)
	
-- Base de dados para os 9 quesitos
CREATE TABLE quesito
(
	id_quesito INT PRIMARY KEY,
	nome VARCHAR(100)
)

INSERT INTO quesito VALUES
	(1, 'Comiss�o de Frente'),
	(2, 'Evolu��o'),
	(3, 'Fantasia'),
	(4, 'Bateria'),
	(5, 'Alegoria'),
	(6, 'Harmonia'),
	(7, 'Samba-Enredo'),
	(8, 'Mestre-Sala e Porta-Bandeira'),
	(9, 'Enredo')

-- Base de dados para os jurados	
CREATE TABLE jurado
(
	id_jurado INT PRIMARY KEY,
	nome VARCHAR(200)
)

INSERT INTO jurado VALUES
	(1, 'Marcos Rocha'),
	(2, 'Giovana Souza'),
	(3, 'Alfredo Travassos'),
	(4, 'Anna Barros'),
	(5, 'Belmiro Macedo'),
	(6, 'Evelyn Gon�alves'),
	(7, 'Cau� Pajares'),
	(8, 'Bianca Carvalho'),
	(9, 'Cosme Bezerril'),
	(10, 'Matilde Ribeiro'),
	(11, 'C�ssio Varanda'),
	(12, 'Almerinda Ruas'),
	(13, 'Delfim Ces�rio'),
	(14, 'Bibiana Cezimbra'),
	(15, 'Ferdinando Caldeira'),
	(16, 'Dorot�ia Vilela'),
	(17, 'Filipe Tabalipa'),
	(18, 'Giovana Cayado'),
	(19, 'Guilherme Hidalgo'),
	(20, 'Teresa Freyria'),
	(21, 'Jaime Capucho'),
	(22, 'Virg�lia Foqui�o'),
	(23, 'Martinho Peroba'),
	(24, 'Em�lia Leit�o'),
	(25, 'Mauro Dias'),
	(26, 'Gerusa Mort�gua'),
	(27, 'Hermenegildo Pereira'),
	(28, 'Isadora Toledo'),
	(29, 'Ad�rito Nunes'),
	(30, 'Ros�lia Pereira'),
	(31, 'Xerxes Coitinho')

/*
Eles julgar�o um ou mais quesitos e, precisa-se saber, para o quesito
que o jurado julgar�, se ele � o 1�, 2�, 3�, 4� ou 5� jurado
*/
CREATE TABLE quesito_jurado
(
	id_quesito INT,
	id_jurado INT,
	ordem INT
	PRIMARY KEY (id_quesito, id_jurado)
	FOREIGN KEY(id_quesito) REFERENCES quesito,
	FOREIGN KEY(id_jurado) REFERENCES jurado
)

INSERT INTO quesito_jurado VALUES
	(1, 1, 2),
	(1, 5, 1),
	(1, 6, 5), -- 1� quesito
	(1, 30, 4),
	(1, 18, 3),
	-------------
	(2, 2, 1),
	(2, 8, 5),
	(2, 13, 3), -- 2� quesito
	(2, 16, 2),
	(2, 4, 4),
	-------------
	(3, 15, 4),
	(3, 24, 2),
	(3, 28, 5), -- 3� quesito
	(3, 9, 1),
	(3, 17, 3),
	-------------
	(4, 7, 3),
	(4, 18, 5),
	(4, 4, 2), -- 4� quesito
	(4, 21, 1),
	(4, 29, 4),
	-------------
	(5, 14, 5),
	(5, 1, 2),
	(5, 19, 3), -- 5� quesito
	(5, 8, 1),
	(5, 11, 4),
	-------------
	(6, 3, 3),
	(6, 5, 5),
	(6, 8, 1), -- 6� quesito
	(6, 22, 4),
	(6, 26, 2),
	-------------
	(7, 27, 2),
	(7, 31, 1),
	(7, 28, 4), -- 7� quesito
	(7, 13, 3),
	(7, 25, 5),
	-------------
	(8, 23, 1),
	(8, 3, 3),
	(8, 10, 5), -- 8� quesito
	(8, 16, 4),
	(8, 20, 2),
	-------------
	(9, 12, 4), 
	(9, 8, 5),
	(9, 25, 1), -- 9� quesito
	(9, 31, 2),
	(9, 28, 3)
	
-- Select para agrupar as escolas de samba por quesito e ordenar os jurados pela ordem de julgamento
SELECT j.nome FROM quesito_jurado qj
INNER JOIN jurado j
ON qj.id_jurado = j.id_jurado
ORDER BY id_quesito, ordem

/*
Cada quesito virar� uma tabela que leva o id da escola, as 5 notas,
a menor descartada, a maior descartada e a nota total
*/
CREATE TABLE comissao_de_frente
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE evolucao
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE fantasia
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE bateria
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE alegoria
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE harmonia
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE samba_enredo
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE mestre_sala_e_porta_bandeira
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE enredo
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(7,2),
	nota2 DECIMAL(7,2),
	nota3 DECIMAL(7,2),
	nota4 DECIMAL(7,2),
	nota5 DECIMAL(7,2),
	menor_descartada DECIMAL(7,2),
	maior_descartada DECIMAL(7,2),
	nota_total DECIMAL(7,2)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)