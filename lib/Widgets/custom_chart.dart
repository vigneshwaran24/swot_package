import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/Services/Provider/event_provider.dart';
import 'package:swot_page/Services/Provider/news_provider.dart';
import 'package:swot_page/Services/Provider/swot_provider.dart';

import '../constant/const.dart';

class CustomChart extends StatefulWidget {
  final double h;
  final double w;
  final bool isStatic;
  final Function getIndex;
  final int index;
  final String nseCode;

  const CustomChart(
      {Key? key,
      required this.h,
      required this.w,
      required this.isStatic,
      required this.getIndex,
      required this.index,
      required this.nseCode})
      : super(key: key);

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  int btnIndex = -1;
  @override
  void initState() {
    if (!widget.isStatic) {
      setState(() {
        btnIndex = 0;
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomChart oldWidget) {
    setState(() {
      if (widget.index != -1) {
        btnIndex = widget.index;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  bool isFirst = true;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SwotProvider>(context);
    final event = Provider.of<EventProvider>(context);
    final news = Provider.of<NewsProvider>(context);
    if (isFirst) {
      provider.updateNse(code: widget.nseCode);
      event.updateNse(code: widget.nseCode);
      news.updateNse(code: widget.nseCode);
      provider.getdata().then((value) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });

      setState(() {
        isFirst = false;
      });
    }
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    return isLoading
        ? loading()
        : Center(
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: widget.h * 0.4,
                width: widget.h * 0.4,
                child: CustomPaint(
                  painter: ChartPainter(
                    context: context,
                    index: btnIndex,
                  ),
                ),
              ),
              Container(
                height: widget.h * 0.27,
                width: widget.h * 0.27,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: light == true
                              ? Colors.grey.shade300
                              : Colors.white10,
                          offset: const Offset(-10, 0),
                          blurRadius: 40)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage(bulb, package: "swot_page"),
                      height: widget.h * 0.12,
                    ),

                    // Image.asset(
                    //   bulb,
                    //   height: widget.h * 0.12,
                    // ),
                    SizedBox(
                      height: widget.h * 0.01,
                    ),
                    Text(
                      "Swot",
                      style: TextStyle(
                          fontSize: widget.h * 0.032,
                          fontFamily: font,
                          package: "swot_page"),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: widget.h * 0.016,
                  right: widget.h * 0.12,
                  child: InkWell(
                    onTap: () {
                      if (widget.isStatic) return;

                      setState(() {
                        btnIndex = 0;
                      });
                      widget.getIndex(0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: textValue(
                          text: provider.strength.length < 10
                              ? "0" + provider.strength.length.toString()
                              : provider.strength.length.toString()),
                    ),
                  )),
              Positioned(
                  top: widget.h * 0.105,
                  right: widget.h * 0.018,
                  child: InkWell(
                    onTap: () {
                      if (widget.isStatic) return;
                      setState(() {
                        btnIndex = 1;
                      });
                      widget.getIndex(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: textValue(
                          text: provider.weaknesses.length < 10
                              ? "0" + provider.weaknesses.length.toString()
                              : provider.weaknesses.length.toString()),
                    ),
                  )),
              Positioned(
                  top: widget.h * 0.235,
                  right: widget.h * 0.016,
                  child: InkWell(
                    onTap: () {
                      if (widget.isStatic) return;
                      setState(() {
                        btnIndex = 2;
                      });
                      widget.getIndex(2);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: textValue(
                          text: provider.opportunity.length < 10
                              ? "0" + provider.opportunity.length.toString()
                              : provider.opportunity.length.toString()),
                    ),
                  )),
              Positioned(
                  bottom: widget.h * 0.01,
                  right: widget.h * 0.115,
                  child: InkWell(
                    onTap: () {
                      if (widget.isStatic) return;
                      setState(() {
                        btnIndex = 3;
                      });
                      widget.getIndex(3);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: textValue(
                          text: provider.treats.length < 10
                              ? "0" + provider.treats.length.toString()
                              : provider.treats.length.toString()),
                    ),
                  )),
            ]),
          );
  }

  Text textValue({required String text}) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: widget.h * 0.03,
          fontWeight: FontWeight.bold,
          fontFamily: font,
          package: "swot_page"),
    );
  }
}

class ChartPainter extends CustomPainter {
  int index;
  final BuildContext context;
  ChartPainter({
    required this.index,
    required this.context,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    final circle = Paint()..color = Colors.transparent;
    canvas.drawCircle(Offset(w / 2, h / 2), min(w / 2, h / 2), circle);
    var pie_1 = Paint()
      ..color = Colors.white
      ..shader = const SweepGradient(colors: [
        Color(0xFF0783FA),
        Color(0xFF35CDBD),
        Color(0xFF0783FA),
        Color(0xFF35CDBD),
        Color(0xFF0783FA),
        Color(0xFF35CDBD),
        Color(0xFF0783FA),
        Color(0xFF35CDBD),
        Color(0xFF0783FA),
      ]).createShader(Rect.fromCircle(
          center: Offset(w / 2, h / 2), radius: min(w / 2, h / 2)));
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(w / 2, h / 2),
          radius: index == 0 ? min(w / 2, h / 2) + 15 : min(w / 2, h / 2)),
      pi * -0.5,
      pi * 0.2,
      true,
      pie_1,
    );
    var pie_2 = Paint()
      ..color = Colors.white
      ..shader = const SweepGradient(colors: [
        Color(0xFFC4B5B5),
        Color(0xFF646161),
        Color(0xFFC4B5B5),
        Color(0xFF646161),
        Color(0xFFC4B5B5),
        Color(0xFF646161),
        Color(0xFFC4B5B5),
        Color(0xFF646161),
        Color(0xFFC4B5B5),
      ]).createShader(Rect.fromCircle(
          center: Offset(w / 2, h / 2), radius: min(w / 2, h / 2)));
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(w / 2, h / 2),
            radius: index == 1 ? min(w / 2, h / 2) + 15 : min(w / 2, h / 2)),
        pi * -0.23,
        pi * 0.2,
        true,
        pie_2);
    var pie_3 = Paint()
      ..color = Colors.white
      ..shader = const SweepGradient(colors: [
        Color(0xFF766EE1),
        Color(0xFFF7B343),
        Color(0xFFF7B343),
        Color(0xFF766EE1),
        Color(0xFFF7B343),
        Color(0xFF766EE1),
        Color(0xFFF7B343),
        Color(0xFF766EE1),
        Color(0xFFF7B343),
      ]).createShader(Rect.fromCircle(
          center: Offset(w / 2, h / 2), radius: min(w / 2, h / 2)));
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(w / 2, h / 2),
            radius: index == 2 ? min(w / 2, h / 2) + 15 : min(w / 2, h / 2)),
        pi * 0.03,
        pi * 0.2,
        true,
        pie_3);
    var pie_4 = Paint()
      ..color = Colors.white
      ..shader = const SweepGradient(colors: [
        Color(0xFFF76093),
        Color(0xFFA64063),
        Color(0xFFF76093),
        Color(0xFFA64063),
        Color(0xFFF76093),
        Color(0xFFA64063),
        Color(0xFFF76093),
        Color(0xFFA64063),
        Color(0xFFF76093),
      ]).createShader(Rect.fromCircle(
          center: Offset(w / 2, h / 2), radius: min(w / 2, h / 2)));
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(w / 2, h / 2),
            radius: index == 3 ? min(w / 2, h / 2) + 15 : min(w / 2, h / 2)),
        pi * 0.3,
        pi * 0.2,
        true,
        pie_4);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ChartPainter oldDelegate) => true;
}
