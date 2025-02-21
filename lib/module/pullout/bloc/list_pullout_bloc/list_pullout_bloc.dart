import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'list_pullout_event.dart';
part 'list_pullout_state.dart';

class ListPulloutBloc extends Bloc<ListPulloutEvent, ListPulloutState> {
  ListPulloutBloc() : super(ListPulloutInitial()) {
    on<ListPulloutEvent>((event, emit) {
      if (event is LoadData){
        emit(DataLoaded(const []));
      }
    });
  }
}
