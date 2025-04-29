import 'package:flutter/material.dart';

class WallpaperDetailsPage extends StatelessWidget {
  const WallpaperDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: Center(child: Text('Wallpaper Details Page'))),
          SizedBox(height: 20),
          Text('More details about the wallpaper will be shown here.'),
        ],
      ),
    );
  }
}
