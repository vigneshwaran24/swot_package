// To parse this JSON data, do
//
//     final boardmeetingsmodel = boardmeetingsmodelFromJson(jsonString);

import 'dart:convert';

Boardmeetingsmodel boardmeetingsmodelFromJson(String str) =>
    Boardmeetingsmodel.fromJson(json.decode(str));

String boardmeetingsmodelToJson(Boardmeetingsmodel data) =>
    json.encode(data.toJson());

class Boardmeetingsmodel {
  Boardmeetingsmodel({
    required this.body,
  });

  Body body;

  factory Boardmeetingsmodel.fromJson(Map<String, dynamic> json) =>
      Boardmeetingsmodel(
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

  List<List<String>> tableData;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        tableData: List<List<String>>.from(
            json["tableData"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "tableData": List<dynamic>.from(
            tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
