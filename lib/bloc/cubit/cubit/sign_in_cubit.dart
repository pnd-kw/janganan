import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/repository/auth_repository.dart';

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
      emit(state.copyWith(
        status: SignInStatus.initial,
        errorMessage: '',
      ));

      await _authenticationRepository.logInWithEmailAndPassword(
          email: email, password: password);

      emit(state.copyWith(status: SignInStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SignInStatus.failure,
        errorMessage: e.toString(),
      ));
      // } finally {
      //   emit(state.copyWith(isLoading: false));
    }
  }
}
