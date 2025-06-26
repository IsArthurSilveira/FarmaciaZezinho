-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema EDITORA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EDITORA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EDITORA` DEFAULT CHARACTER SET utf8 ;
USE `EDITORA` ;

-- -----------------------------------------------------
-- Table `EDITORA`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Funcionario` (
  `CPF_Func` VARCHAR(14) NOT NULL,
  `NomeFunc` VARCHAR(45) NOT NULL,
  `sexo` CHAR NOT NULL,
  `dataNasc` DATE NOT NULL,
  `ch` INT(11) UNSIGNED NOT NULL,
  `salario` DECIMAL(7,2) ZEROFILL UNSIGNED NOT NULL,
  `dataAdm` DATE NOT NULL,
  PRIMARY KEY (`CPF_Func`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`EnderecoFunc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`EnderecoFunc` (
  `FuncionarioCPF` VARCHAR(14) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `rua` VARCHAR(70) NOT NULL,
  `numero` INT(11) NOT NULL,
  `comp` VARCHAR(45) NULL,
  `cep` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`FuncionarioCPF`),
  INDEX `fk_EnderecoFunc_Funcionario_idx` (`FuncionarioCPF` ASC) VISIBLE,
  CONSTRAINT `fk_EnderecoFunc_Funcionario`
    FOREIGN KEY (`FuncionarioCPF`)
    REFERENCES `EDITORA`.`Funcionario` (`CPF_Func`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Cargo` (
  `cbo` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `faixaSalario` DECIMAL(7,2) ZEROFILL UNSIGNED NOT NULL,
  PRIMARY KEY (`cbo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `localizacao` VARCHAR(45) NOT NULL,
  `Gerente_cpf` VARCHAR(14) NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `Gerente_cpf_idx` (`Gerente_cpf` ASC) VISIBLE,
  CONSTRAINT `Gerente_cpf`
    FOREIGN KEY (`Gerente_cpf`)
    REFERENCES `EDITORA`.`Funcionario` (`CPF_Func`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Trabalhar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Trabalhar` (
  `Cargo_cbo` INT NOT NULL,
  `Funcionario_CPF_Func` VARCHAR(14) NOT NULL,
  `Departamento_idDepartamento` INT(11) NOT NULL,
  PRIMARY KEY (`Cargo_cbo`, `Funcionario_CPF_Func`, `Departamento_idDepartamento`),
  INDEX `fk_Trabalhar_Funcionario1_idx` (`Funcionario_CPF_Func` ASC) VISIBLE,
  INDEX `fk_Trabalhar_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Trabalhar_Cargo1`
    FOREIGN KEY (`Cargo_cbo`)
    REFERENCES `EDITORA`.`Cargo` (`cbo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Trabalhar_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF_Func`)
    REFERENCES `EDITORA`.`Funcionario` (`CPF_Func`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Trabalhar_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `EDITORA`.`Departamento` (`idDepartamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Cliente` (
  `CPF_Cli` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `sexo` CHAR NOT NULL,
  PRIMARY KEY (`CPF_Cli`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Pedidos` (
  `idPedidos` INT(11) NOT NULL,
  `DataPedido` DATE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Cliente_CPF_Cli` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idPedidos`, `Cliente_CPF_Cli`),
  INDEX `fk_Pedidos_Cliente1_idx` (`Cliente_CPF_Cli` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Cliente1`
    FOREIGN KEY (`Cliente_CPF_Cli`)
    REFERENCES `EDITORA`.`Cliente` (`CPF_Cli`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `DataVenda` DATE NOT NULL,
  `valor` DECIMAL(6,2) ZEROFILL NOT NULL,
  `Desconto` DECIMAL(4,2) UNSIGNED NOT NULL,
  `Funcionario_CPF_Func` VARCHAR(14) NOT NULL,
  `Pedidos_idPedidos` INT(11) NOT NULL,
  PRIMARY KEY (`idVendas`, `Pedidos_idPedidos`),
  INDEX `fk_Vendas_Funcionario1_idx` (`Funcionario_CPF_Func` ASC) VISIBLE,
  INDEX `fk_Vendas_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF_Func`)
    REFERENCES `EDITORA`.`Funcionario` (`CPF_Func`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vendas_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `EDITORA`.`Pedidos` (`idPedidos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`FormaPag` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `parcela` INT(11) NOT NULL,
  `Vendas_idVendas` INT NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Vendas1_idx` (`Vendas_idVendas` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `EDITORA`.`Vendas` (`idVendas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`EnderecoCli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`EnderecoCli` (
  `Cliente_CPF_Cli` VARCHAR(14) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `rua` VARCHAR(70) NOT NULL,
  `numero` INT(11) NOT NULL,
  `comp` VARCHAR(45) NULL,
  `cep` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`Cliente_CPF_Cli`),
  CONSTRAINT `fk_EnderecoCli_Cliente1`
    FOREIGN KEY (`Cliente_CPF_Cli`)
    REFERENCES `EDITORA`.`Cliente` (`CPF_Cli`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Contato` (
  `idContato` INT(11) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Departamento_idDepartamento` INT(11) NULL,
  `Funcionario_CPF_Func` VARCHAR(14) NULL,
  `Cliente_CPF_Cli` VARCHAR(14) NULL,
  PRIMARY KEY (`idContato`),
  INDEX `fk_Contato_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_Contato_Funcionario1_idx` (`Funcionario_CPF_Func` ASC) VISIBLE,
  INDEX `fk_Contato_Cliente1_idx` (`Cliente_CPF_Cli` ASC) VISIBLE,
  CONSTRAINT `fk_Contato_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `EDITORA`.`Departamento` (`idDepartamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Contato_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF_Func`)
    REFERENCES `EDITORA`.`Funcionario` (`CPF_Func`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Contato_Cliente1`
    FOREIGN KEY (`Cliente_CPF_Cli`)
    REFERENCES `EDITORA`.`Cliente` (`CPF_Cli`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`AreaConhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`AreaConhecimento` (
  `idAreaConhecimento` INT(11) NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(500) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAreaConhecimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Livros` (
  `ISBN` VARCHAR(13) NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `data_publicacao` DATE NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `Npaginas` INT(4) NOT NULL,
  `Descricao` VARCHAR(500) NOT NULL,
  `AreaConhecimento_idAreaConhecimento` INT(11) NOT NULL,
  PRIMARY KEY (`ISBN`, `AreaConhecimento_idAreaConhecimento`),
  INDEX `fk_Livros_AreaConhecimento1_idx` (`AreaConhecimento_idAreaConhecimento` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_AreaConhecimento1`
    FOREIGN KEY (`AreaConhecimento_idAreaConhecimento`)
    REFERENCES `EDITORA`.`AreaConhecimento` (`idAreaConhecimento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Exemplar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Exemplar` (
  `NumeroSerie` INT(11) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Localizacao` VARCHAR(45) NOT NULL,
  `Livros_ISBN` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`NumeroSerie`, `Livros_ISBN`),
  INDEX `fk_Exemplar_Livros1_idx` (`Livros_ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_Exemplar_Livros1`
    FOREIGN KEY (`Livros_ISBN`)
    REFERENCES `EDITORA`.`Livros` (`ISBN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`PedidoExemplares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`PedidoExemplares` (
  `Exemplar_NumeroSerie` INT(11) NOT NULL,
  `Pedidos_idPedidos` INT(11) NOT NULL,
  PRIMARY KEY (`Exemplar_NumeroSerie`, `Pedidos_idPedidos`),
  INDEX `fk_PedidoExemplares_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  CONSTRAINT `fk_PedidoExemplares_Exemplar1`
    FOREIGN KEY (`Exemplar_NumeroSerie`)
    REFERENCES `EDITORA`.`Exemplar` (`NumeroSerie`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PedidoExemplares_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `EDITORA`.`Pedidos` (`idPedidos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`PalavraChave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`PalavraChave` (
  `idPalavraChave` INT(11) NOT NULL AUTO_INCREMENT,
  `Palavra` VARCHAR(45) NOT NULL,
  `Significado` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`idPalavraChave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`LivroPalavras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`LivroPalavras` (
  `PalavraChave_idPalavraChave` INT(11) NOT NULL,
  `Livros_ISBN` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`PalavraChave_idPalavraChave`, `Livros_ISBN`),
  INDEX `fk_LivroPalavras_Livros1_idx` (`Livros_ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_LivroPalavras_PalavraChave1`
    FOREIGN KEY (`PalavraChave_idPalavraChave`)
    REFERENCES `EDITORA`.`PalavraChave` (`idPalavraChave`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LivroPalavras_Livros1`
    FOREIGN KEY (`Livros_ISBN`)
    REFERENCES `EDITORA`.`Livros` (`ISBN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`Autor` (
  `CPF_Autor` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Biografia` VARCHAR(450) NOT NULL,
  `Nacionalidade` VARCHAR(45) NOT NULL,
  `DataNasc` DATE NOT NULL,
  PRIMARY KEY (`CPF_Autor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDITORA`.`LivroAutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORA`.`LivroAutores` (
  `Autor_CPF_Autor` VARCHAR(14) NOT NULL,
  `Livros_ISBN` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Autor_CPF_Autor`, `Livros_ISBN`),
  INDEX `fk_LivroAutores_Livros1_idx` (`Livros_ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_LivroAutores_Autor1`
    FOREIGN KEY (`Autor_CPF_Autor`)
    REFERENCES `EDITORA`.`Autor` (`CPF_Autor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LivroAutores_Livros1`
    FOREIGN KEY (`Livros_ISBN`)
    REFERENCES `EDITORA`.`Livros` (`ISBN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET SQL_SAFE_UPDATES = 0;
