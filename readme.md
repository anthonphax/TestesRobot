# Testes Dojô

## Desafio

Ambiente de Testes (E-commerce): http://www.automationpractice.pl

    1. Configurar Robot Framework Localmente  

    2. Realizar a compra de uma blusa preta tamanho L (Blouse, sku:demo_2)
    Verificar se: 
    A categoria Blouses possui produtos
    Há estoque de produto e qual a quantidade
    Produto é adicionado corretamente ao carrinho
    Preço do Produto é o mesmo no catálogo, carrinho, checkout e pedido
    Campos obrigatórios zipcode do formulário tem validações
    Verificar se a mensagem de erro do campo é “The Zip/Postal code you've entered is invalid. It must follow this format: 00000”
    Verificar se o Pedido foi bem sucedido
    Verificar se o estoque de produto foi reduzido


## Configuração de Projeto

1. Configure python3-pip e robot do seu computador
2. Gerar base com Katalon test recorder
3. Instalar suporte para Sleenium: `pip install --upgrade robotframework-seleniumlibrary`
