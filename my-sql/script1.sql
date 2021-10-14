
CREATE DATABASE resilia_m3;
set autocommit=0;
USE resilia_m3;
CREATE TABLE resilientes(
	`id` int primary key auto_increment,
    `nome` varchar(255),
    `CPF` varchar(11),
    `turma` int
);

CREATE TABLE facilitadores(
`id` int ,
`nome` varchar(255),
`CPF` varchar(11),
`frente` varchar(4)
);

create table turma7(
    foreign key (id_facilitador) REFERENCES facilitador(id),
    foreign key (id_resilientes) REFERENCES resilientes(id)
);

insert into resilientes values(1,'Juarez',98765432101,7);
insert into resilientes values(2,'Maria',98765432102,7);
select * from turma7;

alter table `resilia_m3`.`resilientes` 
change column `turma` `turma` int not null ;

alter table resilia_m3.facilitadores
change column nome nome varchar(255) not null,
change column CPF CPF	varchar(11) not null,
change column frente frente varchar(4) not null;


insert into facilitadores values(2,'Angelo',12345678910,'Tech');

update facilitadores set nome = 'Noeme' where id = 2; 

insert into facilitadores values(3,'Angelo',12345678910,'Tech');

update facilitadores set frente = 'Soft' where id = 3;

##insert id, nome, cpf, frente into var1, var2, var3, var4  from facilitadores;

select* from facilitadores;

delete from facilitadores where id = 3;

delete from resilientes where id = 2;

delete from resilientes where id = 1;
USE resilia_m3;
select * from resilientes;

