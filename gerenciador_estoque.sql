-- Criação do banco de dados
CREATE DATABASE gerenciador_estoque;
USE gerenciador_estoque;

-- Criação da tabela categoria
CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    descricao TEXT
);

-- Criação da tabela produto
CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    quantidade INT,
    preco_compra DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

-- Criação da tabela movimentação de estoque
CREATE TABLE movimentacao_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    tipo_movimentacao ENUM('entrada', 'saida'),
    quantidade INT,
    data_movimentacao DATETIME,
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);

-- Trigger para verificar estoque baixo
DELIMITER //
CREATE TRIGGER verifica_estoque_baixo
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    IF NEW.quantidade < 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Alerta: Estoque abaixo do mínimo!';
    END IF;
END //
DELIMITER ;

-- Stored Procedure para cadastrar produto
DELIMITER //
CREATE PROCEDURE cadastrar_produto(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT,
    IN p_quantidade INT,
    IN p_preco_compra DECIMAL(10,2),
    IN p_preco_venda DECIMAL(10,2),
    IN p_categoria_id INT
)
BEGIN
    INSERT INTO produto(nome, descricao, quantidade, preco_compra, preco_venda, categoria_id)
    VALUES (p_nome, p_descricao, p_quantidade, p_preco_compra, p_preco_venda, p_categoria_id);
END //
DELIMITER ;

-- Stored Procedure para cadastrar categoria
DELIMITER //
CREATE PROCEDURE cadastrar_categoria(
    IN p_nome VARCHAR(50),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO categoria(nome, descricao)
    VALUES (p_nome, p_descricao);
END //
DELIMITER ;

-- Stored Procedure para consultar produtos
DELIMITER //
CREATE PROCEDURE consultar_produtos_por_nome(
    IN p_nome VARCHAR(100)
)
BEGIN
    SELECT * FROM produto WHERE nome LIKE CONCAT('%', p_nome, '%');
END //
DELIMITER ;

-- Stored Procedure para relatório de produtos com baixo estoque
DELIMITER //
CREATE PROCEDURE relatorio_produtos_baixo_estoque()
BEGIN
    SELECT * FROM produto WHERE quantidade < 5;
END //
DELIMITER ;

-- Stored Procedure para relatório de movimentação de estoque
DELIMITER //
CREATE PROCEDURE relatorio_movimentacao_estoque()
BEGIN
    SELECT * FROM movimentacao_estoque;
END //
DELIMITER ;

