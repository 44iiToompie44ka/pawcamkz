
import 'package:flutter/material.dart';
import 'package:pawcamkz/screens/menu/contacts_screen.dart';
import 'package:pawcamkz/screens/menu/faq_screen.dart';
import 'package:pawcamkz/screens/payment_screen.dart';
import 'package:pawcamkz/widgets/user_banner.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const UserBanner(),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              ),
            ),
            GestureDetector(
                            onTap: () {
                              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentHistory()),
                  );    
                },
              child: const ListTile(
                leading: Icon(Icons.payment_rounded), 
                title: Text('Платежи'),
                
              ),
            ),
            const ListTile(
              leading: Icon(Icons.people), 
              title: Text('Партнеры'),
              
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
            "Мы",
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
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Часто задаваемые вопросы'),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FaqScreen()),
                  );              
                },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail), 
              title: const Text('Контакты'),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactsScreen()),
                  );      
                
              },
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
  
}

