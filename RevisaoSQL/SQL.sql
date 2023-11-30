CREATE DATABASE escola
GO 
USE escola

GO
CREATE TABLE aluno (
ra    int            NOT NULL,
nome  varchar(100)   NOT NULL,
idade int            NOT NULL
PRIMARY KEY (ra)
)

GO
CREATE TABLE disciplina (
codigo           int        NOT NULL,
nome           varchar(50)  NOT NULL,
carga_horaria    int        NOT NULL
PRIMARY KEY (codigo)
)

GO
CREATE TABLE professor (
registro        int        NOT NULL,
nome          varchar(40)  NOT NULL,
titulacao_codigo  int      NOT NULL
PRIMARY KEY (registro)
FOREIGN KEY (titulacao_codigo) REFERENCES titulacao (codigo)
)

GO
CREATE TABLE curso (
codigo       int         NOT NULL,
nome       varchar(40)   NOT NULL,
area       Varchar(40)   NOT NULL
PRIMARY KEY (codigo)
)

GO
CREATE TABLE titulacao (
codigo      int         NOT NULL,
titulo     varchar(20)  NOT NULL
PRIMARY KEY (codigo)
)

GO
CREATE TABLE aluno_disciplina (
disciplina_codigo    int     NOT NULL,
aluno_ra             int     NOT NULL
PRIMARY KEY (disciplina_codigo, aluno_ra),
FOREIGN KEY (disciplina_codigo)  REFERENCES  disciplina (codigo),
FOREIGN KEY (aluno_ra)  REFERENCES aluno (ra)
)

GO
CREATE TABLE professor_disciplina (
disciplina_codigo     int     NOT NULL,
professor_registro    int     NOT NULL
PRIMARY KEY (disciplina_codigo, professor_registro),
FOREIGN KEY (disciplina_codigo)  REFERENCES disciplina (codigo),
FOREIGN KEY (professor_registro)  REFERENCES professor (registro)
)

GO
CREATE TABLE disciplina_curso (
disciplina_codigo     int     NOT NULL,
curso_codigo          int     NOT NULL
PRIMARY KEY (disciplina_codigo, curso_codigo),
FOREIGN KEY (disciplina_codigo) REFERENCES disciplina (codigo),
FOREIGN KEY (curso_codigo) REFERENCES curso (codigo)
)


SELECT * FROM aluno
SELECT * FROM curso
SELECT * FROM professor
SELECT * FROM disciplina
SELECT * FROM aluno_disciplina
SELECT * FROM professor_disciplina
SELECT * FROM disciplina_curso


--1
SELECT al.ra, al.nome, dis.nome AS nome_disciplina
FROM aluno al, disciplina dis, aluno_disciplina ad
WHERE al.ra = ad.aluno_ra
AND ad.disciplina_codigo = dis.codigo

--2
SELECT dis.nome, pro.nome
FROM disciplina dis, professor pro, professor_disciplina pd
WHERE dis.codigo = pd.disciplina_codigo
AND pd.professor_registro = pro.registro

--3
SELECT dis.nome, cur.nome
FROM disciplina dis, curso cur, disciplina_curso dc
WHERE dis.codigo = dc.disciplina_codigo
AND dc.curso_codigo = cur.codigo

--4
SELECT dis.nome, cur.area
FROM disciplina dis, curso cur, disciplina_curso dc
WHERE dis.codigo = dc.disciplina_codigo
AND dc.curso_codigo = cur.codigo

--5
SELECT dis.nome, ti.titulo
FROM disciplina dis, professor pro, professor_disciplina pd, titulacao ti
WHERE dis.codigo = pd.disciplina_codigo
AND pd.professor_registro = pro.registro
AND pro.titulacao_codigo = ti.codigo

--6 
SELECT dis.nome AS Nome_Disciplina, COUNT(al.nome) AS Qntd_alunos
FROM disciplina dis, aluno al, aluno_disciplina ad
WHERE dis.codigo = ad.disciplina_codigo
AND ad.aluno_ra = al.ra
GROUP BY dis.nome

--7 FINALIZAR
SELECT dis.nome AS Disciplina, 
pro.nome AS Professor, COUNT(al.nome) AS Qntd_alunos
FROM disciplina dis, professor pro, aluno al, aluno_disciplina ad, professor_disciplina pd
WHERE al.ra = ad.aluno_ra
AND ad.disciplina_codigo = dis.codigo
AND dis.codigo = pd.disciplina_codigo
AND pd.professor_registro = pro.registro
GROUP BY dis.nome



--8 
SELECT cur.nome, COUNT(pro.nome) AS Qntd
FROM curso cur, professor pro, disciplina dis, professor_disciplina pd, disciplina_curso dc
WHERE cur.codigo = dc.curso_codigo
AND dc.disciplina_codigo = dis.codigo
AND dis.codigo = pd.disciplina_codigo
AND pd.professor_registro = pro.registro
GROUP BY cur.nome
