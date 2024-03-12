import 'package:flutter/material.dart';
import 'package:pawcamkz/providers/user_provider.dart';
import 'package:pawcamkz/screens/registrationNLogin/login_screen.dart';
import 'package:provider/provider.dart';

class UserBanner extends StatelessWidget {
  const UserBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 0),
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
                Text(
  Provider.of<UserProvider>(context).isLoggedIn
      ? Provider.of<UserProvider>(context).username
      : 'Гость',
  style: const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 22,
  ),
),

                if (!userProvider.isLoggedIn) // Only show if the login status is false
                  const SizedBox(height: 5),
                  if (!userProvider.isLoggedIn)
                    const Text(
                      'Авторизуйся',
                      style: TextStyle(
                          color: Color.fromARGB(219, 0, 0, 0),
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
              ],
            ),
          ),
          if (!userProvider.isLoggedIn) // Only show if the login status is false
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
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
