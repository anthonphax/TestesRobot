*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***
${BROWSER}   firefox
${SELSPEED}  0.0s

*** Keywords ***
Abrir Navegador
	Modificar URL
	Open Browser			${url}		   chrome				options=add_argument("--disable-gpu"); add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--ignore-certificate-errors");add_argument("--ignore-ssl-errors")
	# Open Browser			${url}		   chrome				options=add_argument("--disable-gpu"); add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--ignore-certificate-errors");add_argument("--ignore-ssl-errors")
    Set Window Size         1920           1080
    Register Keyword To Run On Failure     NONE

Modificar URL
    ${bool_url}=                           Run Keyword and Return Status        Should Not End With     ${url}     /
    IF  '${bool_url}' == 'False'
        ${url}=                            Get Substring                        ${url}                  0          -1
        Set Global Variable                ${url}
    END

open
    [Arguments]    ${element}
    Go To          ${element}

click
    [Arguments]    ${element}
    Wait Until Element Is Visible        ${element}        timeout=20s
    Click Element  ${element}

sendKeys
    [Arguments]    ${element}    ${value}
    Press Keys     ${element}    ${value}

submit
    [Arguments]    ${element}
    Submit Form    ${element}

type
    [Arguments]    ${element}    ${value}
    Input Text     ${element}    ${value}

selectAndWait
    [Arguments]        ${element}  ${value}
    Select From List By Value   ${element}  ${value}

select
    [Arguments]        ${element}  ${value}
    Select From List By Value   ${element}  ${value}

verifyValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

verifyTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertConfirmation
    [Arguments]                  ${value}
    Alert Should Be Present      ${value}

assertText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

assertTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

waitForTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

doubleClick
    [Arguments]           ${element}
    Double Click Element  ${element}

doubleClickAndWait
    [Arguments]           ${element}
    Double Click Element  ${element}

goBack
    Go Back

goBackAndWait
    Go Back

runScript
    [Arguments]         ${code}
    Execute Javascript  ${code}

runScriptAndWait
    [Arguments]         ${code}
    Execute Javascript  ${code}

setSpeed
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

setSpeedAndWait
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

verifyAlert
    [Arguments]              ${value}
    Alert Should Be Present  ${value}

covertToNumber
    [Arguments]              ${value}
    TRY
        ${value}=    Evaluate    int(re.search("\\d+$","${value}")[0])     modules=re
    EXCEPT    
        Log To Console        falha ao converter valor ${value}
    END
    RETURN                   ${value}

compareValues
    [Arguments]              ${value1}    ${value2}
    ${igualdade}=            Run Keyword And Return Status    Should Be Equal    ${value1}      ${value2}
    IF    ${igualdade}
        Log     Valores são Iguais
    ELSE
        Fail    Valores não são iguais
    END
    