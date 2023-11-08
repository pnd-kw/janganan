import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/repository/auth_repository.dart';

import '../../../utils/constants/exception.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  void usernameChanged(String value) {
    final username = value;
    emit(state.copyWith(username: username));
  }

  void emailChanged(String value) {
    final email = value;
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String value) {
    final password = value;
    emit(state.copyWith(password: password));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = value;
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  Future<void> signUpFormSubmitted(String username, String email,
      String password, String phoneNumber) async {
    try {
      emit(state.copyWith(status: SignUpStatus.sendingRequest));

      await _authenticationRepository.signUp(
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        // userVerificationStatus: 'unverified',
        authMethodType: 'email',
        isVerified: false,
      );

      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      if (e is SignUpWithEmailAndPasswordFailure) {
        emit(state.copyWith(
            status: SignUpStatus.failure, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            status: SignUpStatus.failure,
            errorMessage: 'An unknown error occured.'));
      }
    }
  }
}
