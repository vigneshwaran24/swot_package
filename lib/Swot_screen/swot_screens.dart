import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/Services/Provider/swot_provider.dart';

import '../constant/const.dart';
import '../Widgets/custom_chart.dart';

class Swot extends StatefulWidget {
  const Swot({Key? key}) : super(key: key);

  @override
  State<Swot> createState() => _SwotState();
}

class _SwotState extends State<Swot> {
  final controller = PageController();
  int index = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;
        final light =
            MediaQuery.of(context).platformBrightness == Brightness.light;

        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.white10,
            elevation: 0,
            leading: BackButton(
              color: light == true ? Colors.black : Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.03,
                ),
                Row(
                  children: [
                    button(onPressed: () {}, text: "Swot", selected: true),
                  ],
                ),
                // SizedBox(
                //   height: h * 0.00,
                // ),
                CustomChart(
                  h: h * 0.8,
                  w: w * 0.8,
                  isStatic: false,
                  getIndex: (value) {
                    controller.animateToPage(value,
                        duration: const Duration(milliseconds: 80),
                        curve: Curves.fastLinearToSlowEaseIn);
                    // controller.jumpToPage(value);
                  },
                  index: index,
                  nseCode: '',
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                Expanded(
                    child: PageView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    SwotPages(index: 0),
                    SwotPages(index: 1),
                    SwotPages(index: 2),
                    SwotPages(index: 3),
                  ],
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class SwotPages extends StatefulWidget {
  final int index;
  const SwotPages({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<SwotPages> createState() => _SwotPagesState();
}

class _SwotPagesState extends State<SwotPages> {
  List imgList = [strengthImg, weeknessImg, opportunityImg, treatsImg];
  List nameList = ["Strengths", "Weaknesses", "Opportunity", "Treats"];
  List colorList = [color1194EB, color707070, color7B71DC, colorF05D8F];

  List<dynamic> dataList = [];
  Color color = color1194EB;
  String img = strengthImg;
  String name = "Strengths";
  @override
  void initState() {
    type();
    super.initState();
  }

  type() {
    setState(() {
      switch (widget.index) {
        case 0:
          img = imgList[0];
          name = nameList[0];
          color = colorList[0];
          break;
        case 1:
          img = imgList[1];
          name = nameList[1];
          color = colorList[1];
          break;
        case 2:
          img = imgList[2];
          name = nameList[2];
          color = colorList[2];
          break;
        case 3:
          img = imgList[3];
          name = nameList[3];
          color = colorList[3];
          break;
        default:
          img = imgList[0];
          name = nameList[0];
          color = colorList[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    final provider = Provider.of<SwotProvider>(context);

    switch (widget.index) {
      case 0:
        setState(() {
          dataList = provider.strength;
        });
        break;
      case 1:
        setState(() {
          dataList = provider.weaknesses;
        });
        break;
      case 2:
        setState(() {
          dataList = provider.opportunity;
        });
        break;
      case 3:
        setState(() {
          dataList = provider.treats;
        });
        break;
      default:
    }

    return provider.res == null
        ? loading()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: font,
                        package: "swot_page"),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  CircleAvatar(
                    foregroundImage: AssetImage(img, package: "swot_page"),
                    backgroundColor: Colors.white,
                    radius: 11,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 40,
                height: 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: color),
              ),
              const SizedBox(height: 15),
              if (dataList.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "No threats to display",
                      style: TextStyle(
                          fontFamily: font,
                          fontSize: 14,
                          color: light == true ? Colors.black : Colors.white),
                    ),
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        dataList.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    trinagle(h: 15, w: 15, index: widget.index),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Text(
                                      dataList[index][1],
                                      style: TextStyle(
                                          color: light == true
                                              ? Colors.black
                                              : Colors.grey,
                                          fontFamily: font,
                                          fontSize: 13,
                                          package: "swot_page"),
                                    ))
                                  ]),
                            )),
                  ),
                ),
              )
            ],
          );
  }
}
