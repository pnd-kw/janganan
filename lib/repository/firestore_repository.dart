import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> setUserData(
    String userId,
    String username,
    String email,
    String phoneNumber,
    String userVerificationStatus,
  ) async {
    final userData = {
      // 'userId': userId,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'userVerificationStatus': userVerificationStatus,
    };

    try {
      await _firebaseFirestore.collection('users').doc(userId).set(userData);
    } catch (e) {
      throw 'Failed to store user data.';
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final userDoc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Failed to get user data.';
    }
  }

  Future<void> updateUserData(
      String userId, Map<String, dynamic> updateData) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .update(updateData);
    } catch (e) {
      throw 'Failed to update user data.';
    }
  }

  // Future<QuerySnapshot> checkIfEmailExists(String email) async {
  //   try {
  //     final querySnapshot = await _firebaseFirestore
  //         .collection('users')
  //         .where('email', isEqualTo: email)
  //         .get();

  //     return querySnapshot;
  //   } catch (e) {
  //     throw 'Failed to check if email exists.';
  //   }
  // }

  // Future<QuerySnapshot> getUserIdByEmail(String email) async {
  //   try {
  //     final querySnapshot = await _firebaseFirestore
  //         .collection('users')
  //         .where('email', isEqualTo: email)
  //         .get();

  //     return querySnapshot;
  //   } catch (e) {
  //     throw 'Failed to get userId by email.';
  //   }
  // }
}
