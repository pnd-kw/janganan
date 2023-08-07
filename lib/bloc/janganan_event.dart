part of 'janganan_bloc.dart';

sealed class JangananEvent extends Equatable {
  const JangananEvent();

  @override
  List<Object> get props => [];
}

class JangananLoaded extends JangananEvent {}
