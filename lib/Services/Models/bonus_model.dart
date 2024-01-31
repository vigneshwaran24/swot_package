// To parse this JSON data, do
//
//     final bonusmodel = bonusmodelFromJson(jsonString);

import 'dart:convert';

Bonusmodel bonusmodelFromJson(String str) =>
    Bonusmodel.fromJson(json.decode(str));

String bonusmodelToJson(Bonusmodel data) => json.encode(data.toJson());

class Bonusmodel {
  Bonusmodel({
    required this.body,
  });

  Body body;

  factory Bonusmodel.fromJson(Map<String, dynamic> json) => Bonusmodel(
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.tableData,
  });

  List<List<dynamic>> tableData;

  factory Body.fromJson(Map<dynamic, dynamic> json) => Body(
        tableData: List<List<dynamic>>.from(
            json["tableData"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "tableData": List<dynamic>.from(
            tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
