CREATE DATABASE av1_lab_bd
GO 
USE av1_lab_bd

/*
É preciso também, persistir as escolas de samba, por um id, nome e
total de pontos
*/
CREATE TABLE escola_de_samba
(
	id_escola INT PRIMARY KEY,
	nome VARCHAR(100),
	total_de_pontos DECIMAL(4,1)
)

INSERT INTO escola_de_samba VALUES
	(1, 'Acadêmicos do Tatuapé', 0),
	(2, 'Rosas de Ouro', 0),
	(3, 'Mancha Verde', 0),
	(4, 'Vai-Vai', 0),
	(5, 'X-9 Paulistana', 0),
	(6, 'Dragões da Real', 0),
	(7, 'Águia de Ouro', 0),
	(8, 'Nenê de Vila Matilde', 0),
	(9, 'Gaviões da Fiel', 0),
	(10, 'Mocidade Alegre', 0),
	(11, 'Tom Maior', 0),
	(12, 'Unidos de Vila Maria', 0),
	(13, 'Acadêmicos do Tucuruvi', 0),
	(14, 'Império de Casa Verde', 0)
	
-- Base de dados para os 9 quesitos
CREATE TABLE quesito
(
	id_quesito INT PRIMARY KEY,
	nome VARCHAR(100)
)

INSERT INTO quesito VALUES
	(1, 'Comissão de Frente'),
	(2, 'Evolução'),
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
	(6, 'Evelyn Gonçalves Ribeiro'),
	(7, 'Cauê Pajares Ribeiro'),
	(8, 'Bianca Carvalho de Lima'),
	(9, 'Cosme Alves Bezerril'),
	(10, 'Matilde Ribeiro Almeida'),
	(11, 'Cássio Varanda Nascimento'),
	(12, 'Almerinda Ruas Bonfim'),
	(13, 'Delfim Cesário Alencar'),
	(14, 'Bibiana Cezimbra Correia'),
	(15, 'Ferdinando Caldeira da Silva'),
	(16, 'Dorotéia Dias Vilela'),
	(17, 'Filipe Tabalipa de Oliveira'),
	(18, 'Giovana de Araújo Cayado'),
	(19, 'Guilherme Hidalgo Rodrigues'),
	(20, 'Teresa Freyria Pinto'),
	(21, 'Jaime José Capucho'),
	(22, 'Virgília Boaventura Foquiço'),
	(23, 'Martinho de Francisco Peroba'),
	(24, 'Emília Leitão Harris'),
	(25, 'Mauro Dias Gonzalez'),
	(26, 'Gerusa Cardoso Mortágua'),
	(27, 'Hermenegildo Melo Pereira'),
	(28, 'Isadora Toledo Souza'),
	(29, 'Adérito Ferreira Nunes'),
	(30, 'Rosália Pereira Santos'),
	(31, 'Xerxes Coitinho Almeida')

/*
Eles julgarão um ou mais quesitos e, precisa-se saber, para o quesito
que o jurado julgará, se ele é o 1º, 2º, 3º, 4º ou 5º jurado
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
	(1, 6, 5), -- 1º quesito
	(1, 30, 4),
	(1, 18, 3),
	-------------
	(2, 2, 1),
	(2, 8, 5),
	(2, 13, 3), -- 2º quesito
	(2, 16, 2),
	(2, 4, 4),
	-------------
	(3, 15, 4),
	(3, 24, 2),
	(3, 28, 5), -- 3º quesito
	(3, 9, 1),
	(3, 17, 3),
	-------------
	(4, 7, 3),
	(4, 18, 5),
	(4, 4, 2), -- 4º quesito
	(4, 21, 1),
	(4, 29, 4),
	-------------
	(5, 14, 5),
	(5, 1, 2),
	(5, 19, 3), -- 5º quesito
	(5, 8, 1),
	(5, 11, 4),
	-------------
	(6, 3, 3),
	(6, 5, 5),
	(6, 8, 1), -- 6º quesito
	(6, 22, 4),
	(6, 26, 2),
	-------------
	(7, 27, 2),
	(7, 31, 1),
	(7, 28, 4), -- 7º quesito
	(7, 13, 3),
	(7, 25, 5),
	-------------
	(8, 23, 1),
	(8, 3, 3),
	(8, 10, 5), -- 8º quesito
	(8, 16, 4),
	(8, 20, 2),
	-------------
	(9, 12, 4), 
	(9, 8, 5),
	(9, 25, 1), -- 9º quesito
	(9, 31, 2),
	(9, 28, 3)
	
-- Select para agrupar as escolas de samba por quesito e ordenar os jurados pela ordem de julgamento
SELECT j.nome FROM quesito_jurado qj
INNER JOIN jurado j
ON qj.id_jurado = j.id_jurado
ORDER BY id_quesito, ordem

/*
Cada quesito virará uma tabela que leva o id da escola, as 5 notas,
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

--DROP PROCEDURE sp_apuracao

/*
Dois blocos à seguir são para definir quais são a maior e menor notas 
à serem descartadas
*/
UPDATE comissao_de_frente
SET menor_descartada = (select min(valores.menor_valor)
from
(select nota1 menor_valor from comissao_de_frente
union all
select nota2 menor_valor from comissao_de_frente
union all
select nota3 menor_valor from comissao_de_frente) as valores)
WHERE id_escola = 1

UPDATE comissao_de_frente
SET maior_descartada = (select max(valores.menor_valor)
from
(select nota1 menor_valor from comissao_de_frente
union all
select nota2 menor_valor from comissao_de_frente
union all
select nota3 menor_valor from comissao_de_frente) as valores)
WHERE id_escola = 1

SELECT escola_de_samba.nome, nota1,
	   nota2, nota3, nota4, nota5,
	   menor_descartada, maior_descartada,
	   nota_total
FROM comissao_de_frente
INNER JOIN escola_de_samba
ON comissao_de_frente.id_escola = escola_de_samba.id_escola

CREATE PROCEDURE sp_apuracao (@id_quesito INT, @id_escola INT,
		 @nota DECIMAL(4,1), @contador_nota INT)
AS
DECLARE @menor_descartada AS DECIMAL(4,1), @maior_descartada AS DECIMAL(4,1),
		@nota_total AS DECIMAL(4,1), @total_de_pontos AS DECIMAL(4,1),
		@tabela AS VARCHAR(30), @query AS VARCHAR(MAX)
									
-- Verificando qual o quesito atual
IF(@id_quesito = 0)
BEGIN
	SET @tabela = 'comissao_de_frente'
END
ELSE IF(@id_quesito = 1)
BEGIN
	SET @tabela = 'evolucao'
END
ELSE IF(@id_quesito = 2)
BEGIN
	SET @tabela = 'fantasia'
END
ELSE IF(@id_quesito = 3)
BEGIN
	SET @tabela = 'bateria'
END
ELSE IF(@id_quesito = 4)
BEGIN
	SET @tabela = 'alegoria'
END
ELSE IF(@id_quesito = 5)
BEGIN
	SET @tabela = 'harmonia'
END
ELSE IF(@id_quesito = 6)
BEGIN
	SET @tabela = 'samba_enredo'
END
ELSE IF(@id_quesito = 7)
BEGIN
	SET @tabela = 'mestre_sala_e_porta_bandeira'
END
ELSE IF(@id_quesito = 8)
BEGIN
	SET @tabela = 'enredo'
END
ELSE
BEGIN
	RAISERROR('O ID do quesito informado não existe!', 16, 1)
END

/*
Verificando em que nota a apuração em um determinado quesito se encontra

OBS: o comando UPDATE não resulta em nada quando não há valores 
	 previamente inseridos na tabela
*/
IF(@contador_nota = 0)
BEGIN
	SET @query = 'INSERT INTO ' + @tabela + 
		'(id_escola, nota1) VALUES(''' + CAST(@id_escola AS VARCHAR(2)) + 
		''',''' + CAST(@nota AS VARCHAR(7)) + ''')'		
	/*SET @query = 'UPDATE ' + @tabela + 
		' SET nota1 = ''' + CAST(@nota AS VARCHAR(7)) + '''' +
        ' WHERE id_escola = ''' + CAST(@id_escola AS VARCHAR(2)) + ''''*/
END
ELSE IF(@contador_nota = 1)
BEGIN
	SET @query = 'UPDATE ' + @tabela + 
				 ' SET nota2 = ''' + CAST(@nota AS VARCHAR(7)) + '''' +
                 ' WHERE id_escola = ''' + CAST(@id_escola AS VARCHAR(2)) + ''''
END
ELSE IF(@contador_nota = 2)
BEGIN
	SET @query = 'UPDATE ' + @tabela + 
				 ' SET nota3 = ''' + CAST(@nota AS VARCHAR(7)) + '''' +
                 ' WHERE id_escola = ''' + CAST(@id_escola AS VARCHAR(2)) + ''''
END
ELSE IF(@contador_nota = 3)
BEGIN
	SET @query = 'UPDATE ' + @tabela + 
				 ' SET nota4 = ''' + CAST(@nota AS VARCHAR(7)) + '''' +
                 ' WHERE id_escola = ''' + CAST(@id_escola AS VARCHAR(2)) + ''''
END
ELSE IF(@contador_nota = 4)
BEGIN
	SET @query = 'UPDATE ' + @tabela + 
				 ' SET nota5 = ''' + CAST(@nota AS VARCHAR(7)) + '''' +
                 ' WHERE id_escola = ''' + CAST(@id_escola AS VARCHAR(2)) + ''''
END
ELSE 
BEGIN
	RAISERROR('Notas variam de nota1 à nota5 somente!', 17, 1)
END
EXEC(@query)

DROP PROCEDURE sp_deleta

CREATE PROCEDURE sp_deleta(@tabela INT)
AS 
DECLARE @contador AS INT, @query AS VARCHAR(MAX)
IF(@tabela = 1)
BEGIN
	SET @contador = (SELECT MAX(id_escola) FROM comissao_de_frente)
	SET @query = 'DELETE FROM comissao_de_frente ' +
			 'WHERE id_escola = ''' + CAST(@contador AS VARCHAR(2)) + '''' 
END
ELSE IF(@tabela = 2)
BEGIN
	SET @contador = (SELECT MAX(id_escola) FROM evolucao)
	SET @query = 'DELETE FROM evolucao ' +
			 'WHERE id_escola = ''' + CAST(@contador AS VARCHAR(2)) + '''' 
END
EXEC(@query)

EXEC sp_deleta 1
EXEC sp_deleta 2