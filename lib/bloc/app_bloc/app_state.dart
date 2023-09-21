part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

final class AppState extends Equatable {
  final AppStatus status;
  final User user;
  final String authenticationStatus;

  const AppState._({
    required this.status,
    this.user = User.empty,
    this.authenticationStatus = 'Unauthenticated',
  });

  const AppState.authenticated(User user, String authenticationStatus)
      : this._(status: AppStatus.authenticated, user: user, authenticationStatus: authenticationStatus);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status, user, authenticationStatus];
}
