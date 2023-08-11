part of 'quantity_counter_bloc.dart';

sealed class QuantityCounterEvent extends Equatable {
  const QuantityCounterEvent();

  @override
  List<Object> get props => [];
}

class QuantityCounterIncrement extends QuantityCounterEvent {
  final double quantityIncrement;

  const QuantityCounterIncrement({required this.quantityIncrement});

  @override
  List<Object> get props => [quantityIncrement];
}

class QuantityCounterDecrement extends QuantityCounterEvent {
  final double quantityDecrement;

  const QuantityCounterDecrement({required this.quantityDecrement});

  @override
  List<Object> get props => [quantityDecrement];
}
