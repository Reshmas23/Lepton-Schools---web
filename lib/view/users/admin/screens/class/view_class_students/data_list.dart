import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vidyaveechi_website/model/class_model/class_model.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/widgets/data_list_widgets/data_container.dart';

class ClassDataListWidget extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> classStatus;
  final ClassModel data;
  final int index;
  const ClassDataListWidget({
    required this.index,
    super.key,
    required this.data,
    required this.classStatus,
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    final String classStData =
        classStatus.data!.docs[index].data().containsKey('lastActiveClassDay')
            ? classStatus.data?.docs[index]['lastActiveClassDay']
            : '00-00-0000';
    //date string in dd-mm-yyyy format
// Split the date string into day, month, and year
    List<String> dateParts = classStData.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

// Create a DateTime object using the parsed components
    DateTime dateResult = DateTime(year, month, day);

// Calculate the difference in milliseconds between the current date and the given date
    int differenceInMilliseconds =
        currentDate.difference(dateResult).inMilliseconds;

// Convert milliseconds to days
    int daysAgo = (differenceInMilliseconds / (1000 * 60 * 60 * 24)).round();
    log("date$daysAgo");
    //print( "     ${data.classTeacherName??''}");
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: "     ${data.classId}"),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                color: cWhite,
                index: index,
                headerTitle: "     ${data.className}"),
          ),
          const SizedBox(
            width: 01,
          ),
           Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                color: cWhite,
                index: index,
                headerTitle: "     ${data.classTeacherName??''}"),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                color: cWhite,
                index: index,
                headerTitle: daysAgo == 739389
                    ? 'No records found'
                    : daysAgo == 1
                        ? 'Today'
                        : daysAgo == 2
                            ? 'Yesterday'
                            : classStData),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                color: cWhite,
                index: index,
                headerTitle: "${data.workingDaysCount}"),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
                stream: server
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection("classes")
                    .doc(data.docid)
                    .collection('Students')
                    .snapshots(),
                builder: (context, studentSnaps) {
                  if (studentSnaps.data == null) {
                    return DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        color: cWhite,
                        // width: 150,
                        index: index,
                        headerTitle: 'No Students is there');
                  } else if (studentSnaps.hasData) {
                    return DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        color: cWhite,
                        // width: 150,
                        index: index,
                        headerTitle: '${studentSnaps.data!.docs.length}');
                  } else {
                    return DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        color: cWhite,
                        // width: 150,
                        index: index,
                        headerTitle: '...');
                  }
                }),
          ), // ...................................Total Number of Students
          const SizedBox(
            width: 01,
          ),
        ],
      ),
    );
  }
}
