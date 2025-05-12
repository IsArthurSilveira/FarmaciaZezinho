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
  res.render('dashboard');
});

app.get('/about', (req, res) => {
    res.render('about');
});

// Inicia o servidor
app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});