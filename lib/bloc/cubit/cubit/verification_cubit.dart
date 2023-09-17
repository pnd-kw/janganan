import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/repository/auth_repository.dart';
// import 'package:janganan/utils/otp_util.dart';

part 'verification_state.dart';

// class VerificationCubit extends Cubit<VerificationState> {
//   final OtpUtil _otpUtil;

//   VerificationCubit({
//     required OtpUtil otpUtil,
//   })  : _otpUtil = otpUtil,
//         super(const VerificationState());

//   Future<void> resendOtp(String phoneNumber) async {
//     emit(state.copyWith(status: VerificationStatus.initial));
//     try {
//       await _otpUtil.sendOtp(phoneNumber);

//       emit(state.copyWith(status: VerificationStatus.codeSent));
//     } catch (e) {
//       String errorMessage = 'Failed to verify OTP.';
//       if (e is LogInWithPhoneNumberFailure) {
//         errorMessage = 'Failed to initiate phone verification.';
//       } else if (e is UserDocumentNotFound) {
//         errorMessage = 'User document not found.';
//       }
//       emit(state.copyWith(
//         status: VerificationStatus.verificationFailed,
//         errorMessage: errorMessage,
//       ));
//     }
//   }

//   Future<void> verifyOtp(String code) async {
//     emit(state.copyWith(status: VerificationStatus.initial));
//     try {
//       await _otpUtil.verifyOtp(code);

//       emit(state.copyWith(status: VerificationStatus.verificationCompleted));
//     } catch (e) {
//       String errorMessage = 'Failed to verify OTP.';
//       if (e is LogInWithPhoneNumberFailure) {
//         errorMessage = 'Failed to initiate phone verification.';
//       } else if (e is UserDocumentNotFound) {
//         errorMessage = 'User document not found.';
//       }
//       emit(state.copyWith(
//         status: VerificationStatus.verificationFailed,
//         errorMessage: errorMessage,
//       ));
//     }
//   }
// }
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

  // Future<void> phoneVerification(String code) async {
  //   try {
  //     if (state.step == VerificationStep.requestingCode) {
  //       emit(state.copyWith(
  //         status: VerificationStatus.initial,
  //         step: VerificationStep.requestingCode,
  //       ));

  //       emit(state.copyWith(
  //         step: VerificationStep.codeSent,
  //       ));

  //       startCountdown();
  //     } else if (state.step == VerificationStep.verifying) {
  //       final result =
  //           await _authenticationRepository.verifyPhoneNumberAndSignIn(code);

  //       if (result) {
  //         emit(state.copyWith(
  //           status: VerificationStatus.verificationCompleted,
  //           step: VerificationStep.verificationCompleted,
  //         ));
  //       } else {
  //         emit(state.copyWith(
  //           status: VerificationStatus.verificationFailed,
  //           errorMessage: 'Failed to verify OTP.',
  //         ));
  //       }
  //     } else if (state.step == VerificationStep.countdown) {
  //       if (state.remainingTime > 0) {
  //         emit(state.copyWith(
  //           remainingTime: state.remainingTime - 1,
  //         ));
  //       } else {
  //         emit(state.copyWith(
  //           step: VerificationStep.requestingCode,
  //         ));

  //         stopCountdown();
  //       }
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: VerificationStatus.verificationFailed,
  //       errorMessage: 'Failed to verify OTP.',
  //     ));
  //   }
  // }

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
