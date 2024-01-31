import 'package:flutter/material.dart';

const color2796F3 = Color(0xff2796F3);
const color1194EB = Color(0xff1194EB);
const color0783FA = Color(0xff0783FA);
const color707070 = Color(0xff707070);
const color7B71DC = Color(0xff7B71DC);
const colorF05D8F = Color(0xffF05D8F);
const color35CDBD = Color(0xff35CDBD);
const color646161 = Color(0xff646161);
const colorC4B5B5 = Color(0xffC4B5B5);
const color766EE1 = Color(0xff766EE1);
const colorF7B343 = Color(0xffF7B343);
const colorA64063 = Color(0xffA64063);
const colorF76093 = Color(0xffF76093);
const color9B9191 = Color(0xff9B9191);
const color979797 = Color(0xff979797);

const bulb = "assets/swot.png";
const strengthImg = "assets/strength.png";
const weeknessImg = "assets/weekness.png";
const opportunityImg = "assets/opportunity.png";
const treatsImg = "assets/treats.png";
const agmImg = "assets/agm.png";
const boardmeetingImg = "assets/board-meeting.png";
const companyupdateImg = "assets/company-update.png";
const corpnoteImg = "assets/corp-note.png";
const newsImg = "assets/news.png";
const sastImg = "assets/sast.png";
//====================font=====================

const String font = "OpenSans";

//=============================================
const baseUrl =
    "https://middleware-uat.aliceblueonline.com:8181/trendlyne/stock/";
const swotApi = baseUrl + "overview?scrip=";
const dividendApi = baseUrl + "dividend?scrip=";
const bonusApi = baseUrl + "bonus-split?type=bonus&scrip=";
const splitApi = baseUrl + "bonus-split?type=split&scrip=";
const boardmeetingApi = baseUrl + "board-meetings?scrip=";
const newsApi =
    "https://middleware-uat.aliceblueonline.com:8181/trendlyne/following/news?";
//=============================================

ThemeData lightTheme() => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(color: Colors.white),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: color0783FA));

ThemeData darkTheme() => ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(color: Colors.black),
    iconTheme: const IconThemeData(color: Colors.black),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[900]),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white));

Widget loading() => const Center(
      child: CircularProgressIndicator.adaptive(),
    );

Widget button(
        {required VoidCallback onPressed,
        required String text,
        required bool selected}) =>
    TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor:
              selected ? color2796F3.withOpacity(0.2) : Colors.transparent,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(60, 30),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: selected ? color2796F3 : Colors.grey,
              fontSize: 14,
              fontFamily: font,
              package: "swot_page"),
        ));

Widget trinagle({required double h, required double w, required int index}) {
  return SizedBox(
    height: h,
    width: w,
    child: CustomPaint(
      painter: TrianglePainter(index: index),
    ),
  );
}

class TrianglePainter extends CustomPainter {
  int index;
  TrianglePainter({required this.index});
  color() {
    switch (index) {
      case 0:
        return [color35CDBD, color0783FA];
      case 1:
        return [color646161, colorC4B5B5];
      case 2:
        return [colorF7B343, color766EE1];
      case 3:
        return [colorF76093, colorA64063];
      default:
        return [color0783FA, color35CDBD];
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    final paint = Paint()
      ..color = color0783FA
      ..shader = LinearGradient(colors: color())
          .createShader(Rect.fromLTWH(0, 0, w, h));
    final path1 = Path()
      ..lineTo(0, h)
      ..lineTo(w, h / 2);

    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TrianglePainter oldDelegate) => false;
}
