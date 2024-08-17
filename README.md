# Bom Hamburguer

## Descrição do Projeto:
O projeto "Bom Hamburguer" é um aplicativo móvel desenvolvido usando o Flutter, que oferece uma experiência de compra de sanduíches e extras, como batatas fritas e refrigerantes. O aplicativo inclui várias funcionalidades, como um carrinho de compras, um sistema de descontos condicionado à compra de combos, e uma interface visual agradável com carrosséis de imagens para destacar os produtos.

## Funcionalidades Implementadas:

     Interface do Usuário (UI):
        Utilização de um tema com cores específicas, incluindo cores como bege pastel e tons de marrom escuro.
        Implementação de um carrossel de imagens na tela inicial, utilizando o pacote carousel_slider.
        Exibição dos produtos disponíveis (sanduíches e extras) em um grid de visualização.
        Botões estilizados para adicionar itens ao carrinho de compras.

    Carrinho de Compras:
        O usuário pode adicionar um sanduíche e até dois extras (batatas fritas e refrigerante) ao carrinho.
        O carrinho exibe o subtotal, descontos aplicados, e o valor total.
        Opção para remover itens do carrinho.
        O botão "Proceed to Checkout" só fica habilitado se houver itens no carrinho.

    Pagamento:
        O usuário precisa fornecer seu nome antes de concluir a compra.
        Após a confirmação do pagamento, os itens são removidos do carrinho e uma mensagem de "Pedido Concluído com Sucesso" é exibida.

    Suporte a Diferentes Dispositivos:
        Integração com o DevicePreview para testar o aplicativo em diferentes dispositivos e tamanhos de tela.

## Configuração e Tecnologias Usadas:

    Flutter SDK: Versão 3.10.6
    Dart: Versão 3.0.6
    Kotlin: A versão utilizada foi a 1.8.0, porém o projeto originalmente esperava a versão 1.6.0.
    Gradle: Versão recomendada 7.0 ou superior.
    Pacotes Usados:
        provider: Para gerenciamento de estado.
        carousel_slider: Para o carrossel de imagens na tela inicial.
        device_preview: Para simulação do app em diferentes dispositivos.

## Passos para Compilação e Exportação:

    Compilação do APK:
        O APK foi construído utilizando o comando flutter build apk --release.

## Resultado Final:

  O projeto foi compilado com sucesso, resultando em um APK que pode ser instalado e executado em dispositivos Android.
    O APK gerado pode ser encontrado no diretório build\app\outputs\flutter-apk\app-release.apk.
