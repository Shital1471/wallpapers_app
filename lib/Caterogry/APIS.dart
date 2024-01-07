import 'dart:convert';

import 'package:animal_pagination/model/photomodel.dart';
import 'package:http/http.dart' as http;

class APiOperation {
  static List<PhotoModel> trendingWallpapers = [];
  static List<PhotoModel> searchwallpapersList = [];
  static int page = 1;
  static int limit = 25;
  static int pagesearch = 1;
  static int limitsearch = 15;
  static Future<List<PhotoModel>> getWallpapers() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$limit&page=$page"),
        headers: {
          "Authorization":
              "your_pixels_api_key"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        Map<String, dynamic> src = element["src"];
        trendingWallpapers.add(PhotoModel.fromAPItoApp(element));
      });
    });
    return trendingWallpapers;
  }

  static Future<List<PhotoModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=$limitsearch&page=$pagesearch"),
        headers: {
          "Authorization":
             "your_pixels_api_key"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchwallpapersList.clear();
      photos.forEach((element) {
        Map<String, dynamic> src = element["src"];
        searchwallpapersList.add(PhotoModel.fromAPItoApp(element));
      });
    });
    return searchwallpapersList;
  }
}
