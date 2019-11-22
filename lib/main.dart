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
    'https://status.g2lytics.com',
    'https://www.wikipedia.org/wiki/Kraken',
    'https://www.msn.com/en-us/weather/fullscreenmaps', 
    'https://weather.com/weather/5day/l/d31b209091908e29d78cfb58bcb998952d09db7e10e650e3f7b2d93516bcab18',
    ], 20);
}

class _Page extends State<PageOne> with AfterLayoutMixin<PageOne> {

  int _pageIndex;
  int _durationSeconds;
  int _pageLoadDelay;
  List<String> _urls;
  WebViewController _controller;

  _Page(List<String> urls, int durationSeconds) {
    this._pageIndex = 0;
    this._urls = urls;
    this._durationSeconds = durationSeconds;

    // Page delay so it can start loading the
    this._pageLoadDelay = 5;
  }

  nextPage() {
    _pageIndex++;
    if(_pageIndex >= _urls.length) {
      _pageIndex = 0;
    }
    Future.delayed(Duration(seconds: _durationSeconds), () {
      _controller.loadUrl(_urls[_pageIndex]);
      Future.delayed(Duration(seconds : _pageLoadDelay), () {
        setState(() => {});
      });
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
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        }
      )
    );
  }
}