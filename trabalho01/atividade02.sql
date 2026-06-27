-- 1. Liste todos os alunos cadastrados.
select * from aluno 

-- 2. Mostre apenas o nome e o curso dos alunos.
select nome, curso from aluno 
  
-- 3. Liste os alunos do curso de Computacao.
select nome from aluno WHERE curso = 'Computacao'
  
-- 4. Liste os alunos que moram em Maringa.
select nome from aluno WHERE cidade = 'Maringa'
  
-- 5. Mostre os alunos ordenados pelo nome em ordem alfabética.
select nome from aluno ORDER BY NOME
  
-- 6. Mostre os alunos ordenados pelo ano de ingresso, do mais antigo para o mais recente.
select nome from aluno ORDER BY ano_ingresso 
  
-- 7. Liste os alunos que ingressaram a partir de 2022.
select nome, ano_ingresso from aluno WHERE ano_ingresso >= 2022
  
-- 8. Liste os alunos cujo nome começa com a letra A.
select nome from aluno WHERE nome LIKE 'A%'
  
-- 9. Liste os alunos dos cursos Computacao ou Engenharia.
select nome from aluno WHERE curso = 'Computacao' OR curso = 'Engenharia'
  
-- 10. Liste as disciplinas com carga horária entre 60 e 80 horas.
select nome from disciplina WHERE carga_horaria > 60 AND carga_horaria < 80
  
-- 11. Conte quantos alunos existem cadastrados.
select COUNT(id) from aluno
  
-- 12. Calcule a média das notas da tabela matricula.
select AVG(NOTA) from matricula
  
-- 13. Mostre a maior nota registrada.
select max(NOTA) from matricula
  
-- 14. Mostre a menor nota registrada.
select min(NOTA) from matricula
  
-- 15. Calcule a soma das cargas horárias de todas as disciplinas.
select SUM(carga_horaria) from disciplina
  
-- 16. Mostre a quantidade de alunos por curso.
select CURSO, COUNT(id) from aluno GROUP BY CURSO
  
-- 17. Mostre a quantidade de alunos por cidade.
select cidade, COUNT(id) from aluno GROUP BY cidade
  
-- 18. Mostre a média das notas por situação da matrícula.
select situacao, avg(nota) AS media_notas from MATRICULA GROUP BY situacao
  
-- 19. Mostre quantas matrículas existem por semestre.
select semestre, COUNT(ID) AS quantidade_alunos from MATRICULA GROUP BY semestre

-- 20. Mostre os cursos que possuem mais de 1 aluno cadastrado.
select curso from aluno GROUP BY CURSO HAVING COUNT(id) > 1;

-- 21. Liste o nome dos alunos e a situação de suas matrículas.
SELECT nome, situacao 
FROM aluno JOIN matricula 
ON  aluno.id = matricula.aluno_id;

-- 22.Liste o nome dos alunos e o nome das disciplinas em que estão matriculados.
SELECT a.nome, d.nome
FROM matricula m
JOIN aluno a
    ON m.aluno_id = a.id
JOIN disciplina d
    ON m.disciplina_id = d.id;


-- 23.Liste o nome do aluno, o nome da disciplina e a nota.
SELECT a.nome AS aluno,
       d.nome AS disciplina,
       m.nota
FROM matricula m
JOIN aluno a
    ON m.aluno_id = a.id
JOIN disciplina d
    ON m.disciplina_id = d.id;

-- 24. Liste apenas os alunos matriculados em disciplinas do departamento Computacao.
SELECT a.nome AS aluno,
       d.nome AS disciplina
FROM disciplina d
JOIN matricula m
    ON d.id = m.disciplina_id
JOIN aluno a
    ON a.id = m.aluno_id
WHERE d.departamento = 'Computacao';

-- 25. Mostre o nome dos alunos que tiveram matrícula com situação Reprovado.
SELECT a.nome
FROM matricula m
JOIN aluno a 
  ON m.aluno_id = a.id
WHERE m.situacao = 'Reprovado';

-- 26. Mostre o nome dos alunos de Computacao e as disciplinas que eles cursaram.
SELECT a.nome AS aluno,
       d.nome AS disciplina
FROM aluno a
JOIN matricula m
    ON a.id = m.aluno_id
JOIN disciplina d
    ON d.id = m.disciplina_id
WHERE a.curso = 'Computacao';

-- 27. Mostre a média de notas por aluno.
SELECT a.nome AS aluno,
       AVG(m.nota) AS media_notas
FROM matricula m
JOIN aluno a
    ON a.id = m.aluno_id
GROUP BY a.id, a.nome;

-- 28. Mostre a quantidade de disciplinas cursadas por cada aluno.
SELECT a.nome AS aluno,
      COUNT(m.disciplina_id) AS qtd_disciplinas
FROM matricula m
JOIN aluno a
    ON a.id = m.aluno_id
GROUP BY a.id, a.nome;

-- 29. Liste os alunos cuja média de notas foi maior que 8.
SELECT a.nome
FROM (
    SELECT aluno_id
    FROM matricula
    GROUP BY aluno_id
    HAVING AVG(nota) > 8
) m
JOIN aluno a
ON a.id = m.aluno_id;

-- 30. Mostre o departamento e a quantidade de matrículas em disciplinas de cada departamento.
SELECT d.departamento,
       COUNT(*) AS qtd_matriculas
FROM disciplina d
JOIN matricula m
    ON m.disciplina_id = d.id
GROUP BY d.departamento;
