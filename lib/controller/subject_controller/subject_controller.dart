import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vidyaveechi_website/controller/class_controller/class_controller.dart';
import 'package:vidyaveechi_website/model/subject_model/subject_model.dart';
import 'package:vidyaveechi_website/view/constant/const.dart';
import 'package:vidyaveechi_website/view/constant/constant.validate.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';

class SubjectController extends GetxController {
  List<SubjectModel> classwiseSubjectList = [];
   List<SubjectModel> teacherwiseSubjectList = [];
   //List<SubjectModel> teacherList = [];
     RxList<Map<String, dynamic>> teacherList = <Map<String, dynamic>>[].obs;

  TextEditingController subNameController = TextEditingController();
  TextEditingController subNameEditController = TextEditingController();
  TextEditingController subFeeController = TextEditingController();
   
    TextEditingController selectedSub = TextEditingController();
  RxString subjectName = ''.obs;
  RxString teacherId=''.obs;
  RxString teacherName=''.obs;
  RxString periodperday =''.obs;
 
  RxString subjectID = ''.obs;
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  var selectedDays = <String>[].obs;
  Rx<Color> subjectColor = Colors.amber.obs;
  RxList<SubjectModel> selectedSubjects = <SubjectModel>[].obs;
   RxList<SubjectDayCount> subjectDayCounts = <SubjectDayCount>[].obs; // Define the subjectDayCounts
  final List<String> daysOfWeek = ['1', '2', '3', '4', '5', '6', '7'];
 //  RxList teacherList = [].obs;

  var periodsPerWeek = <int>[].obs;

  final _firebase = server
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId!)
      .doc(UserCredentialsController.batchId!)
      .collection('classes');
  Future<void> asignSubjectToTeacher(
      {required String teacherName, required String teacherDocid}) async {
    buttonstate.value = ButtonState.loading;
    try {
      final asignSubDetail = SubjectModel(
          subjectColor: subjectColor.value,
          subjectFeefortr: int.parse(subFeeController.text.trim()),
          subjectNameedit: false,
          docid: subjectID.value,
          subjectName: subjectName.value,
          teacherId: teacherDocid,
          teacherName: teacherName);
      log("Color value $asignSubDetail");
      await _firebase
          .doc(Get.find<ClassController>().classDocID.value)
          .collection('teachers')
          .doc(teacherDocid)
          .set({
        'teacherId': asignSubDetail.teacherId,
        'teacherName': asignSubDetail.teacherName
      }, SetOptions(merge: true)).then((value) async {
        await _firebase
            .doc(Get.find<ClassController>().classDocID.value)
            .collection('teachers')
            .doc(teacherDocid)
            .collection('teacherSubject')
            .doc(subjectID.value)
            .set(asignSubDetail.toMap())
            .then((value) async {
          await _firebase
              .doc(Get.find<ClassController>().classDocID.value)
              .collection('subjects')
              .doc(subjectID.value)
              .collection('teachers')
              .doc(teacherDocid)
              .set({
            'teacherId': asignSubDetail.teacherId,
            'teacherName': asignSubDetail.teacherName
          }, SetOptions(merge: true)).then((value) async {
            buttonstate.value = ButtonState.success;
            showToast(msg: 'Subject added to this teacher');
            subFeeController.clear();
            await Future.delayed(const Duration(seconds: 2)).then((value) {
              buttonstate.value = ButtonState.idle;
            });
          });
        });
      });
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<void> addSubjectIntoClass({required String classID}) async {
    buttonstate.value = ButtonState.loading;
    try {
      final String subDocid = subNameController.text.trim() + uuid.v1();
      final SubjectModel subjDetails = SubjectModel(
          docid: subDocid,
          subjectName: subNameController.text,
          subjectNameedit: false,
          subjectColor: subjectColor.value);
      await _firebase
          .doc(classID)
          .collection('subjects')
          .doc(subDocid)
          .set(subjDetails.toMap())
          .then((value) async {
        buttonstate.value = ButtonState.success;
        subNameController.clear();
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<List<SubjectModel>> fetchClassWiseSubject() async {
    final firebase = await _firebase
        .doc(Get.find<ClassController>().classDocID.value)
        .collection('subjects')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => SubjectModel.fromMap(e.data())).toList();
      classwiseSubjectList.add(list[i]);
    }
    return classwiseSubjectList;
  }

    Future<List<SubjectModel>> fetchClassWisTimeTableeSubject() async {
    final firebase = await _firebase
        .doc(Get.find<ClassController>().classDocID.value)
        .collection('subjects')
        .get();

    for (var doc in firebase.docs) {
      teacherwiseSubjectList.add(SubjectModel.fromMap(doc.data()));
    }
    return teacherwiseSubjectList;
  }
/////////////////////////////////////////////////////////////////////////////////////
Future<List<Map<String, dynamic>>> fetchClassWiseTimeTableTeacherSubject() async {
  teacherList.clear();

  try {
    final firebase = await _firebase
        .doc(Get.find<ClassController>().classDocID.value)
        .collection('teachers')
        .get();

    for (var doc in firebase.docs) {
      var teacherData = doc.data();
      var teacherId = teacherData['teacherId'];

      var subjectsSnapshot = await _firebase
          .doc(Get.find<ClassController>().classDocID.value)
          .collection('teachers')
          .doc(teacherId)
          .collection('teacherSubject')
          .get();

      var specificSubjects = subjectsSnapshot.docs
          .map((subjectDoc) => SubjectModel.fromMap(subjectDoc.data()))
          .toList();

      // Store subjects as List<SubjectModel>
      teacherData['subjectName'] = specificSubjects;

      teacherList.add(teacherData);
    }

    log('Teacher List: $teacherList');
  } catch (e) {
    log('Error fetching teachers: $e');
  }

  return teacherList;
}








  

////////////////////////////////////////////////////////////////////////////////////
///
///
///
/////////////////////////////////////////////////////////////////////////////////////\
///////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////
  Future<List<SubjectModel>> fetchClassWiseTimeTableSubject() async {
    List<SubjectModel> subjects = [];

    try {
      final classDocID = Get.find<ClassController>().classDocID.value;

    
      final teacherDocs = await _firebase
          .doc(classDocID)
          .collection('teachers')
          .get();

     
      for (var teacherDoc in teacherDocs.docs) {
        var teacherId = teacherDoc.id;

      
        final subjectDocs = await _firebase
            .doc(classDocID)
            .collection('teachers')
            .doc(teacherId)
            .collection('teacherSubject')
            .get();

        
        for (var subjectDoc in subjectDocs.docs) {
          var subjectData = subjectDoc.data();
         
          var subjectModel = SubjectModel.fromMap(subjectData);
         
          subjects.add(subjectModel);
        }
      }

     
      log('Subjects: $subjects');
    } catch (e) {
     
      log('Error $e');
    }

   
    return subjects;
  }

///////////////////////////////////////////////////////////
  //  return firebase.docs.
  Future<void> enableorDisableUpdate(
    String docid,
    bool status,
  ) async {
    await _firebase
        .doc(Get.find<ClassController>().classModelData.value!.docid)
        .collection("subjects")
        .doc(docid)
        .update({'subjectNameedit': status});
  }

  Future<void> deleteSubject(String docid, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(),
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Once you delete a Subject all data will be lost \n Are you sure ?')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () async {
                try {
                  await _firebase
                      .doc(Get.find<ClassController>()
                          .classModelData
                          .value!
                          .docid)
                      .collection("subjects")
                      .doc(docid)
                      .delete()
                      .then((value) => showToast(msg: 'Subject Deleted'));
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  showToast(msg: 'Somthing went wrong please try again');
                  if (kDebugMode) {
                    log(e.toString());
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateSubjectName(String docid) async {
    //................. Update Class Name
    //.... Update Class Name
    try {
      await _firebase
          .doc(Get.find<ClassController>().classModelData.value!.docid)
          .collection("subjects")
          .doc(docid)
          .update({
        'subjectNameedit': false,
        'subjectName': subNameEditController.text
      }).then((value) => subNameEditController.clear());
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<void> asignSubRemoveFromTr(
      String teacherdocid, String subjectID) async {
    //................. Update Class Name
    //.... Update Class Name
    try {
      _firebase
          .doc(Get.find<ClassController>().classDocID.value)
          .collection('teachers')
          .doc(teacherdocid)
          .collection('teacherSubject')
          .doc(subjectID)
          .delete()
          .then((value) {
        showToast(msg: 'Subject Removed');
        Get.back();
      });
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<List<DocumentSnapshot>> fetchExamWiseSubject(examName) async {
    //print(examName);
    final firebase = await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(Get.find<ClassController>().classModelData.value!.docid)
        .collection('Exam Results')
        .doc(examName)
        .collection('Subjects')
        .get();

    // for (var i = 0; i < firebase.docs.length; i++) {
    //   final list =
    //       firebase.docs.map((e) => SubjectModel.fromMap(e.data())).toList();
    //   classwiseSubjectList.add(list[i]);
    // }
    return firebase.docs;
  }
  void initializeSubjectDayCounts() {
    subjectDayCounts.clear();
    for (var subject in selectedSubjects) {
      for (var day in daysOfWeek) {
        subjectDayCounts.add(SubjectDayCount(
          subjectId: subject.docid,
          day: day,
          count: 0.obs,
        ));
      }
    }
  }



  Future<Map<String, List<SubjectModel>>> fetchClassWiseTimeTableTeacher(String teacherName) async {
  Map<String, List<SubjectModel>> teacherSubjects = {};

  try {
    // Assuming you fetch teacher subjects based on teacherName
    var teacherData = await _firebase
        .doc(Get.find<ClassController>().classDocID.value)
        .collection('teachers')
        .where('teacherName', isEqualTo: teacherName)
        .get();

    if (teacherData.docs.isNotEmpty) {
      var teacherId = teacherData.docs.first['teacherId'];

      var subjectsSnapshot = await _firebase
          .doc(Get.find<ClassController>().classDocID.value)
          .collection('teachers')
          .doc(teacherId)
          .collection('teacherSubject')
          .get();

      var specificSubjects = subjectsSnapshot.docs
          .map((subjectDoc) => SubjectModel.fromMap(subjectDoc.data()))
          .toList();

      // Store subjects as List<SubjectModel>
      teacherSubjects[teacherName] = specificSubjects;
    }

    print('Teacher Subjects: $teacherSubjects');
  } catch (e) {
    print('Error fetching teacher subjects: $e');
  }

  return teacherSubjects;
}




}
class SubjectDayCount {
  final String subjectId;
  final String day;
  RxInt count;

  SubjectDayCount({
    required this.subjectId,
    required this.day,
    required this.count,
  });
}
