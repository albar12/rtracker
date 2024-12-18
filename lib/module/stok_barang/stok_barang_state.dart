import 'package:rtracker/api/endpoint/non_sn_stock_portal/non_sn_stock_portal_response.dart';
import 'package:rtracker/api/endpoint/sn_stock_portal/sn_stock_portal_response.dart';

abstract class StokBarangState {}

class StokBarangInitial extends StokBarangState {}

class StokBarangGetSnLoading extends StokBarangState {}

class StokBarangGetSnSuccess extends StokBarangState {
  final SnStockPortalResponse snStockPortalResponse;

  StokBarangGetSnSuccess({
    required this.snStockPortalResponse,
  });
}

class StokBarangGetSnFailed extends StokBarangState {
  final String message;

  StokBarangGetSnFailed({
    required this.message,
  });
}

class StokBarangGetSnFinished extends StokBarangState {}

class StokBarangReturSnLoading extends StokBarangState {}

class StokBarangReturSnSuccess extends StokBarangState {
  final String message;

  StokBarangReturSnSuccess({
    required this.message,
  });
}

class StokBarangReturSnFailed extends StokBarangState {
  final String message;

  StokBarangReturSnFailed({
    required this.message,
  });
}

class StokBarangReturSnFinished extends StokBarangState {}

class StokBarangGetNonSnLoading extends StokBarangState {}

class StokBarangGetNonSnSuccess extends StokBarangState {
  final NonSnStockPortalResponse nonSnStockPortalResponse;

  StokBarangGetNonSnSuccess({
    required this.nonSnStockPortalResponse,
  });
}

class StokBarangGetNonSnFailed extends StokBarangState {
  final String message;

  StokBarangGetNonSnFailed({
    required this.message,
  });
}

class StokBarangGetNonSnFinished extends StokBarangState {}

class StokBarangReturNonSnLoading extends StokBarangState {}

class StokBarangReturNonSnSuccess extends StokBarangState {
  final String message;

  StokBarangReturNonSnSuccess({
    required this.message,
  });
}

class StokBarangReturNonSnFailed extends StokBarangState {
  final String message;

  StokBarangReturNonSnFailed({
    required this.message,
  });
}

class StokBarangReturNonSnFinished extends StokBarangState {}
