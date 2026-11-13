
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {

  final String conversationId;
  final bool autoUpdate;

  const ChatScreen({
    super.key,
    this.conversationId = '1',
    this.autoUpdate = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with WidgetsBindingObserver {

  final TextEditingController controller =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (!mounted) return;

      if (widget.autoUpdate) {
        context.read<ChatProvider>().startUpdating(
          widget.conversationId,
        );
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (!widget.autoUpdate) return;

    final chat = context.read<ChatProvider>();

    if (state == AppLifecycleState.resumed) {

      chat.startUpdating(widget.conversationId);

    } else {

      chat.stopUpdating();

    }
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);

    context.read<ChatProvider>().stopUpdating();

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.autoUpdate
              ? 'Chat - Atualização automática'
              : 'Minha conversa',
        ),
      ),

      body: Column(
        children: [

          if (widget.autoUpdate)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Atualização automática a cada 5 segundos',
                style: TextStyle(color: Colors.green),
              ),
            ),

          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, provider, child) {

                final messages = provider.getMessages(
                  widget.conversationId,
                );

                if (messages.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma mensagem ainda'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,

                  itemBuilder: (context, index) {

                    final message = messages[index];

                    final isMe = message.sender == 'Eu';

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,

                      child: Card(
                        color: isMe
                            ? Colors.deepPurple.shade100
                            : Colors.grey.shade200,

                        child: Padding(
                          padding: const EdgeInsets.all(12),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                message.sender,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(message.text),

                              const SizedBox(height: 5),

                              Text(
                                '${message.createdAt.hour}:'
                                '${message.createdAt.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 10),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.send),

                  onPressed: () {

                    context.read<ChatProvider>().sendMessage(
                      widget.conversationId,
                      controller.text,
                    );

                    controller.clear();
                  },
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
