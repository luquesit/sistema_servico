const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const OrdemServico = sequelize.define('OrdemServico', {
  clienteId: DataTypes.INTEGER,
  descricao: DataTypes.STRING,
  tecnicoId: DataTypes.INTEGER,
  prioridade: DataTypes.STRING,
  status: DataTypes.STRING,
  dataAbertura: DataTypes.DATE
});

module.exports = OrdemServico;
