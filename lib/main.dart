import 'package:flutter/material.dart';

import 'screens/main_shell.dart';
import 'services/data_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await DataService.load();
  runApp(MinecraftApp(data: data));
}

class MinecraftApp extends StatelessWidget {
  const MinecraftApp({super.key, required this.data});

  final AppData data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blok Wiki',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: MainShell(data: data),
    );
  }
}
