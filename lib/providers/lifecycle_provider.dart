
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/lifecycle_model.dart';

class LifecycleProvider extends ChangeNotifier
    with WidgetsBindingObserver {

  final LifecycleModel model = LifecycleModel();

  LifecycleProvider() {
    WidgetsBinding.instance.addObserver(this);
    loadLastBackground();
  }

  Future<void> loadLastBackground() async {
    final prefs = await SharedPreferences.getInstance();

    final saved = prefs.getString('lastBackground');

    if (saved != null) {
      model.lastBackground = DateTime.tryParse(saved);
      notifyListeners();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    model.status = state.name;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      saveBackgroundTime();
    }

    notifyListeners();
  }

  Future<void> saveBackgroundTime() async {
    final prefs = await SharedPreferences.getInstance();

    final now = DateTime.now();

    await prefs.setString(
      'lastBackground',
      now.toIso8601String(),
    );

    model.lastBackground = now;

    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
