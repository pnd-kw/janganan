import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_counter_event.dart';
part 'quantity_counter_state.dart';

// class CounterBloc extends Bloc<QuantityCounterEvent, QuantityCounterState> {
//   CounterBloc() : super(const QuantityCounterInitial(quantity: 0)) {
//     on<QuantityCounterIncrement>((event, emit) {
//       emit(QuantityCounterInitial(quantity: event.quantityIncrement + 1));
//     });
//     on<QuantityCounterDecrement>((event, emit) {
//       emit(QuantityCounterInitial(quantity: event.quantityDecrement - 1));
//     });
//   }
// }

class QuantityCounterBloc extends Bloc<QuantityCounterEvent, int> {
  QuantityCounterBloc() : super(0) {
    on<QuantityCounterIncrement>((event, emit) {
      emit(state + 1);
    });
    on<QuantityCounterDecrement>((event, emit) {
      emit(state - 1);
    });
  }
}
