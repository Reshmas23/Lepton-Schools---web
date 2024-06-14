import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/model/therapy_student_model/therapy_student_model.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/ioT_Card/code.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/students/student_details/widgets/category_tableHeader.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/therapy_management/std_data_list.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/therapy_management/therapy_home.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';
import 'package:vidyaveechi_website/view/widgets/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:vidyaveechi_website/view/widgets/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class TherapyManagement extends StatelessWidget {
  const TherapyManagement({super.key});
  @override
  Widget build(BuildContext context) {
    TherapyController therapycontroller = Get.put(TherapyController());
    final data = therapycontroller.therapyModelData.value;

    return Obx(() => therapycontroller.therapyhome.value == true
        ? TherapyHomePage()
        : SingleChildScrollView(
            child: Container(
              color: screenContainerbackgroundColor,
              height: ResponsiveWebSite.isMobile(context) ? 840 : 890,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 25),
                    child: TextFontWidget(
                      text: 'All Students List ',
                      fontsize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: InkWell(
                            onTap: () {
                              therapycontroller.therapyhome.value = true;
                            },
                            child: const RouteNonSelectedTextContainer(
                                width: 50, title: 'Back')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: InkWell(
                            onTap: () {},
                            child: const RouteSelectedTextContainer(
                                width: 100, title: 'Students List')),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ResponsiveWebSite.isMobile(context) ? 20 : 50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: cWhite,
                        height: ResponsiveWebSite.isMobile(context) ? 750 : 700,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     width: 250,
                                //     height: ResponsiveWebSite.isMobile(context) ? 80 : 100,
                                //     color: cWhite,
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(top: 10, bottom: 10),
                                //       child: TextFormFiledBlueContainerWidget(
                                //         // controller: studentController.stNameController,
                                //         hintText: "Enter Therapy Type",
                                //         title: 'Therapy Type ',
                                //         validator: checkFieldEmpty,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: TextFontWidget(
                                text: "Therapy Name : ${data!.therapyName}",
                                fontsize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 15),
                              child: TextFontWidget(
                                text: "Therapy Duration : ${data.duration}",
                                fontsize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 580,
                              width: ResponsiveWebSite.isMobile(context)
                                  ? double.infinity
                                  : 1300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: 'No')),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: "ID")),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: "Student Name")),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: "Class")),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: "Day")),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: "Status/Comment")),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: " Follow-up")),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CatrgoryTableHeaderWidget(
                                                headerTitle: "Edit")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 500,
                                      child: StreamBuilder(
                                          stream: server
                                              .collection(
                                                  'SchoolListCollection')
                                              .doc(UserCredentialsController
                                                  .schoolId)
                                              .collection(
                                                  UserCredentialsController
                                                      .batchId!)
                                              .doc(UserCredentialsController
                                                  .batchId!)
                                              .collection('Therapy')
                                              .doc(data.docid)
                                              .collection('students')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                  child: Text(
                                                      'Error loading data'));
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                      'Students data is not available'));
                                            }
                                            return ListView.separated(
                                              itemBuilder: (context, index) {
                                                StudentTherapyModel data =
                                                    StudentTherapyModel.fromMap(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data());

                                                return AllStdDataList(
                                                    data: data, index: index);
                                              },
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                height: 1,
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}
