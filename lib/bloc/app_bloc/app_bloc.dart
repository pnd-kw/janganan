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

  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogOutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(
        _AppUserChanged(user),
      ),
    );
  }

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async {
    if (event.user.isNotEmpty) {
      final userVerificationStatus =
          await _authenticationRepository.getUserVerificationStatus();

      if (userVerificationStatus == true) {
        emit(AppState.authenticated(event.user));
      } else {
        emit(const AppState.unauthenticated());
      }
    } else {
      emit(const AppState.unauthenticated());
    }
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
