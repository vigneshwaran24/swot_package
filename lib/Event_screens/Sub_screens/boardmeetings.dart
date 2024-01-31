import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/Services/Provider/event_provider.dart';

import '../../constant/const.dart';

class BoardMeetingsScreen extends StatefulWidget {
  const BoardMeetingsScreen({Key? key}) : super(key: key);

  @override
  State<BoardMeetingsScreen> createState() => _BoardMeetingsScreenState();
}

class _BoardMeetingsScreenState extends State<BoardMeetingsScreen> {
  bool isFirst = true;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    final provider = Provider.of<EventProvider>(context);
    if (isFirst) {
      provider.boardmeetingFetch().then((value) {
        setState(() {
          isLoading = false;
        });
      });
      setState(() {
        isFirst = false;
      });
    }
    return isLoading
        ? loading()
        : provider.boardmeetinglist.isEmpty
            ? Center(
                child: Text(
                  "No threats to display",
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 14,
                      color: light == true ? Colors.black : Colors.white),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                physics: const BouncingScrollPhysics(),
                itemCount: provider.boardmeetinglist.length,
                itemBuilder: (BuildContext context, int index) {
                  return data(
                      exDate: provider.boardmeetinglist[index][0] ?? "NA",
                      purpose: provider.boardmeetinglist[index][1] ?? "NA",
                      remark: provider.boardmeetinglist[index][2] ?? "NA",
                      ctx: context,
                      light: light);
                },
              );
  }

  Widget data(
          {required String exDate,
          required String purpose,
          required String remark,
          required BuildContext ctx,
          required bool light}) =>
      Column(
        children: [
          const SizedBox(height: 10),
          rowData(
              data1: "Ex-Date : ",
              data2: exDate != "NA"
                  ? DateFormat.yMMMd("en_US")
                      .format(DateTime.parse(exDate))
                      .toString()
                  : exDate,
              light: light),
          rowData(data1: "Purpose : ", data2: purpose, light: light),
          rowData(data1: "Remark : ", data2: "", light: light),
          text(text: remark, color: light == true ? Colors.black : Colors.grey),
          if (remark.length > 100)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      // minimumSize: const Size(60, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      splashFactory: NoSplash.splashFactory,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          isScrollControlled: true,
                          context: ctx,
                          builder: (context) => viewMore(
                              exDate: exDate,
                              purpose: purpose,
                              light: light,
                              remark: remark));
                    },
                    child: text(text: "view more", color: color1194EB)),
              ],
            ),
          // const SizedBox(height: 10),
          Divider(
            color: light == true ? Colors.grey.shade400 : Colors.grey.shade800,
          )
        ],
      );

  Widget rowData(
      {required String data1, required String data2, required bool light}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
              text: data1,
              bold: true,
              color: light == true ? Colors.black : Colors.grey),
          const SizedBox(width: 10),
          Expanded(
              child: text(
                  text: data2,
                  color: light == true ? Colors.black : Colors.grey))
        ],
      ),
    );
  }

  Widget text(
          {required String text,
          bool bold = false,
          Color color = Colors.black,
          double size = 12}) =>
      Text(
        text,
        style: TextStyle(
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : FontWeight.w400,
            color: color,
            fontFamily: font,
            package: "swot_page"),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  DraggableScrollableSheet viewMore(
          {required exDate,
          required purpose,
          required remark,
          required bool light}) =>
      DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.8,
        initialChildSize: 0.8,
        minChildSize: 0.8,
        builder: (context, scrollController) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 4,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade300),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                rowData(
                    data1: "Ex-Date : ",
                    data2: exDate != "NA"
                        ? DateFormat.yMMMd("en_US")
                            .format(DateTime.parse(exDate))
                            .toString()
                        : exDate,
                    light: light),
                rowData(data1: "Purpose : ", data2: purpose, light: light),
                rowData(data1: "Remark : ", data2: "", light: light),
                const SizedBox(height: 10),
                Text(
                  remark,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: light == true ? Colors.black : Colors.grey,
                      fontFamily: font),
                )
              ],
            ),
          ),
        ),
      );
}
