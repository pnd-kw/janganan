import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_counter_event.dart';
part 'quantity_counter_state.dart';

class QuantityCounterBloc
    extends Bloc<QuantityCounterEvent, QuantityCounterState> {
  final bool isIntType;
  QuantityCounterBloc({required this.isIntType})
      : super(isIntType
            ? const IntQuantityCounter(quantity: 0)
            : const DoubleQuantityCounter(quantity: 0)) {
    on<QuantityCounterEvent>((event, emit) {
      if (event is IncrementEvent) {
        if (isIntType) {
          emit(IntQuantityCounter(quantity: state.quantity.toInt() + 1));
        } else {
          emit(DoubleQuantityCounter(quantity: state.quantity + 0.25));
        }
      } else if (event is DecrementEvent) {
        if (isIntType) {
          emit(IntQuantityCounter(quantity: state.quantity.toInt() - 1));
        } else {
          emit(DoubleQuantityCounter(quantity: state.quantity - 0.25));
        }
      }
    });
  }
}
