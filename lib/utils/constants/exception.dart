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

class GetUserStatusFailure implements Exception {
  final String message;

  GetUserStatusFailure([
    this.message = 'Current user not found.',
  ]);
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

class LinkCredentialFailure implements Exception {
  final String message;

  const LinkCredentialFailure([this.message = 'An unknown exception occured.']);

  factory LinkCredentialFailure.fromCode(String code) {
    switch (code) {
      case 'provider-already-linked':
        return const LinkCredentialFailure(
          'The provider has already been linked to the user.',
        );
      case 'invalid-credential':
        return const LinkCredentialFailure(
          "The provider's credential is not valid.",
        );
      case 'credential-already-in-use':
        return const LinkCredentialFailure(
          'or is already linked to a Firebase User',
        );
      default:
        return const LinkCredentialFailure();
    }
  }
}

class ResetPasswordFailure implements Exception {
  final String message;

  const ResetPasswordFailure([this.message = 'An unknown exception occured.']);

  factory ResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const ResetPasswordFailure(
          'Email address is not valid.',
        );
      case 'missing-android-pkg-name':
        return const ResetPasswordFailure(
          'An Android package name must be provided if the Android app is required to be installed.',
        );
      case 'missing-continue-uri':
        return const ResetPasswordFailure(
          'A continue URL must be provided in the request.',
        );
      case 'missing-ios-bundle-id':
        return const ResetPasswordFailure(
          'An iOS Bundle ID must be provided if an App Store ID is provided.',
        );
      case 'invalid-continue-uri':
        return const ResetPasswordFailure(
          'The Continue URL provided in the request is invalid.',
        );
      case 'unauthorized-continue-uri':
        return const ResetPasswordFailure(
          'The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.',
        );
      case 'user-not-found':
        return const ResetPasswordFailure(
          'There is no user corresponding to the email address.',
        );
      default:
        return const ResetPasswordFailure();
    }
  }
}

class UpdatePasswordFailure implements Exception {
  final String message;

  const UpdatePasswordFailure([this.message = 'An unknown error occured.']);

  factory UpdatePasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-password':
        return const UpdatePasswordFailure(
          'The provided value for the password user property is invalid.',
        );
      case 'invalid-password-hash':
        return const UpdatePasswordFailure(
          'The password hash must be a valid byte buffer.',
        );
      case 'invalid-password-salt':
        return const UpdatePasswordFailure(
          'The password salt must be a valid byte buffer.',
        );
      default:
        return const UpdatePasswordFailure();
    }
  }
}
