import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../view/utils/shared_pref/user_auth/user_credentials.dart';
import '../class_controller/class_controller.dart';

class TeacherExamStatusController extends GetxController {
  var chartData = <ChartData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasswiseExamData();
  }

  Future<void> fetchClasswiseExamData() async {
    try {
      final selectedClassDocID = Get.find<ClassController>().classDocID.value;
      if (selectedClassDocID.isNotEmpty) {
        final examSnapshot = await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('ExamNotification')
            .get();

        final List<ChartData> data =
            await _getChartData(examSnapshot, selectedClassDocID);
        chartData.value = data;
      }
    } catch (e) {
      print('Error fetching class-wise exam data: $e');
    }
  }

  Future<List<ChartData>> _getChartData(
      QuerySnapshot examSnapshot, String classDocID) async {
    List<ChartData> chartData = [];
    for (var doc in examSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final examName = data['examName'] ?? '';

      final studentsWrittenExamCount =
          await getStudentsWrittenExamCount(examName, classDocID);

      final studentsPassedExamCount =
          await getStudentsPassedExamCount(examName, classDocID);

      chartData.add(ChartData(
        examName,
        studentsWrittenExamCount.toDouble(),
        studentsPassedExamCount.toDouble(),
      ));
    }
    return chartData;
  }

  Future<int> getStudentsWrittenExamCount(
      String examName, String classDocID) async {
    try {
      int total = 0;
      final markListCollection = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(classDocID)
          .collection('Exam Results')
          .doc(examName)
          .collection('Subjects')
          .get();

      for (var subjectElement in markListCollection.docs) {
        final studentMarkListCollection = await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('classes')
            .doc(classDocID)
            .collection('Exam Results')
            .doc(examName)
            .collection('Subjects')
            .doc(subjectElement.id)
            .collection('MarkList')
            .get();

        for (var studentMark in studentMarkListCollection.docs) {
          final markData = studentMark.data();
          final obtainedMark = markData['obtainedMark'] ?? '0';
          final passMark = markData['passMark'] ?? '0';

          final obtainedMarkNum =
              double.tryParse(obtainedMark.toString()) ?? 0;
          final passMarkNum = double.tryParse(passMark.toString()) ?? 0;

          if (obtainedMarkNum > passMarkNum) {
            total++;
          }
        }
      }
      return total;
    } catch (e) {
      print('Error fetching students written exam count: $e');
      return 0;
    }
  }

  Future<int> getStudentsPassedExamCount(
      String examName, String classDocID) async {
    try {
      int total = 0;
      final markListCollection = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(classDocID)
          .collection('Exam Results')
          .doc(examName)
          .collection('Subjects')
          .get();

      for (var subjectElement in markListCollection.docs) {
        final studentMarkListCollection = await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('classes')
            .doc(classDocID)
            .collection('Exam Results')
            .doc(examName)
            .collection('Subjects')
            .doc(subjectElement.id)
            .collection('MarkList')
            .get();

        for (var studentMark in studentMarkListCollection.docs) {
          final markData = studentMark.data();
          final obtainedMark = markData['obtainedMark'] ?? '0';
          final passMark = markData['passMark'] ?? '0';

          final obtainedMarkNum =
              double.tryParse(obtainedMark.toString()) ?? 0;
          final passMarkNum = double.tryParse(passMark.toString()) ?? 0;

          if (obtainedMarkNum > passMarkNum) {
            total++;
          }
        }
      }
      return total;
    } catch (e) {
      print('Error fetching students passed exam count: $e');
      return 0;
    }
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final double y1;
}
