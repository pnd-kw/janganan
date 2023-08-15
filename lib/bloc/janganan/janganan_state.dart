part of 'janganan_bloc.dart';

abstract class JangananState extends Equatable {
  const JangananState();

  @override
  List<Object> get props => [];
}

final class JangananInitial extends JangananState {}

class LoadByCategory extends JangananState {
  final List<JangananItem> filteredItems;

  const LoadByCategory({required this.filteredItems});

  @override
  List<Object> get props => [filteredItems];
}
