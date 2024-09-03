*** Settings ***
Resource        ../resources/BDDpt-br.robot
Resource        ../resources/ResourceBDD.robot
Library         SeleniumLibrary
Library         OperatingSystem
Suite Setup     Abrir Navegador
Suite Teardown  Close Browser


*** Test Cases ***
Cenario 1: Checar Informações de Catálogo
    Dado que Acesso a Categoria
    E Categoria Tem Produtos
    Logo Armazeno Preço catálogo
    
Cenário 2: Checar Informações de Página de Produto
    Dado que Acesso Produto
    E Produto em Estoque 
    Logo Armazeno Preço Página de Produto
    E Armazeno Quantidade Disponível
    Logo Adiciono Produto ao Carrinho
    E Exibe Sucesso ao Adicionar Produto ao Carrinho
    E Armazeno URI

Cenário 3: Checar Informações de Carrinho
    Dado que Exibe Sucesso ao Adicionar Produto ao Carrinho
    Quando Avanço para o Checkout
    Logo Armazeno Preço do Carrinho
    E Quantidade de Carrinho é 1
    E Comparo Preço de Catálogo e Carrinho


Canário 4: Avançar Cadastro de Dados Pessoais
    Dado que Procedo para Sign In 
    E Cadastro novo E-mail
    Preencho dados Pessoais
    E Clico Registrar
    Logo Formulário de Endereço Visível
   

Cenário 5: Formulario de Endereço
    Dado que Formulário de Endereço Visível
    Preencho Dados de Endereço
    Quando Informo Zip Code Inválido
    Logo Mensagem de Zip Code Inválido Visível
    
Cenário 6: Fluxo e Informações de Checkout
    Dado que Informo Zip Code Válido 
    Quando Avanço Para Revisão de Endereço
    E Avanço Para Entrega
    E Concordo com os Termos de Serviço
    E Avanço para Pagamento
    Logo Preço do Produto no Checkout Visível
    E Preço do Checkout é o mesmo do Catálogo

Cenário 7: Pedido Bem-Sucedido
    Dado que Escolho Método de Pagamento Check
    E Confirmo meu Pedido
    Logo Mensagem De Pedido Completo Visível


Cenário 8: Atualização de Estoque
    Dado que Retorno Para Página de Produto
    Quando Verifico Estoque atualizado
    Logo Quantidade de Estoque Deve Estar Atualizado
    