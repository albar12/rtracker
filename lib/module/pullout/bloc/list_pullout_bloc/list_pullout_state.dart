part of 'list_pullout_bloc.dart';

@immutable
abstract class ListPulloutState {}

class ListPulloutInitial extends ListPulloutState {}

class DataLoaded extends ListPulloutState {
  final List<String> list;
  DataLoaded(this.list);
}
