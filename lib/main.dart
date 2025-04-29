import 'package:flutter/material.dart';
import 'package:pixora/pages/homepage.dart';
import 'package:pixora/providers/wallpaper_provider.dart'
    show WallpaperProvider;
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider;

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WallpaperProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixora',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}
