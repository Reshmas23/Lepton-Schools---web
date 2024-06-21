import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/subject_controller/subject_controller.dart';

class SelectCStudentClassWiseSubjectDropDown extends StatelessWidget {
  SelectCStudentClassWiseSubjectDropDown({
    Key? key,
  }) : super(key: key);

  final SubjectController subjectController = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<Map<String, dynamic>>(
        validator: (item) {
          if (item == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        // autoValidateMode: AutovalidateMode.always,
        asyncItems: (value) {
          return subjectController.fetchClassWiseTimeTableTeacherSubject();
        },
        itemAsString: (value) => value['teacherName'] ?? "",
        onChanged: (value) async {
          if (value != null) {
            subjectController.teacherName.value = value['docid'];
          }
        },
      //  dropdownDecoration: 
        // InputDecoration(
        //   border: OutlineInputBorder(),
        //   labelText: 'Select Teacher',
        // ),
      ),
    );
  }
}
