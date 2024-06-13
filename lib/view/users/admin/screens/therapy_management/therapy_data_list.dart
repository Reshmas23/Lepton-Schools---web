import 'package:flutter/material.dart';
import 'package:vidyaveechi_website/model/notice_model/notice_model.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';

class AllTherapyDataList extends StatelessWidget {
  final NoticeModel? data;
  final int index;
  const AllTherapyDataList({
    this.data,
    required this.index,
    super.key,
  });

  // final NoticeController noticeController = Get.put(NoticeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? const Color.fromARGB(255, 246, 246, 246) : Colors.blue[50],
      ),
      child: const Row(
        children: [
          Expanded(
              flex: 1,
              child: TextFontWidget(
                text: '--',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: 02,
          ),
          Expanded(
              flex: 1,
              child: TextFontWidget(
                text: '--',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: 02,
          ),
          Expanded(
              flex: 3,
              child: TextFontWidget(
                text: '--',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: 02,
          ),
          Expanded(
              flex: 2,
              child: TextFontWidget(
                text: '--',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: 02,
          ),
          Expanded(
              flex: 2,
              child: TextFontWidget(
                text: '--',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: 02,
          ),
          Expanded(
              flex: 2,
              child: TextFontWidget(
                text: '--',
                fontsize: 12,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: 02,
          ),
        ],
      ),
    );
  }
}
