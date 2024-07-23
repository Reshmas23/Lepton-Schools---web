import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/presentation/pages/widgets/video_widgets.dart';
import 'package:vidyaveechi_website/view/widgets/responsive.dart';

import '../../../../../../fonts/google_poppins_widget.dart';
import '../../../../../../utils/shared_pref/user_auth/user_credentials.dart';

class TeacherActivityGraph extends StatefulWidget {
  const TeacherActivityGraph({super.key});

  @override
  _TeacherActivityGraphState createState() => _TeacherActivityGraphState();
}

class _TeacherActivityGraphState extends State<TeacherActivityGraph> {
  late Future<List<ChartData>> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _fetchChartData();
  }

  Future<List<ChartData>> _fetchChartData() async {
    List<ChartData> chartData = [];

    // Fetch total classes attended
    QuerySnapshot classSnapshot = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('TeacherAttendence')
        .get();

    int totalClassesAttended = 0;
    if (classSnapshot.docs.isNotEmpty) {
      var data = classSnapshot.docs.first.data() as Map<String, dynamic>;
      totalClassesAttended = data['CountClassAttended'] ?? 0;
    }

    // Fetch number of days attended
    QuerySnapshot daySnapshot = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('TeacherAttendence')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DayWiseAttendence')
        .get();

    int totalDaysAttended = daySnapshot.size;

    // Populate chart data
    chartData.add(ChartData('Total Classes Attended', totalClassesAttended.toDouble()));
    chartData.add(ChartData('Total Days Attended', totalDaysAttended.toDouble()));

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWebSite.isMobile(context)?SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: FutureBuilder<List<ChartData>>(
                  future: _chartData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data available');
                    } else {
                      return SfCircularChart(
                        series: <CircularSeries>[
                          RadialBarSeries<ChartData, String>(
                            dataSource: snapshot.data!,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.inside,
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
           
            Container(
              color: Colors.white,
              height: 80, // Increased height to prevent overflow
              width: 300, // Increased width to prevent overflow
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 68, 141, 250),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Expanded(
                          child: GooglePoppinsWidgets(
                            text: 'Total class attended',
                            fontsize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Expanded(
                          child: GooglePoppinsWidgets(
                            text: 'Total days of attendance',
                            fontsize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ):Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: FutureBuilder<List<ChartData>>(
                future: _chartData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data available');
                  } else {
                    return SfCircularChart(
                      series: <CircularSeries>[
                        RadialBarSeries<ChartData, String>(
                          dataSource: snapshot.data!,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside,
                            textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),const Divider(),
          const SizedBox(height: 10,),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 68, 141, 250),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: GooglePoppinsWidgets(
                          text: 'Total class attended',
                          fontsize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: GooglePoppinsWidgets(
                          text: 'Total days of attendance',
                          fontsize: 10,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}