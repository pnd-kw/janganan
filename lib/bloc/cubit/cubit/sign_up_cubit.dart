import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/repository/auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  void emailChanged(String value) {
    final email = value;
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String value) {
    final password = value;
    emit(state.copyWith(password: password));
  }

  Future<void> signUpFormSubmitted(String username, String email,
      String password, String phoneNumber) async {
    try {
      emit(state.copyWith(status: SignUpStatus.initial));

      await _authenticationRepository.signUp(
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
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
