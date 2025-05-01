const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const SECRET_KEY = 'chave_secreta_segura';
const { OrdemServico, Usuario } = require('./models');

app.use(bodyParser.json());

// Middleware de autenticação JWT
function authenticate(req, res, next) {
  const token = req.headers['authorization'];
  if (!token) return res.status(401).json({ erro: 'Token não fornecido' });
  jwt.verify(token, SECRET_KEY, (err, decoded) => {
    if (err) return res.status(403).json({ erro: 'Token inválido' });
    req.usuarioId = decoded.id;
    next();
  });
}

// Rota para login (gera token)
app.post('/api/login', async (req, res) => {
  const { email, senha } = req.body;
  const usuario = await Usuario.findOne({ where: { email } });
  if (!usuario || usuario.senha !== senha) {
    return res.status(401).json({ erro: 'Credenciais inválidas' });
  }
  const token = jwt.sign({ id: usuario.id }, SECRET_KEY, { expiresIn: '8h' });
  res.json({ token });
});

// Rota protegida para criação de OS
app.post('/api/ordens', authenticate, async (req, res) => {
  const { clienteId, descricao, tecnicoId, prioridade } = req.body;
  try {
    const ordem = await OrdemServico.create({
      clienteId,
      descricao,
      tecnicoId,
      prioridade,
      status: 'Aberto',
      dataAbertura: new Date()
    });
    res.status(201).json(ordem);
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao criar ordem de serviço' });
  }
});

module.exports = app;
