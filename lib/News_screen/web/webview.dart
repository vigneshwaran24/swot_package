import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  final String link;
  const NewsWebview({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<NewsWebview> createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  @override
  Widget build(BuildContext context) {
    final light = MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: light == true ? Colors.black : Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.link,
        zoomEnabled: false,
      ),
    );
  }
}
