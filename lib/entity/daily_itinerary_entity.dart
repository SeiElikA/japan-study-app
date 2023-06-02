class DailyItineraryEntity {
  String title = "";
  String content = "";
  String imgPreview = "";
  List<Itinerary> itinerary = [];

  DailyItineraryEntity(
      {required this.title,
      required this.content,
      required this.imgPreview,
      required this.itinerary});

  DailyItineraryEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    imgPreview = json['imgPreview'];
    if (json['itinerary'] != null) {
      itinerary = <Itinerary>[];
      json['itinerary'].forEach((v) {
        itinerary!.add(new Itinerary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['imgPreview'] = this.imgPreview;
    if (this.itinerary != null) {
      data['itinerary'] = this.itinerary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Itinerary {
  String? dateTime;
  String? introduction;

  Itinerary({this.dateTime, this.introduction});

  Itinerary.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    introduction = json['introduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['introduction'] = this.introduction;
    return data;
  }
}
