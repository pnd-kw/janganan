part of 'total_price_bloc.dart';

abstract class TotalPriceState extends Equatable {
  const TotalPriceState();

  @override
  List<Object> get props => [];
}

final class TotalPriceCounterState extends TotalPriceState {
  final double totalPrice;

  const TotalPriceCounterState({required this.totalPrice});

  @override
  List<Object> get props => [totalPrice];
}
