part of 'add_pullout_bloc.dart';

@immutable
abstract class AddPulloutState {}

class AddPulloutInitial extends AddPulloutState {}

class LoadedData extends AddPulloutState {
  final List<SpinnerItem> listServicePoint;
  final List<SpinnerItem> listProduct;
  final List<SpinnerItem> listStatusGoods;
  final List<SpinnerItem> listMerchant;

  LoadedData({
    required this.listServicePoint,
    required this.listProduct,
    required this.listStatusGoods,
    required this.listMerchant,
  });
}

class LoadingProcess extends AddPulloutState {
  final bool loading;
  LoadingProcess(this.loading);
}
class ProcessSuccess extends AddPulloutState {}
class ProcessFailed extends AddPulloutState {}
