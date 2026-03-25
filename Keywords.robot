*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   variaveis.robot
Library    Collections


*** Keywords ***
Abrir Navegador

    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${INPUT_EMAIL}    timeout=20s

Abrir Navegador Whatsapp
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    Evaluate    $options.add_experimental_option("debuggerAddress", "127.0.0.1:9222")

    Create Webdriver    Chrome    options=${options}

    Go To    ${URL}
    Maximize Browser Window
    Wait Until Element Is Visible    ${INPUT_EMAIL}    timeout=20s

Clicar no item
    [Arguments]    ${elemento}
    Wait Until Element Is Visible    ${elemento}    10s
    Wait Until Element Is Enabled    ${elemento}    10s
    Click Element     ${elemento}


Preencher Credenciais
    Input Text    ${inputemail}    ${USUARIO}
    Input Text    ${inputsenha}    ${SENHA}

Submeter Login
    Clicar no item    ${BTN_LOGIN}
    ${existe}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//button[contains(.,'Desconectar e Continuar')]    timeout=5s
    IF    ${existe}
        Click Element    xpath=//button[contains(.,'Desconectar e Continuar')]
    END

Validar Login
    Wait Until Page Contains Element    ${BUSCARCHAT}    timeout=15s
    Capture Page Screenshot

Acessar Conexoes
    Clicar no item    ${BOTAOMENU}
    Clicar no item    ${BOTAOCONEXOES}


ValidarConexoesCompletas
    Sleep    10
    Wait Until Page Contains Element    xpath=//p[contains(@class,'text-sm')]    10s

    # Pega todos os números conectados
    ${lista_conectados}=    SeleniumLibrary.Execute Javascript    return Array.from(document.querySelectorAll("div.rounded-2xl")).map(function(card) { var numeroEl = card.querySelector("p"); var numero = numeroEl ? numeroEl.innerText.trim() : ""; var statusEl = Array.from(card.querySelectorAll("span")).find(function(s) { return s.innerText.includes("Conectado"); }); if(statusEl && numero !== "") return numero; }).filter(Boolean)

    ${lista_formatada}=    Create List
    FOR    ${numero}    IN    @{lista_conectados}
        ${numero_formatado}=    Set Variable    ${numero[0:2]} (${numero[2:4]}) ${numero[4:8]}-${numero[8:]}
        Append To List    ${lista_formatada}    ${numero_formatado}
    END

    ${qtd_desconectados}=    SeleniumLibrary.Execute Javascript    return Array.from(document.querySelectorAll("div.rounded-2xl")).filter(function(card) { var statusEl = Array.from(card.querySelectorAll("span")).find(function(s) { return s.innerText.includes("Desconectado"); }); return statusEl ? true : false; }).length


    ${mensagem}=    Set Variable    Números *ONLINE*:%0A
    FOR    ${numero}    IN    @{lista_formatada}
        ${mensagem}=    Catenate    SEPARATOR=    ${mensagem}${numero}%0A
    END
    ${mensagem}=    Catenate    SEPARATOR=    *CONEXOES WHATSAPP*%0A%0A${mensagem}%0AExistem ${qtd_desconectados} números *OFFLINE*

    ${mensagem_url}=    Replace String    ${mensagem}    ${SPACE}    %20

    # Abre WhatsApp Web na sessão existente
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Evaluate    $options.add_experimental_option("debuggerAddress", "127.0.0.1:9222")
    Create Webdriver    Chrome    options=${options}    alias=whatsapp
    Switch Browser    whatsapp

    Go To    https://web.whatsapp.com/send?phone=558194013405&text=${mensagem_url}

    Sleep    20

    Execute JavaScript    var input=document.querySelector("footer div[contenteditable='true']"); input.focus();
    Sleep    1
    Execute JavaScript    var input=document.querySelector("footer div[contenteditable='true']"); var evt=new KeyboardEvent('keydown',{key:'Enter',code:'Enter',which:13,keyCode:13,bubbles:true}); input.dispatchEvent(evt);
    Sleep    2

    Switch Browser    1
