import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/students/student_details/widgets/category_tableHeader.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/therapy_management/therapy_create.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/therapy_management/therapy_data_list.dart';
import 'package:vidyaveechi_website/view/users/super_admin/widgets/buttonContainer.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';

class TherapyHomePage extends StatelessWidget {
  const TherapyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TherapyController therapycontroller = Get.put(TherapyController());
    return SingleChildScrollView(
      child: Container(
        color: screenContainerbackgroundColor,
        height: ResponsiveWebSite.isMobile(context) ? 840 : 840,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  child: InkWell(
                    onTap: () {
                      therapycontroller.therapyhome.value = false;
                    },
                    child: const TextFontWidget(
                      text: 'All Therapy',
                      fontsize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 700),
                  child: GestureDetector(
                    onTap: () {
                      createTherapyAdmin(context);
                    },
                    child: ButtonContainerWidget(
                        curving: 30,
                        colorindex: 0,
                        height: 40,
                        width: 180,
                        child: const Center(
                          child: TextFontWidgetRouter(
                            text: 'Create Therapy',
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      // therapycontroller.therapyhome.value = false;
                    },
                    child: const TextFontWidget(
                      text: 'Add Students',
                      fontsize: 18,
                      fontWeight: FontWeight.bold,
                      color: cred,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveWebSite.isMobile(context) ? 20 : 50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: cWhite,
                  height: ResponsiveWebSite.isMobile(context) ? 750 : 700,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 580,
                        width: ResponsiveWebSite.isMobile(context) ? double.infinity : 1300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Expanded(
                                      flex: 1, child: CatrgoryTableHeaderWidget(headerTitle: 'No')),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: CatrgoryTableHeaderWidget(
                                          headerTitle: "Types of therapies")),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: CatrgoryTableHeaderWidget(headerTitle: "Description")),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(headerTitle: "Therapist")),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: CatrgoryTableHeaderWidget(headerTitle: "Duration")),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child:
                                          CatrgoryTableHeaderWidget(headerTitle: "Total students")),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  width: 1200,
                                  decoration: BoxDecoration(
                                    color: cWhite,
                                    border: Border.all(color: cWhite),
                                  ),
                                  child: ListView.separated(
                                    itemCount: 12,
                                    itemBuilder: (context, index) {
                                      return AllTherapyDataList(
                                        index: index,
                                      );
                                    },
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
