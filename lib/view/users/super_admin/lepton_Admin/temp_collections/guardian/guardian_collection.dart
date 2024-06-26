import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/view/users/super_admin/widgets/buttonContainer.dart';
import 'package:vidyaveechi_website/view/users/super_admin/widgets/drop_down/select_batch_year.dart';

import '../../../controllers/temp_Collection_controller/temp_gurdian_cotroller/temp_guardian_controller.dart';
import '../../../widgets/drop_down/get_class.dart';

// ignore: must_be_immutable
class GuardianTempCollection extends StatelessWidget {
  TempGuardianController tempGuardianController = Get.put(TempGuardianController());
  String schoolID;
  GuardianTempCollection({super.key, required this.schoolID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            height: 200,
            color: const Color.fromARGB(255, 160, 219, 162),
            child: Row(
              children: [
                SizedBox(
                    height: 100,
                    width: 300,
                    child: GetBatchYearListDropDownButton(schoolID: schoolID)),
                Obx(() {
                  if (tempGuardianController.batchYear.value == '') {
                    return const SizedBox(
                        height: 100,
                        width: 300,
                        child: Text('Please Select batch year'));
                  } else {
                    return SizedBox(
                      height: 100,
                      width: 300,
                      child: GetClassesListDropDownButton(
                        batchyearID: tempGuardianController.batchYear.value,
                        schoolID: schoolID,
                      ),
                    );
                  }
                })
              ],
            ),
          ),
          Expanded(child: Obx(() {
            if (tempGuardianController.classID.value == '') {
              return const Center(
                child: Text("Select Class"),
              );
            } else {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('SchoolListCollection')
                      .doc(schoolID)
                      .collection(tempGuardianController.batchYear.value)
                      .doc(tempGuardianController.batchYear.value)
                      .collection('classes')
                      .doc(tempGuardianController.classID.value)
                      .collection('Temp_GuardianCollection')
                      .orderBy('guardianName', descending: false)
                      .snapshots(),
                  builder: (context, snaps) {
                    if (snaps.hasData) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 60,
                                color: const Color.fromARGB(255, 190, 220, 245),
                                child: Row(
                                  children: [
                                          const  SizedBox(
                            width: 10,
                          ),
                                    Text('${index + 1}'),
                                          const  SizedBox(
                            width: 10,
                          ),
                                    Text(
                                        snaps.data!.docs[index]['guardianName']),
                                    IconButton(
                                        onPressed: () async {
                                          await tempGuardianController.updateName(
                                              context: context,
                                              schoolID: schoolID,
                                              batchyear: tempGuardianController
                                                  .batchYear.value,
                                              classId: tempGuardianController
                                                  .classID.value,
                                              parentDocID: snaps
                                                  .data!.docs[index]['docid']);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        )),
                                    const Spacer(),
                                    Text(
                                        'Ph :  ${snaps.data!.docs[index]['guardianPhoneNumber']}'),
                                    IconButton(
                                        onPressed: () async {
                                          await tempGuardianController
                                              .updatePhoneNumber(
                                                  context: context,
                                                  schoolID: schoolID,
                                                  batchyear:
                                                      tempGuardianController
                                                          .batchYear.value,
                                                  classId: tempGuardianController
                                                      .classID.value,
                                                  parentDocID: snaps.data!
                                                      .docs[index]['docid']);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        )),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await tempGuardianController
                                              .removeStudent(
                                                  context: context,
                                                  schoolID: schoolID,
                                                  batchyear:
                                                      tempGuardianController
                                                          .batchYear.value,
                                                  classId: tempGuardianController
                                                      .classID.value,
                                                  parentDocID: snaps.data!
                                                      .docs[index]['docid']);
                                        },
                                        child: ButtonContainerWidget(
                                            curving: 5,
                                            colorindex: 6,
                                            height: 35,
                                            width: 100,
                                            child: const Center(
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: snaps.data!.docs.length);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  });
            }
          })),
        ],
      ),
    ));
  }
}
