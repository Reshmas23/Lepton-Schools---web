// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// NoticeModel noticeModelFromJson(String str) =>
//     NoticeModel.fromJson(json.decode(str));

// String noticeModelToJson(NoticeModel data) =>
//     json.encode(data.toJson());

class TherapyModel {
  String docid;
  String therapyName;
  String therapyDes;
  String therapistNAme;
  String duration;
  String totalStudents;

  TherapyModel({
    required this.docid,
    required this.therapyName,
    required this.therapyDes,
    required this.therapistNAme,
    required this.duration,
    required this.totalStudents,
  });

  TherapyModel copyWith({
    String? docid,
    String? therapyName,
    String? therapyDes,
    String? therapistNAme,
    String? duration,
    String? totalStudents,
  }) {
    return TherapyModel(
      docid: docid ?? this.docid,
      therapyName: therapyName ?? this.therapyName,
      therapyDes: therapyDes ?? this.therapyDes,
      therapistNAme: therapistNAme ?? this.therapistNAme,
      duration: duration ?? this.duration,
      totalStudents: totalStudents ?? this.totalStudents,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'therapyName': therapyName,
      'therapyDes': therapyDes,
      'therapistNAme': therapistNAme,
      'duration': duration,
      'totalStudents': totalStudents,
    };
  }

  factory TherapyModel.fromMap(Map<String, dynamic> map) {
    return TherapyModel(
      docid: map['docid'] as String,
      therapyName: map['therapyName'] as String,
      therapyDes: map['therapyDes'] as String,
      therapistNAme: map['therapistNAme'] as String,
      duration: map['duration'] as String,
      totalStudents: map['totalStudents'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TherapyModel.fromJson(String source) =>
      TherapyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoticeModel(docid: $docid, therapyName: $therapyName, therapyDes: $therapyDes, therapistNAme: $therapistNAme, duration: $duration, totalStudents: $totalStudents)';
  }

  @override
  bool operator ==(covariant TherapyModel other) {
    if (identical(this, other)) return true;

    return other.docid == docid &&
        other.therapyName == therapyName &&
        other.therapyDes == therapyDes &&
        other.therapistNAme == therapistNAme &&
        other.duration == duration &&
        other.totalStudents == totalStudents;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
        therapyName.hashCode ^
        therapyDes.hashCode ^
        therapistNAme.hashCode ^
        duration.hashCode ^
        totalStudents.hashCode;
  }
}
