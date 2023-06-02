class ExperienceEntity {
  String schoolName = "";
  String authorName = "";
  String avatarUrl = "";
  String shortContent = "";
  String imgPreview = "";
  String docUrl = "";

  ExperienceEntity(
      {required this.schoolName,
      required this.authorName,
      required this.avatarUrl,
      required this.shortContent,
      required this.imgPreview,
      required this.docUrl});

  ExperienceEntity.fromJson(Map<String, dynamic> json) {
    schoolName = json['schoolName'];
    authorName = json['authorName'];
    avatarUrl = json['avatarUrl'];
    shortContent = json['shortContent'];
    imgPreview = json['imgPreview'];
    docUrl = json['docUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolName'] = this.schoolName;
    data['authorName'] = this.authorName;
    data['avatarUrl'] = this.avatarUrl;
    data['shortContent'] = this.shortContent;
    data['imgPreview'] = this.imgPreview;
    data['docUrl'] = this.docUrl;
    return data;
  }
}
