--
--  ____                         ____  _____   
-- |  _ \                       |  _ \|  __ \  
-- | |_) |_ __ _   _ _ __   ___ | |_) | |  | | 
-- |  _ <| '__| | | | '_ \ / _ \|  _ <| |  | | 
-- | |_) | |  | |_| | | | | (_) | |_) | |__| | 
-- |____/|_|   \__,_|_| |_|\___/|____/|_____/  PT-BR
-- https://github.com/BMainardes/Java-Grocery-Store-Management-System
-- Criação do banco de dados para o sistema de mercado                                             
                                             

CREATE DATABASE bdmercado;

-- Seleção do banco de dados(USE)
USE bdmercado;

-- Criação da tabela de 'produtos' que serão inclusos no mercado(CREATE TABLE)
-- A coluna 'descrição' pode ser opcional dependendo do produto
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

-- Criação da tabela 'vendedor' que estarão inclusos os dados do caixa que venderá os produtos(CREATE TABLE)\
CREATE TABLE vendedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Criando a tabela 'vendas' que registra as vendas dos clientes(CREATE TABLE)
CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    vendedor_id INT,
    quantidade INT NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
     FOREIGN KEY (produto_id) REFERENCES produtos(id),
   FOREIGN KEY (vendedor_id) REFERENCES vendedor(id)

);

-- Inserção dados para teste na tabela 'produtos'(INSERT INTO)
INSERT INTO produtos (nome, descricao, preco, quantidade_estoque) VALUES
('Arroz', 'Arroz Branco Tio João 1kg', 6.00, 100),
('Feijão', 'Feijão Preto Solito 1kg', 8.99, 50),
('Açúcar', 'Açúcar Refinado Caravelas 1kg', 5.00, 80);

-- Inserindo dados para teste na tabela 'vendedor'(INSERT INTO)
INSERT INTO vendedor (nome, cpf, telefone, email) VALUES
('Bruno Vieira', '12345678901', '11999999999', 'bruno.vieira24@fatec.gov.sp.br'),
('Matheus Visoto', '09876543210', '11888888888', 'matheus@fatec.sp.gov.br'),
('Fabricio', '09876543220', '12000000000', 'fabricio@fatec.sp.gov.br');



-- Inserindo dados para teste na tabela'vendas'(INSERT INTO)
INSERT INTO vendas (produto_id, vendedor_id, quantidade, valor_total) VALUES
(1, 1, 2, 9.00),
(2, 2, 1, 6.00),
(3, 1, 3, 9.00);
