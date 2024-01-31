import 'package:flutter/material.dart';
import 'package:swot_page/Services/APIs/event_service.dart';
import 'package:swot_page/Services/Models/boardmeetings_model.dart';
import 'package:swot_page/Services/Models/bonus_model.dart';
import 'package:swot_page/Services/Models/dividend_model.dart';
import 'package:swot_page/Services/Models/split_model.dart';

class EventProvider extends ChangeNotifier {
  List<dynamic> dividendlist = [];
  List<dynamic> splitlist = [];
  List<dynamic> bonuslist = [];
  List<dynamic> boardmeetinglist = [];
  String nseCode = "";

  updateNse({required String code}) {
    nseCode = code;
  }

  Future dividendFetch() async {
    final result = await EventService.divident(nsecode: nseCode).then((value) {
      if (value == null) return null;
      Dividendmodel data = value;
      dividendlist = data.body.tableData;
      notifyListeners();
      return data;
    });
    return result;
  }

  Future splitFetch() async {
    final result = await EventService.split(nsecode: nseCode).then((value) {
      if (value == null) return null;
      Splitmodel data = value;
      splitlist = data.body.tableData;
      notifyListeners();
      return data;
    });
    return result;
  }

  Future bonusFetch() async {
    final result = await EventService.bonus(nsecode: nseCode).then((value) {
      if (value == null) return null;
      Bonusmodel data = value;
      bonuslist = data.body.tableData;
      notifyListeners();
      return data;
    });
    return result;
  }

  Future boardmeetingFetch() async {
    final result =
        await EventService.boardmeeting(nsecode: nseCode).then((value) {
      if (value == null) return null;
      Boardmeetingsmodel data = value;
      boardmeetinglist = data.body.tableData;
      notifyListeners();
      return data;
    });
    return result;
  }
}
