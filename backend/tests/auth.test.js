const request = require('supertest');
const appTest = require('../app');

describe('Autenticação e OS', () => {
  let token;

  it('deve fazer login e retornar token', async () => {
    const res = await request(appTest)
      .post('/api/login')
      .send({ email: 'teste@exemplo.com', senha: '123456' });
    expect(res.statusCode).toBe(200);
    expect(res.body.token).toBeDefined();
    token = res.body.token;
  });

  it('deve criar uma nova OS', async () => {
    const res = await request(appTest)
      .post('/api/ordens')
      .set('Authorization', token)
      .send({
        clienteId: 1,
        descricao: 'Teste de OS via API',
        tecnicoId: 1,
        prioridade: 'Alta'
      });
    expect(res.statusCode).toBe(201);
    expect(res.body.descricao).toBe('Teste de OS via API');
  });
});
