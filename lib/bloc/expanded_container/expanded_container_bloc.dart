import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expanded_container_event.dart';
part 'expanded_container_state.dart';

class ExpandedContainerBloc
    extends Bloc<ExpandedContainerEvent, ExpandedContainerState> {
  ExpandedContainerBloc()
      : super(const ExpandedContainerInitial(expandedIndex: -1)) {
    on<ToggleExpandedContainer>(
      (event, emit) {
        if (state is ExpandedContainerInitial) {
          final currentState = state as ExpandedContainerInitial;
          if (currentState.expandedIndex == event.expandedContainerIndex) {
            emit(const ExpandedContainerInitial(
                expandedIndex: -1)); // Tutup semua Container
          } else {
            emit(ExpandedContainerInitial(
                expandedIndex:
                    event.expandedContainerIndex)); // Buka expanded Container
          }
        }
      },
    );
  }
}
