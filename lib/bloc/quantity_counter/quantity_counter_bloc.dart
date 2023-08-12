import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_counter_event.dart';
part 'quantity_counter_state.dart';

class QuantityCounterBloc
    extends Bloc<QuantityCounterEvent, QuantityCounterState> {
  final bool isIntType;
  QuantityCounterBloc({required this.isIntType})
      : super(isIntType
            ? const IntQuantityCounter(quantity: 1)
            : const DoubleQuantityCounter(quantity: 0.25)) {
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
    // on<IntQuantityCounterIncrement>((event, emit) {
    //   emit(IntQuantityCounter(
    //       quantity: (state as IntQuantityCounter).quantity + 1));
    // });
    // on<IntQuantityCounterDecrement>((event, emit) {
    //   emit(IntQuantityCounter(
    //       quantity: (state as IntQuantityCounter).quantity - 1));
    // });
    // on<DoubleQuantityCounterIncrement>((event, emit) {
    //   emit(DoubleQuantityCounter(
    //       quantity: (state as DoubleQuantityCounter).quantity + 0.25));
    // });
    // on<DoubleQuantityCounterDecrement>((event, emit) {
    //   emit(DoubleQuantityCounter(
    //       quantity: (state as DoubleQuantityCounter).quantity - 0.25));
    // });
  }
}
