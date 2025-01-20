part of 'replacement_bloc.dart';

@immutable
abstract class ReplacementState {}

class ReplacementInitial extends ReplacementState {}

class ReplacementLoading extends ReplacementState {}

class ReplacementLoaded extends ReplacementState {
  final List<SpinnerItem> listMachine;
  final List<SpinnerItem> listSimcard;
  final List<SpinnerItem> listSamcard;

  ReplacementLoaded({
    required this.listMachine,
    required this.listSimcard,
    required this.listSamcard,
  });
}