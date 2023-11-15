part of 'reset_password_cubit.dart';

enum ResetPasswordStatus {
  initial,
  sendingRequest,
  resetPasswordSuccess,
  resetPasswordFailed,
}

enum UpdatePasswordStatus {
  initial,
  updatePasswordSuccess,
  updatePasswordFailed,
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.email = '',
    this.errorMessage,
    this.resetStatus = ResetPasswordStatus.initial,
    this.updateStatus = UpdatePasswordStatus.initial,
  });
  final String email;
  final String? errorMessage;
  final ResetPasswordStatus resetStatus;
  final UpdatePasswordStatus updateStatus;

  ResetPasswordState copyWith({
    String? email,
    String? errorMessage,
    ResetPasswordStatus? resetStatus,
    UpdatePasswordStatus? updateStatus,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      resetStatus: resetStatus ?? this.resetStatus,
      updateStatus: updateStatus ?? this.updateStatus,
    );
  }

  @override
  List<Object?> get props => [email, errorMessage, resetStatus, updateStatus];
}
