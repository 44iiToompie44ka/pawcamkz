import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawcamkz/firebase_options.dart';
import 'package:pawcamkz/providers/user_provider.dart';
import 'package:pawcamkz/screens/main_screen.dart';
import 'package:pawcamkz/screens/payment_screen.dart';
import 'package:pawcamkz/screens/menu/menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp(),);
  
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        context.read<UserProvider>().isLoggedIn == false; // Use assignment instead of comparison

      } else {
        print('User is signed in!');
        context.read<UserProvider>().isLoggedIn == true; // Use assignment instead of comparison
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(

      create: (BuildContext context) {         ChangeNotifierProvider(create: (_) => UserProvider());
 },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            primary: Colors.purple,
            onPrimary: Colors.grey[700],
          ),
          textTheme: const TextTheme(
            labelLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            bodyMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black54),
            titleLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    PaymentHistory(),
    const MainScreen(),
    const Center(child: Text('menu')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_rounded),
            label: 'Платежи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Помощь',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Меню',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (int index) {
          switch (index) {
            case 0:
            case 1:
              _onItemTapped(index);
              break;
            case 2:
              Future.delayed(const Duration(milliseconds: 100)).then((value) => _showMenu(context));
              break;
          }
        },
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(borderRadius: BorderRadius.circular(40), child: const MenuWidget());
      },
    );
  }
}
