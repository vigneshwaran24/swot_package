import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:swot_page/Constant/const.dart';
import 'package:swot_page/Services/Models/swot_model.dart';

class SwotService {
  static Future datafetch({required String nseCode}) async {
    try {
      final response = await http.get(Uri.parse(swotApi + nseCode));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Swotmodel.fromJson(result);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
