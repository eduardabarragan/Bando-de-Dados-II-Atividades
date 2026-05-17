-- 08. Atividade prática - Sistema bancário multiusuário precisa permitir operações simultâneas sem comprometer a integridade dos dados. Para isso, implemente testes em SQL que demonstrem:

-- 1. Bloqueio explícito de registros com FOR UPDATE
START TRANSACTION;
SELECT * FROM contas
WHERE id = 1
FOR UPDATE;
UPDATE contas
SET saldo = saldo - 100
WHERE id = 1;

-- 2. Espera de uma transação por outra
START TRANSACTION;
UPDATE contas
SET saldo = saldo + 50
WHERE id = 1;

-- 3. Diferença entre concorrência em registros iguais e em registros diferentes

-- 3.1 Em registros diferentes: Não há bloqueio entre elas. 
-- Sessão 1
UPDATE contas SET saldo = saldo - 50 WHERE id = 1;

-- Sessão 2
UPDATE contas SET saldo = saldo + 70 WHERE id = 4;

-- 3.2 Em registro iguais: 
-- Sessão 1:
START TRANSACTION;
SELECT saldo FROM contas WHERE id = 1;
UPDATE contas
SET saldo = saldo - 100
WHERE id = 1;

-- Mantém a transação aberta (sem COMMIT ainda)
-- Sessão 2:
START TRANSACTION;
SELECT saldo FROM contas WHERE id = 1;
UPDATE contas
SET saldo = saldo - 200
WHERE id = 1;
-- Fica bloqueada

-- Finalize:
-- Sessão 1
COMMIT;
-- Sessão 2
COMMIT;

-- 4. Risco de atualização perdida
-- Seção 1:
START TRANSACTION;
SELECT saldo FROM contas WHERE id = 1;
UPDATE contas
SET saldo = 900
WHERE id = 1;

-- Seção 2:
START TRANSACTION;
-- lê o MESMO valor antigo
SELECT saldo FROM contas WHERE id = 1;
-- sobrescreve sem saber da A
UPDATE contas
SET saldo = 800
WHERE id = 1;

-- 5. Análise da consistência final dos dados após execuções concorrentes
SELECT * FROM contas;
