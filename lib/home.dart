import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Event_screens/event.dart';
import 'News_screen/news_screen.dart';
import 'Services/Provider/event_provider.dart';
import 'Services/Provider/news_provider.dart';
import 'Services/Provider/swot_provider.dart';
import 'Swot_screen/swot_screens.dart';
import 'Widgets/custom_chart.dart';
import 'constant/const.dart';

class HomePage extends StatefulWidget {
  final BuildContext ctx;
  final String nseCode;
  const HomePage({
    Key? key,
    required this.ctx,
    required this.nseCode,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();
  int tabIndex = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SwotProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final h = constraints.maxHeight;
          final w = constraints.maxWidth;
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.white,
              leading: BackButton(
                color: light == true ? Colors.black : Colors.white,
                onPressed: () {
                  Navigator.pop(widget.ctx);
                },
              ),
            ),
            body: Center(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: h * 0.04, left: w * 0.05, right: w * 0.05),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      button(
                          onPressed: () {
                            controller.jumpToPage(0);
                          },
                          text: "Swot",
                          selected: tabIndex == 0 ? true : false),
                      SizedBox(width: w * 0.05),
                      button(
                          onPressed: () {
                            controller.jumpToPage(1);
                          },
                          text: "Event",
                          selected: tabIndex == 1 ? true : false),
                      SizedBox(width: w * 0.05),
                      button(
                          onPressed: () {
                            // controller.animateToPage(2,
                            //     duration: const Duration(milliseconds: 200),
                            //     curve: Curves.fastLinearToSlowEaseIn);
                            controller.jumpToPage(2);
                          },
                          text: "News",
                          selected: tabIndex == 2 ? true : false)
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        tabIndex = value;
                      });
                    },
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomChart(
                            h: h * 0.9,
                            w: w * 0.9,
                            isStatic: true,
                            getIndex: (_) {},
                            index: -1,
                            nseCode: widget.nseCode,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Swot()));
                            },
                            child: SizedBox(
                              height: h * 0.4,
                              width: h * 0.4,
                            ),
                          )
                        ],
                      ),
                      const EventPage(),
                      const NewsScreen()
                    ],
                  ),
                ),
              ],
            )),
          );
        }),
      ),
    );
  }
}
