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
  _Page createState() => _Page([
    'https://www.wikipedia.org/wiki/Kraken', 
    'https://www.wikipedia.org/wiki/dragon', 
    'https://www.wikipedia.org/wiki/dog', 
    'https://www.wikipedia.org/wiki/cat'
    ], 5);
}

class _Page extends State<PageOne> with AfterLayoutMixin<PageOne> {

  int _pageIndex = 0;
  List<String> _urls;
  int _durationSeconds;
  WebViewController _controller;

  _Page(List<String> urls, int durationSeconds) {
    this._urls = urls;
    this._durationSeconds = durationSeconds;
  }

  nextPage() {
    _pageIndex++;
    if(_pageIndex >= _urls.length) {
      _pageIndex = 0;
    }
    Future.delayed(Duration(seconds: _durationSeconds), () {
      _controller.loadUrl(_urls[_pageIndex]);
      setState(() => {});
      nextPage();
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('G2Lytics Inaugural Hackathon!'),
      ),
      body: WebView(
        initialUrl: _urls[_pageIndex],
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        }
      )
    );
  }
}