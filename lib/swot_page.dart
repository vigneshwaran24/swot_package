library swot_page;

import 'package:flutter/material.dart';

import 'package:swot_page/home.dart';

class SwotButton {
  // final BuildContext context;
  // final String nseCode;
  // const SwotButton({
  //   required this.context,
  //   required this.nseCode,
  // });

  static navigate({required BuildContext context, required String nseCode}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => HomePage(
                  ctx: _,
                  nseCode: nseCode,
                )));
  }
}
