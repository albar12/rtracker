import 'package:rtracker/api/endpoint/terima_non_sn_stock/terima_non_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/terima_sn_stock/terima_sn_stock_response.dart';

abstract class TerimaBarangState {}

class TerimaBarangInitial extends TerimaBarangState {}

class TerimaBarangSendSnStockLoading extends TerimaBarangState {}

class TerimaBarangSendSnStockSuccess extends TerimaBarangState {
  final String message;

  TerimaBarangSendSnStockSuccess({
    required this.message,
  });
}

class TerimaBarangSendSnStockFailed extends TerimaBarangState {
  final String message;

  TerimaBarangSendSnStockFailed({
    required this.message,
  });
}

class TerimaBarangSendSnStockFinished extends TerimaBarangState {}

class TerimaBarangGetSnStockLoading extends TerimaBarangState {}

class TerimaBarangGetSnStockSuccess extends TerimaBarangState {
  final TerimaSnStockResponse terimaSnStockResponse;

  TerimaBarangGetSnStockSuccess({
    required this.terimaSnStockResponse,
  });
}

class TerimaBarangGetSnStockFailed extends TerimaBarangState {
  final String message;

  TerimaBarangGetSnStockFailed({
    required this.message,
  });
}

class TerimaBarangGetSnStockFinished extends TerimaBarangState {}

class TerimaBarangSendNonSnStockLoading extends TerimaBarangState {}

class TerimaBarangSendNonSnStockSuccess extends TerimaBarangState {
  final String message;

  TerimaBarangSendNonSnStockSuccess({
    required this.message,
  });
}

class TerimaBarangSendNonSnStockFailed extends TerimaBarangState {
  final String message;

  TerimaBarangSendNonSnStockFailed({
    required this.message,
  });
}

class TerimaBarangSendNonSnStockFinished extends TerimaBarangState {}

class TerimaBarangGetNonSnStockLoading extends TerimaBarangState {}

class TerimaBarangGetNonSnStockSuccess extends TerimaBarangState {
  final TerimaNonSnStockResponse terimaNonSnStockResponse;

  TerimaBarangGetNonSnStockSuccess({
    required this.terimaNonSnStockResponse,
  });
}

class TerimaBarangGetNonSnStockFailed extends TerimaBarangState {
  final String message;

  TerimaBarangGetNonSnStockFailed({
    required this.message,
  });
}

class TerimaBarangGetNonSnStockFinished extends TerimaBarangState {}
