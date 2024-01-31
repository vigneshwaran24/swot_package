// To parse this JSON data, do
//
//     final Splitmodel = SplitmodelFromJson(jsonString);

import 'dart:convert';

Splitmodel splitmodelFromJson(String str) =>
    Splitmodel.fromJson(json.decode(str));

String splitmodelToJson(Splitmodel data) => json.encode(data.toJson());

class Splitmodel {
  Splitmodel({
    required this.body,
  });

  Body body;

  factory Splitmodel.fromJson(Map<String, dynamic> json) => Splitmodel(
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
