*** Variables ***

${URL}           https://chat.gsprodutora.com.br/pt/login
${BROWSER}       Chrome
${USUARIO}       tilongevita@gmail.com
${SENHA}         Long@457

${inputemail}                xpath=//input[@name="email"]
${inputsenha}                xpath=//input[@name="password"]
${BTN_LOGIN}                 xpath=//button[@type="submit"]
${BTN_DESCONECTAR}           xpath=//button[contains(.,'Desconectar e Continuar')]

${BUSCARCHAT}                xpath=//input[contains(@placeholder,'Buscar tickets')]
${BOTAOMENU}                 xpath=//button[contains(@class, 'bg-gray-50') and contains(@class, 'text-[#022746]')]
${BOTAOCONEXOES}             xpath=//button[.//span[normalize-space()='Conexões']]   
${Desconectado}              xpath=//*[text()[normalize-space()='Desconectado']]
