import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
      // } on firebase_auth.FirebaseAuthException catch (e) {
      //   throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
      // } catch (_) {
      //   emit(state.copyWith(
      //     status: SignUpStatus.failure,
      //     errorMessage: 'An unknown error occured.',
      //   ));
      // }
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
    // } on SignUpWithEmailAndPasswordFailure {
    //   // print('SignUp Error: ${e.message}');
    //   rethrow;
    // } catch (_) {
    //   // print('Unknown error');
    //   throw const SignUpWithEmailAndPasswordFailure();
    // }
  }
}
