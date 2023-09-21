part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

final class _AppUserChanged extends AppEvent {
  final User user;
  final String authenticationStatus;

  const _AppUserChanged(this.user, this.authenticationStatus);
}

final class AppLogOutRequested extends AppEvent {
  const AppLogOutRequested();
}
