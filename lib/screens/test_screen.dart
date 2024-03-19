import 'package:flutter/material.dart';
import 'package:pawcamkz/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class VideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return MaterialApp(
          theme: themeProvider.themeData,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThemeProvider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Change theme using ThemeProvider',
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(AppTheme.dark);
              },
              child: Text('Toggle Dark Theme'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(AppTheme.light);
              },
              child: Text('Toggle Light Theme'),
            ),
          ],
        ),
      ),
    );
  }
}