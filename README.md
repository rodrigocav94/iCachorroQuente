# iCachorroQuente
Este aplicativo simula a interface de uma loja de cachorro-quentes fictícia.

Permite selecionar entre diversas opções, dispondo de uma variedade de preços, armazena as informações localmente e as utiliza como padrão sempre que o usuário reabrir o app.

Ao finalizar o pedido, suas informações serão enviadas como JSON ao servidor reqres.in, se houver sucesso, o servidor enviará o mesmo objeto de volta, que será interpretado e mostrado ao usuário em uma notificação, utilizando a library Alert Toast do CocoaPods.
