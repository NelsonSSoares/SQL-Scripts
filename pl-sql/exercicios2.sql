 SET SERVEROUTPUT ON
SET VERIFY OFF
/*
8. ACESSAR NA TABELA FORNECEDOR O ENDEREÇO E AS VENDAS DO
FORNECEDOR INFORMADO PELO USUÁRIO.
Criar um bloco PL-SQL para acessar um determinado fornecedor na tabela
FORNECEDOR, cujo código do fornecedor deverá ser informado em tempo de execução.
Apresente na tela o seu código, endereço e o valor de suas vendas.
*/

DECLARE
V_CODF    FORNECEDOR.N_FORNEC%TYPE := &CODIGO_FORNECEDOR;
v_END     FORNECEDOR.ENDERECO%TYPE;
V_VENDAS  FORNECEDOR.VENDA%TYPE;

BEGIN
  SELECT N_FORNEC, ENDERECO, VENDA INTO V_CODF, V_END, V_VENDAS FROM FORNECEDOR
  WHERE N_FORNEC = V_CODF;
  DBMS_OUTPUT.PUT_LINE('O FORNECEDOR INFORMADO É: ' || V_CODF);
  DBMS_OUTPUT.PUT_LINE('O ENDEREÇO É: ' || V_END);
  DBMS_OUTPUT.PUT_LINE('O NUMERO DE VENDAS É: ' || V_VENDAS);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO ENCONTRADO');
END;



/*
9. ACESSAR TABELA FORNECEDOR, CUJO CÓDIGO DEVERÁ SER INFORMADO NA
TELA E ALTERAR O VALOR DA COMISSÃO, NAS CONDIÇÕES ABAIXO.
Criar um bloco PL-SQL para acessar, na tabela FORNECEDOR, o fornecedor informado
na tela e executar as seguintes ações:
o Caso não encontre dar a mensagem ‘ FORNECEDOR NÃO INFORMADO’
o Caso encontre deverá fazer a seguinte atualização na comissão:
• Se as vendas forem maiores que 6000 ? a comissão deverá ser 15% do valor das
vendas
• Caso contrário ? a comissão deverá ser 5% do valor das vendas
o No final, atualizar o valor da comissão do fornecedor e dar uma mensagem do valor
calculado da comissão.
*/

DECLARE
  V_CODF FORNECEDOR.N_FORNEC%TYPE := &CODIGO_FORNECEDOR;
  V_VENDA FORNECEDOR.VENDA%TYPE;
  V_COM FORNECEDOR.COMISSAO%TYPE;
BEGIN
  SELECT VENDA INTO V_VENDA FROM FORNECEDOR WHERE N_FORNEC = V_CODF;
  
  IF V_VENDA > 6000 THEN
     V_COM := V_VENDA *0.15 ;
  ELSE
    V_COM := V_VENDA * 0.05;
  END IF;  
  UPDATE FORNECEDOR 
     SET
     COMISSAO = COMISSAO + V_COM
     WHERE N_FORNEC = V_CODF;
     
     DBMS_OUTPUT.PUT_LINE('COMISSÃO ATUALIZADA COM SUCESSO. VALOR = ' || V_COM) ;
     
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO CADASTRADO!');

END;


/*
10. Acessar a tabela “CONTA” pesquisando registro e em função do resultado da
pesquisa, inserir nova linha na tabela A_FAZER.
Criar um bloco PL-SQL para recuperar, na tabela CONTA, o numero da conta com saldo
inferior a R$ 10.000 em uma variável e caso encontre um registro, inserir na tabela
A_FAZER uma nova tarefa nos campos abaixo:
FEITO = ‘N’
DATA = data do sistema
OBSERV = ‘Mensagem para CC nº xxxx – saldo baixo’
Para evitar problemas com o SELECT retornando mais de uma linha ou não encontrando
registros, acrescente na programação o controle de erros, utilizando para isso , a seção
EXCEPTION.
*/

DECLARE
V_CONTA CONTA.N_CONTA%TYPE;
V_MENS A_FAZER.OBSERV%TYPE;
BEGIN
 SELECT N_CONTA INTO V_CONTA FROM CONTA WHERE SALDO < 10000;
 V_MENS := 'MENSAGEM PARA CC Nº '||V_CONTA||'SALDO BAIXO';
 INSERT INTO A_FAZER /*(FEITO, DATA,OBESERV) -- OPCIONAL*/
 VALUES('N',SYSDATE,V_MENS);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('INFORMAÇÃO NÃO ENCONTRADA!');
  WHEN TOO_MANY_ROWS THEN
  DBMS_OUTPUT.PUT_LINE('MAIS DE UM VALOR ENCONTRADO!');
END;



/* 
  11. Criar um bloco PL/SQL para atualizar um campo numa tabela de acordo com o resultado de uma
pesquisa feita no registro dessa tabela.
Antes de criar o bloco para atualização dos dados, execute os comandos abaixo para criação e
inserção de dados na tabela ALUNO.
• Criar uma tabela conforme segue:
CREATE TABLE ALUNO
( RA NUMBER(9) PRIMARY KEY, NOME VARCHAR(50) NOT NULL,
 DISCIPLINA VARCHAR(30), MEDIA NUMBER(3,1), CARGA_HORA NUMBER(2),
 FALTAS NUMBER(2), RESULTADO VARCHAR(10)
);
• Inserir registros na tabela ALUNO deixando a coluna RESULTADO em branco.
INSERT INTO ALUNO VALUES (100, ‘Luis’, ’Modelagem Dados',7.5,80,14,null);
INSERT INTO ALUNO VALUES (200, ‘Carla’, ’Modelagem Dados',4.5,80,16,null);
INSERT INTO ALUNO VALUES (300, ‘Pedro’, ’Modelagem Dados',6.0,80,24,null);
Criar um bloco PL/SQL para pesquisar um nº de RA fornecido em tempo de execução e,
encontrando o registro, atualizar o campo RESULTADO, de acordo com as regras abaixo:
? Se o aluno obteve média igual ou maior que 7.0 e suas faltas não ultrapassarem 25% da
carga horária da disciplina o resultado será: APROVADO.
? Se o aluno obteve média inferior a 7.0 e suas faltas não ultrapassarem 25% da carga
horária da disciplina o resultado será: EXAME.
? Para os demais casos o resultado será: REPROVADO.
*/

CREATE TABLE ALUNO
( RA NUMBER(9) PRIMARY KEY, NOME VARCHAR(50) NOT NULL,
 DISCIPLINA VARCHAR(30), MEDIA NUMBER(3,1), CARGA_HORA NUMBER(2),
 FALTAS NUMBER(2), RESULTADO VARCHAR(10)
);
INSERT INTO ALUNO VALUES (100, 'Luis', 'Modelagem Dados',7.5,80,14,null);
INSERT INTO ALUNO VALUES (200, 'Carla', 'Modelagem Dados',4.5,80,16,null);
INSERT INTO ALUNO VALUES (300, 'Pedro', 'Modelagem Dados',6.0,80,24,null);

DECLARE
	V_RA		ALUNO.RA%TYPE	:= &RA	;
	V_NOME		ALUNO.NOME%TYPE			;
	V_MEDIA		ALUNO.MEDIA%TYPE		;
	V_FALTAS	ALUNO.FALTAS%TYPE		;
	V_CH		ALUNO.CARGA_HORA%TYPE	;
	V_RESULT	ALUNO.RESULTADO%TYPE	;
BEGIN
	SELECT 	RA, 	NOME,	MEDIA,	 FALTAS,	CARGA_HORA 
	INTO	V_RA,	V_NOME,	V_MEDIA, V_FALTAS,	V_CH
	FROM 	ALUNO
	WHERE	RA = V_RA	;
	IF V_MEDIA >= 7 AND V_FALTAS <= V_CH * 0.25 THEN
	   V_RESULT := 'APROVADO'	;
	ELSIF V_MEDIA < 7 AND V_FALTAS <= V_CH * 0.25 THEN
	   V_RESULT := 'EXAME'		;
	ELSE
	   V_RESULT := 'REPROVADO'	;	
	END IF						;   
	UPDATE ALUNO SET RESULTADO = V_RESULT  WHERE RA = V_RA	;
	DBMS_OUTPUT.PUT_LINE('REGISTRO ATUALIZADO COM SUCESSO!'); 
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('RA NÃO ENCONTRADO!');
END;
