// To parse this JSON data, do
//
//     final dividendmodel = dividendmodelFromJson(jsonString);

import 'dart:convert';

Dividendmodel dividendmodelFromJson(String str) =>
    Dividendmodel.fromJson(json.decode(str));

String dividendmodelToJson(Dividendmodel data) => json.encode(data.toJson());

class Dividendmodel {
  Dividendmodel({
    required this.body,
  });

  Body body;

  factory Dividendmodel.fromJson(Map<String, dynamic> json) => Dividendmodel(
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

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        tableData: List<List<dynamic>>.from(
            json["tableData"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "tableData": List<dynamic>.from(
            tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
