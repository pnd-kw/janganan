import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/repository/auth_repository.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final AuthenticationRepository _authenticationRepository;

  VerificationCubit(this._authenticationRepository)
      : super(const VerificationState());

  Timer? _countdownTimer;

  Future<void> requestOtp() async {
    try {
      await _authenticationRepository.requestOtp();

      emit(state.copyWith(
          status: VerificationStatus.initial, step: VerificationStep.codeSent));

      startCountdown();
    } catch (e) {
      if (e is LogInWithPhoneNumberFailure) {
        emit(state.copyWith(
            status: VerificationStatus.verificationFailed,
            errorMessage: e.message));
      } else {
        emit(state.copyWith(
          status: VerificationStatus.verificationFailed,
          errorMessage: 'Gagal meminta kode OTP.',
        ));
      }
    }
  }

  Future<void> verifyOtp(String code) async {
    try {
      await _authenticationRepository.verifyOtp(code);
      emit(state.copyWith(
        status: VerificationStatus.verificationCompleted,
        step: VerificationStep.verificationCompleted,
      ));
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
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // phoneVerification(state.code);
      if (state.remainingTime > 0) {
        emit(state.copyWith(
          remainingTime: state.remainingTime - 1,
        ));
      } else {
        emit(state.copyWith(
          step: VerificationStep.initial,
        ));

        stopCountdown();
      }
    });
    emit(state.copyWith(
      step: VerificationStep.countdown,
    ));
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
  }
}
