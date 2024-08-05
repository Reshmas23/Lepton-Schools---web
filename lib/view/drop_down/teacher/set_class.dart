import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyaveechi_website/controller/class_controller/class_controller.dart';
import 'package:vidyaveechi_website/model/class_model/class_model.dart';

import '../../../controller/user_login_Controller/user_login_controller.dart';

class SelectClassDropDownClassTeacher extends StatelessWidget {
  SelectClassDropDownClassTeacher({Key? key}) : super(key: key);

  final classCtrl = Get.put(ClassController());
  final userLoginController = Get.find<UserLoginController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownSearch<ClassModel>(
            validator: (item) {
              if (item == null) {
                return "Select Class";
              } else {
                return null;
              }
            },
            asyncItems: (value) {
              classCtrl.allclassList.clear();
              return classCtrl.fetchClass();
            },
            itemAsString: (value) => value.className,
            onChanged: (value) async {
              if (value != null) {
                classCtrl.className.value = value.className;
                classCtrl.classDocID.value = value.docid;
                log("Selected Class ID: ${classCtrl.classDocID.value}");
              }
            },
            popupProps: const PopupProps.menu(
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Search Class",
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
         
         
        ],
      ),
    );
  }

}
