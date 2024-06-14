// import 'package:awesome_side_sheet/Enums/sheet_position.dart';
// import 'package:awesome_side_sheet/side_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vidyaveechi_website/controller/therapy_controller/therapy_controller.dart';
// import 'package:vidyaveechi_website/view/constant/constant.validate.dart';
// import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
// import 'package:vidyaveechi_website/view/widgets/progess_button/progress_button.dart';
// import 'package:vidyaveechi_website/view/widgets/routeSelectedTextContainer/routeSelectedTextContainer.dart';
// import 'package:vidyaveechi_website/view/widgets/textformFiledContainer/textformFiledBlueContainer.dart';

// class CreateTherapy extends StatelessWidget {
//   final TherapyController therapyController = Get.put(TherapyController());
//   CreateTherapy({super.key});

//   // bool? valuefirst = false;
//   @override
//   Widget build(BuildContext context) {
//     // List<Widget> textformWidget = [
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       controller: noticeController.noticeHeadingController,
//     //       validator: checkFieldEmpty,
//     //       title: 'Heading',
//     //       hintText: 'Heading', /////////////////////////////////////////0
//     //     ),
//     //   ),

//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       controller: noticeController.noticePublishedDateController,
//     //       validator: checkFieldDateIsValid,
//     //       hintText: 'Published Date',
//     //       title: 'Published Date',
//     //     ),
//     //   ), ////////////////////////////////////////////////////////2
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       validator: checkFieldEmpty,
//     //       controller: noticeController.noticeSubjectController,
//     //       title: 'Subject',
//     //       hintText: 'Subject',
//     //     ),
//     //   ), ///////////////////////////////////////////////3
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       validator: checkFieldDateIsValid,
//     //       controller: noticeController.noticeDateofoccationontroller,
//     //       title: 'Date of occation',
//     //       hintText: 'Date of occation',
//     //     ),
//     //   ), ////////////////////////////////////4
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       validator: checkFieldEmpty,
//     //       controller: noticeController.noticevenueController,
//     //       title: 'Venue',
//     //       hintText: 'Venue',
//     //     ),
//     //   ), ////////////////////////////////////5
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       validator: checkFieldEmpty,
//     //       controller: noticeController.noticeGuestController,
//     //       title: 'Cheif guest',
//     //       hintText: 'Cheif guest',
//     //     ),
//     //   ), ////////////////////////////////////6
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       validator: checkFieldEmpty,
//     //       controller: noticeController.noticeSignedByController,
//     //       title: 'Signed by',
//     //       hintText: 'Signed by',
//     //     ),
//     //   ), ////////////////////////////////////7
//     //   Padding(
//     //     padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//     //     child: TextFormFiledHeightnoColor(
//     //       width: 500,
//     //       validator: checkFieldDateIsValid,
//     //       controller: noticeController.noticeDateofSubmissionontroller,
//     //       title: 'Date of Submission',
//     //       hintText: 'Date of Submission',
//     //     ),
//     //   ),

//     //   const Expanded(
//     //       child: SizedBox(
//     //     height: 40,
//     //     width: 400,
//     //   ))
//     // ];
//     return Container(
//       child: Form(
//         key: therapyController.formKey,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         aweSideSheet(
//                             context: context,
//                             sheetPosition: SheetPosition.right,
//                             header: Container(),
//                             body: Padding(
//                               padding: const EdgeInsets.only(left: 10, top: 10),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     const Row(
//                                       children: [
//                                         BackButton(),
//                                         SizedBox(
//                                           width: 20,
//                                         ),
//                                         TextFontWidget(
//                                           text: 'Therapy',
//                                           fontsize: 17,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       height: 900,
//                                       width: 500,
//                                       margin: const EdgeInsets.only(top: 10),
//                                       child:
//                                           //  Obx(() {
//                                           // return
//                                           Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Form(
//                                             key: therapyController.formKey,
//                                             child: Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       top: 5, left: 10, right: 10),
//                                                   child: TextFormFiledHeightnoColor(
//                                                     width: 500,
//                                                     controller: therapyController.nameController,
//                                                     validator: checkFieldEmpty,
//                                                     title: 'Student Name',
//                                                     hintText:
//                                                         'Student Name', /////////////////////////////////////////0
//                                                   ),
//                                                 ),
//                                                   Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       top: 5, left: 10, right: 10),
//                                                   child: TextFormFiledHeightnoColor(
//                                                     width: 500,
//                                                     controller: therapyController.classController,
//                                                     validator: checkFieldEmpty,
//                                                     title: 'Student Class',
//                                                     hintText:
//                                                         'Student Class', /////////////////////////////////////////0
//                                                   ),
//                                                 ),

//                                                 ////////////////////////////////////////////////////////2
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       top: 5, left: 10, right: 10),
//                                                   child: TextFormFiledHeightnoColor(
//                                                     width: 500,
//                                                     validator: checkFieldEmpty,
//                                                     controller: therapyController
//                                                         .therapyofStudentController,
//                                                     title: 'Therapy Student ',
//                                                     hintText: 'Therapy Student ',
//                                                   ),
//                                                 ), ///////////////////////////////////////////////3
//                                                 ////////////////////////////////////4
//                                                 ////////////////////////////////////5
//                                                 ////////////////////////////////////7

//                                                 ////////////////////////////////////6
//                                               ],
//                                             ),
//                                           ),
//                                           Padding(
//                                               padding: const EdgeInsets.only(top: 10, bottom: 10),
//                                               child: Center(
//                                                   child: ProgressButtonWidget(
//                                                       // function: () async {
//                                                       //   if (therapyController.formKey.currentState!
//                                                       //       .validate()) {
//                                                       // therapyController.createTherapy(),
//                                                       //     print("object");
//                                                       //   }
//                                                       // },
//                                                       buttonstate:
//                                                           therapyController.buttonstate.value,
//                                                       text: 'Add Student'))
//                                               // NoticeButtonContainerWidget(
//                                               //           text: 'Submit',
//                                               //          width: 300,
//                                               //         height: 50,
//                                               //         fontSize: 18,
//                                               //         onTap: () {
//                                               //            if (therapyController
//                                               //         .formKey
//                                               //         .currentState!
//                                               //         .validate()) {
//                                               //       therapyController
//                                               //           .createNotice();
//                                               //       print("object");
//                                               //     }
//                                               //         },
//                                               //         color: adminePrimayColor,
//                                               //   ),
//                                               ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             showCloseButton: false,
//                             footer: Container());
//                       },
//                       child: const RouteSelectedTextContainer(width: 140, title: 'Add')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// addTherapyStudent(BuildContext context) {
//   final TherapyController therapyController = Get.put(TherapyController());
//   aweSideSheet(
//       context: context,
//       sheetPosition: SheetPosition.right,
//       header: Container(),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 10, top: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Row(
//                 children: [
//                   BackButton(),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   TextFontWidget(
//                     text: 'Add Student',
//                     fontsize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 900,
//                 width: 500,
//                 margin: const EdgeInsets.only(top: 10),
//                 child:
//                     //  Obx(() {
//                     // return
//                     Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Form(
//                       key: therapyController.formKey,
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                             child: TextFormFiledHeightnoColor(
//                               width: 500,
//                               controller: therapyController.nameController,
//                               validator: checkFieldEmpty,
//                               title: ' Student Name',
//                               hintText: ' Student Name', /////////////////////////////////////////0
//                             ),
//                           ),

//                           ////////////////////////////////////////////////////////2
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                             child: TextFormFiledHeightnoColor(
//                               width: 500,
//                               validator: checkFieldEmpty,
//                               controller: therapyController.classController,
//                               title: 'Student Class',
//                               hintText: 'Student Class',
//                             ),
//                           ), ///////////////////////////////////////////////3
//                           ////////////////////////////////////4
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                             child: TextFormFiledHeightnoColor(
//                               width: 500,
//                               validator: checkFieldEmpty,
//                               controller: therapyController.therapyofStudentController,
//                               title: 'Studet Therapy',
//                               hintText: 'Student Therapy',
//                             ),
//                           ), ////////////////////////////////////5
//                           ////////////////////////////////////7

//                           ////////////////////////////////////6
//                         ],
//                       ),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                         child: Center(
//                             child: ProgressButtonWidget(
//                                 function: () async {
//                                   if (therapyController.formKey.currentState!.validate()) {
//                                     // therapyController.createNotice();
//                                     print("object");
//                                   }
//                                 },
//                                 buttonstate: therapyController.buttonstate.value,
//                                 text: 'Add Student'))),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       showCloseButton: false,
//       footer: Container());
// }
