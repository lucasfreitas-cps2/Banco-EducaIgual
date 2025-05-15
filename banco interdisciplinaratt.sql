create database BDEduca;
use BDEduca;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(65) NOT NULL,
    email VARCHAR(255) unique
);

CREATE TABLE instituicoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco varchar(300)
);
CREATE TABLE cursos (
id INT auto_increment PRIMARY KEY,
nome varchar(100) not null,
instituicao_id INT NOT NULL,
FOREIGN KEY (instituicao_id) references instituicoes(id)
);
CREATE TABLE avalia_curso(
 id INT AUTO_INCREMENT PRIMARY KEY,
 usuario_id INT NOT NULL,
 curso_id INT NOT NULL,
 nota INT CHECK (nota BETWEEN 1 AND 5),
 comentario TEXT,
 data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
 FOREIGN KEY (curso_id) REFERENCES cursos(id)
);
CREATE TABLE avalia_instituicao(
id INT AUTO_INCREMENT PRIMARY KEY,
usuario_id INT NOT NULL,
instituicao_id INT NOT NULL,
nota INT CHECK (nota BETWEEN 1 AND 5),
comentario TEXT,
 data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
 FOREIGN KEY (instituicao_id) REFERENCES instituicoes(id)
);
-- PARA FAZER O RANKING DE MELHOR/PIOR AVALIADO --
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



-- MODIFICAÇÕES -- 
ALTER TABLE usuarios MODIFY COLUMN facebook_id VARCHAR(50);
ALTER TABLE instituicoes MODIFY COLUMN nome VARCHAR(255) NOT NULL UNIQUE;
ALTER TABLE usuarios drop column facebook_id;
ALTER TABLE usuarios drop column google_id;
select * from usuarios;
alter table usuarios add column senha varchar(8) not null unique;
alter table usuarios modify column senha varchar(255) not null;
drop table avaliacoes;
DROP VIEW IF EXISTS ranking_instituicoes;


