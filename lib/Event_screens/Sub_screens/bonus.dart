import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/Services/Provider/event_provider.dart';

import '../../constant/const.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({Key? key}) : super(key: key);

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  bool isFirst = true;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    final provider = Provider.of<EventProvider>(context);
    if (isFirst) {
      provider.bonusFetch().then((value) {
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
        : provider.bonuslist.isEmpty
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
                itemCount: provider.bonuslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return data(
                      exDate: provider.bonuslist[index][0] ?? "NA",
                      ratio: provider.bonuslist[index][1] ?? "NA",
                      recordDate: provider.bonuslist[index][2] ?? "NA",
                      light: light);
                },
              );
  }

  Widget data(
          {required String exDate,
          required String ratio,
          required String recordDate,
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
          rowData(data1: "Ratio : ", data2: ratio, light: light),
          rowData(
              data1: "Record Date : ",
              data2: recordDate != "NA"
                  ? DateFormat.yMMMd("en_US")
                      .format(DateTime.parse(recordDate))
                      .toString()
                  : recordDate,
              light: light),
          const SizedBox(height: 10),
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
        children: [
          text(text: data1, bold: true, light: light),
          const SizedBox(width: 10),
          text(text: data2, light: light)
        ],
      ),
    );
  }

  Widget text({required String text, bool bold = false, required bool light}) =>
      Text(
        text,
        style: TextStyle(
            fontSize: 12,
            fontWeight: bold ? FontWeight.bold : FontWeight.w400,
            color: light == true ? Colors.black : Colors.grey,
            fontFamily: font,
            package: "swot_page"),
      );
}
