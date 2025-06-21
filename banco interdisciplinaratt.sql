CREATE DATABASE BDEduca;
USE BDEduca;

CREATE TABLE tipo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(40)
);

CREATE TABLE selos (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
);
CREATE TABLE usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (70) NOT NULL,
email VARCHAR (255) NOT NULL UNIQUE,
senha VARCHAR (260) NOT NULL,
tipo_id INT,
FOREIGN KEY (tipo_id) REFERENCES tipo(id)
);
CREATE TABLE instituicoes(
   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    rua VARCHAR(300),
    bairro VARCHAR(300),
    numero CHAR(4)
);
CREATE TABLE instituicao_selos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    instituicao_id INT NOT NULL,
    selo_id INT NOT NULL,
    FOREIGN KEY (instituicao_id) REFERENCES instituicoes(id),
    FOREIGN KEY (selo_id) REFERENCES selos(id),
    UNIQUE (instituicao_id, selo_id)
);

CREATE TABLE avalia_instituicao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    instituicao_id INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (instituicao_id) REFERENCES instituicoes(id),
    UNIQUE (usuario_id, instituicao_id)
);

CREATE VIEW ranking_instituicoes AS
SELECT 
    i.id AS instituicao_id,
    i.nome AS nome_instituicao,
    AVG(a.nota) AS media_avaliacoes,
    COUNT(a.id) AS total_avaliacoes
FROM 
    instituicoes i
INNER JOIN 
    avalia_instituicao a ON i.id = a.instituicao_id
GROUP BY 
    i.id, i.nome
ORDER BY 
    media_avaliacoes DESC, total_avaliacoes DESC;

