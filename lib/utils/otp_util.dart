import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:janganan/repository/auth_repository.dart';
import 'package:janganan/repository/firestore_repository.dart';

class OtpUtil {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirestoreRepository _firestoreRepository;

  OtpUtil({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required FirestoreRepository firestoreRepository,
  })  : _firebaseAuth = firebaseAuth,
        _firestoreRepository = firestoreRepository;

  Future<void> sendOtp(String phoneNumber) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      final userDoc = await _firestoreRepository.getUserData(userId!);

      if (userDoc != null) {
        final userPhoneNumber = userDoc['phoneNumber'];

        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: userPhoneNumber,
          verificationCompleted:
              (firebase_auth.PhoneAuthCredential credential) {},
          verificationFailed: (firebase_auth.FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        throw const UserDocumentNotFound();
      }
    } catch (e) {
      throw const UserDocumentNotFound();
    }
  }

  Future<void> verifyOtp(String code) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      final userDoc = await _firestoreRepository.getUserData(userId!);

      if (userDoc != null) {
        // final userPhoneNumber = userDoc['phoneNumber'];

        final phoneAuthCredential = firebase_auth.PhoneAuthProvider.credential(
          verificationId: code,
          smsCode: code,
        );

        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      } else {
        throw const LogInWithPhoneNumberFailure();
      }
    } catch (e) {
      throw const LogInWithPhoneNumberFailure();
    }
  }
}
