SET SERVEROUTPUT ON
SET VERIFY OFF

/*
12. Criar um bloco PL/SQL para selecionar na tabela FORNECEDOR, o c�digo do fornecedor
informado na tela. Se o fornecedor existir, apresente seu c�digo e nome, do contr�rio, apresente
uma mensagem �Fornecedor n�o cadastrado�. Utilize para isso a estrutura EXCEPTION.
*/

SELECT * FROM FORNECEDOR;

DECLARE
F_COD  FORNECEDOR.N_FORNEC%TYPE := &CODIGO_FORNECEDOR;
F_NOME FORNECEDOR.NOME%TYPE;
BEGIN
SELECT N_FORNEC, NOME INTO F_COD, F_NOME  FROM FORNECEDOR WHERE N_FORNEC = F_COD;
DBMS_OUTPUT.PUT_LINE('O CODIGO �: ' || F_COD || 'NOME DO FORNECEDOR :' || F_NOME);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('FORNECEDOR N�O ENCONTRADO');
END;

/*
13. Fazer c�lculo das parcelas da compra de um carro de acordo com a condi��o de pagamento
escolhida. As condi��es s�o:
? Parcelas para aquisi��o em 6 pagamentos
? Parcelas para aquisi��o em 12 pagamentos
? Parcelas para aquisi��o em 18 pagamentos
Observa��o:
a. O valor da compra dever� ser informado em tempo de execu��o
b. O n� de parcelas que se deseja pagar dever� ser informado em tempo de execu��o
c. Dever� ser dada uma entrada de 20% do valor da compra
d. Dever� ser aplicada uma taxa de juros sobre o saldo restante, nas seguintes condi��es:
� Pagamento em 6 parcelas: 10%
� Pagamento em 12 parcelas: 15%
� Pagamento em 18 parcelas: 20%
e. No final, informar o valor da compra, o valor da entrada, o n� de parcelas escolhido para
pagamento, al�m do valor da parcela
*/
DECLARE
  VALOR NUMBER(5,2) := &VALOR_VEICULO;
  PARCELA NUMBER(2) := &NUM_PARCELAS;
  ENTRADA NUMBER(5,2);
BEGIN
  IF PARCELA BETWEEN 6 AND 11 THEN
  ENTRADA := VALOR * 0.10;
  ELSIF PARCELA BETWEEN 12 AND 17 THEN
  ENTRADA := VALOR * 0.15;
  ELSE PARCELA >= 18 THEN
  ENTRADA := VALOR * 0.20;
  END IF;
  DBMS_OUTPUT.PUT_LINE('VALOR DA COMPRA: '|| VALOR);
  DBMS_OUTPUT.PUT_LINE('NUMERO DE PARCELAS: ' || PARCELA);
  DBMS_OUTPUT.PUT_LINE('ENTRADA: ' || ENTRADA);
END;



/*
14. O IMC � �ndice de Massa Corporal � um crit�rio da Organiza��o Mundial de Sa�de para dar uma
indica��o sobre a condi��o de peso de uma pessoa adulta. A f�rmula � IMC = peso / (altura)2.
Elabore um bloco PL/SQL que leia o peso e a altura de um adulto em tempo de execu��o e
identifique em que condi��o ele se encontra, de acordo com a tabela abaixo.
IMC em adultos Condi��o
< 18,5 Abaixo do peso
>= 18,5 e < 25 Peso normal
>= 25 e < 30 Acima do peso
>= 30 Obeso
No final, apresente seu peso, sua altura e sua condi��o.
Atividade extra: Repita os exerc�cios n�s 13 e 14 utilizando a estrutura de decis�o CASE.
*/