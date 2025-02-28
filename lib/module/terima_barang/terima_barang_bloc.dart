import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/master/non_sn_stock/get_non_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/master/sn_stock/get_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/terima_non_sn_stock/terima_non_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/terima_sn_stock/terima_sn_stock_response.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/exceptions.dart';
import 'package:rtracker/module/terima_barang/terima_barang_event.dart';
import 'package:rtracker/module/terima_barang/terima_barang_state.dart';
import 'package:rtracker/realm/non_sn_stock_dao.dart';
import 'package:rtracker/realm/sn_stock_dao.dart';

class TerimaBarangBloc extends Bloc<TerimaBarangEvent, TerimaBarangState> {
  TerimaBarangBloc() : super(TerimaBarangInitial()) {
    on<TerimaBarangSendSnStock>(sendSnStock);
    on<TerimaBarangGetSnStock>(getSnStock);
    on<TerimaBarangSendNonSnStock>(sendNonSnStock);
    on<TerimaBarangGetNonSnStock>(getNonSnStock);
  }

  FutureOr<void> sendSnStock(
    TerimaBarangSendSnStock event,
    Emitter<TerimaBarangState> emit,
  ) async {
    emit(TerimaBarangSendSnStockLoading());

    try {
      Response response = await ApiManager().sendTerimaSnStock(
        serialNumber: event.serialNumber,
      );

      if (response.statusCode == 200) {
        try {
          Response response = await ApiManager().snStocks();

          if (response.statusCode == 200 && response.data != null) {
            SnStockDao.insertOrUpdate(
              versionKey: VersionKey.SN_STOCK,
              // getSnStockResponse: GetSnStockResponse.fromJson(response.data),
              getSnStockResponse:
                  GetSnStockResponse.fromJson(jsonDecode(response.data)),
            );
          }
        } catch (e) {
          print(e);
        }

        emit(TerimaBarangSendSnStockSuccess(message: response.data));
      } else {
        emit(
          TerimaBarangSendSnStockFailed(
            message:
                "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message =
          "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(TerimaBarangSendSnStockFailed(message: message));
    } finally {
      emit(TerimaBarangSendSnStockFinished());
    }
  }

  FutureOr<void> getSnStock(
    TerimaBarangGetSnStock event,
    Emitter<TerimaBarangState> emit,
  ) async {
    emit(TerimaBarangGetSnStockLoading());

    try {
      Response response = await ApiManager().terimaSnStock();

      if (response.statusCode == 200) {
        // TerimaSnStockResponse terimaSnStockResponse =
        //     TerimaSnStockResponse.fromJson(response.data);
        TerimaSnStockResponse terimaSnStockResponse =
            TerimaSnStockResponse.fromJson(jsonDecode(response.data));
        emit(
          TerimaBarangGetSnStockSuccess(
            terimaSnStockResponse: terimaSnStockResponse,
          ),
        );
      } else {
        emit(
          TerimaBarangGetSnStockFailed(
            message:
                "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message =
          "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(TerimaBarangGetSnStockFailed(message: message));
    } finally {
      emit(TerimaBarangGetSnStockFinished());
    }
  }

  FutureOr<void> sendNonSnStock(
    TerimaBarangSendNonSnStock event,
    Emitter<TerimaBarangState> emit,
  ) async {
    emit(TerimaBarangSendNonSnStockLoading());

    try {
      Response response = await ApiManager().sendTerimaNonSnStock(
        id: event.id,
        productId: event.productId,
        quantity: event.quantity,
      );

      if (response.statusCode == 200) {
        try {
          Response response = await ApiManager().nonSnStocks();

          if (response.statusCode == 200 && response.data != null) {
            NonSnStockDao.insertOrUpdate(
              versionKey: VersionKey.NON_SN_STOCK,
              // getNonSnStockResponse:
              //     GetNonSnStockResponse.fromJson(response.data),
              getNonSnStockResponse:
                  GetNonSnStockResponse.fromJson(jsonDecode(response.data)),
            );
          }
        } catch (e) {
          print(e);
        }

        emit(TerimaBarangSendNonSnStockSuccess(message: response.data));
      } else {
        emit(
          TerimaBarangSendNonSnStockFailed(
            message:
                "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message =
          "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(TerimaBarangSendNonSnStockFailed(message: message));
    } finally {
      emit(TerimaBarangSendNonSnStockFinished());
    }
  }

  FutureOr<void> getNonSnStock(
    TerimaBarangGetNonSnStock event,
    Emitter<TerimaBarangState> emit,
  ) async {
    emit(TerimaBarangGetNonSnStockLoading());

    try {
      Response response = await ApiManager().terimaNonSnStock();

      if (response.statusCode == 200) {
        // TerimaNonSnStockResponse terimaNonSnStockResponse =
        //     TerimaNonSnStockResponse.fromJson(response.data);
        TerimaNonSnStockResponse terimaNonSnStockResponse =
            TerimaNonSnStockResponse.fromJson(jsonDecode(response.data));

        emit(
          TerimaBarangGetNonSnStockSuccess(
            terimaNonSnStockResponse: terimaNonSnStockResponse,
          ),
        );
      } else {
        emit(
          TerimaBarangGetNonSnStockFailed(
            message:
                "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.",
          ),
        );
      }
    } catch (e) {
      String message =
          "Ada sesuatu yang salah, mohon coba kembali beberapa saat kemudian.";

      if (e is GeneralException) {
        message = e.message;
      } else if (e is DioError) {
        message = e.response!.data;
      }

      emit(TerimaBarangGetNonSnStockFailed(message: message));
    } finally {
      emit(TerimaBarangGetNonSnStockFinished());
    }
  }
}
