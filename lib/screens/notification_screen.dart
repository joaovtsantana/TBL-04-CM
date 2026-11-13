
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),

      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(
                  Icons.notifications_active,
                  size: 80,
                  color: Colors.deepPurple,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Teste de notificações locais',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: provider.sendFakeNotification,
                  icon: const Icon(Icons.notifications),
                  label: const Text(
                    'Enviar notificação fake',
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Clique na notificação do sistema para abrir o chat.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                Text(
                  'Notificações criadas: '
                  '${provider.notifications.length}',
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
