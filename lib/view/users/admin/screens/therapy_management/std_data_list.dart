// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/model/therapy_student_model/therapy_student_model.dart';
import 'package:vidyaveechi_website/view/constant/constant.validate.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/result/widget/data_container_marks.dart';
import 'package:vidyaveechi_website/view/widgets/custom_showdialouge/custom_showdialouge.dart';
import 'package:vidyaveechi_website/view/widgets/textformFiledContainer/textformFiledBlueContainer.dart';

class AllStdDataList extends StatelessWidget {
  final StudentTherapyModel data;
  final int index;
  AllStdDataList({
    required this.data,
    required this.index,
    super.key,
  });
  final formKey = GlobalKey<FormState>();
  TherapyController therapycontroller = Get.put(TherapyController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? const Color.fromARGB(255, 246, 246, 246)
            : Colors.blue[50],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.center,
                index: index,
                headerTitle: "${index + 1}"),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 1,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.center,
                index: index,
                headerTitle: data.studentAdNo),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 3,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: data.studentName),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: data.className),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.center,
                index: index,
                headerTitle: data.day == "" ? "--" : data.day),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: data.status == "" ? "--" : data.status),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: DataContainerMarksWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: data.followUp == "" ? "--" : data.followUp),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                therapycontroller.therapyDayController.text = data.day;
                therapycontroller.therapyStatusController.text = data.status;
                therapycontroller.therapyFollowUpController.text =
                    data.followUp;
                customShowDilogBox(
                    context: context,
                    title: 'Edit',
                    children: [
                      SizedBox(
                        width: 400,
                        height: 500,
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  TextFormFiledBlueContainerWidgetWithOutColor(
                                    hintText: ' ${data.studentAdNo}',
                                    title: 'Admission No.',
                                    readOnly: true,
                                  ),
                                  TextFormFiledBlueContainerWidgetWithOutColor(
                                    readOnly: true,
                                    hintText: ' ${data.studentName}',
                                    title: 'Student Name',
                                  ),
                                  TextFormFiledBlueContainerWidgetWithOutColor(
                                    validator: checkFieldEmpty,
                                    hintText: ' ${data.day}',
                                    title: 'Day',
                                    controller:
                                        therapycontroller.therapyDayController,
                                  ),
                                  TextFormFiledBlueContainerWidgetWithOutColor(
                                    validator: checkFieldEmpty,
                                    hintText: ' ${data.status}',
                                    title: 'Status/Comment',
                                    controller: therapycontroller
                                        .therapyStatusController,
                                  ),
                                  TextFormFiledBlueContainerWidgetWithOutColor(
                                    validator: checkFieldEmpty,
                                    hintText: ' ${data.followUp}',
                                    title: 'Follow UP',
                                    controller: therapycontroller
                                        .therapyFollowUpController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                    doyouwantActionButton: true,
                    actiontext: 'Update',
                    actiononTapfuction: () {
                      if (formKey.currentState!.validate()) {
                        therapycontroller.editTherapyStudent(
                            stdTherapyModel: data);
                        Navigator.of(context).pop();
                      }
                    });
              },
              child: DataContainerMarksWidget(
                  rowMainAccess: MainAxisAlignment.center,
                  index: index,
                  headerTitle: '  Update'),
            ),
          ),
        ],
      ),
    );
  }
}
