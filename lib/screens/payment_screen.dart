import 'package:flutter/material.dart';
import 'package:pawcamkz/screens/registrationNLogin/login_screen.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class PaymentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the UserProvider using the Provider.of method
    final userProvider = Provider.of<UserProvider>(context);

    // Check if the user is logged in
    if (!userProvider.isLoggedIn) {
      
      return LoginScreen(); // Return an empty container, or you can show a loading spinner
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sample Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
