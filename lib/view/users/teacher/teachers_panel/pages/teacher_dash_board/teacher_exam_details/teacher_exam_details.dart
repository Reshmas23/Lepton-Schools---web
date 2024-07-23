import 'package:flutter/material.dart';
import 'package:vidyaveechi_website/view/fonts/google_poppins_widget.dart';

import '../../../../../../widgets/responsive/responsive.dart';
import 'teacher_class_exam_details_graph.dart';

class TeacherExamDetails extends StatelessWidget {
  const TeacherExamDetails({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: 300,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            offset: Offset(0.5, 0.5),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Exam Details",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [Row(children: [ Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color:  Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),), GooglePoppinsWidgets(text: 'Total Students', fontsize: 10), ],),
                          const SizedBox(width: 5,),
                             Row(children: [Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color:  Colors.greenAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),), GooglePoppinsWidgets(text: 'Passed Students', fontsize: 10), ],)  , Container(
                        width: 01,
                        color: Colors.grey,
                      ),
                                                ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Container(
                height: 200,
                width: ResponsiveWebSite.isTablet(context) ? double.infinity : 500,
                color: Colors.white,
                child: const TeacherClassExamDetailsGraph(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
