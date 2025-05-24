#!/bin/bash

echo "🚀 Iniciando instalação do Stack..."

# Pergunta pelo nome do projeto
read -p "Digite o nome do projeto: " PROJECT_NAME

echo "📁 Criando pastas de projeto: frontend e backend..."
mkdir $PROJECT_NAME
cd $PROJECT_NAME
mkdir frontend backend
cd frontend

echo "⚛️ Instalando Frontend: React + Vite + Tailwind CSS..."
npm create vite@latest . -- --template react
npm install
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

echo "✅ Configurando Tailwind..."
echo "module.exports = { content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'], theme: { extend: {}, }, plugins: [], }" > tailwind.config.js

echo "@tailwind base;\n@tailwind components;\n@tailwind utilities;" > src/index.css

echo "✅ Frontend pronto."

cd ../backend

echo "🟢 Instalando Backend: Node.js + Express..."
npm init -y
npm install express dotenv jsonwebtoken bcryptjs cors morgan
npm install prisma --save-dev
npx prisma init

echo "✅ Backend pronto com Prisma e Express."

echo "📦 Instalando Cloudinary..."
npm install cloudinary

echo "🔥 Instalando Firebase Admin SDK..."
npm install firebase-admin

echo "📄 Criando estrutura de pastas no backend..."
mkdir src
cd src
mkdir routes controllers middlewares services config
touch app.js server.js

echo "✅ Estrutura criada."

echo "🔐 Configurando .env exemplo..."
cd ..
touch .env.example
echo "DATABASE_URL=postgresql://user:password@localhost:5432/dbname\nJWT_SECRET=your_jwt_secret\nCLOUDINARY_CLOUD_NAME=your_cloud_name\nCLOUDINARY_API_KEY=your_api_key\nCLOUDINARY_API_SECRET=your_api_secret\nFIREBASE_PROJECT_ID=your_project_id\nGOOGLE_MAPS_API_KEY=your_google_maps_api_key" > .env.example

echo "✅ Arquivo .env.example criado."

cd ..

echo "✅ Instalando dependências globais úteis..."
npm install -g nodemon

echo "✅ Instalando dependências concluído."

echo "🚨 Lembre-se de: "
echo "1. Configurar a chave da API do Google Maps: https://console.cloud.google.com/apis"
echo "2. Configurar o Firebase: https://console.firebase.google.com/"
echo "3. Configurar o Cloudinary: https://cloudinary.com/console"
echo "4. Criar workflow do GitHub Actions para CI/CD:"
echo "
name: Node.js CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
    - run: npm install
    - run: npm run build
    - run: npm test
"

echo "5. Criar conta e deploy no Railway: https://railway.app/"

echo "✅ Tudo pronto! Agora entre nas pastas 'frontend' e 'backend' e comece a desenvolver!"


