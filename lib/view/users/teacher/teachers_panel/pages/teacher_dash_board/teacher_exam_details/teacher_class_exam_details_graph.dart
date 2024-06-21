import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vidyaveechi_website/controller/teacher_exam_graph_controller/teacher_exam_graph_controller.dart';

class TeacherClassExamDetailsGraph extends StatefulWidget {
  const TeacherClassExamDetailsGraph({super.key});

  @override
  _TeacherClassExamDetailsGraphState createState() => _TeacherClassExamDetailsGraphState();
}

class _TeacherClassExamDetailsGraphState extends State<TeacherClassExamDetailsGraph> {
  final TeacherExamStatusController examStatusController = Get.put(TeacherExamStatusController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (examStatusController.chartData.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final chartData = examStatusController.chartData;
      return SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(minimum: 0, maximum: 100, interval: 10),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Colors.blue,
          ),
          ColumnSeries<ChartData, String>(
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y1,
            color: Colors.greenAccent,
          ),
        ],
      );
    });
  }
}