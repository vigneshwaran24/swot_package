import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swot_page/Constant/const.dart';
import 'package:swot_page/Services/Models/news_model.dart';

class NewsServive {
  static Future news({required String nsecode}) async {
    try {
      final response = await http.get(
          Uri.parse(newsApi + "stockCodeList=$nsecode&stockCodeList=$nsecode"));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Newsmodel.fromJson(result);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
