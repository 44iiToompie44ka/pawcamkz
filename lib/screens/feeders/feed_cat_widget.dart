import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawcamkz/requests.dart';

class FeedCatWidget extends StatelessWidget {
  final String url;
  final int food;
  final int maxFood;

  const FeedCatWidget({
    required this.url,
    required this.food,
    required this.maxFood,
  });

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    double remainingFoodPercentage = food / maxFood;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  IconData iconData;
                  String actionText;

                  switch (index) {
                    case 0:
                      iconData = Icons.animation;
                      actionText = 'Донат в 50';
                      break;
                    case 1:
                      iconData = Icons.access_alarm_outlined;
                      actionText = 'Донат в 75';
                      break;
                    case 2:
                      iconData = Icons.logo_dev;
                      actionText = 'Донат в 100';
                      break;
                    case 3:
                      iconData = Icons.catching_pokemon;
                      actionText = 'Донат в 125';
                      break;
                    case 4:
                      iconData = Icons.fast_rewind_sharp;
                      actionText = 'Донат в 150';
                      break;
                    case 5:
                      iconData = Icons.trolley;
                      actionText = 'Донат в 200';
                      break;
                    default:
                      iconData = Icons.error;
                      actionText = 'Unknown';
                      break;
                  }

                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 20),
                                Text("Обработка запроса..."),
                              ],
                            ),
                          );
                        },
                      );

                      await Future.delayed(const Duration(seconds: 1));
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Pop twice to dismiss both the dialog and this widget
                      await sendRequestToFeeder(url, '/donate$index');
                    },
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconData,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  actionText,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                Image.asset('assets/mysyq_coin_gold.png', height: 15, width: 15,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 20),
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).get(),
              builder: (context, snapshot) {
                int mysyqCoins = snapshot.data?.data()?['mysyq_coins'] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Text("Ваш баланс: ", style: TextStyle(fontSize: 12),),
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
            Container(
              width: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 100 * remainingFoodPercentage,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: remainingFoodPercentage < 0.1 ? Colors.red : Colors.red[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
