part of 'verification_cubit.dart';

enum VerificationStatus {
  initial,
  requestingCode,
  codeSent,
  requestFailed,
  countdown,
  verifying,
  verificationCompleted,
  verificationFailed,
  codeAutoRetrievalTimeout,
}

class VerificationState extends Equatable {
  const VerificationState({
    this.code = '',
    this.errorMessage,
    this.status = VerificationStatus.initial,
    this.remainingTime = 60,
    this.countdownText = '',
  });

  final String code;
  final String? errorMessage;
  final VerificationStatus status;
  final int remainingTime;
  final String countdownText;

  // bool get isValid => code.isNotEmpty;

  VerificationState copyWith({
    String? code,
    String? errorMessage,
    VerificationStatus? status,
    int? remainingTime,
    String? countdownText,
  }) {
    return VerificationState(
      code: code ?? this.code,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      remainingTime: remainingTime ?? this.remainingTime,
      countdownText: countdownText ?? this.countdownText,
    );
  }

  @override
  List<Object?> get props => [code, errorMessage, status, remainingTime];
}
