set serveroutput on

/*set verify off*/

/*SELECIONE O BLOCO PARA SER EXECUTADO*/

DECLARE   /*HERDA TAMANHO E TIPO E ATRIBUI A VARIAVEL*/
  V_CODF FORNECEDOR.N_FORNEC%TYPE := &CODIGO_FORNECEDO /*INPUT DE DADOS COM NOME DO CAMPO TUDO É ARMAZENADO NA VARIAVEL V_CODF*/;
  V_END  FORNECEDOR.ENDERECO%TYPE ;
  V_VENDA FORNECEDOR.VENDA%TYPE ;
BEGIN
  SELECT N_FORNEC, ENDERECO, VENDA
  INTO V_CODF, V_END, V_VENDA
  FROM FORNECEDOR
  WHERE N_FORNEC = V_CODF;
  
  DBMS_OUTPUT.PUT_LINE('CODIGO DO FORNECEDOR: ' || V_CODF);
  DBMS_OUTPUT.PUT_LINE('ENDEREÇO DO FORNECEDOR: ' || V_END);
  DBMS_OUTPUT.PUT_LINE('VENDAS DO FORNECEDOR: ' || V_VENDA);
EXCEPTION
  WHEN NO_DATA_FOUND THEN 
  DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO ENCONTRADO');
END;

/*CONDICIONAL IFS*/

DECLARE
  var1 NUMBER(4) :=  &var1;
  var2 NUMBER(4) := 0;
BEGIN
  IF var1 > 10 THEN
  var2 := var1 + 20;
  DBMS_OUTPUT.PUT_LINE('O VALOR DE VAR 2 É: ' || var2);
  ELSE
  dbms_output.put_line('VALOR MENOR QUE 10');
  END IF;
  /* EXCEPTION DEVE SER SÓ INSERIDO SE HOUVER TRATAMENTO DE ERRO */
END;

DECLARE
  var1 NUMBER(4) :=  &var1;
  var2 NUMBER(4) := 0;
BEGIN
  IF var1 > 10 THEN
  var2 := var1 + 20;  
  ELSE
  var2 := var1* var1;
  END IF;
  DBMS_OUTPUT.PUT_LINE('O VALOR DE VAR 2 É: ' || var2);
  /* EXCEPTION DEVE SER SÓ INSERIDO SE HOUVER TRATAMENTO DE ERRO */
END;
/*
  IF ELSE IF ELSE END IF;
*/
DECLARE
  var1 NUMBER(4) :=  &var1;
  var2 NUMBER(4) := 0;
BEGIN
  IF var1 > 10 THEN
  var2 := var1 + 20;  
  ELSE
    IF var1 between 7 and 9 THEN
      var2:= var1*2;
    ELSE
    var2 := var1 * var1;
    END IF;
  END IF;
END;

/*
    ELSIF
*/

DECLARE
  var1 NUMBER(4) :=  &var1;
  var2 NUMBER(4) := 0;
BEGIN
  IF var1 > 10 THEN
  var2 := var1 + 20;  
  ELSIF var1 between 7 and 9 THEN
      var2:= var1*2;
    ELSE
    var2 := var1 * var1;
    END IF;
  END IF;
END;
/* 
DECLARE
	V_CODF	FORNECEDOR.N_FORNEC%TYPE	:=	&CODIGO_FORNECEDOR	;
	V_END	FORNECEDOR.ENDERECO%TYPE							;
	V_VENDA	FORNECEDOR.VENDA%TYPE								;
BEGIN
	SELECT 	N_FORNEC, 	ENDERECO, 	VENDA
	INTO	V_CODF,		V_END,		V_VENDA	
	FROM 	FORNECEDOR
	WHERE	N_FORNEC = V_CODF									;
	DBMS_OUTPUT.PUT_LINE('CÓDIGO DO FORNECEDOR: ' || V_CODF)	;
	DBMS_OUTPUT.PUT_LINE('ENDEREÇO DO FORNECEDOR: ' || V_END)	;
	DBMS_OUTPUT.PUT_LINE('VENDAS DO FORNECEDOR: ' || V_VENDA)	;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO ENCONTRADO!')	;
END;

CORREÇÃO EXERCICIOS 3/4

4.	Fazer cálculo usando variáveis, sendo que as mesmas deverão ser informadas em tempo de execução.

Criar um bloco PL-SQL para converter em REAIS os valores que serão informados em dólares, considerando R$ 1,70 o valor do câmbio. Os valores (dólar e câmbio) deverão ser informados em tempo de execução.
 Convertendo dólar em real (Cotação do dólar do dia 27/01/2010 = R$ 1,86) 

DECLARE
  v_dolar  NUMBER(5,2) := &v_dolar;
  v_cambio NUMBER(3,2) := &v_cambio;
  v_real   NUMBER(7,2);

BEGIN
  v_real := v_dolar * v_cambio;
  DBMS_OUTPUT.PUT_LINE ('O valor em REAIS é = ' || v_real);
END;
/

3.	Alterar o valor de uma variável, sendo que a mesma deverá ser informada em tempo de execução.

Criar um bloco PL-SQL para calcular o valor do novo salário mínimo que deverá ser 8% a mais sobre o valor atual. O valor atual deverá ser informado em tempo de execução.


 Calcular o reajuste do salário mínimo aplicando 25% sobre o valor informado. 

DECLARE 
  v_salmin NUMBER(7,2) := &v_salmin;

BEGIN
  v_salmin := v_salmin * 1.25;
  DBMS_OUTPUT.PUT_LINE ('O novo salário mínimo é = ' || v_salmin);
END;


*/
