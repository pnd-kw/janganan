part of 'verification_cubit.dart';

enum VerificationStatus {
  initial,
  // verifying,
  verificationCompleted,
  verificationFailed,
  codeAutoRetrievalTimeout,
}

enum VerificationStep {
  initial,
  // requestingCode,
  codeSent,
  // verifying,
  countdown,
  verificationCompleted,
  verificationFailed,
  codeAutoRetrievalTimeout,
}

class VerificationState extends Equatable {
  const VerificationState({
    this.code = '',
    this.errorMessage,
    this.status = VerificationStatus.initial,
    this.step = VerificationStep.initial,
    this.remainingTime = 60,
  });

  final String code;
  final String? errorMessage;
  final VerificationStatus status;
  final VerificationStep step;
  final int remainingTime;

  bool get isValid => code.isNotEmpty;

  VerificationState copyWith({
    String? code,
    String? errorMessage,
    VerificationStatus? status,
    VerificationStep? step,
    int? remainingTime,
  }) {
    return VerificationState(
      code: code ?? this.code,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      step: step ?? this.step,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }

  @override
  List<Object?> get props => [code, errorMessage, status, step, remainingTime];
}
