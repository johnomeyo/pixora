// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;

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
            const Text(
              "Set as Wallpaper",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildOption(
              context,
              imageUrl,
              AsyncWallpaper.HOME_SCREEN,
              "Home Screen",
            ),
            _buildOption(
              context,
              imageUrl,
              AsyncWallpaper.LOCK_SCREEN,
              "Lock Screen",
            ),
            _buildOption(
              context,
              imageUrl,
              AsyncWallpaper.BOTH_SCREENS,
              "Both Screens",
            ),
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
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/wallpaper.jpg';

        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final image = img.decodeImage(response.bodyBytes);

          if (image != null) {
            final screenSize = ui.window.physicalSize;
            final pixelRatio = ui.window.devicePixelRatio;
            final targetWidth = (screenSize.width * pixelRatio).round();
            final targetHeight = (screenSize.height * pixelRatio).round();

            // Resize and crop with correct argument
            final resized = img.copyResizeCropSquare(
              image,
              size: min(targetWidth, targetHeight),
            );

            final jpg = img.encodeJpg(resized);
            final file = File(filePath)..writeAsBytesSync(jpg);

            await AsyncWallpaper.setWallpaperFromFile(
              filePath: file.path,
              wallpaperLocation: wallpaperLocation,
              goToHome: false,
              toastDetails: ToastDetails.success(),
              errorToastDetails: ToastDetails.error(),
            );
          } else {
            throw Exception("Could not decode image");
          }
        } else {
          throw Exception("Image download failed: \${response.statusCode}");
        }
      } catch (e) {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('Error: \$e')));
      }
    },
  );
}

int min(int a, int b) => a < b ? a : b;
