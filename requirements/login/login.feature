Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
para que eu possa ver e responder enquetes de forma rápida

Cenário: Credenciais Válidas
Dado que o cliente informou credenciais válidas,
quando solicitar para fazer o login, então o sistema deve
enviar o usuário para a tela de pesquisas e mantê-lo conectado.

Cenário: Credenciais Inválidas
Dado que o cliente informou credenciais inválidas,
quando solicitar para fazer o login, então o sistema
deve retornar uma mensagem de erro.