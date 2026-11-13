
import 'package:flutter/material.dart';
import '../models/sync_model.dart';

class SyncProvider extends ChangeNotifier {
  final SyncModel model = SyncModel();

  Future<void> syncNow() async {
    if (model.isSyncing) return;

    model.isSyncing = true;
    model.message = 'Sincronizando...';
    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 3),
    );

    model.isSyncing = false;
    model.lastSync = DateTime.now();
    model.message = 'Sincronização concluída!';

    notifyListeners();
  }

  Future<void> scheduleSync() async {
    model.message = 'Sincronização agendada!';
    notifyListeners();
  }

  Future<void> cancelSync() async {
    model.message = 'Agendamento cancelado!';
    notifyListeners();
  }
}
