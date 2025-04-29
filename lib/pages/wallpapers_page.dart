import 'package:flutter/material.dart';
import 'package:pixora/models/wallpaper_model.dart' show Wallpaper;
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pixora/pages/full_wallpaper_preview_page.dart';
import 'package:pixora/providers/wallpaper_provider.dart';

class WallpapersPage extends StatefulWidget {
  final String topic;

  const WallpapersPage({super.key, required this.topic});

  @override
  State<WallpapersPage> createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WallpaperProvider>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).fetchWallpapers(query: widget.topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);
    final wallpapers = wallpaperProvider.wallpapers;

    return Scaffold(
      appBar: AppBar(title: Text("${widget.topic} Wallpapers")),
      body:
          wallpaperProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : wallpapers.isEmpty
              ? const Center(child: Text('No wallpapers found.'))
              : GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: wallpapers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final Wallpaper wallpaper = wallpapers[index];
                  final heroTag = '${wallpaper.id}-$index'; // Unique tag

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => FullWallpaperPreview(
                                imageUrl: wallpaper.imageUrl,
                              ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: wallpaper.imageUrl,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
