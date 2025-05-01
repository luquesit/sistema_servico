const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Usuario = sequelize.define('Usuario', {
  email: DataTypes.STRING,
  senha: DataTypes.STRING
});

module.exports = Usuario;
