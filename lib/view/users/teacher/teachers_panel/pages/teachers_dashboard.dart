import 'package:flutter/material.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/presentation/pages/widgets/video_widgets.dart';

import '../../../../fonts/text_widget.dart';
import '../../../../widgets/responsive/responsive.dart';
import 'teacher_dash_board/teacher_class_attendence_graph_container/teacher_class_attendence.dart';
import 'teacher_dash_board/teacher_classes_students_details/t_statistics_of_horizontal_container.dart';
import 'teacher_dash_board/teacher_exam_details/teacher_exam_details.dart';
import 'teacher_dash_board/teaching_activity/teaching_activity.dart';

class TeacherDashBoardScreen extends StatelessWidget {
  const TeacherDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> teacherDashboardWidget = [
      const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: TStatisticsOfHorizontalContainer(),
        ),
      ), // Teachersection Horizontal Container list
      const TeacherExamDetails(),
      const TeachingActivity(),

      const TeacherClassAttendence(),
    ];
    ////////////////////////////////////
    return Container(
      height: ResponsiveWebSite.isMobile(context) ? 1200 : 800,

      color: const Color.fromARGB(138, 245, 247, 249),

      child:
          ResponsiveWebSite.isMobile(context) //.,..................MOBILE VIEW
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
                      child: TextFontWidget(
                        text: "Welcome Teacher ",
                        fontsize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    teacherDashboardWidget[
                        0], //...Teacher Statistics Horizontal Container
                    teacherDashboardWidget[1], //....Teacher Class Attendence
                    teacherDashboardWidget[2], //....Teacher Exam Details
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: teacherDashboardWidget[3], //....Teaching Activity
                    ),
                  ],
                )
              : Column(
                  //............................................ TAB AND WEB VIEW
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
                      child: TextFontWidget(
                        text: "Welcome Teacher ",
                        fontsize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   teacherDashboardWidget[0],
                    Row(
                      children: [
                        Expanded(flex: 2,child: teacherDashboardWidget[1]),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(flex: 1,child: teacherDashboardWidget[2]),
                      ],
                    ),
                  
                        Row(
                          children: [
                            Expanded(child: teacherDashboardWidget[3]),
                          ],
                        ),
                  
                  ],
                ),
      // child: SingleChildScrollView(
      //     child: ResponsiveWebSite.isDesktop(context)
      //         ? Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [

      //               const SingleChildScrollView(
      //                 scrollDirection: Axis.horizontal,
      //                 child: Padding(
      //                   padding: EdgeInsets.only(bottom: 10),
      //                   child: TStatisticsOfHorizontalContainer(),
      //                 ),
      //               ),
      //               // const SizedBox(
      //               //   height: 10,
      //               // ),
      //               const Padding(
      //                 padding: EdgeInsets.only(bottom: 10),
      //                 child: Row(
      //                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   children: [
      //                     Expanded(flex: 2, child: TeacherClassAttendence()),
      //                     Expanded(flex: 2, child: TeacherExamDetails()),
      //                   ],
      //                 ),
      //               ),
      //               // const SizedBox(
      //               //   height: 10,
      //               // ),
      //               const Padding(
      //                 padding: EdgeInsets.only(left: 10, bottom: 10),
      //                 child: TeachingActivity(),
      //               ),
      //               // const SizedBox(
      //               //   height: 10,
      //               // ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 10),
      //                 child: Container(
      //                   height: 300,
      //                   width: 750,
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(12),
      //                       color: Colors.blue),
      //                 ),
      //               ),
      //             ],
      //           )
      //         : ResponsiveWebSite.isTablet(context)
      //             ? Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.only(
      //                         left: 30, top: 20, bottom: 10),
      //                     child: TextFontWidget(
      //                       text: "Welcome Teacher ",
      //                       fontsize: 22,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                   const SingleChildScrollView(
      //                     scrollDirection: Axis.horizontal,
      //                     child: Padding(
      //                       padding: EdgeInsets.only(bottom: 10),
      //                       child: TStatisticsOfHorizontalContainer(),
      //                     ),
      //                   ),
      //                   // const SizedBox(
      //                   //   height: 10,
      //                   // ),
      //                   const Padding(
      //                     padding: EdgeInsets.only(bottom: 10),
      //                     child: Column(
      //                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: [
      //                         Padding(
      //                           padding: EdgeInsets.only(bottom: 10),
      //                           child: SizedBox(
      //                               width: double.infinity,
      //                               child: TeacherClassAttendence()),
      //                         ),
      //                         SizedBox(
      //                             width: double.infinity,
      //                             child: TeacherExamDetails()),
      //                       ],
      //                     ),
      //                   ),
      //                   // const SizedBox(
      //                   //   height: 10,
      //                   // ),
      //                   const Padding(
      //                     padding: EdgeInsets.only(left: 10, bottom: 10),
      //                     child: TeachingActivity(),
      //                   ),
      //                   // const SizedBox(
      //                   //   height: 10,
      //                   // ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 10),
      //                     child: Container(
      //                       height: 300,
      //                       width: 750,
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(12),
      //                           color: Colors.blue),
      //                     ),
      //                   ),
      //                 ],
      //               )
      //             : ResponsiveWebSite.isMobile(context)
      //                 ? Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.only(
      //                             left: 30, top: 20, bottom: 10),
      //                         child: TextFontWidget(
      //                           text: "Welcome Teacher ",
      //                           fontsize: 22,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       const SingleChildScrollView(
      //                         scrollDirection: Axis.horizontal,
      //                         child: Padding(
      //                           padding: EdgeInsets.only(bottom: 10),
      //                           child: TStatisticsOfHorizontalContainer(),
      //                         ),
      //                       ),
      //                       // const SizedBox(
      //                       //   height: 10,
      //                       // ),
      //                       const Padding(
      //                         padding: EdgeInsets.only(bottom: 10),
      //                         child: Column(
      //                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                           children: [
      //                             Padding(
      //                               padding: EdgeInsets.only(bottom: 10),
      //                               child: SizedBox(
      //                                   width: double.infinity,
      //                                   child: TeacherClassAttendence()),
      //                             ),
      //                             SizedBox(
      //                                 width: double.infinity,
      //                                 child: ()),
      //                           ],
      //                         ),
      //                       ),
      //                       // const SizedBox(
      //                       //   height: 10,
      //                       // ),
      //                       const Padding(
      //                         padding: EdgeInsets.only(left: 10, bottom: 10),
      //                         child: TeachingActivity(),
      //                       ),
      //                       // const SizedBox(
      //                       //   height: 10,
      //                       // ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 10),
      //                         child: Container(
      //                           height: 300,
      //                           width: 750,
      //                           decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(12),
      //                               color: Colors.blue),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //                 : null),
    );
  }
}
