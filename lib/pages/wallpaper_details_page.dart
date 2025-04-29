import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullWallpaperPreview extends StatelessWidget {
  final String imageUrl;

  const FullWallpaperPreview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Wallpaper Preview')),
      body: Column(
        children: [
          // Main Hero image
          Expanded(
            child: Hero(
              tag: imageUrl,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // const Divider(),
          SizedBox(height: 20),
          // Lock & Home Screen previews side by side
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text('Previews', style: theme.textTheme.titleMedium)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Lock Screen
                    Expanded(
                      child: Column(
                        children: [
                          Text('Lock Screen',
                              style: theme.textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 9 / 19.5,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Home Screen
                    Expanded(
                      child: Column(
                        children: [
                          Text('Home Screen',
                              style: theme.textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 9 / 19.5,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.wallpaper),
              label: const Text("Set as Wallpaper"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Set wallpaper tapped")),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
