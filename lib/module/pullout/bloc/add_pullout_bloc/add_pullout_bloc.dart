import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
part 'add_pullout_event.dart';
part 'add_pullout_state.dart';

class AddPulloutBloc extends Bloc<AddPulloutEvent, AddPulloutState> {
  AddPulloutBloc() : super(AddPulloutInitial()) {
    on<AddPulloutEvent>((event, emit) {
      if (event is LoadAllData){
        emit(
          LoadedData(
            listServicePoint: const [],
            listProduct: const [],
            listStatusGoods: const [],
            listMerchant: const [],
          ),
        );
      }

      if (event is SubmitData){

      }
    });
  }
}
