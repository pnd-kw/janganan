import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationChanged(navIndex: 0)) {
    on<BottomNavigationSelected>((event, emit) {
      emit(BottomNavigationChanged(navIndex: event.navIndex));
    });
  }
}
