
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/lifecycle_provider.dart';
import 'providers/sync_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/chat_provider.dart';

import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LifecycleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SyncProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exercícios Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        routes: {
          '/chat': (context) => const ChatScreen(),
        },
      ),
    );
  }
}
