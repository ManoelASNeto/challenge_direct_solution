import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewPage extends StatelessWidget {
  final String url;
  final String title;

  const WebviewPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
            url,
          ),
        ),
      ),
    );
  }
}
