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
    String authMethodType,
    bool isVerified,
  ) async {
    final userData = {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
    };

    try {
      await _firebaseFirestore.collection('users').doc(userId).set(userData);

      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('linkedAuthMethods')
          .add({
        'authMethodType': authMethodType,
        'isVerified': isVerified,
      });
    } catch (e) {
      throw 'Failed to store user data.';
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final userDoc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        final linkedAuthMethodsCollection =
            userDoc.reference.collection('linkedAuthMethods');
        final linkedAuthMethodsDocs = await linkedAuthMethodsCollection.get();

        final linkedAuthMethodsData =
            linkedAuthMethodsDocs.docs.map((doc) => doc.data()).toList();
        userData['linkedAuthMethods'] = linkedAuthMethodsData;

        return userData;
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

  Future<bool?> getLinkedAuthMethod(
      String userId, String authMethodType) async {
    try {
      final userRef = _firebaseFirestore.collection('users').doc(userId);
      final linkedAuthMethodsCollection =
          userRef.collection('linkedAuthMethods');
      final querySnapshot = await linkedAuthMethodsCollection
          .where('authMethodType', isEqualTo: authMethodType)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        final data = docSnapshot.data();
        final isVerified = data['isVerified'] as bool;
        return isVerified;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Failed to getLinkedAuthMethod.';
    }
  }

  Future<void> addLinkedAuthMethod(
      String userId, String authMethodType, bool isVerified) async {
    try {
      final userRef = _firebaseFirestore.collection('users').doc(userId);
      final linkedAuthMethodsCollection =
          userRef.collection('linkedAuthMethods');
      await linkedAuthMethodsCollection.add({
        'authMethodType': authMethodType,
        'isVerified': isVerified,
      });
    } catch (e) {
      throw 'Failed to add linkedAuthMethods data.';
    }
  }

  Future<void> updateLinkedAuthMethod(String userId, String authMethodType,
      Map<String, dynamic> updateData) async {
    try {
      final userRef = _firebaseFirestore.collection('users').doc(userId);
      final linkedAuthMethodsCollection =
          userRef.collection('linkedAuthMethods');

      final querySnapshot = await linkedAuthMethodsCollection
          .where('authMethodType', isEqualTo: authMethodType)
          .get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.update(updateData);
      }
    } catch (e) {
      throw 'Failed to update linkedAuthMethod.';
    }
  }
}
