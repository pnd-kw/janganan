part of 'card_bloc.dart';

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {
  final int expandedIndex;

  const CardInitial({required this.expandedIndex});

  @override
  List<Object> get props => [expandedIndex];
}
