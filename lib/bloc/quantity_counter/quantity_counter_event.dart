part of 'quantity_counter_bloc.dart';

abstract class QuantityCounterEvent extends Equatable {
  const QuantityCounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends QuantityCounterEvent {}

class DecrementEvent extends QuantityCounterEvent {}

// class IntQuantityCounterIncrement extends QuantityCounterEvent {
//   final int quantity;

//   const IntQuantityCounterIncrement({required this.quantity});

//   @override
//   List<Object> get props => [quantity];
// }

// class IntQuantityCounterDecrement extends QuantityCounterEvent {
//   final int quantity;

//   const IntQuantityCounterDecrement({required this.quantity});

//   @override
//   List<Object> get props => [quantity];
// }

// class DoubleQuantityCounterIncrement extends QuantityCounterEvent {
//   final double quantity;

//   const DoubleQuantityCounterIncrement({required this.quantity});

//   @override
//   List<Object> get props => [quantity];
// }

// class DoubleQuantityCounterDecrement extends QuantityCounterEvent {
//   final double quantity;

//   const DoubleQuantityCounterDecrement({required this.quantity});

//   @override
//   List<Object> get props => [quantity];
// }
