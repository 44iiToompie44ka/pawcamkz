
// ignore_for_file: empty_catches, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcamkz/main.dart';
import 'package:pawcamkz/providers/user_provider.dart';
import 'package:pawcamkz/screens/registrationNLogin/registration_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String email;
  late String password;
  String emailError = '';
  String passwordError = '';
  String errorMessage = '';

Future<void> validateUser() async {
    try {
      final UserCredential? userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Вход в аккаунт', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize, fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },                decoration: buildInputDecoration('Email', emailError),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              onChanged: (value) {
                              password = value;
                            },                obscureText: true,
                decoration: buildInputDecoration('Пароль', passwordError),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: GestureDetector(
                onTap: () async {
                  validateUser();
                },
                child: Container(
                  height: 60,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: Theme.of(context).textTheme.headline6?.fontWeight,
                        fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
              },
              child: Text(
                'Нет аккаунта? Зарегистрироваться',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ИЛИ",
            style: TextStyle(
              color: Theme.of(context).textTheme.titleMedium?.color,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight,
            ),
          ),
        ),
        Container(
          height: 2,
          width: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    ),
            ),
            GestureDetector(
      onTap: () async {
      },
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google_logo.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Продолжить через Google',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () async {
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'По номеру телефона',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String labelText, String errorText) {
    return InputDecoration(
      labelText: labelText,
      errorText: errorText.isNotEmpty ? errorText : null,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 4,
        ),
      ),
    );
  }




  void clearErrors() {
    emailError = '';
    passwordError = '';
  }

  void handleLoginError(dynamic error) {
    setState(() {
      errorMessage = 'Ошибка при входе: $error';

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
            emailError = 'Пользователь не найден';
            break;
          case 'wrong-password':
            passwordError = 'Неверный пароль';
            break;
          case 'invalid-email':
            emailError = 'Неверный формат email';
            break;
        }
      }
    });
  }
}
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter password',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);