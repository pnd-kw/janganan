import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:janganan/repository/auth_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthenticationRepository _authenticationRepository;

  ResetPasswordCubit(this._authenticationRepository)
      : super(const ResetPasswordState());

  Future<void> resetPassword(String email) async {
    try {
      emit(state.copyWith(resetStatus: ResetPasswordStatus.sendingRequest));

      await _authenticationRepository.resetPassword(email);

      emit(state.copyWith(
          resetStatus: ResetPasswordStatus.resetPasswordSuccess));
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(state.copyWith(
            resetStatus: ResetPasswordStatus.resetPasswordFailed,
            errorMessage: e.message));
      } else {
        emit(state.copyWith(
            resetStatus: ResetPasswordStatus.resetPasswordFailed,
            errorMessage: 'Permintaan reset password gagal.'));
      }
    }
  }
}
