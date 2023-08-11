import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(const CardInitial(expandedIndex: -1)) {
    on<ToggleCard>((event, emit) {
      if (state is CardInitial) {
        final currentState = state as CardInitial;
        if (currentState.expandedIndex == event.cardIndex) {
          emit(const CardInitial(expandedIndex: -1));
        } else {
          emit(CardInitial(expandedIndex: event.cardIndex));
        }
      }
      // if (event.cardIndex == state.expandedIndex) {
      //   emit(const CardInitial(expandedIndex: -1));
      // } else {
      //   emit(CardInitial(expandedIndex: event.cardIndex));
      // }
    });
  }
}
