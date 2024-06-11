-- Copiando estrutura do banco de dados para bdmercado
CREATE DATABASE IF NOT EXISTS `bdmercado` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `bdmercado`;

-- Copiando estrutura para tabela bdmercado.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela bdmercado.admin: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bdmercado.produtos
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade_estoque` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela bdmercado.produtos: ~3 rows (aproximadamente)
INSERT INTO `produtos` (`id`, `nome`, `descricao`, `preco`, `quantidade_estoque`) VALUES
	(1, 'Arroz', 'Arroz Branco Tio João 1kg', 6.00, 100),
	(2, 'Feijão', 'Feijão Preto Solito 1kg', 8.99, 50),
	(3, 'Açúcar', 'Açúcar Refinado Caravelas 1kg', 5.00, 80);

-- Copiando estrutura para tabela bdmercado.vendas
CREATE TABLE IF NOT EXISTS `vendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendedor_id` int(11) DEFAULT NULL,
  `nome_cliente` varchar(100) DEFAULT NULL,
  `data_venda` datetime DEFAULT current_timestamp(),
  `valor_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vendedor_id` (`vendedor_id`),
  CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela bdmercado.vendas: ~3 rows (aproximadamente)
INSERT INTO `vendas` (`id`, `vendedor_id`, `nome_cliente`, `data_venda`, `valor_total`) VALUES
	(1, 1, NULL, '2024-06-08 16:42:59', 22.00),
	(2, 2, NULL, '2024-06-08 16:42:59', 8.99),
	(3, 1, NULL, '2024-06-08 16:42:59', 15.00);

-- Copiando estrutura para tabela bdmercado.venda_produto
CREATE TABLE IF NOT EXISTS `venda_produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_id` int(11) DEFAULT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `venda_id` (`venda_id`),
  KEY `produto_id` (`produto_id`),
  CONSTRAINT `venda_produto_ibfk_1` FOREIGN KEY (`venda_id`) REFERENCES `vendas` (`id`),
  CONSTRAINT `venda_produto_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela bdmercado.venda_produto: ~4 rows (aproximadamente)
INSERT INTO `venda_produto` (`id`, `venda_id`, `produto_id`, `quantidade`) VALUES
	(1, 1, 1, 2),
	(2, 1, 3, 2),
	(3, 2, 2, 1),
	(4, 3, 3, 3);

-- Copiando estrutura para tabela bdmercado.vendedor
CREATE TABLE IF NOT EXISTS `vendedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela bdmercado.vendedor: ~3 rows (aproximadamente)
INSERT INTO `vendedor` (`id`, `nome`, `cpf`, `telefone`, `email`) VALUES
	(1, 'Bruno Vieira', '12345678901', '11999999999', 'bruno.vieira24@fatec.gov.sp.br'),
	(2, 'Matheus Visoto', '09876543210', '11888888888', 'matheus@fatec.sp.gov.br'),
	(3, 'Fabricio', '09876543220', '12000000000', 'fabricio@fatec.sp.gov.br');

-- Criando o gatilho after_venda_produto_insert para atualizar a quantidade em estoque
DELIMITER //

CREATE TRIGGER after_venda_produto_insert
AFTER INSERT ON venda_produto
FOR EACH ROW
BEGIN
    -- Atualiza a quantidade de estoque na tabela produtos
    UPDATE produtos
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade
    WHERE id = NEW.produto_id;
END;

//

DELIMITER ;
