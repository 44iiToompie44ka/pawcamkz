import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawcamkz/screens/registrationNLogin/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

class UserBanner extends StatelessWidget {
  const UserBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage('assets/avatar_placeholder.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentUser != null)
                  Row(
                    children: [
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get(),
                        builder: (context, snapshot) {
                          String? username = snapshot.data?.data()?['username']; 
                          return Text(
                            username ?? 'Гость',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                          
                        },
                      ),
                    ],
                  ),

                if(currentUser == null)
                  Text(
                        'Гость',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                if(currentUser == null)
                  Text(
                    'Авторизуйся',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                
                  
                
                
                  
              ],
            ),
          ),
          if (currentUser == null) 
            Padding(
              padding: const EdgeInsets.only(left: 70, top: 0),
              child: Container(
                width: 100,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        if (currentUser != null)
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get(),
                    builder: (context, snapshot) {
                      
                      int mysyqCoins = snapshot.data?.data()?['mysyq_coins'] ?? 0; // Ensure to cast to Map<String, dynamic>
                      return Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),                         color: Theme.of(context).colorScheme.background,),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(
                                  
                                  '$mysyqCoins',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Image.asset('assets/mysyq_coin_gold.png', height: 30, width: 30,),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ],
      ),
    );
  }
}
