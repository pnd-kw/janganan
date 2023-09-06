part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class _AppUserChanged extends AppEvent {
  final User user;

  const _AppUserChanged(this.user);
}

final class AppLogOutRequested extends AppEvent {
  const AppLogOutRequested();
}
