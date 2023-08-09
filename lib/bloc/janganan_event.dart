part of 'janganan_bloc.dart';

sealed class JangananEvent extends Equatable {
  const JangananEvent();

  @override
  List<Object> get props => [];
}

class LoadByCategoryEvent extends JangananEvent {
  final Category selectedCat;

  const LoadByCategoryEvent({required this.selectedCat});

  @override
  List<Object> get props => [selectedCat];
}
