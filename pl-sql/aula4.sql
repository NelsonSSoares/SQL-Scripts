-- ESTRUTURA CASE FINALIZANDO COM END CASE E VÍRGULA EM CADA LINHA DENTRO DA ESTRUTURA
DECLARE
	v_ra  ALUNO.RA%TYPE   :=  1;
	v_nota   ALUNO.NOTA%TYPE;
	v_conceito   VARCHAR(12);
BEGIN
	SELECT nota INTO v_nota FROM ALUNO WHERE RA = v_ra;
    CASE
        WHEN  v_nota <= 5  THEN  
			v_conceito := ’REGULAR’		;
	    WHEN  v_nota < 7   THEN   
			v_conceito := ’BOM’			;
	    ELSE
	        v_conceito := ’EXCELENTE’	;
	END CASE							;
    dbms_output.put_line(’Conceito: ’ || v_conceito);
END;

-- ESTRUTURA CASE FINALIZANDO COM END E SEM VÍRGULA EM CADA LINHA DENTRO DA ESTRUTURA
DECLARE
	v_ra  ALUNO.RA%TYPE   :=  1;
	v_nota   ALUNO.NOTA%TYPE;
	v_conceito   VARCHAR(12);
BEGIN
	SELECT nota INTO v_nota FROM ALUNO WHERE RA = v_ra;
    v_conceito :=
	CASE
        WHEN  v_nota <= 5  THEN  ’REGULAR’
	    WHEN  v_nota < 7   THEN   ’BOM’
	    ELSE
			’EXCELENTE’
	END;
    dbms_output.put_line(’Conceito: ’ || v_conceito);
END;

-- ESTRUTURA WHILE
DECLARE  
	V_AUX NUMBER(2) := 0;
BEGIN
	WHILE  V_AUX < 10 LOOP
		V_AUX := V_AUX + 1;
		DBMS_OUTPUT.PUT_LINE (V_AUX);
	END LOOP;
END;

-- ESTRUTURA LOOP
DECLARE
	V_AUX NUMBER(2) := 0;
BEGIN
	LOOP
		V_AUX := V_AUX +1;
		DBMS_OUTPUT.PUT_LINE (V_AUX);
		IF V_AUX = 10 THEN 
			EXIT;
		END IF;
	END LOOP;
END;