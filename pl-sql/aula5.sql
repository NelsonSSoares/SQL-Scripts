-- CORRE��O DO EXERC 5

SET SERVEROUTPUT ON
SET VERIFY OFF

/*
18. Criar um bloco PL-SQL para ler o empregado numero 7369, cuja caracter�stica das colunas dever�
ser a mesma definida na tabela EMP.
� Calcular o novo sal�rio que dever� ter um aumento de 8% sobre o sal�rio atual.
� Posteriormente, dever� ser mostrado o nome, cargo e o novo sal�rio calculado.
Observa��o: Dever� ser usado registro com a op��o ROWTYPE. 
*/

DECLARE
	V_REG		EMP%ROWTYPE												;
	V_NOVOSAL	EMP.SAL%TYPE											;
  V_EXCEP EXCEPTION                         ;
BEGIN
	SELECT	*
	INTO	V_REG
	FROM	EMP
	WHERE	EMPNO = &CODIGO												;
  IF V_REG.EMPNO = 7839 THEN
      RAISE V_EXCEP     ;
  ELSE   
      V_NOVOSAL := V_REG.SAL * 1.08										;
      DBMS_OUTPUT.PUT_LINE('NOME: ' || V_REG.ENAME)						;
      DBMS_OUTPUT.PUT_LINE('CARGO: ' || V_REG.JOB)						;
      DBMS_OUTPUT.PUT_LINE('SAL�RIO COM REAJUSTE DE 8%: ' || V_NOVOSAL)	;
  END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('EMPREGADO N�O ENCONTRADO!')	;
  WHEN V_EXCEP THEN
    DBMS_OUTPUT.PUT_LINE('PRESIDENTE - SEM REAJUSTE');
END;

/*
DECLARE
  V_REG EMP%ROWTYPE; -- ARMAZENA OS TIPOS DAS COLUNAS DA TABELA
  V_NOVOSAL EMP.SAL%TYPE; -- CRIA VARIAVAL COM O MESMO TIPO DA COLUNA
BEGIN
 SELECT * 
 INTO V_REG
 FROM EMP
 WHERE EMPNO = &CODIGO;-- PEDE O CODIGO E PASSA COMO PARAMETRO;.
 
 V_NOVOSAL := V_REG.SAL * 1.08;
 DBMS_OUTPUT.PUT_LINE('NOME: ' || V_REG.ENAME);
 DBMS_OUTPUT.PUT_LINE('CARGO: ' ||V_REG.JOB );
 DBMS_OUTPUT.PUT_LINE('SALARIO COM REJUSTE DE 8%' || V_NOVOSAL);
EXCEPTION

  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('EMPREGADO N�O ENCONTRADO!')	;

END;

/*
DECLARE
  V_REG EMP%ROWTYPE; -- ARMAZENA OS TIPOS DAS COLUNAS DA TABELA
  V_NOVOSAL EMP.SAL%TYPE; -- CRIA VARIAVAL COM O MESMO TIPO DA COLUNA
BEGIN
 SELECT * 
 INTO V_REG
 FROM EMP
 WHERE EMPNO = &CODIGO;-- PEDE O CODIGO E PASSA COMO PARAMETRO;.
 
 V_NOVOSAL := V_REG.SAL * 1.08;
 DBMS.OUTPUT.PUT_LINE('NOME: ' || V_REG.ENAME);
 DBMS.OUTPUT.PUT_LINE('CARGO: ' ||V_REG.JOB );
 DBMS.OUTPUT.PUT_LINE('SALARIO COM REJUSTE DE 8%' || V_NOVOSAL);
EXCEPTION

  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('EMPREGADO N�O ENCONTRADO!')	;

END;

/*
   SELECT ENAME, JOB , SAL ;--SELECIONA COLUNAS
  INTO V_NOME, V_CARGO, V_SAL-- ARMAZENA AS COLUNAS SELECIONADA EM VARIAVEIS
  FROM -- NOME DA TABELA
  WHERE -- CONDI��O PARA FILTRAR LINHAS

*/

---------------------------------------------------------------------------------------------------------

/*
19. Criar um bloco PL/SQL para selecionar na tabela FORNECEDOR o fornecedor informado na tela
em tempo de execu��o e controlar no programa as seguintes situa��es:
� Caso n�o encontre registro o bloco deve ir para o EXCEPTION apresentando mensagem de registro
n�o encontrado.
� Caso encontre o registro, verificar a quantidade de estrelas para este fornecedor e:
? Se for igual a 5, apresentar um EXCEPTION definido no programa como E_ForaEscopo com a
mensagem �Fornecedor fora do escopo � Estrela = 5�. Para isso, utilize a op��o RAISE.
? Para os demais valores de ESTRELA, apresentar a mensagem: �'Fornecedor dentro
parametro pesquisa � Estrela = x�.
*/

DECLARE
V_REG FORNECEDOR%ROWTYPE ;
V_EXCEP EXCEPTION;
BEGIN

  SELECT *
  INTO V_REG
  FROM FORNECEDOR
  WHERE N_FORNEC = &CODIGO;
  
  IF V_REG.ESTRELA = 5 THEN
  RAISE V_EXCEP;
  
  ELSE
  DBMS_OUTPUT.PUT_LINE('O NUMERO DE ESTRELAS � : ' || V_REG.ESTRELA);
  END IF;
  
EXCEPTION

WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('FORNECEDOR N�O ENCONTRADO');
WHEN V_EXCEP THEN
DBMS_OUTPUT.PUT_LINE('FORNECEDOR CONFIDENCIAL');
END;

-----------------------------------------------------------------------------------------------------------------

/*
20. Criar um bloco PL/SQL para incluir registros na tabela TITULO para todos os clientes cadastrados
na tabela CLIENTE cujo status seja ATIVO.
Para cada parcela existente na tabela CLIENTE, 1 registro de t�tulo dever� ser inserido na tabela
TITULO, ou seja, se o cliente escolheu pagar em 5 parcelas, fa�a uma rotina que insira 5 novos
registros na tabela TITULO, de acordo com as condi��es abaixo:
� CODIGO = CODIGO DO CLIENTE
� NUMERO DO TITULO = SEQUENCIAL A PART�R DE 1, PARA CADA CLIENTE
SELECIONADO (Para isso, crie uma sequ�ncia)
� VALOR DO TITULO = VALOR DA VENDA DIVIDIDO PELO N�MERO DE PARCELAS
� VALOR DOS JUROS = 0
� VALOR DOS DESCONTOS = 0
� VALOR PAGO = 0
� DATA DE EMISS�O = EMISS�O DA NOTA FISCAL DO CLIENTE
� DATA DE VENCTO = DEVER� SER DE 30 EM 30 DIAS A PARTIR DA EMISS�O PARA
CADA T�TULO
� DATA DE PAGAMENTO = NULO
Observa��es: Dever� ser utilizado CURSOR com registro ou com vari�veis
*/
DECLARE
	CURSOR c_cliente IS SELECT codigo, parcela, valor_nota,  emissao_nota 
	FROM cliente WHERE status = 'A';
	V_REG		C_CLIENTE%ROWTYPE		;
	V_PARC		NUMBER(2)				;
	V_VALTIT	TITULO.VALOR_TITULO%TYPE;
	V_VENC		DATE					;
BEGIN
	OPEN 	C_cliente;
 	FETCH 	C_cliente INTO V_REG;
   	WHILE 	C_cliente%FOUND LOOP
			V_PARC:= 0;
			V_VALTIT:= V_REG.valor_nota / V_REG.parcela	;
			v_venc	:= V_REG.emissao_nota				;
			WHILE V_PARC <  V_REG.parcela  LOOP
				v_venc:= v_venc + 30;
				Insert into titulo
				Values
				(seq_numtit.nextval,v_reg.codigo, v_valtit,0,0,0,v_reg.emissao_nota,v_venc,null);
            	V_parc:= V_parc + 1;
			END LOOP;
         	FETCH C_cliente INTO V_REG;
  	END LOOP;
   	CLOSE C_cliente;
	DBMS_OUTPUT.PUT_LINE('REGISTROS INSERIDOS COM SUCESSO!');
END;


/*
DECLARE

CURSOR C_CLIENTE IS
SELECT codigo, parcela, valor_nota, emissao_nota
FROM cliente 
WHERE status = 'A';

V_REG C_CLIENTE%ROWTYPE;
V_PARC NUMBER(2);
V_VALTIT TITULO.VALOR_TITULO%TYPE;
V_VENC DATE;

BEGIN
  
  OPEN C_CLIENTE;
  FETCH C_CLIENTE INTO V_REG;
  
  WHILE C_CLIENTE%FOUND LOOP
  
    V_PARC:= 0;
    V_VALTIT := V_REG.valor_nota / V_REG.parcela;
    V_VENC := V_REG.emissao_nota
    
    WHILE V_PARC < V_REG.parcela LOOP
    
    V_VENC := V_VENC + 30;
    
    INSERT INTO TITULO
    VALUES(seq_numtit.nextval, v_reg.codigo, v_valtit, 0,0,0, v_reg.emissao_nota, v_venc, null);
    V_PARC := V_PARC +1;
    
    END LOOP;
    
    FETCH C_CLIENTE   INTO V_REG;
  END LOOP;
  
  CLOSE C_CLIENTE;
  
  DBMS_OUTPUT.PUT_LINE('PARCELAS INSERIDAS COM SUCESSO');

END;


*/


/*
21. Criar um bloco PL/SQL para selecionar da tabela lan�amentos os lan�amentos de 106 a 114 que
estejam com os valores negativos, mostrando na tela em seguida. Utilize a op��o FOR com LOOP
e CURSOR com REGISTRO. Utilize CURSOR atrav�s dos comandos OPEN, FETCH e CLOSE

*/
SELECT * FROM LANC;

DECLARE
  R_LANC LANC%ROWTYPE;
  
  CURSOR C_LANC IS SELECT * FROM LANC WHERE LANC BETWEEN 106 AND 114;
  
BEGIN
  
  FOR R_LANC IN C_LANC LOOP
  
    IF R_LANC.VALOR < 0 THEN
      
      DBMS_OUTPUT.PUT_LINE('N LANC = ' || R_LANC.N_LANC || ' / VALOR NEGATIVO ' || R_LANC.VALOR );
    END IF;
  END LOOP;
  
EXCEPTION

END;



DECLARE
	R_LANC  LANC%ROWTYPE		;
	CURSOR C_LANC IS SELECT * FROM LANC WHERE N_LANC BETWEEN 106 AND 114	;
BEGIN
	FOR R_LANC IN C_LANC LOOP
		IF R_LANC.VALOR < 0 THEN
			DBMS_OUTPUT.PUT_LINE('N� LANC = ' || R_LANC.N_LANC || ' / VALOR NEGATIVO = ' || R_LANC.VALOR);
		END IF;	
	END LOOP;
END;













/*
22. Repita o exerc�cio anterior utilizando outra estrutura de repeti��o que exija a manipula��o do
CURSOR atrav�s dos comandos OPEN, FETCH e CLOSE.
*/