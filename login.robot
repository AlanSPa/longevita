*** Settings ***
Library    SeleniumLibrary
Resource   pages/variaveis.robot
Resource   pages/keywords.robot



*** Test Cases ***
*** Test Cases ***
Login com sucesso
    Abrir Navegador
    Preencher Credenciais
    Submeter Login
    Validar Login
    Acessar Conexoes
    ValidarConexoesCompletas
