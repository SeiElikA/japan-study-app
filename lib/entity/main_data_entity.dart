import 'dart:convert';

import 'package:japan_study_app/entity/work_preview_entity.dart';

class MainDataEntity {
  List<String> bestImage = [];
  List<WorkPreviewEntity> bestWork = [];

  MainDataEntity({required this.bestImage, required this.bestWork});

  MainDataEntity.fromJson(Map<String, dynamic> json) {
    bestImage = json['bestImage'].cast<String>();

    var workList = json["bestWork"] as List;
    var bestWorkList = <WorkPreviewEntity>[];
    for (var element in workList) {
      bestWorkList.add(WorkPreviewEntity.fromJson(element));
    }
    bestWork = bestWorkList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bestImage'] = bestImage;
    data['bestWork'] = bestWork;
    return data;
  }
}
