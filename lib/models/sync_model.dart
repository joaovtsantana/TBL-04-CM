
class SyncModel {
  bool isSyncing;
  String message;
  DateTime? lastSync;

  SyncModel({
    this.isSyncing = false,
    this.message = 'Aguardando sincronização',
    this.lastSync,
  });
}
