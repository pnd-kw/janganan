import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:janganan/repository/auth_repository.dart';

import '../../../utils/constants/exception.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final AuthenticationRepository _authenticationRepository;

  VerificationCubit(this._authenticationRepository)
      : super(const VerificationState());

  Timer? _countdownTimer;

  Future<void> requestOtp() async {
    try {
      emit(state.copyWith(status: VerificationStatus.requestingCode));

      await _authenticationRepository.requestOtp();

      emit(state.copyWith(status: VerificationStatus.codeSent));
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(state.copyWith(
            status: VerificationStatus.requestFailed, errorMessage: e.message));
      } else {
        emit(state.copyWith(
            status: VerificationStatus.requestFailed,
            errorMessage: 'Gagal meminta token OTP.'));
      }
    }
  }

  Future<void> verifyOtp(String code) async {
    try {
      emit(state.copyWith(status: VerificationStatus.verifying));

      final isVerificationSuccessful =
          await _authenticationRepository.verifyOtp(code);

      if (isVerificationSuccessful) {
        emit(state.copyWith(
          status: VerificationStatus.verificationCompleted,
        ));
      } else {
        emit(state.copyWith(
          status: VerificationStatus.verificationFailed,
        ));
      }
    } catch (e) {
      if (e is LogInWithPhoneNumberFailure) {
        emit(state.copyWith(
            status: VerificationStatus.verificationFailed,
            errorMessage: e.message));
      } else {
        emit(state.copyWith(
          status: VerificationStatus.verificationFailed,
          errorMessage: 'Gagal verifikasi OTP.',
        ));
      }
    }
  }

  void startCountdown() {
    _countdownTimer?.cancel();
    emit(state.copyWith(
      status: VerificationStatus.countdown,
    ));
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        emit(state.copyWith(
          status: VerificationStatus.codeSent,
          remainingTime: state.remainingTime - 1,
        ));
      } else {
        emit(state.copyWith(
          status: VerificationStatus.initial,
          remainingTime: 60,
        ));

        stopCountdown();
      }
    });
    emit(state.copyWith(
      status: VerificationStatus.countdown,
    ));
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
  }
}
