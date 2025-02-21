part of 'add_pullout_bloc.dart';

@immutable
abstract class AddPulloutEvent {}

class LoadAllData extends AddPulloutEvent {}

class SubmitData extends AddPulloutEvent {}