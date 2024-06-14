import 'package:flutter/material.dart';
import 'package:vidyaveechi_website/model/therapy_model/therapy_model.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/ioT_Card/code.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';

class AllTherapyDataList extends StatelessWidget {
  final TherapyModel data;
  final int index;
  const AllTherapyDataList({
    required this.data,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? const Color.fromARGB(255, 246, 246, 246) : Colors.blue[50],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFontWidget(
              text: '${index + 1}',
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: TextFontWidget(
              text: data.therapyName,
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 3,
            child: TextFontWidget(
              text: data.therapyDes,
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: data.therapistNAme,
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 2,
            child: TextFontWidget(
              text: data.duration,
              fontsize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: server
                  .collection('SchoolListCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection('Therapy')
                  .doc(data.docid)
                  .collection('students')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const TextFontWidget(
                    text: 'Error',
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const TextFontWidget(
                    text: '0',
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  );
                } else {
                  final totalStd = snapshot.data!.docs.length;
                  return TextFontWidget(
                    text: totalStd.toString(),
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
