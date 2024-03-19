import 'package:cloud_firestore/cloud_firestore.dart';

class CurrencyManager {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> earnCurrency(int amount, String userId) async {
    DocumentReference userDocRef = _firestore.collection('users').doc(userId);
    DocumentSnapshot userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      int currentBalance = userData?['virtual_currency'] ?? 0;
      await userDocRef.update({'virtual_currency': currentBalance + amount});
    }
  }

  static Future<void> spendCurrency(int amount, String userId) async {
    DocumentReference userDocRef = _firestore.collection('users').doc(userId);
    DocumentSnapshot userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      int currentBalance = userData?['virtual_currency'] ?? 0;
      if (currentBalance >= amount) {
        await userDocRef.update({'virtual_currency': currentBalance - amount});
      } else {
        throw Exception('Insufficient balance');
      }
    }
  }
}
