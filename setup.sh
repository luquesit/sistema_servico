#!/bin/bash

echo "📥 Clonando repositório..."
git clone https://github.com/seu-usuario/seu-repo.git sistema-servico
cd sistema-servico

echo "⚙️ Instalando dependências do backend..."
cd backend
cp .env.example .env 2>/dev/null
npm install

echo "📦 Rodando migrações e criando tabelas..."
# ajuste conforme sua configuração do Sequelize ou ORM
npx sequelize db:create
npx sequelize db:migrate

echo "🚀 Iniciando servidor backend..."
npm run dev &

cd ../frontend

echo "🌐 Instalando dependências do frontend..."
npm install

echo "💡 Iniciando frontend..."
npm run dev
