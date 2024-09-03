*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Resource        ../resources/resource.robot

*** Variables ***
${url}           http://www.automationpractice.pl
${Menu_Women}    //a[contains(@class, 'sf-with-ul')]
${categoria}     Blouses

*** Keywords ***
Acesso a Categoria
    Mouse Over                       ${Menu_Women}
    click                            link=${categoria} 

Armazeno Preço catálogo
    ${preco_catalogo}=               Get Text       //a[@title= "Blouse" and @class="product_img_link"]/parent::div/parent::*/following-sibling::div/div[@class="content_price"]/span
    ${preco_catalogo}                covertToNumber        ${preco_catalogo}
    Set Suite Variable               ${preco_catalogo}

Armazeno Preço Página de Produto
    Double Click Element             id=color_8
    ${preco_pgproduto}=              Get Text              id=our_price_display
    ${preco_pgproduto}               covertToNumber        ${preco_pgproduto}
    Set Suite Variable               ${preco_pgproduto}

Armazeno Quantidade Disponível
    Run Keyword If                   ${disponibilidade}            Get Text        id=quantityAvailable
    ${quantidade_estoque}=           Get Text       id=quantityAvailable
    Log To Console                   Estoque Inicial: ${quantidade_estoque}
    ${quantidade_estoque}            covertToNumber                ${quantidade_estoque}
    Set Suite Variable               ${quantidade_estoque}

Categoria Tem Produtos
    ${disponibilidade}=              Run Keyword And Return Status    Wait Until Element Is Visible    //a[@title= "Blouse" and @class="product_img_link"]    timeout=30s
    Log To Console                   Disponível? ${disponibilidade}
    Run Keyword If                   not ${disponibilidade}        Fail    Seção ${categoria}  não tem produtos

Acesso Produto
    click                            //*[contains(@class, 'product_img_link')]
    click                            id=color_8

Produto em Estoque
    ${status_estoque}=               Get Text       id=availability_value
    ${disponibilidade}=              Run Keyword And Return Status                 Should Be Equal    ${Status_estoque}    In stock
    Set Suite Variable               ${disponibilidade}
    IF                               not ${disponibilidade}        
            Skip             Produto indisponível
    END

Comparo Preço de Catálogo e Página de Produto
    compareValues                    ${preco_catalogo}      ${preco_pgproduto}         

Armazeno URI
    ${url_produto}=                  Get Location
    Set Suite Variable               ${url_produto}

Retorno Para Página de Produto
    Go To                            ${url_produto}


Adiciono Produto ao Carrinho
    click                            id=add_to_cart

Exibe Sucesso ao Adicionar Produto ao Carrinho
    Wait Until Element Is Visible    //*[normalize-space() = "Product successfully added to your shopping cart"]

Avanço para o Checkout
    click                            //*[contains(@title, 'Proceed to checkout')]

Armazeno Preço do Carrinho
    ${preco_carrinho}=               Get Text                   id:total_product_price_2_8_0
    ${preco_carrinho}                covertToNumber             ${preco_carrinho}
    Set Suite Variable               ${preco_carrinho}


Quantidade de Carrinho é 1
    ${qt_adicionada}=                Get Element Attribute      //*[contains(@class, 'cart_quantity_input')]    value
    ${qt_adicionada}                 covertToNumber             ${qt_adicionada}
    Set Suite Variable               ${qt_adicionada}


Comparo Preço de Catálogo e Carrinho
    ${preco_carrinho}                Evaluate                   ${preco_carrinho}/${qt_adicionada}
    compareValues                    ${preco_catalogo}          ${preco_carrinho}

Procedo para Sign In
    click                            //*[(normalize-space() = "Proceed to checkout") and contains(@class, "standard-checkout")]

Cadastro novo E-mail
    ${mockmail}=                     Generate Random String                 8          [LOWER]
    click                            id=email_create
    type                             id=email_create                        ${mockmail}@teste.br
    submit                           id=create-account_form

Preencho dados Pessoais
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

Preencho Dados de Endereço
    click                            xpath=//form[@id='add_address']/div[9]
    click                            xpath=//button[@id='submitAddress']/span
    click                            xpath=//div[@id='center_column']/div/div/ol/li[5]
    click                            xpath=//form[@id='add_address']/div[4]
    type                             id=company                             Bis2bis
    type                             id=address1                            r. fantasma
    type                             id=address2                            123
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

Clico Registrar
    click                            xpath=//button[@id='submitAccount']/span

Formulário de Endereço Visível
    Element Should Be Visible        id=add_address
    
Informo Zip Code Inválido
    click                            id=postcode
    type                             id=postcode                              1
    click                            xpath=//button[@id='submitAddress']/span

Informo Zip Code Válido 
    type                             id=postcode                              11122
    

Mensagem de Zip Code Inválido Visível
    Element Should Contain           //*[contains(@class, 'alert')]          The Zip/Postal code you've entered is invalid. It must follow this format: 00000
    
Avanço Para Revisão de Endereço
    click                            xpath=//button[@id='submitAddress']/span

Avanço Para Entrega
    click                            xpath=//*[@name = "processAddress"]

Concordo com os Termos de Serviço
    click                            //*[@id='cgv']/parent::*

Avanço para Pagamento
    click                            xpath=//*[@name = "processCarrier"]

Preço do Produto no Checkout Visível
    Wait Until Element Is Visible    //*[contains(@id,"total_product_price")]

Preço do Checkout é o mesmo do Catálogo
    ${preco_checkout}=               Get Text                        //*[contains(@id,"total_product_price")]
    ${preco_checkout}=               covertToNumber                  ${preco_checkout}
    compareValues                    ${preco_catalogo}               ${preco_checkout}

Escolho Método de Pagamento Check
    click                            link=Pay by check (order processing will be longer)

Confirmo meu Pedido
    click                            //*[@id="cart_navigation"]/button

Mensagem De Pedido Completo Visível
    Element Should Contain           //*[contains(@class, 'alert')]          Your order on My Shop is complete.

Verifico Estoque Atualizado
    ${estoque_atualizado}=           Get Text                      id=quantityAvailable
    ${estoque_atualizado}            covertToNumber                ${estoque_atualizado}
    Set Suite Variable               ${estoque_atualizado}


Quantidade de Estoque Deve Estar Atualizado
    Should Not Be Equal As Integers  ${quantidade_estoque}         ${estoque_atualizado}        msg=Estoque não foi atualizado