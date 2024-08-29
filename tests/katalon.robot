*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${BROWSER}   firefox
${SELSPEED}  0.0s

*** Test Cases ***
Untitled Test Case
    [Setup]  Run Keywords  Open Browser  http://www.automationpractice.pl  ${BROWSER}
    ...              AND   Set Selenium Speed  ${SELSPEED}
    # open    http://www.automationpractice.pl
    click    link=Blouses
    click    xpath=//div[@id='center_column']/ul/li/div/div[2]/div[2]/a/span
    click    id=availability_value
    click    id=availability_value
    doubleClick    id=availability_value
    click    id=availability_value
    click    id=color_8
    click    xpath=//div[@id='center_column']/div/div
    click    xpath=//p[@id='add_to_cart']/button/span
    click    xpath=//div[@id='layer_cart']/div/div[2]/div[4]/a/span
    click    id=total_product_price_2_8_0
    doubleClick    id=total_product_price_2_8_0
    click    xpath=//div[@id='page']/div[2]
    click    xpath=//tr[@id='product_2_8_0_0']/td[7]
    click    xpath=//div[@id='center_column']/p[2]/a/span
    click    xpath=//button[@id='SubmitCreate']/span
    click    xpath=//form[@id='create-account_form']/div
    click    id=create_account_error
    click    id=email_create
    type    id=email_create    teste1@teste.br
    submit    id=create-account_form
    click    id=customer_firstname
    type    id=customer_firstname    tester
    type    id=customer_lastname    tester
    click    id=id_gender1
    click    id=passwd
    type    id=passwd    123123
    click    xpath=//form[@id='account-creation_form']/div/div[7]
    click    id=days
    select    id=days    regexp:7\s+
    click    xpath=//option[@value='7']
    click    id=months
    select    id=months    regexp:July\s
    click    xpath=//select[@id='months']/option[8]
    click    id=years
    select    id=years    regexp:2014\s+
    click    xpath=//option[@value='2014']
    click    xpath=//button[@id='submitAccount']/span
    click    xpath=//form[@id='add_address']/div[9]
    click    xpath=//button[@id='submitAddress']/span
    click    xpath=//div[@id='center_column']/div/div/ol/li[5]
    click    xpath=//form[@id='add_address']/div[4]
    click    id=firstname
    click    id=company
    type    id=company    Bis2bis
    click    id=address1
    type    id=address1    r. fantasma
    click    id=address2
    type    id=address2    123
    click    id=city
    type    id=city    Ldn
    click    xpath=//form[@id='add_address']/div[7]
    click    id=id_state
    select    id=id_state    Idaho
    click    xpath=//option[@value='12']
    click    id=postcode
    click    xpath=//select[@id='id_country']/option
    click    id=phone
    type    id=phone    123123123123
    click    id=phone_mobile
    type    id=phone_mobile    1231231231
    click    id=other
    type    id=other    131231231
    click    id=alias
    click    xpath=//button[@id='submitAddress']/span
    click    xpath=//div[@id='center_column']/div/div
    click    id=postcode
    type    id=postcode    1
    click    xpath=//button[@id='submitAddress']/span
    click    xpath=//div[@id='center_column']/div/div
    click    id=postcode
    type    id=postcode    11122
    click    xpath=//button[@id='submitAddress']/span
    click    xpath=//div[@id='center_column']/form/p/button/span
    click    xpath=//form[@id='form']/div/div[2]/div/div/div/table/tbody/tr/td[4]
    click    xpath=//form[@id='form']/p/button/span
    click    xpath=//body[@id='order']/div[2]/div/div/a
    click    id=cgv
    click    xpath=//form[@id='form']/p/button/span
    click    link=Pay by check (order processing will be longer)
    click    xpath=//p[@id='cart_navigation']/button/span
    click    xpath=//div[@id='center_column']/p
    click    link=Blouses
    click    id=color_8
    click    id=color_8
    click    xpath=//div[@id='center_column']/div/div/div[3]
    [Teardown]  Close Browser

*** Keywords ***
open
    [Arguments]    ${element}
    Go To          ${element}

clickAndWait
    [Arguments]    ${element}
    Click Element  ${element}

click
    [Arguments]    ${element}
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
    Select From List   ${element}  ${value}

select
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

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
