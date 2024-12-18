import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/non_sn_stock/get_non_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/master/non_sn_stock/get_non_sn_stock_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class NonSnStockDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetNonSnStockResponse getNonSnStockResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<NonSnStock>();

      for (GetNonSnStockResponseDetail getNonSnStockResponseDetail in getNonSnStockResponse.data) {
        realm.add(
          NonSnStock(
            getNonSnStockResponseDetail.id,
            getNonSnStockResponseDetail.servicePointId,
            getNonSnStockResponseDetail.servicePointName,
            getNonSnStockResponseDetail.category,
            getNonSnStockResponseDetail.productName,
            getNonSnStockResponseDetail.quantity,
          ),
        );
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: getNonSnStockResponse.version,
      );
    });
  }

  static List<NonSnStock> all({
    required String servicePointId,
  }) {
    return List<NonSnStock>.from(
      Realms.get().query<NonSnStock>(
        "servicePointId == \$0",
        [servicePointId],
      ),
    );
  }

  static void decreaseQuantity({
    required String id,
    required int quantity,
    required String servicePointId,
  }) {
    List<NonSnStock> nonSnStocks = List<NonSnStock>.from(
      Realms.get().query<NonSnStock>(
        "id == \$0 AND servicePointId == \$1",
        [id, servicePointId],
      ),
    );

    if (nonSnStocks.isNotEmpty) {
      NonSnStock nonSnStock = nonSnStocks.first;

      nonSnStock.quantity = nonSnStock.quantity - quantity;
    }
  }

  static void increaseQuantity({
    required String id,
    required int quantity,
    required String servicePointId,
  }) {
    List<NonSnStock> nonSnStocks = List<NonSnStock>.from(
      Realms.get().query<NonSnStock>(
        "id == \$0 AND servicePointId == \$1",
        [id, servicePointId],
      ),
    );

    if (nonSnStocks.isNotEmpty) {
      NonSnStock nonSnStock = nonSnStocks.first;

      nonSnStock.quantity = nonSnStock.quantity + quantity;
    }
  }
}
