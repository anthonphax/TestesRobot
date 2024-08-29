*** Settings ***
Library         SeleniumLibrary
Library    OperatingSystem
Resource        ../resources/resource.robot
Suite Setup     Abrir Navegador
Suite Teardown  Close Browser

*** Variables ***
${url}           http://www.automationpractice.pl

${Menu_Women}    //a[contains(@class, 'sf-with-ul')]
${categoria}     Blouses


*** Test Cases ***
Categoria e Página de Produto
    Mouse Over                       ${Menu_Women}
    Wait Until Element Is Visible    link=${categoria}      10s
    click                            link=${categoria} 
    # 1. A categoria Blouses possui produtos?
    ${disponibilidade}=              Run Keyword And Return Status    Wait Until Element Is Visible    //a[@title= "Blouse" and @class="product_img_link"]    timeout=30s
    Log To Console                   Disponível? ${disponibilidade}
    Run Keyword If           not ${disponibilidade}        Fail    Seção ${categoria}  não tem produtos 
    # Preço é armazenado na Página de Produto para comparação futura
    ${preco_catalogo}=               Get Text       //a[@title= "Blouse" and @class="product_img_link"]/parent::div/parent::*/following-sibling::div/div[@class="content_price"]/span
    ${preco_catalogo}                covertToNumber        ${preco_catalogo}
    Set Suite Variable               ${preco_catalogo}
    click                            //*[contains(@class, 'product_img_link')]
    click                            id=color_8
    # 2. Há estoque de produto? Qual a quantidade?
    ${status_estoque}=               Get Text       id=availability_value
    ${preco_pgproduto}=              Get Text       id=our_price_display
    ${disponibilidade}=              Run Keyword And Return Status                 Should Be Equal    ${Status_estoque}    In stock
    IF                               not ${disponibilidade}        
            Skip             Produto indisponível
    END
    Double Click Element             id=color_8
    ${quantidade_estoque}=           Get Text       id=quantityAvailable
    Log To Console                   Estoque Inicial: ${quantidade_estoque}
    Run Keyword If                   ${disponibilidade}            Get Text        id=quantityAvailable
    Log To Console                   Preço:${preco_pgproduto}| Estoque Status: ${status_estoque}
    ${preco_pgproduto}                covertToNumber        ${preco_pgproduto}
    compareValues                    ${preco_catalogo}      ${preco_pgproduto}                        
    # 3. Produto é adicionado corretamente ao carrinho?
    click                            id=add_to_cart
    Wait Until Element Is Visible    //*[normalize-space() = "Product successfully added to your shopping cart"]

Checkout
    click                            //*[contains(@title, 'Proceed to checkout')]
    ${preco_carrinho}=               Get Text                   id:total_product_price_2_8_0
    ${preco_carrinho}                covertToNumber             ${preco_carrinho}
    #Me assegurar que estou utilizando preço unitário
    ${qt_adicionada}=                Get Element Attribute      //*[contains(@class, 'cart_quantity_input')]    value
    ${qt_adicionada}                 covertToNumber             ${qt_adicionada}
    ${preco_carrinho}                Evaluate                   ${preco_carrinho}/${qt_adicionada}
    # Preço do Produto é o mesmo no catálogo e carrinho?
    compareValues                    ${preco_catalogo}     ${preco_carrinho}
    click                            //*[(normalize-space() = "Proceed to checkout") and contains(@class, "standard-checkout")]
    ${mockmail}=                     Generate Random String                 8          [LOWER]
    click                            id=email_create
    type                             id=email_create                        ${mockmail}@teste.br
    submit                           id=create-account_form
    click                            id=customer_firstname
    type                             id=customer_firstname                  tester
    type                             id=customer_lastname                   tester
    click                            id=id_gender1
    click                            id=passwd
    type                             id=passwd                              123123
    click                            xpath=//form[@id='account-creation_form']/div/div[7]
    select                           id=days                                16
    select                           id=months                              7
    select                           id=years                               2000
    click                            xpath=//button[@id='submitAccount']/span
    click                            xpath=//form[@id='add_address']/div[9]
    click                            xpath=//button[@id='submitAddress']/span
    click                            xpath=//div[@id='center_column']/div/div/ol/li[5]
    click                            xpath=//form[@id='add_address']/div[4]
    click                            id=firstname
    click                            id=company
    type                             id=company                             Bis2bis
    click                            id=address1
    type                             id=address1                            r. fantasma
    click                            id=address2
    type                             id=address2                            123
    click                            id=city
    type                             id=city                                Ldn
    select                           id=id_state                            1
    click                            xpath=//option[@value='12']
    click                            id=postcode
    click                            xpath=//select[@id='id_country']/option
    click                            id=phone
    type                             id=phone                                123123123123
    click                            id=phone_mobile
    type                             id=phone_mobile                         1231231231
    click                            id=other
    type                             id=other                                131231231
    click                            id=alias
    # verifica erro de zip code
    Element Should Contain           //*[contains(@class, 'alert')]          The Zip/Postal code you've entered is invalid. It must follow this format: 00000
    click                            xpath=//button[@id='submitAddress']/span
    type                             id=postcode                             1
    click                            xpath=//button[@id='submitAddress']/span
Pedido Bem-sucedido
    click                            id=postcode
    type                             id=postcode                              11122
    click                            xpath=//button[@id='submitAddress']/span
    click                            xpath=//*[@name = "processAddress"]
    click                            //*[@id='cgv']/parent::*
    click                            xpath=//*[@name = "processCarrier"]
    Wait Until Element Is Visible    //*[contains(@id,"total_product_price")]
    ${preco_checkout}=               Get Text                        //*[contains(@id,"total_product_price")]
    ${preco_checkout}=               covertToNumber                  ${preco_checkout}
    compareValues                    ${preco_catalogo}               ${preco_checkout}
    click                            link=Pay by check (order processing will be longer)
    click                            //*[@id="cart_navigation"]/button
    Element Should Contain           //*[contains(@class, 'alert')]          Your order on My Shop is complete.
    [Teardown]  Close Browser


