import 'dart:developer';

import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';
import 'package:vidyaveechi_website/model/therapy_model/therapy_model.dart';
import 'package:vidyaveechi_website/view/constant/const.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/presentation/pages/widgets/video_widgets.dart';

class TherapyController extends GetxController {
  RxBool therapyhome = true.obs;
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController therapyNameController = TextEditingController();
  TextEditingController therapyDiscriptionController = TextEditingController();
  TextEditingController therapiestController = TextEditingController();
  TextEditingController therapydurationController = TextEditingController();
  clearFields() {
    therapyNameController.clear();
    therapyDiscriptionController.clear();
    therapiestController.clear();
    therapydurationController.clear();
  }

  Future<void> createTherapy() async {
    final uuid = const Uuid().v1();
    final therapyModel = TherapyModel(
        docid: uuid,
        therapyName: therapyNameController.text,
        therapyDes: therapyDiscriptionController.text,
        therapistNAme: therapiestController.text,
        duration: therapydurationController.text,
        totalStudents: "");

    try {
      await server
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('Therapy  ')
          .doc(therapyModel.docid)
          .set(therapyModel.toMap())
          .then((value) async {
        clearFields();
        buttonstate.value = ButtonState.success;
        print(UserCredentialsController.batchId!);

        showToast(msg: "Therapy Created Successfully");
        await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
          buttonstate.value = ButtonState.idle;
        });
      });
    } catch (e) {
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      log("Error .... $e");
    }
  }
}
