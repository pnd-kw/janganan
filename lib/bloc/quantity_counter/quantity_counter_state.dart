part of 'quantity_counter_bloc.dart';

abstract class QuantityCounterState extends Equatable {
  final num quantity;

  const QuantityCounterState({required this.quantity});

  @override
  List<Object> get props => [quantity];
}

class IntQuantityCounter extends QuantityCounterState {
  const IntQuantityCounter({required int quantity}) : super(quantity: quantity);
}

class DoubleQuantityCounter extends QuantityCounterState {
  const DoubleQuantityCounter({required double quantity})
      : super(quantity: quantity);
}
