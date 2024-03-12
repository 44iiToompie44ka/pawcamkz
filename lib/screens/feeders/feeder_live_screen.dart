import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeederLiveScreen extends StatelessWidget {
  final String url;
  final String title;
  final int connections;

  const FeederLiveScreen({
    required this.url,
    required this.title,
    required this.connections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Name: $title'),
                Text('Connections: $connections'),
                // Add more widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
