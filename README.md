# Bando-de-Dados-II-Atividades

## Atividade 02:
Respondida no arquivo SQL: atividades02.sql

## Atividade 03:

<img width="226" height="138" alt="image" src="https://github.com/user-attachments/assets/7c0a00eb-e7aa-43d7-8a31-372a4fe478ca" />

### Pergunta 1 - Qual é o objetivo da tabela contas neste cenário prático?
O objetivo é simular um sistema simples de contas bancárias.

### Pergunta 2 - Quais são os saldos iniciais de cada titular antes da execução das transações?
Antes da execução de qualquer transação, os saldos iniciais são: Ana com 1000.00, Bruno com 500.00, Carlos com 300.00 e Daniela com 800.00.

<img width="212" height="137" alt="image" src="https://github.com/user-attachments/assets/85ca0d5e-d110-4067-b054-b21a03389c04" />

Pergunta 3
 O que aconteceu com os saldos após o COMMIT?
	R: Após o “commit”, o valor referente ao id=1 diminuiu em 100 e o id=2 aumentou em 100. Ou seja, o COMMIT efetivou a transferência de valor entre as contas, salvando as mudanças de forma definitiva.
Pergunta 4
 Por que as duas instruções UPDATE devem fazer parte da mesma transação?
	R: As duas instruções precisam estar na mesma transação para garantir a consistência dos dados. Nesse caso, elas representam uma única operação lógica: uma transferência de R$100 da conta da Ana para a do Bruno.
Se cada UPDATE fosse executado separadamente, poderia ocorrer um problema como:
O valor ser descontado da Ana (primeiro UPDATE executa com sucesso)
Mas não ser creditado ao Bruno (segundo UPDATE falha, por erro ou interrupção)
Isso causaria perda de dinheiro no sistema, deixando os dados inconsistentes.

<img width="222" height="135" alt="image" src="https://github.com/user-attachments/assets/1e9148d7-b3af-431d-a12e-3e36af38d147" />
Pergunta 5
 Por que os valores não foram alterados ao final?
R: Os valores não foram alterados porque foi executado o comando ROLLBACK.
O ROLLBACK desfaz todas as operações realizadas dentro da transação desde o START TRANSACTION.
	
Pergunta 6
 Em quais situações reais o uso de ROLLBACK seria essencial?
	R: O uso de rollback (em bancos de dados e sistemas transacionais) é essencial sempre que você precisa desfazer operações que não podem ser concluídas com segurança ou consistência. Ele garante que o sistema volte a um estado anterior válido.
	Situações:
Falha em transações financeiras
Compras online (o estoque é reduzido e o pagamento falha, tem que haver uma forma de restaurar o estoque automaticamente).

<img width="230" height="56" alt="image" src="https://github.com/user-attachments/assets/54b3b593-5392-4b49-8735-26f9a15f45a7" />
Pergunta 7
 Por que a transação foi desfeita neste caso?
	R: Devido ao uso do comando ROLLBACK, o comando de subtrair 2000 do saldo foi “desfeito”, mantendo o saldo com o valor armazenado antes da transação.
Pergunta 8
 Qual problema de integridade poderia ocorrer se essa transação fosse confirmada?
	R: Inconsistência dos dados e dos valores.
<img width="211" height="137" alt="image" src="https://github.com/user-attachments/assets/c74a1cab-cc27-427c-a5b8-1eabd1ba10c5" />
Pergunta 9
 Qual conta foi debitada e quais contas foram creditadas?
	R: As contas com id 1 e 2 foram creditadas e a conta com id 4 foi debitada. A conta pertencente ao id 3 também havia sido debitada antes da execução do comando ROLLBACK.
Pergunta 10
 Por que esse conjunto de operações também deve ser tratado como uma única transação?
	R: Para haver consistência de dados.
Antes rollback:
<img width="237" height="73" alt="image" src="https://github.com/user-attachments/assets/f7338a3f-1924-4171-adbe-48c478fa225a" />
Após rollback:
<img width="207" height="77" alt="image" src="https://github.com/user-attachments/assets/93687862-5f8b-4f6c-9720-e7230100b4c8" />
Pergunta 11
 Qual era o objetivo de observar o valor da conta em outra sessão antes do COMMIT?
	R: Verificar se outra sessão consegue ver alterações não confirmadas, demonstrando o nível de isolamento da transação.
Pergunta 12
 Como esse teste se relaciona com o conceito de isolamento?
	R: O isolamento garante que:
Operações dentro de uma transação não sejam visíveis para outras transações até que sejam confirmadas com COMMIT.
Cada transação “enxergue” um estado consistente do banco de dados.
Nesse contexto, o teste demonstra como o banco controla a visibilidade das alterações entre transações simultâneas, que é exatamente o papel do isolamento.


