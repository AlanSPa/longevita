*** Settings ***
Library    SeleniumLibrary
Resource   variaveis.robot
Resource   keywords.robot



*** Test Cases ***
*** Test Cases ***
Login com sucesso
    Abrir Navegador
    Preencher Credenciais
    Submeter Login
    Validar Login
    Acessar Conexoes
    ValidarConexoesCompletas
