import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/model/therapy_model/therapy_model.dart';

class TherapyDropDown extends StatelessWidget {
  TherapyDropDown({
    Key? key,
  }) : super(key: key);

  final therapyController = Get.put(TherapyController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<TherapyModel>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },

      // autoValidateMode: AutovalidateMode.always,
      asyncItems: (value) {
        therapyController.allTherapyList.clear();

        return therapyController.fetchTherapyList();
      },
      itemAsString: (value) => value.therapyName,
      onChanged: (value) async {
        if (value != null) {
          therapyController.therapyName = value.therapyName;
          therapyController.therapyId = value.docid;
        }
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
