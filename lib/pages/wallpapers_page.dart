import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pixora/pages/full_wallpaper_preview_page.dart'
    show FullWallpaperPreview;

class WallpapersPage extends StatelessWidget {
  final String topic;

  const WallpapersPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
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
          final imageUrl = wallpapers[index];
          final heroTag = '$imageUrl-$index'; // Ensure uniqueness
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullWallpaperPreview(imageUrl: imageUrl),
                ),
              );
            },
            child: Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
