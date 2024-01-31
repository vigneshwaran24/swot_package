import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swot_page/News_screen/web/webview.dart';
import 'package:swot_page/Services/Provider/news_provider.dart';

import '../constant/const.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late PageController controller;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    controller = PageController(viewportFraction: 1);
    super.initState();
  }

  bool isFirst = true;
  bool isLoading = true;
  String image = "";
  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    final provider = Provider.of<NewsProvider>(context);
    if (isFirst) {
      provider.fetchNews().then((value) {
        setState(() {
          isLoading = false;
        });
      });
      setState(() {
        isFirst = false;
      });
    }
    return isLoading
        ? loading()
        : provider.getList.isEmpty
            ? Center(
                child: Text(
                  "No threats to display",
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 14,
                      color: light == true ? Colors.black : Colors.white),
                ),
              )
            : PageView.builder(
                scrollDirection: Axis.vertical,
                controller: controller,
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                itemCount: provider.getList.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        const SizedBox(height: 30),
                        provider.getList[index].imageUrl == "NA"
                            ? Image(
                                image: AssetImage(
                                    newsImage(
                                        type: provider.getList[index].userType),
                                    package: "swot_page"),
                                height: 250,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: provider.getList[index].imageUrl,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error_outline),
                                height: 250,
                                width: 400,
                                fit: BoxFit.cover,
                              ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    text(
                                        text: DateFormat.yMMMd("en_US")
                                            .format(DateTime.parse(provider
                                                .getList[index].pubDate))
                                            .toString(),
                                        color: color979797,
                                        size: 16,
                                        fontWeight: FontWeight.w400),
                                    const SizedBox(width: 30),
                                    SizedBox(
                                      height: 25,
                                      child: FittedBox(
                                        alignment: Alignment.center,
                                        child: text(
                                            text:
                                                provider.getList[index].source,
                                            color: colorF76093,
                                            size: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () async {
                                    if (provider.getList[index].url == "NA" ||
                                        provider.getList[index].url
                                            .contains(".pdf")) return;

                                    // if (await canLaunchUrl(
                                    //     Uri.parse(provider.getList[index].url))) {
                                    //   launchUrl(
                                    //       Uri.parse(provider.getList[index].url));
                                    // }

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => NewsWebview(
                                                link: provider
                                                    .getList[index].url)));
                                  },
                                  child: text(
                                    text: provider.getList[index].title,
                                    color: light == true
                                        ? Colors.black
                                        : Colors.grey,
                                    size: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (provider.getList[index].url ==
                                                    "NA" ||
                                                provider.getList[index].url
                                                    .contains(".pdf")) return;

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => NewsWebview(
                                                        link: provider
                                                            .getList[index]
                                                            .url)));
                                          },
                                          child: text(
                                              text: provider
                                                  .getList[index].description,
                                              color: light == true
                                                  ? Colors.black
                                                  : Colors.grey,
                                              size: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // const SizedBox(height: 20),
                                // text(
                                //     text:
                                //         "South Indian Bank Ltd. is trading above all available SMAs",
                                //     color: light == true ? Colors.black : Colors.grey,
                                //     size: 12,
                                //     fontWeight: FontWeight.normal)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
  }

  String newsImage({required type}) {
    switch (type) {
      case 1:
        return newsImg;
      case 2:
        return corpnoteImg;
      case 46:
        return corpnoteImg;
      case 48:
        return agmImg;
      case 50:
        return sastImg;
      case 52:
        return boardmeetingImg;
      case 54:
        return companyupdateImg;
      default:
        return newsImg;
    }
  }

  Widget text(
          {required String text,
          required Color color,
          required double size,
          required FontWeight fontWeight}) =>
      Text(text,
          style: TextStyle(
              fontSize: size,
              fontWeight: fontWeight,
              color: color,
              fontFamily: font,
              package: "swot_page"));
}
