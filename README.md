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
<img width="196" height="132" alt="image" src="https://github.com/user-attachments/assets/00b52662-cedf-4e5e-8fd5-2b16e6fb1226" />

Pergunta 13
 O que aconteceu com a segunda transação?
	R: Ela ficou bloqueada (em espera) até a primeira transação fazer o COMMIT. Depois disso, ela continuou e executou o UPDATE.
Pergunta 14
 Por que ela precisou esperar?
	R: A segunda transação precisou esperar porque a primeira já havia adquirido um bloqueio exclusivo (lock) sobre o registro com id = 1. Depois disso, ao fazer o UPDATE, o bloqueio continua ativo até o COMMIT ou ROLLBACK.  O banco percebe que aquela mesma linha já está bloqueada por outra transação em andamento. Para garantir consistência dos dados e evitar conflitos (como atualizações simultâneas inconsistentes), ele faz a segunda transação esperar até que o bloqueio seja liberado.

Pergunta 15
 Qual a função do FOR UPDATE?
	R: O FOR UPDATE, bloqueia as linhas selecionadas até que o COMMIT ou ROLLBACK sejam executados, a fim de manter a persistência dos dados. 

<img width="197" height="121" alt="image" src="https://github.com/user-attachments/assets/f516f811-ff81-4dfc-9daa-c543f3211cb8" />

Pergunta 16
 Por que nesse caso as transações tendem a não disputar o mesmo recurso?
	R:  A transação 1 bloqueia apenas a linha onde id = 1 e a transação 2 bloqueia apenas a linha onde id = 4. Como são registros distintos, não há conflito direto de locks, então as transações conseguem executar em paralelo sem disputar o mesmo recurso.
Pergunta 17
 O que esse teste mostra sobre concorrência em linhas diferentes da tabela?
	R: Apesar de serem linhas diferentes e que supostamente não têm interferência uma sobre a outra, ao rodar o código antes de dar o COMMIT, a outra tabela permanece bloqueada para visualização, contudo, após realizarmos o COMMIT da primeira tabela e tentarmos executar a segunda ela irá mostrar o resultado das duas execuções que testamos.

Pergunta 18
Qual é a importância de registrar movimentações além de atualizar os saldos?
	R: É importante para guardar o histórico de atualizações.


<img width="201" height="120" alt="image" src="https://github.com/user-attachments/assets/62c88f09-bef8-483f-a65f-5422ddbe30fb" />
<img width="501" height="72" alt="image" src="https://github.com/user-attachments/assets/20b1a673-772d-49f2-9138-11e10879be3b" />

Pergunta 19
 Por que o INSERT na tabela movimentacoes deve estar na mesma transação dos UPDATEs?
	R: Para garantir a consistência dos dados, é necessário ter os UPDATEs juntamente com o INSERT nas movimentações, para que ao realizar a transação, o programa saiba o valor real em cada conta, e verificar se a transação poderá ser feita. 
Pergunta 20
 O que poderia acontecer se o histórico fosse gravado, mas os saldos não fossem atualizados, ou vice-versa?
	R: Iria gerar inconsistência nos dados.
<img width="201" height="130" alt="image" src="https://github.com/user-attachments/assets/ccff436e-cd80-4556-9f4b-4aea9558c1fa" />
<img width="500" height="80" alt="image" src="https://github.com/user-attachments/assets/f45002fe-1851-4785-964a-071e943ef4c8" />

Pergunta 21
 O que o ROLLBACK garantiu nesse cenário?
	R: Após as alterações feitas e a implementação do ROLLBACK, a execução do código não mostrou nenhuma alteração, pois a ação foi desfeita. 
Pergunta 22
 Como esse teste demonstra a propriedade de atomicidade?
	R: Ela mostra que ou tudo acontece ou nada acontece. Então, após o rollback, nenhuma tabela mudou.
<img width="183" height="128" alt="image" src="https://github.com/user-attachments/assets/18ddf66f-1332-47fa-8364-392e72f8d75b" />
<img width="491" height="77" alt="image" src="https://github.com/user-attachments/assets/e6f1911f-13c2-418c-83df-efa227b2976f" />
Pergunta 23
 Como verificar se o banco permaneceu consistente após todas as operações realizadas?
	R: É necessário realizar várias operações, para garantir a consistência dos dados, você tem que ver ou se as operações foram realizadas (COMMIT) ou nada foi alterado (ROLLBACK).
Pergunta 24
 Por que a consistência do banco depende não apenas dos comandos SQL, mas também da forma como eles são agrupados em transações?
	R: Os dados raramente são alterados por uma única instrução. Em sistemas reais, uma operação lógica (como uma transferência bancária ou um pedido de compra) envolve várias etapas, por isso precisamos das transações.
Se você executa comandos SQL separadamente (fora de uma transação), pode acabar com estados intermediários inválidos. Sem transação, o banco fica inconsistente. Já ao agrupar esses comandos em uma transação, o sistema garante que todas as etapas sejam concluídas com sucesso , ou nenhuma delas seja aplicada. 

Pergunta 25
Explique o que é uma transação em banco de dados.
	R: Uma transação em banco de dados é um conjunto de operações realizadas como uma única unidade lógica de trabalho. Essas operações podem incluir comandos como inserir, atualizar, excluir ou consultar dados. 
Pergunta 26
Descreva a diferença entre COMMIT e ROLLBACK.
	R: O commit confirma as transações feitas na transação e o rollback desfaz essas alterações.
Pergunta 27
Explique por que uma transferência bancária deve ser tratada como transação.
	R: Uma transferência bancária deve ser tratada como uma transação porque envolve várias operações que precisam acontecer juntas para garantir a consistência dos dados. Ao transferir dinheiro, o sistema retira o valor de uma conta e adiciona em outra. Se ocorrer algum erro durante o processo, as alterações precisam ser desfeitas para evitar inconsistências, como o dinheiro sair de uma conta e não chegar à outra. Por isso, a transação garante que todas as operações sejam concluídas com sucesso ou que nenhuma delas seja aplicada.
Pergunta 28
O que pode acontecer se duas transações alterarem o mesmo dado ao mesmo tempo sem controle da concorrência?
R: Se duas transações alterarem o mesmo dado ao mesmo tempo sem controle de concorrência, podem ocorrer inconsistências e perda de informações no banco de dados. 
Pergunta 29
Qual a relação entre transações e as propriedades ACID?
R: A transação é uma unidade lógica dentro de um banco de dados. Possui 4 principais propriedades, sendo conhecidas como propriedades ACID: Atomicidade, Consistência, Isolamento, Durabilidade. 
A atomicidade é sobre a unidade atômica de processamento. Consistência diz respeito ao banco de dados permanecer consistente após uma transação ser executada. Isolamento trata as transações de forma que a mesma estivesse isolada das demais. Por fim, a durabilidade considera que todas as alterações feitas por uma transação devem ser persistidas no banco de dados.
Pergunta 30
Explique o significado da propriedade de atomicidade no contexto de uma operação bancária.
	R: A propriedade de atomicidade significa que uma transação deve ser executada completamente ou não ser executada. No contexto de uma operação bancária isso garante que o dinheiro só será transferido se todas as etapas ocorrerem corretamente. Se houver falha em qualquer parte do processo, todas as alterações realizadas são desfeitas, evitando inconsistências nos saldos das contas.
Pergunta 31
Explique o que significa dizer que uma transação preserva a consistência do banco de dados.
	R: Significa que após a realização de uma operação o banco continuará consistente, ou seja, não deve haver conflitos no banco nem informações incoerentes após uma transação, os dados devem respeitar as restrições do banco. 
Pergunta 32
Descreva o papel do isolamento em ambientes com múltiplos usuários acessando o mesmo banco.
	R: O isolamento garante que transações executadas ao mesmo tempo por múltiplos usuários não interfiram umas nas outras. Cada transação é tratada como se estivesse sendo executada sozinha.
Pergunta 33
Explique a importância da durabilidade após a execução de um COMMIT.
	R:  Após a execução de um COMMIT,a transação é executada. Sendo assim, a durabilidade garante que todas essas alterações que foram feitas conforme a transação foi realizada, irão persistir no banco de dados.
Pergunta 34
O que é controle de concorrência e por que ele é necessário?
	R: O controle de concorrência é um mecanismo que permite que várias transações aconteçam ao mesmo tempo sem causar erros ou inconsistências nos dados. Ele é necessário para garantir a integridade e a confiabilidade das informações.
Pergunta 35
Explique a função do lock em transações concorrentes.
	R: A função do lock nessas operações é controlar o acesso simultâneo das informações para não gerar inconsistências no banco de dados.
Pergunta 36
Descreva um exemplo prático em que o FOR UPDATE seja necessário.
	R: Um exemplo prático do uso de FOR UPDATE ocorre em uma transferência bancária. Quando o sistema consulta o saldo de uma conta para realizar a transferência, é importante bloquear aquele registro para que outra transação não altere o saldo ao mesmo tempo. Assim, o comando SELECT ... FOR UPDATE bloqueia temporariamente a linha selecionada até o fim da transação, evitando problemas como duas transferências utilizarem o mesmo saldo simultaneamente e causando inconsistências nos dados.
Pergunta 37
O que é uma atualização perdida (lost update)?
	R: Uma atualização perdida é um problema de concorrência que ocorre quando duas ou mais transações tentam alterar o mesmo dado em um banco de dados simultaneamente.
Pergunta 38
Explique por que nem toda leitura concorrente gera problema, mas algumas atualizações simultâneas sim.
	R: Pois quando executado a leitura eles não interferem nos valores dos dados, então realizar diversas leituras ao mesmo tempo não gera inconsistência. Já as atualizações podem gerar inconsistência, pois duas transações podem modificar o mesmo dado ao mesmo tempo. 
Pergunta 39
Qual é a importância de registrar operações em uma tabela de histórico dentro da mesma transação?
	R: É importante para garantir que os dados principais do histórico fiquem sempre sincronizados e consistentes, pois se uma operação é efetiva o histórico também é, caso contrário nenhum dos dois são salvos.
Pergunta 40
Em um sistema acadêmico, cite um exemplo de operação que deveria ser tratada como transação.
	R: Em um sistema acadêmico, a matrícula de um aluno em uma disciplina deve ser tratada como uma transação.
Pergunta 41
Em um sistema de estoque, cite um exemplo de falha que poderia justificar o uso de ROLLBACK.
	R: Uma falha que justificaria o uso do ROLLBACK seria um problema na hora de efetuar o pagamento. Como o pagamento falhou, a operação lógica de "venda" não pode ser concluída com sucesso. Para manter a consistência do banco de dados e evitar que o estoque fique incorreto, ou seja, reduzido mas sem a venda correspondente, o comando ROLLBACK é essencial. Ele desfaz a redução do estoque que já havia sido feita, restaurando o sistema ao estado anterior válido antes da tentativa de venda.
Pergunta 42
Como o processamento de transações contribui para a confiabilidade de sistemas de informação?
	R: O processamento de transações contribui para a confiabilidade dos sistemas de informação porque garante que as operações no banco de dados sejam executadas de forma segura, consistente e previsível. 
Pergunta 43
Considerando todos os experimentos realizados, explique de forma integrada como a atomicidade, consistência, isolamento e durabilidade atuam em conjunto no processamento de transações.
	R: As quatro propriedades ACID atuam em conjunto para garantir à segurança, confiabilidade e corretude, evitando falhas mesmo quando são realizadas diversas operações e se tem muitos usuários acessando o banco ao mesmo tempo.


