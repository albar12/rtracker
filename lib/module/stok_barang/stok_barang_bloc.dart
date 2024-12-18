import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/master/non_sn_stock/get_non_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/master/sn_stock/get_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/non_sn_stock_portal/non_sn_stock_portal_response.dart';
import 'package:rtracker/api/endpoint/sn_stock_portal/sn_stock_portal_response.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/exceptions.dart';
import 'package:rtracker/module/stok_barang/stok_barang_event.dart';
import 'package:rtracker/module/stok_barang/stok_barang_state.dart';
import 'package:rtracker/realm/non_sn_stock_dao.dart';
import 'package:rtracker/realm/sn_stock_dao.dart';

class StokBarangBloc extends Bloc<StokBarangEvent, StokBarangState> {
  StokBarangBloc() : super(StokBarangInitial()) {
    on<StokBarangGetSn>(getSn);
    on<StokBarangReturSn>(returSn);
    on<StokBarangGetNonSn>(getNonSn);
    on<StokBarangReturNonSn>(returNonSn);
  }

  FutureOr<void> getSn(
    StokBarangGetSn event,
    Emitter<StokBarangState> emit,
  ) async {
    emit(StokBarangGetSnLoading());

    try {
      Response response = await ApiManager().snStockPortal();

      if (response.statusCode == 200) {
        SnStockPortalResponse snStockPortalResponse = SnStockPortalResponse.fromJson(response.data);

        emit(
          StokBarangGetSnSuccess(
            snStockPortalResponse: snStockPortalResponse,
          ),
        );
      } else {
        emit(
          StokBarangGetSnFailed(
            message: "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message = "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(StokBarangGetSnFailed(message: message));
    } finally {
      emit(StokBarangGetSnFinished());
    }
  }

  FutureOr<void> returSn(
    StokBarangReturSn event,
    Emitter<StokBarangState> emit,
  ) async {
    emit(StokBarangReturSnLoading());

    try {
      Response response = await ApiManager().sendSnRequestRetur(
        id: event.id,
        condition: event.condition,
        serialNumber: event.serialNumber,
        note: event.note,
      );

      if (response.statusCode == 200) {
        try {
          Response response = await ApiManager().snStocks();

          if (response.statusCode == 200 && response.data != null) {
            SnStockDao.insertOrUpdate(
              versionKey: VersionKey.SN_STOCK,
              getSnStockResponse: GetSnStockResponse.fromJson(response.data),
            );
          }
        } catch (e) {
          print(e);
        }

        emit(StokBarangReturSnSuccess(message: response.data));
      } else {
        emit(
          StokBarangReturSnFailed(
            message: "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message = "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(StokBarangReturSnFailed(message: message));
    } finally {
      emit(StokBarangReturSnFinished());
    }
  }

  FutureOr<void> getNonSn(
    StokBarangGetNonSn event,
    Emitter<StokBarangState> emit,
  ) async {
    emit(StokBarangGetNonSnLoading());

    try {
      Response response = await ApiManager().nonSnStockPortal();

      if (response.statusCode == 200) {
        NonSnStockPortalResponse nonSnStockPortalResponse = NonSnStockPortalResponse.fromJson(response.data);

        emit(
          StokBarangGetNonSnSuccess(
            nonSnStockPortalResponse: nonSnStockPortalResponse,
          ),
        );
      } else {
        emit(
          StokBarangGetNonSnFailed(
            message: "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message = "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(StokBarangGetNonSnFailed(message: message));
    } finally {
      emit(StokBarangGetNonSnFinished());
    }
  }

  FutureOr<void> returNonSn(
    StokBarangReturNonSn event,
    Emitter<StokBarangState> emit,
  ) async {
    emit(StokBarangReturNonSnLoading());

    try {
      Response response = await ApiManager().sendNonSnRequestRetur(
        id: event.id,
        condition: event.condition,
        productId: event.productId,
        quantity: event.quantity,
        note: event.note,
      );

      if (response.statusCode == 200) {
        try {
          Response response = await ApiManager().nonSnStocks();

          if (response.statusCode == 200 && response.data != null) {
            NonSnStockDao.insertOrUpdate(
              versionKey: VersionKey.NON_SN_STOCK,
              getNonSnStockResponse: GetNonSnStockResponse.fromJson(response.data),
            );
          }
        } catch (e) {
          print(e);
        }

        emit(StokBarangReturNonSnSuccess(message: response.data));
      } else {
        emit(
          StokBarangReturNonSnFailed(
            message: "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message = "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(StokBarangReturNonSnFailed(message: message));
    } finally {
      emit(StokBarangReturNonSnFinished());
    }
  }
}
