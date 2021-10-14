SET SERVEROUTPUT ON
SET VERIFY OFF

/*
12. Criar um bloco PL/SQL para selecionar na tabela FORNECEDOR, o código do fornecedor
informado na tela. Se o fornecedor existir, apresente seu código e nome, do contrário, apresente
uma mensagem ‘Fornecedor não cadastrado’. Utilize para isso a estrutura EXCEPTION.
*/

SELECT * FROM FORNECEDOR;

DECLARE
F_COD  FORNECEDOR.N_FORNEC%TYPE := &CODIGO_FORNECEDOR;
F_NOME FORNECEDOR.NOME%TYPE;
BEGIN
SELECT N_FORNEC, NOME INTO F_COD, F_NOME  FROM FORNECEDOR WHERE N_FORNEC = F_COD;
DBMS_OUTPUT.PUT_LINE('O CODIGO É: ' || F_COD || 'NOME DO FORNECEDOR :' || F_NOME);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO ENCONTRADO');
END;

/*
13. Fazer cálculo das parcelas da compra de um carro de acordo com a condição de pagamento
escolhida. As condições são:
? Parcelas para aquisição em 6 pagamentos
? Parcelas para aquisição em 12 pagamentos
? Parcelas para aquisição em 18 pagamentos
Observação:
a. O valor da compra deverá ser informado em tempo de execução
b. O nº de parcelas que se deseja pagar deverá ser informado em tempo de execução
c. Deverá ser dada uma entrada de 20% do valor da compra
d. Deverá ser aplicada uma taxa de juros sobre o saldo restante, nas seguintes condições:
• Pagamento em 6 parcelas: 10%
• Pagamento em 12 parcelas: 15%
• Pagamento em 18 parcelas: 20%
e. No final, informar o valor da compra, o valor da entrada, o nº de parcelas escolhido para
pagamento, além do valor da parcela
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
14. O IMC – Índice de Massa Corporal é um critério da Organização Mundial de Saúde para dar uma
indicação sobre a condição de peso de uma pessoa adulta. A fórmula é IMC = peso / (altura)2.
Elabore um bloco PL/SQL que leia o peso e a altura de um adulto em tempo de execução e
identifique em que condição ele se encontra, de acordo com a tabela abaixo.
IMC em adultos Condição
< 18,5 Abaixo do peso
>= 18,5 e < 25 Peso normal
>= 25 e < 30 Acima do peso
>= 30 Obeso
No final, apresente seu peso, sua altura e sua condição.
Atividade extra: Repita os exercícios nºs 13 e 14 utilizando a estrutura de decisão CASE.
*/