part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class BottomNavigationSelected extends BottomNavigationEvent {
  final int navIndex;

  const BottomNavigationSelected({required this.navIndex});

  @override
  List<Object> get props => [navIndex];
}
