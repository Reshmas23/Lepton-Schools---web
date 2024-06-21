import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyaveechi_website/controller/subject_controller/subject_controller.dart';
import 'package:vidyaveechi_website/model/subject_model/subject_model.dart';

class SelectClassWiseTimetableSubjectDropDown extends StatelessWidget {
  SelectClassWiseTimetableSubjectDropDown({
    Key? key,
  }) : super(key: key);

  final subjectCtrl = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<SubjectModel>.multiSelection(
        validator: (List<SubjectModel>? items) {
          if (items == null || items.isEmpty) {
            return "Required field";
          } else {
            return null;
          }
        },
        asyncItems: (String? value) async {
          subjectCtrl.classwiseSubjectList.clear();
          return await subjectCtrl.fetchClassWisTimeTableeSubject();
        },
        itemAsString: (SubjectModel? value) => value?.subjectName ?? '',
        onChanged: (List<SubjectModel> value) {
          subjectCtrl.selectedSubjects.assignAll(value);
        },
        popupProps: const PopupPropsMultiSelection.menu(
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search Subject",
              border: OutlineInputBorder(),
            ),
          ),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
