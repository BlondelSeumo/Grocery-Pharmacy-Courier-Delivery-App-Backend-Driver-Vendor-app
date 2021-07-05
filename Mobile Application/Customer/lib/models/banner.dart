import 'package:fuodz/models/category.dart';

class Banner {
  int id;
  String name;
  String imageUrl;
  Category category;

  Banner();

  factory Banner.fromJSON(dynamic json) {
    final banner = Banner();
    banner.id = json["id"];
    banner.name = json["name"];
    banner.imageUrl = json["photo"];

    //load category if included
    if (json["category"] != null) {
      banner.category = Category.fromJson(json["category"]);
    }
    return banner;
  }
}
