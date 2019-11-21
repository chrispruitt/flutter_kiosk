import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

void main() => runApp(MaterialApp(home: FlutterKiosk()));

class FlutterKiosk extends StatefulWidget {
  @override
  _FlutterKioskState createState() => _FlutterKioskState();
}

class _FlutterKioskState extends State<FlutterKiosk> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('G2Lytics Inaugural Hackathon!'),
      ),
      body: WebView(
        initialUrl: 'https://www.wikipedia.org/wiki/Kraken'
      )
      // body: const Text('G2Lytics Inaugural Hackathon!')
    );
  }
}