import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'total_price_event.dart';
part 'total_price_state.dart';

class TotalPriceBloc extends Bloc<TotalPriceEvent, TotalPriceCounterState> {
  TotalPriceBloc() : super(const TotalPriceCounterState(totalPrice: 0)) {
    on<TotalPriceCounterEvent>((event, emit) {
      emit(TotalPriceCounterState(totalPrice: event.price * event.quantity));
    });
  }
}
