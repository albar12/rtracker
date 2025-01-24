import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/realm/edc_type_dao.dart';
import 'package:rtracker/realm/provider_dao.dart';

part 'replacement_event.dart';
part 'replacement_state.dart';

class ReplacementBloc extends Bloc<ReplacementEvent, ReplacementState> {

  final List<SamCard> listSamCard = [
    SamCard(
      samCardId: 38,
      vendorId: "2",
      samCardName: "SamCard BRI",
    ),
    SamCard(
      samCardId: 39,
      vendorId: "2",
      samCardName: "SamCard Mandiri",
    ),
    SamCard(
      samCardId: 37,
      vendorId: "2",
      samCardName: "SamCard BNI",
    ),
    SamCard(
      samCardId: 41,
      vendorId: "2",
      samCardName: "SamCard BTN",
    ),
    SamCard(
      samCardId: 91,
      vendorId: "2",
      samCardName: "SamCard BSI",
    ),
    SamCard(
      samCardId: 92,
      vendorId: "2",
      samCardName: "SamCard Danamon",
    ),
    SamCard(
      samCardId: 93,
      vendorId: "2",
      samCardName: "SamCard Astrapay",
    ),
    SamCard(
      samCardId: 34,
      vendorId: "3",
      samCardName: "SamCard BRI",
    ),
    SamCard(
      samCardId: 2,
      vendorId: "3",
      samCardName: "SamCard Mandiri",
    ),
    SamCard(
      samCardId: 3,
      vendorId: "3",
      samCardName: "SamCard BNI",
    ),
    SamCard(
      samCardId: 4,
      vendorId: "3",
      samCardName: "SamCard BTN",
    ),
    SamCard(
      samCardId: 5,
      vendorId: "3",
      samCardName: "SamCard BSI",
    ),
    SamCard(
      samCardId: 6,
      vendorId: "3",
      samCardName: "SamCard Danamon",
    ),
    SamCard(
      samCardId: 7,
      vendorId: "3",
      samCardName: "SamCard Astrapay",
    ),
  ];

  ReplacementBloc() : super(ReplacementInitial()) {
    on<ReplacementEvent>((event, emit) {
      if (event is GetAllProduct){
        emit(ReplacementLoading());
        final filteredListSamCard = this.listSamCard.where((element) => element.vendorId == event.vendorId).toList();
        final realmListMachine = EdcTypeDao.all(vendorId: event.vendorId);
        final realmListSimCard = ProviderDao.all(vendorId: event.vendorId);
        List<SpinnerItem> listSamCard = [];
        List<SpinnerItem> listMachine = [];
        List<SpinnerItem> listSimCard = [];
        for (var samCard in filteredListSamCard) {
          listSamCard.add(SpinnerItem(identity: samCard.samCardId.toString(), description: samCard.samCardName));
        }
        for (var machine in realmListMachine) {
          listMachine.add(SpinnerItem(identity: machine.id, description: machine.name));
        }
        for (var simCard in realmListSimCard){
          listSimCard.add(SpinnerItem(identity: simCard.id, description: simCard.name));
        }
        emit(ReplacementLoaded(listMachine: listMachine, listSimcard: listSimCard, listSamcard: listSamCard));
      }
    });
  }
}

class SamCard {
  final int samCardId;
  final String vendorId;
  final String samCardName;

  SamCard({required this.samCardId, required this.vendorId, required this.samCardName});
}
