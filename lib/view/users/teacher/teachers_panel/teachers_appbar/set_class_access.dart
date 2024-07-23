import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/class_controller/class_controller.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/constant/const.dart';
import 'package:vidyaveechi_website/view/drop_down/teacher/set_class.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/splash_screen/splash_screen.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';

import '../../../../../controller/batch_yearController/batch_year_Controller.dart';

teacherClassSettingFunction(BuildContext context) {
  final BatchYearController batchYearController=Get.put(BatchYearController());
  final academicYearListWidegt = [
    // GestureDetector(
    //   onTap: () {
    //     addAcademicYearFunction(context);
    //   },
    //   child: Container(
    //     height: 40,
    //     width: 150,
    //     decoration: BoxDecoration(
    //         color: themeColorBlue,
    //         border: Border.all(color: themeColorBlue),
    //         borderRadius: BorderRadius.circular(05)),
    //     child: const Center(
    //       child: TextFontWidgetRouter(
    //         text: "Add Academic Year",
    //         fontsize: 14,
    //         // fontWeight: FontWeight.w600,
    //         color: cWhite,
    //       ),
    //     ),
    //   ),
    // ), ///////////////////////.......0
    GestureDetector(
      onTap: () {
       setClass(context);
      },
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            color: themeColorBlue,
            border: Border.all(color: themeColorBlue),
            borderRadius: BorderRadius.circular(05)),
        child: const Center(
          child: TextFontWidgetRouter(
            text: "Set class",
            fontsize: 14,
            // fontWeight: FontWeight.w600,
            color: cWhite,
          ),
        ),
      ),
    ), ////////////////...............1
    GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            color: themeColorBlue,
            border: Border.all(color: themeColorBlue),
            borderRadius: BorderRadius.circular(05)),
        child: const Center(
          child: TextFontWidgetRouter(
            text: "Cancel",
            fontsize: 14,
            // fontWeight: FontWeight.w600,
            color: cWhite,
          ),
        ),
      ),
    ), //////////////////.............2
  ];
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:  const TextFontWidget(text: "Select Class", fontsize: 15),
        backgroundColor: cWhite,
        content: SizedBox(
          height: ResponsiveWebSite.isMobile(context)? 240: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                key: batchYearController.formKey,
                child: SizedBox(
                  height: 95,
                  // color: cWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const TextFontWidget(
                          text: 'Select class*', fontsize: 12.5),
                      const SizedBox(
                        height: 05,
                      ),
                      SelectClassDropDownClassTeacher()
                    ],
                  ),
                ),
              ),
              ResponsiveWebSite.isMobile(context)
                  ? Column(
                      children: [
                        // Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: academicYearListWidegt[
                        //         0] ///////////////............add year
                        //     ),
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child:
                                academicYearListWidegt[0] //////........set year
                            ),
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: academicYearListWidegt[
                                1] ///////////////////.............cancel
                            ),
                      ],
                    )
                  : Row(
                      children: [
                        // Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: academicYearListWidegt[
                        //         0] ///////////////............add year
                        //     ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                academicYearListWidegt[0] //////........set year
                            ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: academicYearListWidegt[
                                1] ///////////////////.............cancel
                            ),
                      ],
                    ),
            ],
          ),
        ),
      );
    },
  );
  
}

  Future<void> setClass(BuildContext context) async {
      final classCtrl = Get.put(ClassController());
    final selectedClassDocID = classCtrl.classDocID.value;
    final teacherUid = FirebaseAuth.instance.currentUser?.uid ;// Ensure userUID is correctly fetched

    log('User UID: $teacherUid');
    log('Selected Class Doc ID: $selectedClassDocID');

    if (teacherUid!.isEmpty || selectedClassDocID.isEmpty) {
      showToast(msg: "User UID or Selected Class Doc ID is empty.");
      return;
    }

    final classAccessDoc = await FirebaseFirestore.instance
           .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(selectedClassDocID)
        .collection('teachers')
        .doc( teacherUid)
        .get();

    if (classAccessDoc.exists) {
      await SharedPreferencesHelper.setString(SharedPreferencesHelper.userRoleKey, 'teacher');
      await SharedPreferencesHelper.setString(SharedPreferencesHelper.schoolIdKey, UserCredentialsController.schoolId!);
      await SharedPreferencesHelper.setString(SharedPreferencesHelper.schoolNameKey, UserCredentialsController.schoolName!);
      await SharedPreferencesHelper.setString(SharedPreferencesHelper.classIdKey, selectedClassDocID);
      await SharedPreferencesHelper.setString(SharedPreferencesHelper.classNameKey, classCtrl.className.value);

      // Navigate to SplashScreen on successful login
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return SplashScreen();
      }), (route) => false);
    } else {
      showToast(msg: "No access to this class");
    }
  }
