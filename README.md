Exercícios Teóricos – Flutter, Android e FCM

1. Qual a diferença entre terminated, foreground e background?

Foreground é quando o aplicativo está aberto e visível para o usuário, permitindo interação normalmente. Background é quando o aplicativo está em segundo plano, ou seja, não está visível na tela, mas ainda pode ter processos em execução. Terminated é quando o aplicativo está completamente encerrado ou foi finalizado pelo sistema, não possuindo uma execução ativa.

2. Por que o Android limita a execução em background?

O Android limita a execução em segundo plano para economizar bateria, reduzir o consumo de memória, melhorar o desempenho do dispositivo e evitar que aplicativos executem tarefas desnecessárias. Por isso, o sistema pode suspender ou interromper processos de aplicativos que estão em segundo plano.

3. Por que Timer.periodic não é confiável em aplicativos reais?

O Timer.periodic não é confiável porque depende do aplicativo estar em execução para continuar funcionando. Quando o aplicativo vai para segundo plano ou é encerrado, o Android pode suspender ou interromper sua execução. Por isso, ele não é indicado para tarefas que precisam funcionar continuamente ou em horários específicos. Para essas situações, existem alternativas como WorkManager, AlarmManager e Firebase Cloud Messaging (FCM).

4. Explique o fluxo Flutter → Android → Servidor → FCM → Flutter.

O Flutter é responsável pela interface e pelo funcionamento do aplicativo. O Android gerencia a execução do aplicativo, as permissões e as notificações no dispositivo. O servidor é responsável por processar informações e enviar solicitações de notificações para o Firebase. O FCM (Firebase Cloud Messaging) recebe essas mensagens do servidor e realiza a entrega ao dispositivo. Por fim, o Flutter recebe e processa a mensagem, podendo exibir informações ou executar alguma ação dentro do aplicativo.

5. Qual a diferença entre foreground, background, servidor, FCM, Android, onMessage, onMessageOpenedApp e getInitialMessage?

Foreground significa que o aplicativo está aberto e visível para o usuário. Background significa que o aplicativo está em segundo plano, sem estar visível na tela. Servidor é o sistema responsável por armazenar informações, processar dados e enviar mensagens para o aplicativo. FCM (Firebase Cloud Messaging) é um serviço do Firebase utilizado para enviar notificações e mensagens aos dispositivos. Android é o sistema operacional responsável por gerenciar os aplicativos, os recursos do celular e as notificações.

O onMessage é chamado quando uma mensagem do FCM chega enquanto o aplicativo está aberto (foreground). O onMessageOpenedApp é chamado quando o usuário toca em uma notificação e abre o aplicativo que estava em segundo plano (background). Já o getInitialMessage é utilizado para recuperar a mensagem que abriu o aplicativo quando ele estava completamente encerrado (terminated).

Conclusão

O Flutter controla o funcionamento do aplicativo, o Android gerencia sua execução, o servidor envia as mensagens e o FCM realiza a entrega das notificações. Os métodos onMessage, onMessageOpenedApp e getInitialMessage permitem identificar e tratar as notificações de acordo com o estado em que o aplicativo se encontra.
