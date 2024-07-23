import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/subject_controller/subject_controller.dart';
import 'package:vidyaveechi_website/model/subject_model/subject_model.dart';

class ClaswiseTeacherSubjects extends StatelessWidget {
  ClaswiseTeacherSubjects({
    Key? key,
  }) : super(key: key);

  final SubjectController subjectController = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: subjectController.fetchClassWiseTimeTableTeacherSubject(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final teachers = snapshot.data ?? [];

            return ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final teacher = teachers[index];
                final teacherName = teacher['teacherName'] ?? '';
                final subjects = teacher['subjectName'] as List<SubjectModel>; // Cast correctly

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teacher: $teacherName',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: subjects.map((subject) {
                        return Text('- ${subject.subjectName}');
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
