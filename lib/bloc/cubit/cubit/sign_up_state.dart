part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  success,
  failure,
}

class SignUpState extends Equatable {
  const SignUpState({
    this.email = '',
    this.password = '',
    this.errorMessage,
    this.status = SignUpStatus.initial,
    this.isLoading = true,
  });

  final String email;
  final String password;
  final String? errorMessage;
  final SignUpStatus status;
  final bool isLoading;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignUpState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    SignUpStatus? status,
    bool? isLoading,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [email, password, errorMessage, status];
}
