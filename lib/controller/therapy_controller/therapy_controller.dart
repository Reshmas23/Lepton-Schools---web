import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/presentation/pages/widgets/video_widgets.dart';

class TherapyController extends GetxController {
  RxBool therapyhome = true.obs;
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;

  final formKey = GlobalKey<FormState>();


  TextEditingController therapyNameController = TextEditingController();
  TextEditingController therapyDiscriptionController = TextEditingController();
  TextEditingController therapiestController = TextEditingController();
  TextEditingController therapydurationController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController therapyofStudentController = TextEditingController();

  

}
