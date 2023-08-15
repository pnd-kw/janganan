part of 'total_price_bloc.dart';

abstract class TotalPriceEvent extends Equatable {
  const TotalPriceEvent();

  @override
  List<Object> get props => [];
}

class TotalPriceCounterEvent extends TotalPriceEvent {
  final double price;
  final double quantity;

  const TotalPriceCounterEvent({required this.price, required this.quantity});

  @override
  List<Object> get props => [price, quantity];
}
