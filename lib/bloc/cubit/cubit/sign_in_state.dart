part of 'sign_in_cubit.dart';

enum SignInStatus {
  initial,
  success,
  failure,
}

class SignInState extends Equatable {
  const SignInState({
    this.email = '',
    this.password = '',
    this.errorMessage,
    this.status = SignInStatus.initial,
    this.isLoading = true,
  });

  final String email;
  final String password;
  final String? errorMessage;
  final SignInStatus status;
  final bool isLoading;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignInState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    SignInStatus? status,
    bool? isLoading,
  }) {
    return SignInState(
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
