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
      emit(state.copyWith(status: VerificationStatus.requestingCode));

      await _authenticationRepository.requestOtp();

      emit(state.copyWith(status: VerificationStatus.codeSent));

      // startCountdown();
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
      emit(state.copyWith(status: VerificationStatus.verifying));

      await _authenticationRepository.verifyOtp(code);

      emit(state.copyWith(
        status: VerificationStatus.verificationCompleted,
        // step: VerificationStep.verificationCompleted,
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
    emit(state.copyWith(
      status: VerificationStatus.countdown,
    ));
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        emit(state.copyWith(
          status: VerificationStatus.codeSent,
          remainingTime: state.remainingTime - 1,
          // countdownText: '${state.remainingTime}',
        ));
      } else {
        emit(state.copyWith(
          status: VerificationStatus.requestingCode,
          remainingTime: 0,
          // countdownText: 'REQUEST CODE',
        ));

        stopCountdown();
      }
    });
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
  }
}
