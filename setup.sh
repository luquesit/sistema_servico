#!/bin/bash

# setup.sh - Script de instalação para sistema_servico
# Autor: Seu Nome
# Data: 24/05/2025

set -e  # Encerra o script se ocorrer algum erro

# Função para exibir mensagens de erro
erro() {
  echo "❌ Erro: $1"
  exit 1
}

# Função para exibir mensagens de sucesso
sucesso() {
  echo "✅ Sucesso: $1"
}

# Verifica se o script está sendo executado com permissões de superusuário
if [ "$EUID" -ne 0 ]; then
  erro "Este script deve ser executado como root. Use 'sudo ./setup.sh'"
fi

# Verifica se o Git está instalado
if ! command -v git &> /dev/null; then
  erro "Git não está instalado. Por favor, instale o Git e tente novamente."
fi

# Verifica se o Python 3 está instalado
if ! command -v python3 &> /dev/null; then
  erro "Python 3 não está instalado. Por favor, instale o Python 3 e tente novamente."
fi

# Verifica se o pip3 está instalado
if ! command -v pip3 &> /dev/null; then
  erro "pip3 não está instalado. Por favor, instale o pip3 e tente novamente."
fi

# Clona o repositório
echo "🔄 Clonando o repositório..."
git clone https://github.com/luquesit/sistema_servico.git || erro "Falha ao clonar o repositório."

cd sistema_servico || erro "Diretório 'sistema_servico' não encontrado."

# Instala dependências do sistema
echo "📦 Instalando dependências do sistema..."
apt-get update && apt-get install -y python3-venv python3-pip || erro "Falha ao instalar dependências do sistema."

# Cria e ativa o ambiente virtual
echo "🐍 Criando ambiente virtual..."
python3 -m venv venv || erro "Falha ao criar o ambiente virtual."
source venv/bin/activate || erro "Falha ao ativar o ambiente virtual."

# Instala dependências do projeto
if [ -f requirements.txt ]; then
  echo "📦 Instalando dependências do projeto..."
  pip install --upgrade pip
  pip install -r requirements.txt || erro "Falha ao instalar dependências do projeto."
else
  echo "⚠️ Arquivo requirements.txt não encontrado. Pulando instalação de dependências do projeto."
fi

# Configurações adicionais (exemplo: migrações de banco de dados)
# echo "⚙️ Executando migrações do banco de dados..."
# python manage.py migrate || erro "Falha ao executar migrações."

# Instruções finais
sucesso "Instalação concluída com sucesso!"
echo "Para iniciar o serviço, execute:"
echo "source venv/bin/activate"
echo "python app.py"

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
