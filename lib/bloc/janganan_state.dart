part of 'janganan_bloc.dart';

sealed class JangananState extends Equatable {
  const JangananState();

  @override
  List<Object> get props => [];
}

final class JangananInitial extends JangananState {}

final class JangananLoad extends JangananState {
  final List<JangananItem> jangananItems;

  const JangananLoad({required this.jangananItems});

  @override
  List<Object> get props => [jangananItems];
}

final class LoadByCategory extends JangananState {
  final List<JangananItem> filteredItems;

  const LoadByCategory({required this.filteredItems});

  @override
  List<Object> get props => [filteredItems];
}
