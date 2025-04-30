import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

Future<void> setWallpaper(BuildContext context, String imageUrl) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Set as Wallpaper", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildOption(context, imageUrl, AsyncWallpaper.HOME_SCREEN, "Home Screen"),
            _buildOption(context, imageUrl, AsyncWallpaper.LOCK_SCREEN, "Lock Screen"),
            _buildOption(context, imageUrl, AsyncWallpaper.BOTH_SCREENS, "Both Screens"),
          ],
        ),
      );
    },
  );
}

Widget _buildOption(
  BuildContext context,
  String imageUrl,
  int wallpaperLocation,
  String label,
) {
  return ListTile(
    leading: const Icon(Icons.wallpaper),
    title: Text(label),
    onTap: () async {
      Navigator.pop(context); // Close bottom sheet
      try {
        bool result = await AsyncWallpaper.setWallpaper(
          url: imageUrl,
          wallpaperLocation: wallpaperLocation,
          goToHome: false,
          toastDetails: ToastDetails.success(),
          errorToastDetails: ToastDetails.error(),
        );
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label wallpaper set successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to set $label wallpaper')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    },
  );
}
