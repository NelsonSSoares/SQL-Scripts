-- CORREÇÃO DO EXERC 5

SET SERVEROUTPUT ON
SET VERIFY OFF

/*
18. Criar um bloco PL-SQL para ler o empregado numero 7369, cuja característica das colunas deverá
ser a mesma definida na tabela EMP.
• Calcular o novo salário que deverá ter um aumento de 8% sobre o salário atual.
• Posteriormente, deverá ser mostrado o nome, cargo e o novo salário calculado.
Observação: Deverá ser usado registro com a opção ROWTYPE. 
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
      DBMS_OUTPUT.PUT_LINE('SALÁRIO COM REAJUSTE DE 8%: ' || V_NOVOSAL)	;
  END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO!')	;
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
  DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO!')	;

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
  DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO!')	;

END;

/*
   SELECT ENAME, JOB , SAL ;--SELECIONA COLUNAS
  INTO V_NOME, V_CARGO, V_SAL-- ARMAZENA AS COLUNAS SELECIONADA EM VARIAVEIS
  FROM -- NOME DA TABELA
  WHERE -- CONDIÇÃO PARA FILTRAR LINHAS

*/

---------------------------------------------------------------------------------------------------------

/*
19. Criar um bloco PL/SQL para selecionar na tabela FORNECEDOR o fornecedor informado na tela
em tempo de execução e controlar no programa as seguintes situações:
• Caso não encontre registro o bloco deve ir para o EXCEPTION apresentando mensagem de registro
não encontrado.
• Caso encontre o registro, verificar a quantidade de estrelas para este fornecedor e:
? Se for igual a 5, apresentar um EXCEPTION definido no programa como E_ForaEscopo com a
mensagem ‘Fornecedor fora do escopo – Estrela = 5’. Para isso, utilize a opção RAISE.
? Para os demais valores de ESTRELA, apresentar a mensagem: ‘'Fornecedor dentro
parametro pesquisa – Estrela = x’.
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
  DBMS_OUTPUT.PUT_LINE('O NUMERO DE ESTRELAS É : ' || V_REG.ESTRELA);
  END IF;
  
EXCEPTION

WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO ENCONTRADO');
WHEN V_EXCEP THEN
DBMS_OUTPUT.PUT_LINE('FORNECEDOR CONFIDENCIAL');
END;

-----------------------------------------------------------------------------------------------------------------

/*
20. Criar um bloco PL/SQL para incluir registros na tabela TITULO para todos os clientes cadastrados
na tabela CLIENTE cujo status seja ATIVO.
Para cada parcela existente na tabela CLIENTE, 1 registro de título deverá ser inserido na tabela
TITULO, ou seja, se o cliente escolheu pagar em 5 parcelas, faça uma rotina que insira 5 novos
registros na tabela TITULO, de acordo com as condições abaixo:
• CODIGO = CODIGO DO CLIENTE
• NUMERO DO TITULO = SEQUENCIAL A PARTÍR DE 1, PARA CADA CLIENTE
SELECIONADO (Para isso, crie uma sequência)
• VALOR DO TITULO = VALOR DA VENDA DIVIDIDO PELO NÚMERO DE PARCELAS
• VALOR DOS JUROS = 0
• VALOR DOS DESCONTOS = 0
• VALOR PAGO = 0
• DATA DE EMISSÃO = EMISSÃO DA NOTA FISCAL DO CLIENTE
• DATA DE VENCTO = DEVERÁ SER DE 30 EM 30 DIAS A PARTIR DA EMISSÃO PARA
CADA TÍTULO
• DATA DE PAGAMENTO = NULO
Observações: Deverá ser utilizado CURSOR com registro ou com variáveis
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
21. Criar um bloco PL/SQL para selecionar da tabela lançamentos os lançamentos de 106 a 114 que
estejam com os valores negativos, mostrando na tela em seguida. Utilize a opção FOR com LOOP
e CURSOR com REGISTRO. Utilize CURSOR através dos comandos OPEN, FETCH e CLOSE

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
			DBMS_OUTPUT.PUT_LINE('Nº LANC = ' || R_LANC.N_LANC || ' / VALOR NEGATIVO = ' || R_LANC.VALOR);
		END IF;	
	END LOOP;
END;













/*
22. Repita o exercício anterior utilizando outra estrutura de repetição que exija a manipulação do
CURSOR através dos comandos OPEN, FETCH e CLOSE.
*/