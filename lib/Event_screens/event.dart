import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/Services/Provider/event_provider.dart';
import '../constant/const.dart';
import 'Sub_screens/boardmeetings.dart';
import 'Sub_screens/bonus.dart';
import 'Sub_screens/dividend.dart';
import 'Sub_screens/split.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List<String> tabname = ["Dividend", "Split", "Bonus", "Board Meetings"];
  bool isFirst = true;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    final provider = Provider.of<EventProvider>(context);
    if (isFirst) {
      provider.dividendFetch();
      provider.splitFetch();
      provider.bonusFetch();
      provider.boardmeetingFetch();
      setState(() {
        isFirst = false;
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TabBar(
            controller: controller,
            isScrollable: true,
            labelColor: color2796F3,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelColor: light == true ? Colors.black : Colors.grey,
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            // indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.transparent,
            tabs: tabname
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
        const SizedBox(height: 20),
        Expanded(
            child: TabBarView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          children: const [
            DividendScreen(),
            SplitScreen(),
            BonusScreen(),
            BoardMeetingsScreen(),
          ],
        ))
      ],
    );
  }
}
