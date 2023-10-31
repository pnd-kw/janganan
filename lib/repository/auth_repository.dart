import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janganan/repository/firestore_repository.dart';

import 'package:janganan/utils/regex_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user.dart';
import '../utils/constants/exception.dart';

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirestoreRepository _firestoreRepository;
  final GoogleSignIn _googleSignIn;

  final SharedPreferences _prefs;

  bool isWeb = kIsWeb;
  String? _verificationId;

  AuthenticationRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      FirestoreRepository? firestoreRepository,
      GoogleSignIn? googleSignIn,
      required SharedPreferences prefs})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestoreRepository = firestoreRepository ?? FirestoreRepository(),
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _prefs = prefs;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _prefs.setBool('isLoggedIn', firebaseUser != null);
      return user;
    });
  }

  User get currentUser {
    final user = _firebaseAuth.currentUser?.toUser ?? User.empty;
    final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      return user;
    } else {
      return User.empty;
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String userVerificationStatus,
  }) async {
    try {
      final formattedPhoneNumber = formatPhoneNumber(phoneNumber);

      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userId = _firebaseAuth.currentUser?.uid;

      await _firestoreRepository.setUserData(
        userId!,
        username,
        email,
        formattedPhoneNumber,
        userVerificationStatus,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    final cleanedPhoneNumber = phoneNumber.replaceAll(frmtPhoneNumber, '');

    if (cleanedPhoneNumber.startsWith('0')) {
      return '+62${phoneNumber.substring(1)}';
    } else if (!cleanedPhoneNumber.startsWith('+')) {
      return '+62$cleanedPhoneNumber';
    } else {
      return cleanedPhoneNumber;
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential googleCredential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        googleCredential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        googleCredential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final email = googleUser.email;

        final emailCredential =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (emailCredential.isNotEmpty) {
          final user = _firebaseAuth.currentUser;

          await user?.linkWithCredential(googleCredential);
        } else {
          await _firebaseAuth.signInWithCredential(googleCredential);

          final userId = _firebaseAuth.currentUser?.uid;

          await _firestoreRepository.setUserData(
              userId!, googleUser.displayName!, email, '-', 'verified');
        }
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<dynamic> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final userId = _firebaseAuth.currentUser?.uid;

      final userDoc = await _firestoreRepository.getUserData(userId!);

      final userVerificationStatus = userDoc?['userVerificationStatus'];

      return userVerificationStatus;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> requestOtp() async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId != null) {
        final userDoc = await _firestoreRepository.getUserData(userId);
        if (userDoc != null) {
          final userPhoneNumber = userDoc['phoneNumber'];
          await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: userPhoneNumber,
            verificationCompleted:
                (firebase_auth.PhoneAuthCredential credential) {},
            verificationFailed: (firebase_auth.FirebaseAuthException e) {},
            codeSent: (String verificationId, int? resendToken) {
              _verificationId = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        }
      } else {
        throw const UserDocumentNotFound();
      }
    } catch (e) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  Future<bool> verifyOtp(String code) async {
    try {
      final user = _firebaseAuth.currentUser;
      final userId = _firebaseAuth.currentUser?.uid;
      final userDoc = await _firestoreRepository.getUserData(userId!);
      if (_verificationId != null) {
        final credential = firebase_auth.PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: code);
        if (user != null) {
          await user.linkWithCredential(credential);
          userDoc?['userVerificationStatus'] = 'verified';
          await _firestoreRepository.updateUserData(userId, userDoc!);
        }
        return true;
      } else {
        throw const LogInWithPhoneNumberFailure();
      }
    } catch (e) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid, username: displayName, email: email, phoneNumber: phoneNumber);
  }
}
