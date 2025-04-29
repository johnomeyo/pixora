import 'package:flutter/material.dart';

class WallpapersPage extends StatelessWidget {
  final String topic;

  const WallpapersPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    // Replace with your actual wallpaper data source
    final List<String> wallpapers = List.generate(
      12,
      (index) =>
          'https://www.bmw-m.com/content/dam/bmw/marketBMW_M/www_bmw-m_com/fastlane/motorsport/M4-GT3-EVO/2025/bmw-m4-gt3-evo-hd-05-2.jpg',
    );

    return Scaffold(
      appBar: AppBar(title: Text("$topic Wallpapers")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: wallpapers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              wallpapers[index],
              fit: BoxFit.cover,
              loadingBuilder:
                  (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
