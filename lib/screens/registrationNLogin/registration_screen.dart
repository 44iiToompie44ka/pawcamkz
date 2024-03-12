import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:pawcamkz/main.dart';
import 'package:pawcamkz/providers/user_provider.dart';
import 'package:provider/provider.dart';



class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}


class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String usernameError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String errorMessage = '';
  String successMessage = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RegExp gmailRegex = RegExp(r'^[a-zA-Z0-9._-]+@gmail\.com$');
  final RegExp mailRuRegex = RegExp(r'^[a-zA-Z0-9._-]+@mail\.ru$');
  final RegExp yandexRegex = RegExp(r'^[a-zA-Z0-9._-]+@yandex\.[a-zA-Z]{2,}$');

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Регистрация', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize, fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: usernameController,
                decoration: buildInputDecoration('Имя пользователя', usernameError),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: buildInputDecoration('Email', emailError),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: buildInputDecoration('Пароль', passwordError),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: buildInputDecoration('Подтвердите пароль', confirmPasswordError),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: GestureDetector(
                onTap: () async {
                  
                  clearErrors();
                  errorMessage = '';

                  if (usernameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    errorMessage = 'Заполните все поля';
                    setState(() {});
                    return;
                  }

                  if (passwordController.text != confirmPasswordController.text) {
                    confirmPasswordError = 'Пароли не совпадают';
                    setState(() {});
                    return;
                  }

                  if (!isEmailFormatValid(emailController.text)) {
                    setState(() {
                      emailError = 'Неверный формат email';
                    });
                    return;
                  }

                  bool isUsernameTaken = await checkUsernameAvailability(usernameController.text);

                  if (isUsernameTaken) {
                    setState(() {
                      usernameError = 'Это имя пользователя уже занято';
                    });
                    return;
                  }

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                      
                    );
                    
                      // ignore: use_build_context_synchronously
                      

                    await _firestore.collection('users').doc(userCredential.user?.uid).set({
                      'username': usernameController.text,
                      'email': emailController.text,
                    });

                    setState(() {
                      successMessage = 'Пользователь зарегистрирован: ${userCredential.user?.email}';
                      errorMessage = '';
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      
                    });
                    
                  } catch (e) {
                    handleRegistrationError(e);
                  }
                  
                    
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
                      'Продолжить',
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
            if (successMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  successMessage,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Padding(
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
            ),
            GestureDetector(
      onTap: () async {
        null;
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
                  errorMessage = 'Продолжить с mobile';
                  setState(() {});
                },
              child: GestureDetector(
                onTap: () async {
                  errorMessage = 'Продолжить с mobile';
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
    usernameError = '';
    emailError = '';
    passwordError = '';
    confirmPasswordError = '';
  }

  Future<bool> checkUsernameAvailability(String username) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  bool isEmailFormatValid(String email) {
    return gmailRegex.hasMatch(email) || mailRuRegex.hasMatch(email) || yandexRegex.hasMatch(email);
  }

  void handleRegistrationError(dynamic error) {
    setState(() {
      errorMessage = 'Ошибка при регистрации: $error';

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'email-already-in-use':
            emailError = 'Этот email уже используется';
            break;
          case 'weak-password':
            passwordError = 'Слабый пароль';
            break;
        }
      } else if (error is String && error.contains('passwords do not match')) {
        confirmPasswordError = 'Пароли не совпадают';
      }
      successMessage = ''; 
    });
  }

  void clearFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
