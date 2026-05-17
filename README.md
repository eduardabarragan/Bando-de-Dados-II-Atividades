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

### Pergunta 3 - O que aconteceu com os saldos após o COMMIT?
Após o “commit”, o valor referente ao id=1 diminuiu em 100 e o id=2 aumentou em 100. Ou seja, o COMMIT efetivou a transferência de valor entre as contas, salvando as mudanças de forma definitiva.

### Pergunta 4 - Por que as duas instruções UPDATE devem fazer parte da mesma transação?
As duas instruções precisam estar na mesma transação para garantir a consistência dos dados. Nesse caso, elas representam uma única operação lógica: uma transferência de R$100 da conta da Ana para a do Bruno. Se cada UPDATE fosse executado separadamente, poderia ocorrer um problema como: o valor ser descontado da Ana (primeiro UPDATE executa com sucesso) mas não ser creditado ao Bruno (segundo UPDATE falha, por erro ou interrupção). Isso causaria perda de dinheiro no sistema, deixando os dados inconsistentes.

<img width="222" height="135" alt="image" src="https://github.com/user-attachments/assets/1e9148d7-b3af-431d-a12e-3e36af38d147" />

### Pergunta 5 - Por que os valores não foram alterados ao final?
Os valores não foram alterados porque foi executado o comando ROLLBACK. O ROLLBACK desfaz todas as operações realizadas dentro da transação desde o START TRANSACTION.
	
### Pergunta 6 - Em quais situações reais o uso de ROLLBACK seria essencial?
O uso de rollback (em bancos de dados e sistemas transacionais) é essencial sempre que você precisa desfazer operações que não podem ser concluídas com segurança ou consistência. Ele garante que o sistema volte a um estado anterior válido. Situações: falha em transações financeiras ou compras online (o estoque é reduzido e o pagamento falha, tem que haver uma forma de restaurar o estoque automaticamente).

<img width="230" height="56" alt="image" src="https://github.com/user-attachments/assets/54b3b593-5392-4b49-8735-26f9a15f45a7" />

### Pergunta 7 - Por que a transação foi desfeita neste caso?
Devido ao uso do comando ROLLBACK, o comando de subtrair 2000 do saldo foi “desfeito”, mantendo o saldo com o valor armazenado antes da transação.

### Pergunta 8 - Qual problema de integridade poderia ocorrer se essa transação fosse confirmada?
Inconsistência dos dados e dos valores.

<img width="211" height="137" alt="image" src="https://github.com/user-attachments/assets/c74a1cab-cc27-427c-a5b8-1eabd1ba10c5" />

### Pergunta 9 - Qual conta foi debitada e quais contas foram creditadas?
As contas com id 1 e 2 foram creditadas e a conta com id 4 foi debitada. A conta pertencente ao id 3 também havia sido debitada antes da execução do comando ROLLBACK.

### Pergunta 10 - Por que esse conjunto de operações também deve ser tratado como uma única transação?
Para haver consistência de dados.

Antes rollback:

<img width="237" height="73" alt="image" src="https://github.com/user-attachments/assets/f7338a3f-1924-4171-adbe-48c478fa225a" />

Após rollback:

<img width="207" height="77" alt="image" src="https://github.com/user-attachments/assets/93687862-5f8b-4f6c-9720-e7230100b4c8" />

### Pergunta 11 - Qual era o objetivo de observar o valor da conta em outra sessão antes do COMMIT?
Verificar se outra sessão consegue ver alterações não confirmadas, demonstrando o nível de isolamento da transação.

### Pergunta 12 - Como esse teste se relaciona com o conceito de isolamento?
O isolamento garante que: operações dentro de uma transação não sejam visíveis para outras transações até que sejam confirmadas com COMMIT, cada transação “enxergue” um estado consistente do banco de dados. Nesse contexto, o teste demonstra como o banco controla a visibilidade das alterações entre transações simultâneas, que é exatamente o papel do isolamento.

<img width="196" height="132" alt="image" src="https://github.com/user-attachments/assets/00b52662-cedf-4e5e-8fd5-2b16e6fb1226" />

### Pergunta 13 - O que aconteceu com a segunda transação?
Ela ficou bloqueada (em espera) até a primeira transação fazer o COMMIT. Depois disso, ela continuou e executou o UPDATE.

### Pergunta 14 - Por que ela precisou esperar?
A segunda transação precisou esperar porque a primeira já havia adquirido um bloqueio exclusivo (lock) sobre o registro com id = 1. Depois disso, ao fazer o UPDATE, o bloqueio continua ativo até o COMMIT ou ROLLBACK.  O banco percebe que aquela mesma linha já está bloqueada por outra transação em andamento. Para garantir consistência dos dados e evitar conflitos (como atualizações simultâneas inconsistentes), ele faz a segunda transação esperar até que o bloqueio seja liberado.

### Pergunta 15 - Qual a função do FOR UPDATE?
O FOR UPDATE, bloqueia as linhas selecionadas até que o COMMIT ou ROLLBACK sejam executados, a fim de manter a persistência dos dados. 

<img width="197" height="121" alt="image" src="https://github.com/user-attachments/assets/f516f811-ff81-4dfc-9daa-c543f3211cb8" />

### Pergunta 16 - Por que nesse caso as transações tendem a não disputar o mesmo recurso?
A transação 1 bloqueia apenas a linha onde id = 1 e a transação 2 bloqueia apenas a linha onde id = 4. Como são registros distintos, não há conflito direto de locks, então as transações conseguem executar em paralelo sem disputar o mesmo recurso.

### Pergunta 17 - O que esse teste mostra sobre concorrência em linhas diferentes da tabela?
Apesar de serem linhas diferentes e que supostamente não têm interferência uma sobre a outra, ao rodar o código antes de dar o COMMIT, a outra tabela permanece bloqueada para visualização, contudo, após realizarmos o COMMIT da primeira tabela e tentarmos executar a segunda ela irá mostrar o resultado das duas execuções que testamos.

### Pergunta 18 - Qual é a importância de registrar movimentações além de atualizar os saldos?
É importante para guardar o histórico de atualizações.

<img width="201" height="120" alt="image" src="https://github.com/user-attachments/assets/62c88f09-bef8-483f-a65f-5422ddbe30fb" />
<img width="501" height="72" alt="image" src="https://github.com/user-attachments/assets/20b1a673-772d-49f2-9138-11e10879be3b" />

### Pergunta 19 - Por que o INSERT na tabela movimentacoes deve estar na mesma transação dos UPDATEs?
Para garantir a consistência dos dados, é necessário ter os UPDATEs juntamente com o INSERT nas movimentações, para que ao realizar a transação, o programa saiba o valor real em cada conta, e verificar se a transação poderá ser feita. 

### Pergunta 20 - O que poderia acontecer se o histórico fosse gravado, mas os saldos não fossem atualizados, ou vice-versa?
Iria gerar inconsistência nos dados.

<img width="201" height="130" alt="image" src="https://github.com/user-attachments/assets/ccff436e-cd80-4556-9f4b-4aea9558c1fa" />
<img width="500" height="80" alt="image" src="https://github.com/user-attachments/assets/f45002fe-1851-4785-964a-071e943ef4c8" />

### Pergunta 21 - O que o ROLLBACK garantiu nesse cenário?
Após as alterações feitas e a implementação do ROLLBACK, a execução do código não mostrou nenhuma alteração, pois a ação foi desfeita. 

### Pergunta 22 - Como esse teste demonstra a propriedade de atomicidade?
Ela mostra que ou tudo acontece ou nada acontece. Então, após o rollback, nenhuma tabela mudou.

<img width="183" height="128" alt="image" src="https://github.com/user-attachments/assets/18ddf66f-1332-47fa-8364-392e72f8d75b" />
<img width="491" height="77" alt="image" src="https://github.com/user-attachments/assets/e6f1911f-13c2-418c-83df-efa227b2976f" />

### Pergunta 23 - Como verificar se o banco permaneceu consistente após todas as operações realizadas?
É necessário realizar várias operações, para garantir a consistência dos dados, você tem que ver ou se as operações foram realizadas (COMMIT) ou nada foi alterado (ROLLBACK).

### Pergunta 24 - Por que a consistência do banco depende não apenas dos comandos SQL, mas também da forma como eles são agrupados em transações?
Os dados raramente são alterados por uma única instrução. Em sistemas reais, uma operação lógica (como uma transferência bancária ou um pedido de compra) envolve várias etapas, por isso precisamos das transações. Se você executa comandos SQL separadamente (fora de uma transação), pode acabar com estados intermediários inválidos. Sem transação, o banco fica inconsistente. Já ao agrupar esses comandos em uma transação, o sistema garante que todas as etapas sejam concluídas com sucesso , ou nenhuma delas seja aplicada. 

### Pergunta 25 - Explique o que é uma transação em banco de dados.
Uma transação em banco de dados é um conjunto de operações realizadas como uma única unidade lógica de trabalho. Essas operações podem incluir comandos como inserir, atualizar, excluir ou consultar dados. 

### Pergunta 26 - Descreva a diferença entre COMMIT e ROLLBACK.
O commit confirma as transações feitas na transação e o rollback desfaz essas alterações.

### Pergunta 27 - Explique por que uma transferência bancária deve ser tratada como transação.
Uma transferência bancária deve ser tratada como uma transação porque envolve várias operações que precisam acontecer juntas para garantir a consistência dos dados. Ao transferir dinheiro, o sistema retira o valor de uma conta e adiciona em outra. Se ocorrer algum erro durante o processo, as alterações precisam ser desfeitas para evitar inconsistências, como o dinheiro sair de uma conta e não chegar à outra. Por isso, a transação garante que todas as operações sejam concluídas com sucesso ou que nenhuma delas seja aplicada.

### Pergunta 28 - O que pode acontecer se duas transações alterarem o mesmo dado ao mesmo tempo sem controle da concorrência?
Se duas transações alterarem o mesmo dado ao mesmo tempo sem controle de concorrência, podem ocorrer inconsistências e perda de informações no banco de dados. 

### Pergunta 29 - Qual a relação entre transações e as propriedades ACID?
A transação é uma unidade lógica dentro de um banco de dados. Possui 4 principais propriedades, sendo conhecidas como propriedades ACID: Atomicidade, Consistência, Isolamento, Durabilidade. A atomicidade é sobre a unidade atômica de processamento. Consistência diz respeito ao banco de dados permanecer consistente após uma transação ser executada. Isolamento trata as transações de forma que a mesma estivesse isolada das demais. Por fim, a durabilidade considera que todas as alterações feitas por uma transação devem ser persistidas no banco de dados.

### Pergunta 30 - Explique o significado da propriedade de atomicidade no contexto de uma operação bancária.
A propriedade de atomicidade significa que uma transação deve ser executada completamente ou não ser executada. No contexto de uma operação bancária isso garante que o dinheiro só será transferido se todas as etapas ocorrerem corretamente. Se houver falha em qualquer parte do processo, todas as alterações realizadas são desfeitas, evitando inconsistências nos saldos das contas.

### Pergunta 31 - Explique o que significa dizer que uma transação preserva a consistência do banco de dados.
Significa que após a realização de uma operação o banco continuará consistente, ou seja, não deve haver conflitos no banco nem informações incoerentes após uma transação, os dados devem respeitar as restrições do banco. 

### Pergunta 32 - Descreva o papel do isolamento em ambientes com múltiplos usuários acessando o mesmo banco.
O isolamento garante que transações executadas ao mesmo tempo por múltiplos usuários não interfiram umas nas outras. Cada transação é tratada como se estivesse sendo executada sozinha.

### Pergunta 33 - Explique a importância da durabilidade após a execução de um COMMIT.
Após a execução de um COMMIT,a transação é executada. Sendo assim, a durabilidade garante que todas essas alterações que foram feitas conforme a transação foi realizada, irão persistir no banco de dados.

### Pergunta 34 - O que é controle de concorrência e por que ele é necessário?
O controle de concorrência é um mecanismo que permite que várias transações aconteçam ao mesmo tempo sem causar erros ou inconsistências nos dados. Ele é necessário para garantir a integridade e a confiabilidade das informações.

### Pergunta 35 - Explique a função do lock em transações concorrentes.
A função do lock nessas operações é controlar o acesso simultâneo das informações para não gerar inconsistências no banco de dados.

### Pergunta 36 - Descreva um exemplo prático em que o FOR UPDATE seja necessário.
Um exemplo prático do uso de FOR UPDATE ocorre em uma transferência bancária. Quando o sistema consulta o saldo de uma conta para realizar a transferência, é importante bloquear aquele registro para que outra transação não altere o saldo ao mesmo tempo. Assim, o comando SELECT ... FOR UPDATE bloqueia temporariamente a linha selecionada até o fim da transação, evitando problemas como duas transferências utilizarem o mesmo saldo simultaneamente e causando inconsistências nos dados.

### Pergunta 37 - O que é uma atualização perdida (lost update)?
Uma atualização perdida é um problema de concorrência que ocorre quando duas ou mais transações tentam alterar o mesmo dado em um banco de dados simultaneamente.

### Pergunta 38 - Explique por que nem toda leitura concorrente gera problema, mas algumas atualizações simultâneas sim.
Pois quando executado a leitura eles não interferem nos valores dos dados, então realizar diversas leituras ao mesmo tempo não gera inconsistência. Já as atualizações podem gerar inconsistência, pois duas transações podem modificar o mesmo dado ao mesmo tempo. 

### Pergunta 39 - Qual é a importância de registrar operações em uma tabela de histórico dentro da mesma transação?
É importante para garantir que os dados principais do histórico fiquem sempre sincronizados e consistentes, pois se uma operação é efetiva o histórico também é, caso contrário nenhum dos dois são salvos.

### Pergunta 40 - Em um sistema acadêmico, cite um exemplo de operação que deveria ser tratada como transação.
Em um sistema acadêmico, a matrícula de um aluno em uma disciplina deve ser tratada como uma transação.

### Pergunta 41 - Em um sistema de estoque, cite um exemplo de falha que poderia justificar o uso de ROLLBACK.
Uma falha que justificaria o uso do ROLLBACK seria um problema na hora de efetuar o pagamento. Como o pagamento falhou, a operação lógica de "venda" não pode ser concluída com sucesso. Para manter a consistência do banco de dados e evitar que o estoque fique incorreto, ou seja, reduzido mas sem a venda correspondente, o comando ROLLBACK é essencial. Ele desfaz a redução do estoque que já havia sido feita, restaurando o sistema ao estado anterior válido antes da tentativa de venda.

### Pergunta 42 - Como o processamento de transações contribui para a confiabilidade de sistemas de informação?
O processamento de transações contribui para a confiabilidade dos sistemas de informação porque garante que as operações no banco de dados sejam executadas de forma segura, consistente e previsível. 

### Pergunta 43 - Considerando todos os experimentos realizados, explique de forma integrada como a atomicidade, consistência, isolamento e durabilidade atuam em conjunto no processamento de transações.
As quatro propriedades ACID atuam em conjunto para garantir à segurança, confiabilidade e corretude, evitando falhas mesmo quando são realizadas diversas operações e se tem muitos usuários acessando o banco ao mesmo tempo.

### Pergunta 44 - Adapte o exemplo bancário para um sistema de matrícula em disciplinas, em que uma transação deva: verificar vaga disponível, reduzir a quantidade de vagas, registrar a matrícula do aluno. Explique por que essas operações devem ocorrer na mesma transação.
Essas operações devem ser realizadas na mesma transação para garantir a consistência do sistema. Assim, a matrícula só será efetuada se tiverem vagas disponíveis, a quantidade de vagas for calculada corretamente e o registro do aluno for efetuado corretamente.

### Pergunta 45 - Adapte o exemplo para um sistema de estoque e vendas, explicando quais operações devem ser agrupadas para evitar inconsistências
Em um sistema de estoque e vendas, uma transação poderia funcionar da seguinte forma: primeiro o sistema verifica se o produto possui quantidade disponível em estoque, depois reduz a quantidade do produto vendido e por fim registra a venda no histórico do sistema. Essas operações devem ocorrer na mesma transação para garantir a consistência dos dados, evitando situações em que a venda seja registrada sem atualizar o estoque ou o estoque seja alterado sem que a venda seja registrada corretamente.


## Atividade 04:

<img width="202" height="137" alt="image" src="https://github.com/user-attachments/assets/62333d38-18c0-4f1f-948e-f48f1f557f71" />

### Pergunta 1 - Qual é a finalidade de manter dados iniciais conhecidos antes dos testes de concorrência?
A finalidade de manter dados iniciais conhecidos antes dos testes de concorrência é permitir que os resultados das transações possam ser analisados corretamente. Assim, é possível comparar os valores antes e depois das operações e verificar se o comportamento do banco ocorreu como esperado. 

### Pergunta 2 - Por que é importante que a tabela esteja em um estado consistente antes do início dos experimentos?
É importante que a tabela esteja em um estado consistente antes do início dos experimentos para garantir que os testes sejam confiáveis e não sofram influência de erros ou alterações anteriores. Dessa forma, os resultados obtidos refletem apenas o efeito das transações executadas durante os testes. 

<img width="207" height="137" alt="image" src="https://github.com/user-attachments/assets/231d1833-f356-4547-93a2-687886cc6f6a" />

### Pergunta 3 - O que aconteceu com a operação realizada na Sessão 2?
A operação realizada na Sessão 2 ficou bloqueada temporariamente enquanto a Sessão 1 ainda estava utilizando o registro da conta de id 1. Após o COMMIT da primeira sessão, a segunda transação pôde continuar sua execução normalmente. 

### Pergunta 4 - Por que a segunda sessão precisou aguardar?
A segunda sessão precisou aguardar porque a primeira transação havia bloqueado o registro da conta utilizando FOR UPDATE. Isso impede que duas transações alterem o mesmo dado ao mesmo tempo, evitando inconsistências no banco.

### Pergunta 5 - Qual é a função do comando FOR UPDATE nesse experimento?
O comando FOR UPDATE tem a função de bloquear as linhas selecionadas durante a transação, impedindo alterações por outras sessões até que a transação atual seja finalizada com COMMIT ou ROLLBACK. Isso garante maior controle e segurança nas operações concorrentes.

<img width="215" height="133" alt="image" src="https://github.com/user-attachments/assets/af88c2ca-a28b-4e40-886b-eb3b7b5062b7" />

### Pergunta 6 - Por que, nesse caso, as duas transações tendem a coexistir sem espera significativa?
Nesse caso, as duas transações tendem a coexistir sem espera significativa porque cada uma está alterando um registro diferente da tabela. Como não há acesso concorrente à mesma linha, o banco consegue executar as operações simultaneamente sem gerar bloqueios entre as sessões.

### Pergunta 7 - O que esse comportamento revela sobre bloqueios em nível de linha?
Esse comportamento revela que os bloqueios ocorrem em nível de linha, ou seja, apenas os registros modificados ficam bloqueados. Assim, outras transações podem acessar e alterar linhas diferentes da mesma tabela ao mesmo tempo sem causar conflitos.

<img width="212" height="133" alt="image" src="https://github.com/user-attachments/assets/31d448cb-25f2-4bcc-9048-5a814d4fbaf3" />

### Pergunta 8 - Qual era o objetivo de consultar o mesmo registro em outra sessão antes do COMMIT?
O objetivo de consultar o mesmo registro em outra sessão antes do COMMIT era verificar se uma transação não finalizada teria suas alterações visíveis para outras sessões do banco de dados.

### Pergunta 9 - Como esse experimento se relaciona com o conceito de isolamento?
Esse experimento se relaciona com o conceito de isolamento porque mostra que alterações feitas dentro de uma transação ainda não confirmada não devem ficar visíveis para outras sessões. Isso garante que cada transação seja executada de forma independente, evitando inconsistências nos dados.

<img width="211" height="58" alt="image" src="https://github.com/user-attachments/assets/42e5751d-0afa-4c7a-8166-90ab28101e4a" />

### Pergunta 10 - O valor lido na Sessão 1 permaneceu o mesmo ou mudou?
O valor lido na Sessão 1 pode permanecer o mesmo ou mudar, dependendo do nível de isolamento utilizado pelo banco de dados. Em muitos casos, a segunda leitura já mostrará o valor atualizado após o COMMIT da Sessão 2.

### Pergunta 11 - Que tipo de fenômeno esse teste procura identificar?
Esse teste procura identificar o fenômeno chamado de leitura não repetível (non-repeatable read), que ocorre quando uma mesma consulta retorna resultados diferentes dentro da mesma transação porque outra transação modificou e confirmou os dados nesse intervalo.

<img width="183" height="60" alt="image" src="https://github.com/user-attachments/assets/6579b3a2-e1d6-473d-831e-f6229f15998b" />

### Pergunta 12 - Por que operações concorrentes sobre o mesmo registro exigem maior controle?
Operações concorrentes sobre o mesmo registro exigem maior controle porque podem acessar e modificar o mesmo dado ao mesmo tempo, causando conflitos de leitura e escrita. Sem controle adequado, uma transação pode sobrescrever a outra ou trabalhar com valores desatualizados, comprometendo a consistência do banco de dados.

### Pergunta 13 - Que inconsistência pode surgir quando duas transações tentam atualizar o mesmo dado quase ao mesmo tempo?
A principal inconsistência que pode surgir é a perda de atualização (lost update), onde uma transação sobrescreve a alteração feita por outra. Isso pode fazer com que uma das reduções de saldo não seja considerada corretamente, resultando em um valor final incorreto e inconsistente no banco.

<img width="216" height="120" alt="image" src="https://github.com/user-attachments/assets/619e2bb5-9097-4ca6-a425-e5296749a257" />

### Pergunta 14 - Qual evidência mostra que havia um bloqueio ativo sobre o registro?
A evidência de que havia um bloqueio ativo sobre o registro é que a Sessão 2 ficou aguardando a execução do UPDATE, sem conseguir concluir a operação. Isso ocorre porque o SELECT com o  FOR UPDATE na Sessão 1 bloqueou a linha da conta de id 2, impedindo que outra transação a modificasse até o término da primeira.

### Pergunta 15 - Por que a liberação do lock depende do fim da transação?
A liberação do lock depende do fim da transação porque o banco de dados precisa garantir a integridade e a consistência dos dados. Enquanto a transação não é finalizada com COMMIT ou ROLLBACK, o sistema mantém o bloqueio para evitar que outras transações alterem ou leiam dados intermediários que ainda não foram confirmados.

<img width="205" height="132" alt="image" src="https://github.com/user-attachments/assets/42987cd5-8877-4a11-ae31-502086ea9a02" />

### Pergunta 16 - Por que a segunda leitura com FOR UPDATE não pôde prosseguir imediatamente?
A segunda leitura com FOR UPDATE não pôde prosseguir imediatamente porque a primeira sessão já havia bloqueado o registro da conta de id 1. Como esse comando coloca um bloqueio na linha selecionada, a Sessão 2 precisa esperar a liberação desse lock antes de continuar, o que só acontece após o COMMIT da Sessão 1.

### Pergunta 17 - Em que essa situação difere de uma consulta SELECT comum?
Essa situação difere de uma consulta SELECT comum porque o SELECT normal apenas lê os dados sem bloquear o registro, permitindo que outras sessões também leiam ou até atualizem o mesmo dado simultaneamente. Já o SELECT com o FOR UPDATE bloqueia a linha, impedindo alterações concorrentes até o fim da transação, garantindo controle sobre atualizações simultâneas.

### Pergunta 18 - Qual seria o saldo correto ao final, caso ambas as operações fossem consideradas corretamente?
O saldo correto ao final deveria ser 700, pois as duas operações devem ser aplicadas sobre o mesmo valor inicial de 1000: 1000 - 100 - 200 = 700.

### Pergunta 19 - Por que o resultado 800 caracteriza uma atualização perdida?
O resultado 800 caracteriza uma atualização perdida porque uma das transações sobrescreveu a outra sem considerar sua alteração. A Transação B leu o valor inicial (1000) e gravou 800, ignorando a redução feita pela Transação A. Assim, a alteração de A (redução de 100) foi perdida, gerando inconsistência nos dados.

<img width="296" height="78" alt="image" src="https://github.com/user-attachments/assets/4d67ed5b-bfdf-42ea-8e63-365c02b45c80" />

### Pergunta 20 - Por que inserções em linhas diferentes nem sempre geram conflito direto?
Inserções em linhas diferentes nem sempre geram conflito direto porque cada INSERT cria um novo registro na tabela, sem precisar alterar ou bloquear dados já existentes. Assim, como não há tentativa de modificar o mesmo registro, as transações podem ser executadas simultaneamente sem interferência direta.

### Pergunta 21 - O que esse experimento mostra sobre concorrência quando não há disputa pelo mesmo registro?
Esse experimento mostra que, quando não há disputa pelo mesmo registro, o banco de dados consegue executar transações concorrentes ao mesmo tempo com eficiência. Isso evidencia que a concorrência é permitida em nível de tabela, desde que as operações não afetem os mesmos dados, garantindo melhor desempenho sem comprometer a integridade.

<img width="222" height="132" alt="image" src="https://github.com/user-attachments/assets/968d459e-2227-4b00-b6d7-02296115e308" />

### Pergunta 22 - Quais impactos um bloqueio mantido por muito tempo pode causar em um sistema real?
Um bloqueio mantido por muito tempo pode causar lentidão no sistema, filas de espera em outras transações e até indisponibilidade de operações, já que outras sessões ficam impedidas de acessar ou atualizar os dados bloqueados. 

### Pergunta 23 - Por que transações longas tendem a ser indesejáveis em ambientes concorrentes?
Transações longas são indesejáveis em ambientes concorrentes porque aumentam o tempo de bloqueio dos dados, reduzindo o desempenho do sistema e aumentando a chance de conflitos, espera excessiva e degradação da performance geral do banco de dados.

<img width="222" height="132" alt="image" src="https://github.com/user-attachments/assets/882d0fa3-3aa1-47ea-a293-30b69f2422a1" />
<img width="298" height="76" alt="image" src="https://github.com/user-attachments/assets/84931480-a6a2-4075-a9de-d971b78ca880" />

### Pergunta 24 - Como verificar se o banco permaneceu consistente após todos os cenários executados?
Para verificar se o banco permaneceu consistente, deve-se analisar se os valores finais das contas correspondem exatamente às operações realizadas durante os testes e se não houve perdas, duplicações ou alterações incorretas. Também é importante conferir se o histórico na tabela log_operacoes registra corretamente todas as inserções feitas nas transações.

### Pergunta 25 - Por que a análise final dos dados é importante após testes de concorrência?
A análise final dos dados é importante após testes de concorrência porque permite identificar possíveis problemas como inconsistências, atualizações perdidas ou falhas de isolamento entre transações. Ela garante que o banco se comportou corretamente sob execução simultânea e que a integridade dos dados foi mantida em todos os cenários.

### Pergunta 26 - Explique o que é concorrência em banco de dados.
É quando duas ou mais transações ou usuários acessam e modificam os mesmos dados ao mesmo tempo.

### Pergunta 27 - Descreva o papel dos bloqueios no controle de concorrência.
A Técnica Bloqueio é utilizada dentro do protocolo pessimista do controle de concorrência. O protocolo pessimista se baseia na premissa de que os conflitos entre as transações ocorrem com frequência. Os bloqueios dentro do protocolo são utilizados para controlar a execução concorrente das transações.  Bloqueio é uma variável associada a um item do banco de dados que indica o status do mesmo em relação às possíveis operações que podem ocorrer ser aplicadas. Normalmente, existe um bloqueio associado a cada um dos itens de dado do banco de dados, além de serem usados como forma de sincronizar o acesso por transações concorrentes aos itens do banco de dados.  

### Pergunta 28 - Explique a diferença entre acessar registros iguais e registros diferentes em transações simultâneas.
Ao acessar registros iguais em transações simultâneas, pode ser que haja alguma inconsistência no sistema, ao acessar registros diferentes, eles não interferem entre si.

### Pergunta 29 - Por que FOR UPDATE é importante em determinadas operações críticas?
O comando FOR UPDATE é importante em operações críticas de banco de dados uma vez que, ao ser anexado a uma instrução SELECT, ele gera um bloqueio de escrita sobre os registros selecionados e o mantém por toda a duração da transação. Isso é importante para eliminar o problema da Atualização Perdida (Lost Update), garantindo que o dado lido não seja alterado por outra transação antes que a transação atual complete seu ciclo de "ler, calcular e gravar".

### Pergunta 30 - O que significa dizer que uma transação ficou esperando outra liberar um recurso?
Significa que uma transação não pode continuar naquele momento porque o dado ou recurso que ela precisa está sendo usado por outra transação. 

### Pergunta 31 - Explique o conceito de atualização perdida.
Atualização Perdida é um problema de concorrência que ocorre quando duas transações simultâneas leem o mesmo dado, o modificam e tentam gravar suas alterações, resultando na perda da modificação realizada pela primeira transação que gravou, pois a segunda transação a sobrescreve sem considerar a alteração intermediária.  

### Pergunta 32 - Descreva por que o isolamento é essencial em sistemas multiusuário.
O isolamento é essencial em sistemas multiusuário, uma vez que garante que a execução de transações simultâneas não afete a consistência dos dados, fazendo com que cada transação se comporte como se estivesse sendo executada sozinha, de forma serializada.

### Pergunta 33 - Explique como uma leitura pode ser afetada por outra transação ainda não concluída.
Uma leitura pode ser afetada por outra transação ainda não concluída, principalmente quando ocorre o problema da Leitura Suja. Este problema ocorre quando uma transação lê um dado modificado por outra transação que ainda não executou o COMMIT, o que significa que as alterações lidas são temporárias e podem ser desfeitas por um ROLLBACK. Se a transação leitora basear suas decisões nesse dado não confirmado, ela estará utilizando informações inconsistentes ou inválidas, caso a transação modificadora decida desfazer suas alterações. 

### Pergunta 34 - Por que transações longas podem prejudicar o desempenho de sistemas concorrentes?
Transações longas podem prejudicar o desempenho de sistemas concorrentes porque mantêm recursos bloqueados por mais tempo, impedindo que outras transações acessem os mesmos dados. 

### Pergunta 35 - Qual é a relação entre concorrência e consistência dos dados?
A concorrência representa o risco de que a consistência dos dados seja violada. Por outro lado, a consistência é o objetivo que o isolamento busca garantir, fazendo com que cada transação se comporte como se estivesse sendo executada sozinha, de forma serializada. A concorrência gera problemas quando transações simultâneas acessam os mesmos registros, podendo levar a inconsistências como a Atualização Perdida ou a Leitura Suja. Para resolver isso, o mecanismo de bloqueio é usado para gerenciar a concorrência e manter a consistência. 

### Pergunta 36 - Descreva um exemplo real em que duas transações possam disputar o mesmo dado.
Podemos citar como exemplo a gestão do saldo em uma conta bancária, onde duas transações tentam sacar ou transferir dinheiro da mesma conta simultaneamente. Se uma Transação 1 lê o saldo (R$ 500) e calcula seu saque, e, ao mesmo tempo, uma Transação 2 também lê o mesmo valor original (R$ 500), ambas baseiam seus cálculos nesse valor. Quando a Transação 1 grava o novo saldo (R$ 400), a Transação 2, ao gravar seu resultado (R$ 300), sobrescreve a alteração da T1, resultando em um saldo final incorreto. O dado disputado é o campo do saldo, e o sistema de banco de dados precisaria usar mecanismos de bloqueio, como o FOR UPDATE, para forçar a serialização das operações e garantir que a T2 esperasse a T1 concluir, evitando a perda de dados e mantendo a consistência. 

### Pergunta 37 - Explique por que nem toda operação simultânea gera conflito.
Nem toda operação simultânea gera conflito porque o risco de conflitos em transações simultâneas está ligado à disputa pelos mesmos recursos. Quando transações simultâneas acessam registros diferentes, as operações são independentes e não interferem nos dados lidos ou modificados por outras transações. 

### Pergunta 38 - Como o banco de dados contribui para impedir que alterações simultâneas corrompam os dados?
O banco de dados impede que alterações simultâneas corrompam os dados usando mecanismos de controle de concorrência. Esses mecanismos garantem que várias transações possam ocorrer ao mesmo tempo sem causar inconsistências.

### Pergunta 39 - Explique o que aconteceria em um sistema bancário sem mecanismos de lock.
Um sistema bancário sem mecanismos de bloqueio falharia em garantir a consistência e a integridade do saldo das contas em um ambiente concorrente. O principal problema seria a Atualização Perdida, onde duas transações que tentassem modificar o mesmo saldo leriam o mesmo valor inicial e a que gravasse por último iria sobrescrever o resultado da primeira transação, fazendo com que o saque ou depósito desta fosse "perdido". Além disso, ocorreria também a Leitura Suja, em que uma transação leria um saldo temporário, modificado por outra transação ainda não confirmada, e que poderia ser desfeito por um ROLLBACK, levando a operações baseadas em dados incorretos ou inválidos. Em suma, sem o isolamento forçado pelos bloqueios, as operações financeiras não seriam executadas de forma serializada, resultando em cálculos de saldo incorretos.

### Pergunta 40 - Qual a importância de observar a ordem de execução das transações em testes práticos?
A importância de observar a ordem de execução das transações em testes práticos é crucial para simular e verificar como o sistema lida com a concorrência e garante o isolamento. A ordem de execução (ou o entrelaçamento das operações) é o que define se ocorrerão conflitos e quebras de consistência, permitindo a identificação de inconsistências como a Atualização Perdida ou a Leitura Suja em cenários onde transações acessam "registros iguais". 

## Atividade 04 - Prática 08 - Tarefa final
As questões práticas estão implementadas no arquivo SQL: atividade04.sql

### Pergunta 1 - O que é concorrência em banco de dados ?
Concorrência em banco de dados é a capacidade de múltiplas transações serem executadas ao mesmo tempo, acessando e modificando dados compartilhados. Isso melhora o desempenho do sistema, mas exige controle para evitar inconsistências.

### Pergunta 2 - Como funcionam os locks ?
Locks são mecanismos que impedem que duas transações modifiquem o mesmo dado simultaneamente. Quando usamos FOR UPDATE, o registro fica bloqueado até que a transação seja finalizada com COMMIT ou ROLLBACK.

### Pergunta 3 - Por que algumas transações precisam esperar?
Uma transação precisa esperar quando outra já está utilizando o mesmo registro. Isso acontece para evitar conflitos de escrita e garantir que os dados não sejam alterados simultaneamente de forma inconsistente.

### Pergunta 4 - O que é atualização perdida ?
Atualização perdida ocorre quando duas transações leem o mesmo valor e escrevem resultados diferentes, fazendo com que uma sobrescreva a outra. Isso gera perda de uma das atualizações.

### Pergunta 5 - Por que o isolamento é importante ?
O isolamento garante que cada transação seja executada de forma independente, sem interferência de outras transações em andamento. Isso evita leituras inconsistentes e erros de concorrência.

### Pergunta 6 - Como o banco preserva a consistência em acessos simultâneos ?
O banco preserva a consistência por meio de transações, locks, níveis de isolamento e controle de concorrência. Esses mecanismos garantem que os dados permaneçam corretos mesmo com múltiplos usuários acessando o sistema ao mesmo tempo.


