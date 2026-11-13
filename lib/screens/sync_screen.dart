
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sync_provider.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkManager'),
      ),

      body: Consumer<SyncProvider>(
        builder: (context, provider, child) {

          final model = provider.model;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(
                    Icons.sync,
                    size: 80,
                    color: Colors.deepPurple,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    model.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  if (model.isSyncing)
                    const CircularProgressIndicator(),

                  ElevatedButton(
                    onPressed: model.isSyncing
                        ? null
                        : provider.syncNow,
                    child: const Text('Sincronizar agora'),
                  ),

                  ElevatedButton(
                    onPressed: provider.scheduleSync,
                    child: const Text('Agendar sincronização'),
                  ),

                  ElevatedButton(
                    onPressed: provider.cancelSync,
                    child: const Text('Cancelar agendamento'),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    model.lastSync != null
                        ? 'Última sincronização: ${model.lastSync}'
                        : 'Nenhuma sincronização realizada',
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
