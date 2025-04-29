import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pixora/models/wallpaper_model.dart' show Wallpaper;

class WallpaperProvider extends ChangeNotifier {
  final String _apiKey =
      'EejMD8U2sMwyHl8uSlyRgzlV58qOWIfbSD21ASzzBUUUnMaZ25sEJguP';
  List<Wallpaper> _wallpapers = [];
  bool _isLoading = false;

  List<Wallpaper> get wallpapers => _wallpapers;
  bool get isLoading => _isLoading;

  Future<void> fetchWallpapers({String query = 'nature'}) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.pexels.com/v1/search?query=$query&per_page=50',
    );

    try {
      final response = await http.get(url, headers: {'Authorization': _apiKey});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List photos = data['photos'];

        _wallpapers = photos.map((json) => Wallpaper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load wallpapers');
      }
    } catch (e) {
      print('Error fetching wallpapers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
