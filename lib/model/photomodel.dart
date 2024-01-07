class PhotoModel {
  String imgscr;
  String Photoname;

  PhotoModel({required this.Photoname, required this.imgscr});

  static PhotoModel fromAPItoApp(Map<String, dynamic> photomap) {
    return PhotoModel(
        Photoname: photomap["photographer"],
        imgscr: (photomap["src"])["portrait"]);
  }
}
