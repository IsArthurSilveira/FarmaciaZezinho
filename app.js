const express = require('express');
const app = express();
const path = require('path');

// Configura a pasta 'public' como estática
app.use(express.static(path.join(__dirname, 'public')));

// Configura o EJS como motor de visualização
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Rotas
app.get('/', (req, res) => {
  res.render('LoginCadastro');
});

app.get('/dashboard', (req, res) => {
    res.render('dashboard');
});

app.get('/estoque', (req, res) => {
  res.render('estoque');
});

app.get('/clientes', (req, res) => {
  res.render('clientes');
});

app.get('/relatorio', (req, res) => {
  res.render('relatorio');
});

app.get('/vendas', (req, res) => {
  res.render('vendas');
});

app.get('/configuracoes', (req, res) => {
  res.render('configuracoes');
});

// Inicia o servidor
app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});