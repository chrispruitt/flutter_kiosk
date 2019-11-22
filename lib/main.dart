import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'connectivity.dart';
import 'package:after_layout/after_layout.dart';

void main() {
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  runApp(MaterialApp(home: PageOne()));
}

class PageOne extends StatefulWidget {
  @override
  _Page createState() => _Page('https://www.wikipedia.org/wiki/Kraken');
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwo createState() => _PageTwo('https://www.wikipedia.org/wiki/dragon');
}


class _Page extends State<PageOne> with AfterLayoutMixin<PageOne> {

  String url;
  WebViewController _controller;

  _Page(String url) {
    this.url = url;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageTwo()),
      );
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('G2Lytics Inaugural Hackathon!'),
      ),
      body: WebView(
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        }
      )
    );
  }
}

class _PageTwo extends State<PageTwo> with AfterLayoutMixin<PageTwo> {

  String url;
  WebViewController _controller;

  _PageTwo(String url) {
    this.url = url;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageOne()),
      );
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('G2Lytics Inaugural Hackathon!'),
      ),
      body: WebView(
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        }
      )
    );
  }
}