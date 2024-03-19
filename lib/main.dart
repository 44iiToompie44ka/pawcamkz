import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawcamkz/managers/firebase_options.dart';
import 'package:pawcamkz/screens/main_screen.dart';
import 'package:pawcamkz/screens/payment_screen.dart';
import 'package:pawcamkz/screens/menu/menu_widget.dart';
import 'package:pawcamkz/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Initialize the ThemeProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: const MyHomePage(),
        );
      },
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
