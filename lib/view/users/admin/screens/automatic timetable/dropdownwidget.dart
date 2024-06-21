import 'package:get/get.dart';

import '../../../../../controller/subject_controller/subject_controller.dart';
import '../../../../web_DashBoard/pages/video_management/presentation/pages/widgets/video_widgets.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.subjectCtrl,
  });

  final SubjectController subjectCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 5, left: 10, right: 10),
      child: Obx(() => Container(
            decoration: BoxDecoration(
              border:Border.all(),
              borderRadius:
                  BorderRadius.circular(5),
              // border: Border.all()
            ),
            // width: 450,
            child: DropdownButtonFormField<
                String>(
              decoration:
                  const InputDecoration(
                border: InputBorder.none,
                hintText: 'Select period per day'
              ),
              isExpanded: true,
              value: subjectCtrl.periodperday
                      .value.isNotEmpty
                  ? subjectCtrl
                      .periodperday.value
                  : null,
              onChanged: (String? newValue) {
                subjectCtrl.periodperday
                    .value = newValue ?? '';
              },
              validator: (item) {
                if (item == null ||
                    item ==
                        'Select period per day') {
                  return "Select period";
                } else {
                  return null;
                }
              },
              items: <String>[
                'Select period per day',
                '1',
                '2',
                '3',
                '4',
                '5',
                '6',
                '7',
                '8',
                '9',
                '10'
              ].map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<
                    String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
    );
  }
}
