// To parse this JSON data, do
//
//     final newsmodel = newsmodelFromJson(jsonString);

import 'dart:convert';

Newsmodel newsmodelFromJson(String str) => Newsmodel.fromJson(json.decode(str));

String newsmodelToJson(Newsmodel data) => json.encode(data.toJson());

class Newsmodel {
  Newsmodel({
    required this.body,
  });

  Body body;

  factory Newsmodel.fromJson(Map<String, dynamic> json) => Newsmodel(
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.newsList,
  });

  List<NewsList> newsList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        newsList: List<NewsList>.from(
            json["newsList"].map((x) => NewsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "newsList": List<dynamic>.from(newsList.map((x) => x.toJson())),
      };
}

class NewsList {
  NewsList({
    required this.stockId,
    required this.userType,
    required this.pubDate,
    required this.title,
    required this.description,
    required this.descriptionHtml,
    required this.authorId,
    required this.isPremium,
    required this.url,
    required this.source,
    required this.imageUrl,
  });

  int stockId;
  int userType;
  String pubDate;
  String title;
  String description;
  String descriptionHtml;
  int authorId;
  bool isPremium;
  String url;
  String source;
  String imageUrl;

  factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
        stockId: json["stockId"],
        userType: json["userType"],
        pubDate: json["pubDate"] ?? "NA",
        title: json["title"] ?? "NA",
        description: json["description"] ?? "NA",
        descriptionHtml: json["descriptionHTML"] ?? "NA",
        authorId: json["authorId"],
        isPremium: json["isPremium"],
        url: json["url"] ?? "",
        source: json["source"] ?? "NA",
        imageUrl: json["imageUrl"] ?? "NA",
      );

  Map<String, dynamic> toJson() => {
        "stockId": stockId,
        "userType": userType,
        "pubDate": pubDate,
        "title": title,
        "description": description,
        "descriptionHTML": descriptionHtml,
        "authorId": authorId,
        "isPremium": isPremium,
        "url": url,
        "source": source,
        "imageUrl": imageUrl,
      };
}
