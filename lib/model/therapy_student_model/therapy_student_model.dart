// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentTherapyModel {
  String studentDocId;
  String studentAdNo;
  String studentName;
  String therapyName;
  String therapyId;
  String className;
  String classID;
  String day;
  String status;
  String followUp;

  StudentTherapyModel({
    required this.studentDocId,
    required this.studentAdNo,
    required this.studentName,
    required this.therapyName,
    required this.therapyId,
    required this.className,
    required this.classID,
    required this.day,
    required this.status,
    required this.followUp,
  });

  StudentTherapyModel copyWith({
    String? studentDocId,
    String? studentAdNo,
    String? studentName,
    String? therapyName,
    String? therapyId,
    String? className,
    String? classID,
    String? day,
    String? status,
    String? followUp,
  }) {
    return StudentTherapyModel(
      studentDocId: studentDocId ?? this.studentDocId,
      studentAdNo: studentAdNo ?? this.studentAdNo,
      studentName: studentName ?? this.studentName,
      therapyName: therapyName ?? this.therapyName,
      therapyId: therapyId ?? this.therapyId,
      className: className ?? this.className,
      classID: classID ?? this.classID,
      day: day ?? this.day,
      status: status ?? this.status,
      followUp: followUp ?? this.followUp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentDocId': studentDocId,
      'studentAdNo': studentAdNo,
      'studentName': studentName,
      'therapyName': therapyName,
      'therapyId': therapyId,
      'className': className,
      'classID': classID,
      'day': day,
      'status': status,
      'followUp': followUp,
    };
  }

  factory StudentTherapyModel.fromMap(Map<String, dynamic> map) {
    return StudentTherapyModel(
      studentDocId: map['studentDocId'] as String,
      studentAdNo: map['studentAdNo'] as String,
      studentName: map['studentName'] as String,
      therapyName: map['therapyName'] as String,
      therapyId: map['therapyId'] as String,
      className: map['className'] as String,
      classID: map['classID'] as String,
      day: map['day'] as String,
      status: map['status'] as String,
      followUp: map['followUp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentTherapyModel.fromJson(String source) =>
      StudentTherapyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentTherapyModel(studentDocId: $studentDocId, studentAdNo: $studentAdNo, studentName: $studentName, therapyName: $therapyName, therapyId: $therapyId, className: $className, classID: $classID, day: $day, status: $status, followUp: $followUp)';
  }

  @override
  bool operator ==(covariant StudentTherapyModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.studentDocId == studentDocId &&
      other.studentAdNo == studentAdNo &&
      other.studentName == studentName &&
      other.therapyName == therapyName &&
      other.therapyId == therapyId &&
      other.className == className &&
      other.classID == classID &&
      other.day == day &&
      other.status == status &&
      other.followUp == followUp;
  }

  @override
  int get hashCode {
    return studentDocId.hashCode ^
      studentAdNo.hashCode ^
      studentName.hashCode ^
      therapyName.hashCode ^
      therapyId.hashCode ^
      className.hashCode ^
      classID.hashCode ^
      day.hashCode ^
      status.hashCode ^
      followUp.hashCode;
  }
}
