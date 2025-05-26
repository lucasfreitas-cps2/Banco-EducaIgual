CREATE DATABASE BDEduca;
USE BDEduca;

CREATE TABLE funcao (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    funcao VARCHAR(40)
);

CREATE TABLE usuarios (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(65) NOT NULL,
    email VARCHAR(255) UNIQUE,
    senha VARCHAR(255),
    funcao_id INT,
    FOREIGN KEY (funcao_id) REFERENCES funcao(id)
);

CREATE TABLE instituicoes (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(300)
);

CREATE TABLE selos (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
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
