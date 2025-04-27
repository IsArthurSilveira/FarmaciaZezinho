# EJS App

Este projeto é uma aplicação web simples utilizando EJS como motor de template. A estrutura do projeto é organizada em pastas para facilitar a manutenção e a escalabilidade.

## Estrutura do Projeto

```
ejs-app
├── public
│   ├── css
│   │   └── style.css        # Estilos CSS para a aplicação
│   ├── images
│   │   └── example.jpg      # Imagem de exemplo utilizada nas views
│   └── js
│       └── script.js        # Código JavaScript para a aplicação
├── views
│   ├── partials
│   │   ├── header.ejs       # Partial para o cabeçalho da página
│   │   └── footer.ejs       # Partial para o rodapé da página
│   ├── index.ejs            # View principal da aplicação
│   └── about.ejs            # View secundária da aplicação
├── app.js                    # Ponto de entrada da aplicação
├── package.json              # Configuração do npm
└── README.md                 # Documentação do projeto
```

## Como Usar

1. Clone o repositório:
   ```
   git clone <URL_DO_REPOSITORIO>
   ```

2. Navegue até o diretório do projeto:
   ```
   cd ejs-app
   ```

3. Instale as dependências:
   ```
   npm install
   ```

4. Inicie o servidor:
   ```
   node app.js
   ```

5. Acesse a aplicação no navegador em `http://localhost:3000`.

## Contribuição

Sinta-se à vontade para contribuir com melhorias ou correções. Crie um fork do repositório, faça suas alterações e envie um pull request.

## Licença

Este projeto está licenciado sob a MIT License. Veja o arquivo LICENSE para mais detalhes.