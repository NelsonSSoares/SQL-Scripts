set serveroutput on -- liga saida do console

DECLARE
v_mens varchar(20) := '&message' ;
BEGIN
DBMS_OUTPUT.PUT_LINE(v_mens);
END;

set verify off;

DECLARE
  new_salario NUMBER(7,2) := &salario * 1.08;
BEGIN
  DBMS_OUTPUT.PUT_LINE(new_salario);
END;


DECLARE
  v_cot NUMBER(3,2) := &cotacao_do_dolar;
  v_real NUMBER (5,2);
  v_dolar NUMBER (5) := &Qtde_Dólar;
BEGIN
  v_real := v_dolar * v_cot;
  DBMS_OUTPUT.PUT_LINE('Quantidade dólar:'|| v_dolar);
  DBMS_OUTPUT.PUT_LINE('Cotação do dia:'|| v_cot);
  DBMS_OUTPUT.PUT_LINE('Valor  em Real'|| v_real);
END;