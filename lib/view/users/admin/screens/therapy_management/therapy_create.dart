import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/view/constant/constant.validate.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/widgets/progess_button/progress_button.dart';
import 'package:vidyaveechi_website/view/widgets/textformFiledContainer/textformFiledBlueContainer.dart';

createTherapyAdmin(BuildContext context) {
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
                    text: 'Therapy',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Container(
                height: 900,
                width: 500,
                margin: const EdgeInsets.only(top: 10),
                child:
                    //  Obx(() {
                    // return
                    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: therapyController.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              controller:
                                  therapyController.therapyNameController,
                              validator: checkFieldEmpty,
                              title: 'Therapy Name',
                              hintText: 'Therapy Name',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              maxLines: 3,
                              validator: checkFieldEmpty,
                              controller: therapyController
                                  .therapyDiscriptionController,
                              title: 'Therapy Discription',
                              hintText: 'Therapy Discription',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              validator: checkFieldEmpty,
                              controller:
                                  therapyController.therapiestController,
                              title: 'Therapist',
                              hintText: 'Therapist',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormFiledHeightnoColor(
                              width: 500,
                              validator: checkFieldEmpty,
                              controller:
                                  therapyController.therapydurationController,
                              title: 'Duration',
                              hintText: 'Duration',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: ProgressButtonWidget(
                            function: () async {
                              if (therapyController.formKey.currentState!
                                  .validate()) {
                                therapyController.createTherapy();
                              }
                            },
                            buttonstate: therapyController.buttonstate.value,
                            text: 'Create Therapy'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      showCloseButton: false,
      footer: Container());
}
