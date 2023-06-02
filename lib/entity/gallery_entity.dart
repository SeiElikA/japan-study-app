class GalleryEntity {
  String iconName = "";
  String title = "";
  List<String> imgList = [];

  GalleryEntity(
      {required this.iconName, required this.title, required this.imgList});

  GalleryEntity.fromJson(Map<String, dynamic> json) {
    iconName = json['iconName'];
    title = json['title'];
    imgList = json['imgList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iconName'] = iconName;
    data['title'] = title;
    data['imgList'] = imgList;
    return data;
  }
}
