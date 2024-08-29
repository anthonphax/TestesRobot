*** Settings ***
Library         SeleniumLibrary
Library    OperatingSystem
Resource        ../resources/resource.robot
Suite Setup     Abrir Navegador
Suite Teardown  Close Browser

*** Variables ***
${BROWSER}   firefox
${url}       http://www.automationpractice.pl

${Menu_Women}    //a[contains(@class, 'sf-with-ul')]


*** Test Cases ***
Untitled Test Case
    Mouse Over                       ${Menu_Women}
    Wait Until Element Is Visible    link=Blouses
    click                            link=Blouses
    Wait Until Element Is Visible    //*[contains(@class, 'product_img_link')]
    click                            //*[contains(@class, 'product_img_link')]
    click                            id=color_8
    ${status_estoque}=               Get Text       id=availability_value
    ${preco}=                        Get Text       id=our_price_display
    ${disponibilidade}=              Run Keyword And Return Status                 Should Be Equal    ${Status_estoque}    In stock
    Run Keyword If                   ${disponibilidade}            Get Text        id=quantityAvailable
    Log To Console                   Preço: ${preco} | Estoque Status: ${status_estoque}
    IF                               not ${disponibilidade}        
            Skip            Produto indisponível
    ELSE
            ${quantidade_estoque}=   Get Text       id=quantityAvailable
            Log To Console           ${quantidade_estoque}
    END
    click                            id=add_to_cart
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
    click    xpath=//div[@id='center_column']/div/div/div[3]
    [Teardown]  Close Browser

