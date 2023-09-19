import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janganan/repository/firestore_repository.dart';

import 'package:janganan/utils/regex_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occured.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occured.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithPhoneNumberFailure implements Exception {
  final String message;

  const LogInWithPhoneNumberFailure(
      [this.message = 'An unknown exception occured.']);

  factory LogInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const LogInWithPhoneNumberFailure(
          'The credential is malformed or has expired.',
        );
      case 'user-disabled':
        return const LogInWithPhoneNumberFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'invalid-verification-code':
        return const LogInWithPhoneNumberFailure(
          'The verification code of the credential is not valid.',
        );
      case 'invalid-verification-id':
        return const LogInWithPhoneNumberFailure(
          'The verification ID of the credential is not valid.id.',
        );
      default:
        return const LogInWithPhoneNumberFailure();
    }
  }
}

class UserDocumentNotFound implements Exception {
  final String message;

  const UserDocumentNotFound([
    this.message = 'User document not found.',
  ]);
}

class SignInWithCredentialFailure implements Exception {
  final String message;

  const SignInWithCredentialFailure([
    this.message = 'An unknown exception occured.',
  ]);

  factory SignInWithCredentialFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithCredentialFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credentials':
        return const SignInWithCredentialFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed:':
        return const SignInWithCredentialFailure(
          'Type of account corresponding to the credential is not enabled',
        );
      case 'user-disabled':
        return const SignInWithCredentialFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithCredentialFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithCredentialFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SignInWithCredentialFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SignInWithCredentialFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const SignInWithCredentialFailure();
    }
  }
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occured.',
  ]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credentials':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
}

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
  }) async {
    try {
      final formattedPhoneNumber = formatPhoneNumber(phoneNumber);

      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userId = _firebaseAuth.currentUser?.uid;

      await _firestoreRepository.setUserData(
        userId!,
        username,
        formattedPhoneNumber,
        'Step1Completed',
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
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final userId = _firebaseAuth.currentUser?.uid;
      final userDoc = await _firestoreRepository.getUserData(userId!);

      if (userDoc != null) {
        await _firestoreRepository
            .updateUserData(userId, {'authenticationStatus': 'Step1Completed'});
      } else {
        throw const UserDocumentNotFound();
      }
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
      if (_verificationId != null) {
        final phoneAuthCredential = firebase_auth.PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: code);

        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
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
