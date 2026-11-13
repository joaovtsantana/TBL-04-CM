
import 'package:flutter/material.dart';

import 'lifecycle_screen.dart';
import 'sync_screen.dart';
import 'notification_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Exercícios Flutter'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Selecione um exercício:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          exerciseCard(
            context,
            'Exercício 1 - Lifecycle',
            Icons.phone_android,
            const LifecycleScreen(),
          ),

          exerciseCard(
            context,
            'Exercício 2 - WorkManager',
            Icons.sync,
            const SyncScreen(),
          ),

          exerciseCard(
            context,
            'Exercício 3 - Notificações',
            Icons.notifications,
            const NotificationScreen(),
          ),

          exerciseCard(
            context,
            'Exercício 4 - Mensagens',
            Icons.message,
            const ChatScreen(),
          ),

          exerciseCard(
            context,
            'Exercício 5 - Atualização automática',
            Icons.update,
            const ChatScreen(autoUpdate: true),
          ),
        ],
      ),
    );
  }

  Widget exerciseCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
          size: 30,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}
