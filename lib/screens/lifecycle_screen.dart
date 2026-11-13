
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/lifecycle_provider.dart';

class LifecycleScreen extends StatelessWidget {
  const LifecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycle'),
      ),

      body: Consumer<LifecycleProvider>(
        builder: (context, provider, child) {

          final model = provider.model;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(
                    Icons.phone_android,
                    size: 80,
                    color: Colors.deepPurple,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Estado atual do aplicativo',
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    model.status,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Último horário em background:',
                  ),

                  const SizedBox(height: 10),

                  Text(
                    model.lastBackground?.toString() ??
                        'Nenhum registro',
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
