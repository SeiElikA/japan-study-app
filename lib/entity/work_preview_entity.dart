class WorkPreviewEntity {
  String authorName = "";
  String content = "";
  String publishedDate = "";
  String previewImg = "";
  String docUrl = "";

  WorkPreviewEntity(
      {required this.authorName,
      required this.content,
      required this.publishedDate,
      required this.previewImg,
        required this.docUrl,
      });

  WorkPreviewEntity.fromJson(Map<String, dynamic> json) {
    authorName = json['authorName'];
    content = json['content'];
    publishedDate = json['publishedDate'];
    previewImg = json['previewImg'];
    docUrl = json['docUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorName'] = this.authorName;
    data['content'] = this.content;
    data['publishedDate'] = this.publishedDate;
    data['previewImg'] = this.previewImg;
    data['docUrl'] = this.docUrl;
    return data;
  }
}
