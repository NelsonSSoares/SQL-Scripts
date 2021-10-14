use musica;
CREATE TABLE `usuario` (
  `id` int(4) PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `senha` int(50) NOT NULL
);

CREATE TABLE `musica` (
  `id` int(4) PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL
);

CREATE TABLE `playlist` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL
);

CREATE TABLE `tb_associativa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `musica_id` int,
  `playlist_id` int,
  `usuario_id` int
);

ALTER TABLE `tb_associativa` ADD FOREIGN KEY (`musica_id`) REFERENCES `musica` (`id`);

ALTER TABLE `playlist` ADD FOREIGN KEY (`id`) REFERENCES `tb_teste` (`playlist_id`);

ALTER TABLE `tb_teste` ADD FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

insert into musica values(1,'BrainWash');
insert into usuario values(0001,'123deoliveira4@gmail.com','Nelson',1234 );
insert into playlist values(1, 'BrainWash');
select * from tb_associativa;
