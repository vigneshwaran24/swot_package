import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swot_page/Constant/const.dart';
import 'package:http/http.dart' as http;
import 'package:swot_page/Services/Models/boardmeetings_model.dart';
import 'package:swot_page/Services/Models/bonus_model.dart';
import 'package:swot_page/Services/Models/dividend_model.dart';
import 'package:swot_page/Services/Models/split_model.dart';

class EventService {
  static Future divident({required String nsecode}) async {
    try {
      final response = await http.get(Uri.parse(dividendApi + nsecode));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Dividendmodel.fromJson(result);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future split({required String nsecode}) async {
    try {
      final response = await http.get(Uri.parse(splitApi + nsecode));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Splitmodel.fromJson(result);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future bonus({required String nsecode}) async {
    try {
      final response = await http.get(Uri.parse(bonusApi + nsecode));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Bonusmodel.fromJson(result);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future boardmeeting({required String nsecode}) async {
    try {
      final response = await http.get(Uri.parse(boardmeetingApi + nsecode));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Boardmeetingsmodel.fromJson(result);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
