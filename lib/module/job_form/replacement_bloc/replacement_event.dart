part of 'replacement_bloc.dart';

@immutable
abstract class ReplacementEvent {}

class GetAllProduct extends ReplacementEvent {
  final String vendorId;
  GetAllProduct({required this.vendorId});
}
