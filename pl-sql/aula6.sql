-- CURSOR IMPLICITO 

-- EXEMPLO DE USO DO CURSOR IMPLÍCITO

DECLARE
	V_VENDA		FORNECEDOR.VENDA%TYPE := &VALOR_VENDA				;
BEGIN
	UPDATE FORNECEDOR
	SET
	VENDA = V_VENDA + VENDA								
	WHERE ESTRELA > 5												;
	IF SQL%FOUND THEN
		DBMS_OUTPUT.PUT_LINE('REGISTRO(S) ATUALIZADO(S) COM SUCESSO!')	;
	ELSE
		DBMS_OUTPUT.PUT_LINE('REGISTROS NÃO ENCONTRADOS PARA ATUALIZAÇÃO!');
	END IF;	
END;

-- PARAMETROS DENTRO DO CURSOR

DECLARE
	CURSOR c_emp (p_Dept emp.deptno%TYPE, p_Job emp.job%TYPE) IS
	SELECT * FROM emp WHERE deptno = p_Dept and job = p_Job;
	v_emp    c_emp%rowtype;
BEGIN
	OPEN c_emp(&DEPT,  '&CARGO');
	LOOP
    	 	FETCH c_emp INTO v_emp;
     	 	EXIT when c_emp%notfound;
     	 	DBMS_OUTPUT.PUT_LINE('Nome Empreg: ' || v_emp.ename);
	END LOOP;
	CLOSE c_emp;
END;

-- PROCEDURE - FUNCTIONS
-- CRIA OU SUBSTITUI SE EXISTIR PROCEDURE

DECLARE
	v_1 	NUMBER(4)  :=  &VALOR_1	;	
	v_2 	NUMBER(4)  :=  &VALOR_2	;
	v_t		NUMBER(4)         		;
BEGIN
	SOMA (v_1, v_2, v_t);
END;

--------------

CREATE OR REPLACE PROCEDURE soma 
	(
	  p_1 IN NUMBER,  p_2 IN NUMBER,  p_t OUT NUMBER
	)
IS
BEGIN
	p_t := p_1 + p_2;
	DBMS_OUTPUT.PUT_LINE(p_1 || ' + ' || p_2 || ' = ' || p_t);
END soma;
/

----------------

DECLARE
    v_phone_no  varchar(15) := '&v_phone_no';
BEGIN
    formata_telefone (v_phone_no);
END;

-----------------

CREATE OR REPLACE PROCEDURE formata_telefone
	(v_phone_no 	IN OUT 	varchar)
IS
BEGIN
	v_phone_no := SUBSTR (v_phone_no,1,5) || '-' || SUBSTR (v_phone_no,6,4);
	Dbms_output.put_line('Telefone:  ' || v_phone_no);
END formata_telefone;

934567890

93456-7890

DECLARE
    v_emp emp.empno%type := &v_emp;
BEGIN
    pesquisa_empregado(v_emp);
END;
/
-------------

EXECUTE PESQUISA_EMPREGADO(7782);

---------------

CREATE OR REPLACE PROCEDURE pesquisa_empregado
	( 
		v_emp_no 	IN 	emp.empno%TYPE
	)
IS
	v_emp_name 	 	emp.ename%TYPE;
	v_emp_sal 	 	emp.sal%TYPE;
	v_emp_comm 	 	emp.comm%TYPE;
BEGIN
	SELECT 	ename, 		sal, 		comm
	INTO 	v_emp_name, v_emp_sal, 	v_emp_comm 
	FROM 	emp 
	WHERE 	empno = v_emp_no;
	DBMS_OUTPUT.PUT_LINE('Nome:  ' || v_emp_name || ' - Salario: ' || v_emp_sal || ' - Comissao: ' || v_emp_comm);
END pesquisa_empregado;

-----------------

CREATE OR REPLACE PROCEDURE novos_empregados
	(
		v_emp_no 		IN 	emp.empno%TYPE		,
		v_emp_name 		IN 	emp.ename%TYPE		,
		v_emp_job 		IN 	emp.job%TYPE		,
		v_emp_hiredate	IN 	emp.hiredate%TYPE	,
		v_emp_sal 		IN 	emp.sal%TYPE		,
		v_dept_no 		IN 	emp.deptno%TYPE
	)
IS
BEGIN
	INSERT INTO emp (empno, ename, job,  hiredate, sal, deptno )
	VALUES
	(v_emp_no, v_emp_name, v_emp_job, v_emp_hiredate, v_emp_sal, v_dept_no);
	COMMIT;
END novos_empregados;






