create database grafica;
use grafica;

create table grafica.pessoa(
cpf varchar(14) primary key,
nome varchar (50),
ident varchar(35),
telefone varchar (30),
rua varchar (50),
numero varchar (10),
complemento varchar (30),
bairro varchar (30),
cidade varchar (35)
);

create table grafica.cliente(
cpf_c varchar(14) primary key,
foreign key (cpf_c) references grafica.pessoa(cpf) on delete cascade
);

create table grafica.funcionario(
cpf_fu varchar(14) primary key,
data_de_admissao date,
foreign key (cpf_fu) references grafica.pessoa(cpf) on delete cascade
);

create table grafica.fornecedor(
cpf_fo  varchar(14) primary key,
foreign key (cpf_fo) references grafica.pessoa(cpf) on delete cascade
);

create table grafica.pedido(
cod_ped smallint auto_increment,
data_ped date,
data_ent date,
hora time,
cpf_c varchar(14),
cpf_fu varchar(14),
primary key (cod_ped, cpf_c, cpf_fu),
foreign key (cpf_c) references grafica.cliente(cpf_c) on delete cascade,
foreign key (cpf_fu) references grafica.funcionario(cpf_fu) on delete cascade
);

create table grafica.servicos(
cod_servico smallint primary key auto_increment,
valor_uni varchar(15)
);

create table grafica.contem(
cod_ped smallint,
cod_servico smallint,
primary key (cod_ped, cod_servico),
foreign key (cod_ped) references grafica.pedido(cod_ped) on delete cascade,
foreign key (cod_servico) references grafica.servicos(cod_servico) on delete cascade
);

create table grafica.material(
cod_material smallint primary key auto_increment,
nome_mat varchar(50),
estoque_min varchar(30),
estoque_max varchar(30),
estoque_atual varchar(30)
);

create table grafica.utiliza(
cod_servico smallint,
cod_material smallint,
primary key (cod_servico, cod_material),
foreign key (cod_servico) references grafica.servicos(cod_servico) on delete cascade,
foreign key (cod_material) references grafica.material(cod_material) on delete cascade
);


create table grafica.fornece(
cpf_fo varchar(14),
cod_material smallint,
primary key (cpf_fo, cod_material),
foreign key (cpf_fo) references grafica.fornecedor(cpf_fo) on delete cascade,
foreign key (cod_material) references grafica.material(cod_material) on delete cascade
);

-- Dados

insert into grafica.pessoa
(cpf, nome, ident, telefone, rua, numero, complemento, bairro, cidade) values
(‘084.826.530-08’, ‘Regina Leticia Hadassa Cardoso’, ‘fornecedor’, ‘(21) 98591-8183’, ‘Rua Toquio’, ‘161’, ‘casa’ , ‘Agostinho Porto’, ‘Sao Joao de Meriti’),
(‘123.909.197-40’, ‘Helena dos Santos Pereira’, ‘funcionario’, ‘(21) 98994-5289’, ‘Travessa Florianopolis’, ‘459’, ‘apt 301’ , ‘Parque Beira Mar’, ‘Duque de Caxias’),
(‘289.826.830-54’, ‘Humberto de Castro Santana’, ‘fornecedor’, ‘(21) 97994-7688’, ‘Ruan Guandu’, ‘190’, ‘casa’ , ‘Pimenteiras’, ‘Teresopolis’),
(‘222.698.470-40’, ‘Joao Certezas’, ‘funcionario’, ‘(21) 98732-9843’, ‘Rua Dona Mariana’, ‘127’, ‘apt 401’ , ‘Botafogo’, ‘Rio de Janeiro’),
(‘328.902.382-04’, ‘Joao Pedro Risaids’, ‘cliente’, ‘(21) 98732-8577’, ‘Rua Ministro Pedro’, ‘148’, ‘casa’ , ‘Pechincha’, ‘Rio de Janeiro’),
(‘516.465.372-25’, ‘Bernardo Mourao Costa’, ‘cliente’, ‘(21) 97336-0933’, ‘Estrada dos Tres Rios’, ‘4120’, ‘apt 804’ , ‘Freguesia’, ‘Rio de Janeiro’);

insert into grafica.funcionario
(cpf_fu, data_de_admissao) values
(‘123.909.197-40’, '2022-08-12'),
(‘222.698.470-40’, '2024-01-29');

insert into grafica.cliente
(cpf_c) values
(‘328.902.382-04’),
(‘516.465.372-25’);

insert into grafica.fornecedor
(cpf_fo) values
(‘084.826.530-08’),
(‘289.826.830-54’);

insert into grafica.pedido
(data_ped, data_ent, hora, cpf_c, cpf_fu) values
('2023-05-13', '2023-05-20', '10:45:54', '328.902.382-04', '123.909.197-40'),
('2024-02-03', '2024-02-10', '17:43:19', '516.465.372-25', '222.698.470-40');

insert into grafica.servicos
(valor_uni) values
('10,00'),
('20,00'),
('17,00'),
('8,00');

insert into grafica.contem
(cod_ped, cod_servico) values
('1', '1'),
('1', '3');

insert into grafica.material
(nome_mat, estoque_min, estoque_max, estoque_atual) values
('placa', '20', '100', '64'),
('adesivo', '20', '100', '24'),
('lona', '20', '100', '94');
('blackout', '20', '100', '9')

insert into grafica.fornece
(cpf_fo, cod_material) values
(‘084.826.530-08’, '1'),
(‘084.826.530-08’, '4');

-- Consultas

select * from pessoa where cidade = 'Rio de Janeiro' and ident = 'cliente';
select * from pessoa where bairro = 'Botafogo' and ident = 'funcionario';
select * from pedido where cpf_fu = '123.909.197-40' and data_ped = '2023-05-13');
select * from pedido where data_ent = '2023-05-20';
select * from servicos join contem on servicos.cod_servico = contem.cod_servico where grafica.contem.cod_ped = 1;
select * from material where cast(estoque_atual as int) < cast(estoque_min as int);
select * from material join fornece on material.cod_material = fornece.cod_material where fornece.cpf_fo = '084.826.530-08';
