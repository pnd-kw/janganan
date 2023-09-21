import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/repository/auth_repository.dart';

import '../../data/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(
                  authenticationRepository.currentUser, 'Step1Completed')
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogOutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(
        user,
        'Step1Completed',
      )),
    );
  }

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    final authenticationStatus = event.authenticationStatus;

    if (authenticationStatus == 'Step2Completed') {
      emit(AppState.authenticated(event.user, event.authenticationStatus));
    } else {
      final isPhoneNumberVerified = authenticationStatus == 'Step1Completed';
      final isUserAuthenticated = event.user.isNotEmpty;

      if (isUserAuthenticated && isPhoneNumberVerified) {
        emit(AppState.authenticated(event.user, event.authenticationStatus));
      } else {
        emit(const AppState.unauthenticated());
      }
    }
    // emit(
    //   event.user.isNotEmpty
    //       ? AppState.authenticated(event.user)
    //       : const AppState.unauthenticated(),
    // );
  }

  void _onLogoutRequested(AppLogOutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
