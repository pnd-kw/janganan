part of 'quantity_counter_bloc.dart';

abstract class QuantityCounterEvent extends Equatable {
  const QuantityCounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends QuantityCounterEvent {}

class DecrementEvent extends QuantityCounterEvent {}
