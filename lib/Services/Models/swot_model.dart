// To parse this JSON data, do
//
//     final swotmodel = swotmodelFromJson(jsonString);

import 'dart:convert';

Swotmodel swotmodelFromJson(String str) => Swotmodel.fromJson(json.decode(str));

String swotmodelToJson(Swotmodel data) => json.encode(data.toJson());

class Swotmodel {
  Swotmodel({
    required this.body,
  });

  Body body;

  factory Swotmodel.fromJson(Map<String, dynamic> json) => Swotmodel(
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.swotData,
  });

  SwotData swotData;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        swotData: SwotData.fromJson(json["SWOTData"]),
      );

  Map<String, dynamic> toJson() => {
        "SWOTData": swotData.toJson(),
      };
}

class SwotData {
  SwotData({
    required this.tableData,
    required this.resultType,
  });

  TableData tableData;
  String resultType;

  factory SwotData.fromJson(Map<String, dynamic> json) => SwotData(
        tableData: TableData.fromJson(json["tableData"]),
        resultType: json["resultType"],
      );

  Map<String, dynamic> toJson() => {
        "tableData": tableData.toJson(),
        "resultType": resultType,
      };
}

class TableData {
  TableData({
    required this.strengths,
    required this.weaknesses,
    required this.opportunities,
    required this.threats,
    required this.others,
  });

  List<List<dynamic>> strengths;
  List<List<dynamic>> weaknesses;
  List<List<dynamic>> opportunities;
  List<dynamic> threats;
  List<List<dynamic>> others;

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
        strengths: List<List<dynamic>>.from(
            json["strengths"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        weaknesses: List<List<dynamic>>.from(
            json["weaknesses"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        opportunities: List<List<dynamic>>.from(json["opportunities"]
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
        threats: List<dynamic>.from(json["threats"].map((x) => x)),
        others: List<List<dynamic>>.from(
            json["others"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "strengths": List<dynamic>.from(
            strengths.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "weaknesses": List<dynamic>.from(
            weaknesses.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "opportunities": List<dynamic>.from(
            opportunities.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "threats": List<dynamic>.from(threats.map((x) => x)),
        "others": List<dynamic>.from(
            others.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
