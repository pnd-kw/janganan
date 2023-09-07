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

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = value;
    emit(state.copyWith(confirmedPassword: confirmedPassword));
  }

  void toggleTerms(bool value) {
    emit(state.copyWith(isTermsAccepted: value));
  }

  void signUpFormSubmitted(
      String email, String password, String confirmedPassword) async {
    try {
      emit(state.copyWith(status: SignUpStatus.initial));

      await _authenticationRepository.signUp(
        email: email,
        password: password,
      );

      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SignUpStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
