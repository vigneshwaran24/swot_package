import 'package:flutter/cupertino.dart';
import 'package:swot_page/Services/APIs/swot_service.dart';
import 'package:swot_page/Services/Models/swot_model.dart';

class SwotProvider extends ChangeNotifier {
  List<dynamic> strength = [];
  List<dynamic> weaknesses = [];
  List<dynamic> opportunity = [];
  List<dynamic> treats = [];
  Swotmodel? res;
  String nseCode = "";

  updateNse({required String code}) {
    nseCode = code;
  }

  Future getdata() async {
    if (nseCode == "") return;

    final result = await SwotService.datafetch(nseCode: nseCode).then((value) {
      if (value == null) return null;
      Swotmodel data = value;
      res = data;
      strength = data.body.swotData.tableData.strengths;
      weaknesses = data.body.swotData.tableData.weaknesses;
      opportunity = data.body.swotData.tableData.opportunities;
      treats = data.body.swotData.tableData.threats;

      notifyListeners();
      return data;
    });
    return result;
  }
}
