import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/view/drop_down/class_wise_students.dart';
import 'package:vidyaveechi_website/view/drop_down/select_class.dart';
import 'package:vidyaveechi_website/view/drop_down/therapy/select_therapy_drop_down.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/widgets/progess_button/progress_button.dart';

addTherapyStd(BuildContext context) {
  final TherapyController therapyController = Get.put(TherapyController());
  aweSideSheet(
      context: context,
      sheetPosition: SheetPosition.right,
      header: Container(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                children: [
                  BackButton(),
                  SizedBox(
                    width: 20,
                  ),
                  TextFontWidget(
                    text: 'Add students',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Container(
                height: 900,
                width: 500,
                margin: const EdgeInsets.only(top: 10),
                child: Form(
                  key: therapyController.formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFontWidget(
                            text: 'Select Therapy Type *', fontsize: 12.5),
                        const SizedBox(
                          height: 05,
                        ),
                        SizedBox(
                          height: 50,
                          child: TherapyDropDown(),
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        const TextFontWidget(
                            text: 'Select Class *', fontsize: 12.5),
                        const SizedBox(
                          height: 05,
                        ),
                        SizedBox(
                          height: 50,
                          child: SelectClassDropDown(),
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        const TextFontWidget(
                            text: 'Select Student *', fontsize: 12.5),
                        const SizedBox(
                          height: 05,
                        ),
                        SizedBox(
                          height: 50,
                          child: ClassWiseStudentsDropDown(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: ProgressButtonWidget(
                              function: () async {
                                if (therapyController.formKey.currentState!
                                    .validate()) {
                                  therapyController
                                      .addTherapyStudent()
                                      .then((value) => Navigator.pop(context));
                                }
                              },
                              buttonstate: therapyController.buttonstate.value,
                              text: 'Add Student'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      showCloseButton: false,
      footer: Container());
}
