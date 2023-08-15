part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

final class BottomNavigationInitial extends BottomNavigationState {}

class BottomNavigationChanged extends BottomNavigationState {
  final int navIndex;

  const BottomNavigationChanged({required this.navIndex});

  @override
  List<Object> get props => [navIndex];
}
