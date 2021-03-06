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
	total_de_pontos DECIMAL(4,1)
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
	(1, 'Marcos Rocha Azevedo'),
	(2, 'Giovana Souza Martins'),
	(3, 'Alfredo Travassos Costa'),
	(4, 'Anna Barros Souza'),
	(5, 'Belmiro Macedo Carvalho'),
	(6, 'Evelyn Gon�alves Ribeiro'),
	(7, 'Cau� Pajares Ribeiro'),
	(8, 'Bianca Carvalho de Lima'),
	(9, 'Cosme Alves Bezerril'),
	(10, 'Matilde Ribeiro Almeida'),
	(11, 'C�ssio Varanda Nascimento'),
	(12, 'Almerinda Ruas Bonfim'),
	(13, 'Delfim Ces�rio Alencar'),
	(14, 'Bibiana Cezimbra Correia'),
	(15, 'Ferdinando Caldeira da Silva'),
	(16, 'Dorot�ia Dias Vilela'),
	(17, 'Filipe Tabalipa de Oliveira'),
	(18, 'Giovana de Ara�jo Cayado'),
	(19, 'Guilherme Hidalgo Rodrigues'),
	(20, 'Teresa Freyria Pinto'),
	(21, 'Jaime Jos� Capucho'),
	(22, 'Virg�lia Boaventura Foqui�o'),
	(23, 'Martinho de Francisco Peroba'),
	(24, 'Em�lia Leit�o Harris'),
	(25, 'Mauro Dias Gonzalez'),
	(26, 'Gerusa Cardoso Mort�gua'),
	(27, 'Hermenegildo Melo Pereira'),
	(28, 'Isadora Toledo Souza'),
	(29, 'Ad�rito Ferreira Nunes'),
	(30, 'Ros�lia Pereira Santos'),
	(31, 'Xerxes Coitinho Almeida')

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
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE evolucao
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE fantasia
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE bateria
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE alegoria
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE harmonia
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE samba_enredo
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE mestre_sala_e_porta_bandeira
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE TABLE enredo
(
	id_escola INT PRIMARY KEY,
	nota1 DECIMAL(4,1),
	nota2 DECIMAL(4,1),
	nota3 DECIMAL(4,1),
	nota4 DECIMAL(4,1),
	nota5 DECIMAL(4,1),
	menor_descartada DECIMAL(4,1),
	maior_descartada DECIMAL(4,1),
	nota_total DECIMAL(4,1)
	FOREIGN KEY (id_escola) REFERENCES escola_de_samba
)

CREATE PROCEDURE sp_apuracao (@nota DECIMAL, @id_escola INT, @id_quesito INT, @contador_nota INT)
AS
DECLARE @nota_final DECIMAL, @menor_descartada DECIMAL, @maior_descartada DECIMAL, @nota_total DECIMAL, @tabela VARCHAR(35)
SET @nota_final = 0
SET @menor_descartada = 0
SET @maior_descartada = 0
SET @nota_total = 0
SET @tabela = NULL 

SET @tabela = (SELECT nome_quesito FROM quesito WHERE id_quesito = @id_quesito)
SET @total_de_pontos = (SELECT total_de_pontos FROM escola WHERE id_escola = @id_escola)

IF (@contador_nota = 1 OR @contador_nota = 2 OR @contador_nota = 3 OR @contador_nota = 4)
BEGIN
	SET @nota_total = @nota_total + @nota
	IF (@contador_nota = 1)
	BEGIN
		SET @maior_descartada = @nota
		SET @menor_descartada = @nota
	END
	ELSE
	BEGIN
		IF (@nota > @maior_descartada)
		BEGIN
			SET @maior_descartada = @nota
		END
		ELSE IF (@nota < @menor_descartada)
		BEGIN
			SET @menor_descartada = @nota
		END	
	END
ELSE IF (@contador_nota = 5)
BEGIN
	@nota_total = @nota_total + @nota
	IF (@nota > @maior_descartada)
	BEGIN
		SET @maior_descartada = @nota
	END
	ELSE IF (@nota < @menor_descartada)
	BEGIN
		SET @menor_descartada = @nota
	END
	SET @nota_total = @nota_total - @maior_descartada - @menor_descartada
	SET @total_de_pontos = @nota_total WHERE id_escola = @id_escola
END

-- SETAR NA TABELA DA ESCOLA O @total_de_pontos

/*
IF ((id_quesito + 1) = 10)
BEGIN
	SET @query = 'INSERT INTO '+@tabela+' VALUES'+
	'('''+@id_escola+''','''+@nota1+''','''+@nota2+''','''+@nota3+''','''+@nota4+''','''+@nota5+''','''+@menor_descartada+''','''+@maior_descartada+''', '''+@nota_total+''')'
	-- PRECISA SETAR NOTA POR NOTA ENT�O N�O VAI DAR PRA USAR UMA S� VARIAVEL @nota
	-- PRECISA SETAR OS VALORES PRA TABELA ESCOLA?
	-- @total_de_pontos NA ESCOLA S�O OS PONTOS FINAIS CONSIDERANDO MINIMO E MAXIMO?
	-- A TABELA FINAL VAI SER UM SELECT?
END	
*/

	