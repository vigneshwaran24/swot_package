import 'package:flutter/cupertino.dart';
import 'package:swot_page/Services/APIs/news_service.dart';
import 'package:swot_page/Services/Models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsList> newsList = [];
  String nseCode = "";
  updateNse({required String code}) {
    nseCode = code;
  }

  Future fetchNews() async {
    final result = await NewsServive.news(nsecode: nseCode).then((value) {
      if (value == null) return null;
      Newsmodel data = value;
      newsList = data.body.newsList;
      notifyListeners();
      return data;
    });
    return result;
  }

  List<NewsList> get getList {
    return newsList;
  }
}
