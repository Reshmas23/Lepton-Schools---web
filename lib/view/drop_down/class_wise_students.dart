import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/model/student_model/student_model.dart';

class ClassWiseStudentsDropDown extends StatelessWidget {
  ClassWiseStudentsDropDown({
    Key? key,
  }) : super(key: key);

  final therapyController = Get.put(TherapyController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<StudentModel>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },

      // autoValidateMode: AutovalidateMode.always,
      asyncItems: (value) {
        therapyController.classwiseStudetsList.clear();

        return therapyController.fetchClassWiseStudents();
      },
      itemAsString: (value) =>
          'Name : ${value.studentName}  ID NO :  ${value.admissionNumber}',
      onChanged: (value) async {
        if (value != null) {
          therapyController.studentName = value.studentName;
          therapyController.studentDocId = value.docid;
          therapyController.studentAdNo = value.admissionNumber;
        }
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
