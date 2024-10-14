create database locadora; 
use locadora; 

create table locadora.pessoa( 
cpf varchar (11) primary key, 
nome varchar (100), 
funcao enum ('funcionario', 'cliente', 'fornecedor'), 
telefone varchar (11), 
rua varchar (50), 
numero int (7),  
bairro varchar (30),
constraint cpf_numeric check (cpf regexp '^[0-9]{11}$'),
constraint telefone_numeric check (telefone regexp '^[0-9]{11}$')
);

create table locadora.cliente(
cpf_cli varchar (11) primary key, 
foreign key (cpf_cli) references locadora.pessoa(cpf) on delete cascade 
); 

create table locadora.funcionario(
cpf_fun varchar (11) primary key, 
foreign key (cpf_fun) references locadora.pessoa(cpf) on delete cascade 
);

create table locadora.fornecedor(
cpf_for varchar (11) primary key, 
foreign key (cpf_for) references locadora.pessoa(cpf) on delete cascade 
);

create table locadora.jogos(
cod_jogo smallint primary key auto_increment,
nome varchar (100),
estado enum ('novo', 'usado'),
geracao enum ('primeira', 'segunda', 'terceira'),
valor enum ('3,00', '5,00', '7,00')
);

create table locadora.pedido( 
cod_ped smallint auto_increment, 
data_ped date, 
data_ent date, 
hora time, 
cpf_cli varchar (11), 
cpf_fun varchar (11), 
primary key (cod_ped, cpf_cli, cpf_fun), 
foreign key (cpf_cli) references locadora.cliente(cpf_cli) on delete cascade, 
foreign key (cpf_fun) references locadora.funcionario(cpf_fun) on delete cascade 
);

create table locadora.fornece( 
cpf_for varchar (11), 
cod_jogo smallint, 
primary key (cpf_for, cod_jogo), 
foreign key (cpf_for) references locadora.fornecedor(cpf_for) on delete cascade, 
foreign key (cod_jogo) references locadora.jogos(cod_jogo) on delete cascade 
); 

create table locadora.contem( 
cod_ped smallint, 
cod_jogo smallint, 
primary key (cod_ped, cod_jogo), 
foreign key (cod_ped) references locadora.pedido(cod_ped) on delete cascade, 
foreign key (cod_jogo) references locadora.jogos(cod_jogo) on delete cascade 
);

-- Inserção de Dados

insert into locadora.pessoa 
(cpf, nome, funcao, telefone, rua, numero, bairro) values 
(‘10172150060’, ‘Renan Martins Pereira’, ‘cliente’, ‘21985992183’, ‘Avenida Mário Rocha’, ‘11’, ‘Pechincha’),
(‘97384029456’, ‘Joao Pedro Galhardi’, ‘cliente’, ‘21995034907’, ‘Rua Princesa’, ‘468’, ‘Portuguesa’),
(‘23597794009’, ‘Joao Gabriel Costa’, ‘funcionario’, ‘21975664980’, ‘Rua Atum’, ‘81’, ‘Anil’),
(‘96295690009’, ‘Maria Eduarda Costa’, ‘funcionario’, ‘21986456224’, ‘Estrada dos Bandeirantes’, ‘6700’, ‘Recreio’),
(‘78903218051’, ‘Felipe Reed Maia’, ‘fornecedor’, ‘21997928788’, ‘Rua Paturi’, ‘875’, ‘Tanque’),
(‘21753526094’, ‘Matheus Araujo Cruz’, ‘fornecedor’, ‘21978658943’, ‘Rua Coronel Cunha Leal’, ‘253’, ‘Engenho de Dentro’);

insert into locadora.funcionario
(cpf_fun) values
(‘23597794009’),
(‘96295690009’);

insert into locadora.cliente
(cpf_cli) values
(‘10172150060’),
(‘97384029456’);

insert into locadora.fornecedor
(cpf_for) values
(‘78903218051’),
(‘21753526094’);

insert into locadora.jogos
(nome, estado, geracao, valor) values
('The Legend of Zelda', 'usado', 'primeira', '3,00'),
('The Last of Us', 'novo', 'terceira', '7,00'),
('Red Dead Redemption', 'usado', 'terceira', '7,00'),
('GTA IV', 'novo', 'segunda', '5,00'),
('God of War', 'usado', 'segunda', '5,00'),
('Super Mario Bros', 'usado', 'primeira', '3,00');

insert into locadora.pedido
(data_ped, data_ent, hora, cpf_cli, cpf_fun) values
('2024-02-03', '2024-02-10', '10:45:54', ‘10172150060’, ‘23597794009’),
('2024-02-07', '2024-02-14', '15:17:51', ‘97384029456’, ‘96295690009’);

insert into locadora.fornece
(cpf_for, cod_jogo) values
(‘78903218051’, '1'),
(‘78903218051’, '3'),
(‘78903218051’, '5'),
(‘21753526094’, '2'),
(‘21753526094’, '4'),
(‘21753526094’, '6');

insert into locadora.contem
(cod_ped, cod_jogo) values
('1', '1'),
('1', '3'),
('2', '2'),
('2', '4'),
('2', '5'),
('2', '6');
