import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'
    hide Column, Row; // Hide conflicting names
import 'package:vidyaveechi_website/controller/class_controller/class_controller.dart';
import 'package:vidyaveechi_website/controller/subject_controller/subject_controller.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/google_poppins_widget.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/automatic%20timetable/dropdownwidget.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/automatic%20timetable/select_subj_wise_dropdown.dart';
import 'package:vidyaveechi_website/view/widgets/custom_showdialouge/custom_showdialouge.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';

import '../../../../../model/subject_model/subject_model.dart';
import '../../../../constant/constant.validate.dart';
import '../../../../drop_down/select_class.dart';
import 'teacherwise_subjects.dart';

class TimeTableNew extends StatelessWidget {
  final SubjectController subjectCtrl = Get.put(SubjectController());
  final ClassController classCtrl = Get.put(ClassController());
  final formKey = GlobalKey<FormState>();
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  TimeTableNew({
    Key? key,
  }) : super(key: key);

  Future<void> exportToExcel(/////////////////////////////////Excel Export
      BuildContext context, SubjectController subjectCtrl) async {
    try {
      // Creating a workbook.
      final Workbook workbook = Workbook();
      // Accessing via index
      final Worksheet sheet = workbook.worksheets[0];
      sheet.showGridlines = true;

      // Add headers
      sheet.getRangeByName('A1').setText('Selected class');
      sheet.getRangeByName('B1').setText('Selected Days');
      sheet.getRangeByName('C1').setText('Selected Subjects');
      sheet.getRangeByName('D1').setText('Periods per Week');
      sheet.getRangeByName('E1').setText('Periods per day');
      sheet.getRangeByName('F1').setText('Teachers in the class');
      sheet.getRangeByName('G1').setText('Teaching subjects');

      // Populate selected class
      sheet.getRangeByName('A2').setText(classCtrl.className.value);

      // Prepare data for selected subjects and periods per week
      List<String> selectedSubjects = subjectCtrl.selectedSubjects
          .map((subject) => subject.subjectName)
          .toList();
      List<int> periodsPerWeek = subjectCtrl.periodsPerWeek;
      List<String> selectedDays = subjectCtrl.selectedDays;

      // Populate the days, subjects, and periods row by row
      int startRowIndex = 2; // Start from row 2 for data
      for (int i = 0; i < selectedDays.length; i++) {
        sheet.getRangeByIndex(startRowIndex + i, 2).setText(selectedDays[i]);
      }

      for (int i = 0; i < selectedSubjects.length; i++) {
        sheet
            .getRangeByIndex(startRowIndex + i, 3)
            .setText(selectedSubjects[i]);
        sheet
            .getRangeByIndex(startRowIndex + i, 4)
            .setText(periodsPerWeek[i].toString());
      }
      sheet.getRangeByName('E2').setText(subjectCtrl.periodperday.value);
      // Get teacher-wise subjects
      var teacherwiseSubjects =
          await subjectCtrl.fetchClassWiseTimeTableTeacherSubject();

      // Add data from teacher-wise subjects
      int teacherRowIndex = startRowIndex; // Separate index for teachers
      for (var teacher in teacherwiseSubjects) {
        var teacherName = teacher['teacherName'] ?? 'Unknown';
        var subjects = teacher['subjectName'] as List<SubjectModel>;

        // Populate data in Excel for each teacher
        sheet.getRangeByIndex(teacherRowIndex, 6).setText(teacherName);

        var teachingSubjects =
            subjects.map((subject) => subject.subjectName).join(', ');
        sheet.getRangeByIndex(teacherRowIndex, 7).setText(teachingSubjects);

        teacherRowIndex++;
      }

      // Save and launch the excel.
      final List<int> bytes = workbook.saveAsStream();
      // Dispose the document.
      workbook.dispose();

      // Save and launch the file.
      await saveAndLaunchFile(bytes, 'timetable.xlsx');
    } catch (e) {
      print('Error exporting to Excel: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while exporting to Excel.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final blob = Blob([Uint8List.fromList(bytes)]);
    final url = Url.createObjectUrlFromBlob(blob);
    AnchorElement(href: url)
      ..target = 'webbrowser'
      ..download = fileName
      ..click();
    Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      color: screenContainerbackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 25),
                child: Row(
                  children: [
                    const TextFontWidget(
                      text: 'Timetable',
                      fontsize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        customShowDilogBox(
                            context: context,
                            title: 'Class Timetable',
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 10, right: 10),
                                      child: TextFontWidget(
                                          text: 'Select class *',
                                          fontsize: 12.5),
                                    ),
                                    SelectClassDropDown(),/////////////////////////////////Select class
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 10, right: 10),
                                      child: TextFontWidget(
                                          text: 'Select days availability *',
                                          fontsize: 12.5),
                                    ), /////////////////////////////////////////////////////////////Select Class
                                    SizedBox(
                                      height: 450,
                                      width: 450,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: daysOfWeek.length,
                                              itemBuilder: (context, index) {
                                                return Obx(() {
                                                  return CheckboxListTile(
                                                    title: Text(
                                                        daysOfWeek[index]),
                                                    value: subjectCtrl
                                                        .selectedDays
                                                        .contains(daysOfWeek[
                                                            index]),
                                                    onChanged: (bool? value) {
                                                      if (value == true) {
                                                        subjectCtrl
                                                            .selectedDays
                                                            .add(daysOfWeek[
                                                                index]);
                                                      } else {
                                                        subjectCtrl
                                                            .selectedDays
                                                            .remove(
                                                                daysOfWeek[
                                                                    index]);
                                                      }
                                                    },
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                          Obx(() {
                                            return SizedBox(
                                              // width: 450,
                                              child: TextFormField(
                                                validator: checkFieldEmpty,
                                                readOnly: true,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Selected Days',
                                                  border:
                                                      OutlineInputBorder(),
                                                ),
                                                controller:
                                                    TextEditingController(
                                                  text: subjectCtrl
                                                      .selectedDays
                                                      .join(', '),
                                                ),
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    ), ////////////////////////////////////////////////////////////////////Select days
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 10, right: 10),
                                      child: TextFontWidget(
                                          text: 'Select subject *',
                                          fontsize: 12.5),
                                    ),
                                    SizedBox(
                                      // height: 40,
                                      width: 450,
                                      child:
                                          SelectClassWiseTimetableSubjectDropDown(),
                                    ), ////////////////////////////////////////////////////////////Select subject
                                    const SizedBox(height: 10),
                                    
                                  
                                    Obx(() {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: subjectCtrl.selectedSubjects
                                            .map((subject) {
                                          int subjectIndex = subjectCtrl
                                              .selectedSubjects
                                              .indexOf(subject);
                                          if (subjectCtrl
                                                  .periodsPerWeek.length <=
                                              subjectIndex) {
                                            subjectCtrl.periodsPerWeek.add(1);
                                          }
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Selected Subject: ${subject.subjectName}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Number of periods per week:',
                                                    style: TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  DropdownButton<int>(
                                                    value: subjectCtrl
                                                            .periodsPerWeek[
                                                        subjectIndex],
                                                    onChanged: (int? value) {
                                                      subjectCtrl.periodsPerWeek[
                                                              subjectIndex] =
                                                          value ?? 1;
                                                    },
                                                    items: List.generate(
                                                      10,
                                                      (index) =>
                                                          DropdownMenuItem<
                                                              int>(
                                                        value: index + 1,
                                                        child: Text(
                                                            '${index + 1}'),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 10,
                                                    right: 10),
                                                child: TextFontWidget(
                                                    text:
                                                        'Select period per day *',
                                                    fontsize: 12.5),
                                              ),
                                              DropdownWidget(
                                                  subjectCtrl:
                                                      subjectCtrl), //////////////////////////////////////////////////////////////////////////////////////////////////Select period
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }),
                                  ],
                                ),
                              )
                            ],
                            doyouwantActionButton: true,
                            actiononTapfuction: () {
                              if (formKey.currentState!.validate()) {
                                customShowDilogBox(/////////////////////////////////////////Second Dialouge box
                                    doyouwantActionButton: true,
                                    actiononTapfuction: () {
                                      Get.to(exportToExcel(
                                          context, subjectCtrl));
                                    },
                                    context: context,
                                    title: 'Classwise teacher and subject *',
                                    children: [
                                       const SizedBox(height: 10),
                                      SizedBox(
                                        height: 550,
                                        width: 550,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child:
                                                  ClaswiseTeacherSubjects(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                    actiontext: 'Submit');////////////////////////////////
                              }
                            },
                            actiontext: 'Next');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: adminePrimayColor),
                          height: 38,
                          width: 80,
                          child: Center(
                              child: GooglePoppinsWidgets(
                            text: 'Add',
                            fontsize: 14,
                            fontWeight: FontWeight.w500,
                            color: cWhite,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 25,
                    left: ResponsiveWebSite.isMobile(context) ? 05 : 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
