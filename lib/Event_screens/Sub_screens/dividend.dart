import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/Services/Provider/event_provider.dart';
import 'package:swot_page/constant/const.dart';

class DividendScreen extends StatefulWidget {
  const DividendScreen({Key? key}) : super(key: key);

  @override
  State<DividendScreen> createState() => _DividendScreenState();
}

class _DividendScreenState extends State<DividendScreen> {
  bool isFirst = true;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    final provider = Provider.of<EventProvider>(context);
    if (isFirst) {
      provider.dividendFetch().then((value) {
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
        : provider.dividendlist.isEmpty
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
                itemCount: provider.dividendlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return data(
                      exDate: provider.dividendlist[index][0] ?? "NA",
                      amount: provider.dividendlist[index][1].toString(),
                      type: provider.dividendlist[index][2] ?? "NA",
                      recordDate: provider.dividendlist[index][3] ?? "NA",
                      light: light);
                },
              );
  }

  Widget data(
          {required String exDate,
          required String amount,
          required String type,
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
          rowData(data1: "Amount : ", data2: amount, light: light),
          rowData(data1: "Type : ", data2: type, light: light),
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
