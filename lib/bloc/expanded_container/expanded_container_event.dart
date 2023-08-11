part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class ToggleCard extends CardEvent {
  final int cardIndex;

  const ToggleCard({required this.cardIndex});

  @override
  List<Object> get props => [cardIndex];
}
