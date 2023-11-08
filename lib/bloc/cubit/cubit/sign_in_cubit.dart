import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/repository/auth_repository.dart';

import '../../../utils/constants/exception.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthenticationRepository _authenticationRepository;

  SignInCubit(this._authenticationRepository) : super(const SignInState());

  void emailChanged(String value) {
    final email = value;
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String value) {
    final password = value;
    emit(state.copyWith(password: password));
  }

  Future<void> logInWithCredentials(String email, String password) async {
    try {
      emit(state.copyWith(status: SignInStatus.sendingRequest));

      final userVerificationStatus = await _authenticationRepository
          .logInWithEmailAndPassword(email: email, password: password);

      emit(state.copyWith(status: SignInStatus.success));
      emit(state.copyWith(method: SignInMethod.emailAndPassword));

      if (userVerificationStatus == true) {
        emit(state.copyWith(
            userVerificationStatus: UserVerificationStatus.verifiedUser));
      } else if (userVerificationStatus == false) {
        emit(state.copyWith(
            userVerificationStatus: UserVerificationStatus.unverifiedUser));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SignInStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      emit(state.copyWith(status: SignInStatus.sendingRequest));

      await _authenticationRepository.logInWithGoogle();

      emit(state.copyWith(status: SignInStatus.success));
      emit(state.copyWith(method: SignInMethod.googleSignIn));

      final userVerificationStatus =
          await _authenticationRepository.getGoogleSignInStatus();

      if (userVerificationStatus == true) {
        emit(state.copyWith(
            userVerificationStatus: UserVerificationStatus.verifiedUser));
      } else if (userVerificationStatus == false) {
        emit(state.copyWith(
            userVerificationStatus: UserVerificationStatus.unverifiedUser));
      }
    } catch (e) {
      if (e is LogInWithGoogleFailure) {
        emit(state.copyWith(
            status: SignInStatus.failure, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            status: SignInStatus.failure,
            errorMessage: 'An unknown error occured.'));
      }
    }
  }

  Future<void> linkCredential(String password) async {
    try {
      emit(state.copyWith(linkStatus: LinkStatus.linking));

      await _authenticationRepository.googleSignIn(password);

      emit(state.copyWith(linkStatus: LinkStatus.linked));
    } catch (e) {
      emit(state.copyWith(
          linkStatus: LinkStatus.failed,
          errorMessage: 'Unknown error occured.'));
    }
  }
}
