import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:janganan/data/models/category_model.dart';
import 'package:janganan/data/models/janganan_items.dart';

import '../../data/models/janganan_item_model.dart';

part 'janganan_event.dart';
part 'janganan_state.dart';

class JangananBloc extends Bloc<JangananEvent, JangananState> {
  JangananBloc() : super(JangananInitial()) {
    on<LoadByCategoryEvent>((event, emit) async {
      // await Future<void>.delayed(const Duration(seconds: 1));
      emit(LoadByCategory(
          filteredItems: jangananItems
              .where((item) => item.category == event.selectedCat)
              .toList()));
    });
  }
}
