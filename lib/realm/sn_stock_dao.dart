import 'package:basic_utils/basic_utils.dart';
import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/sn_stock/get_sn_stock_response.dart';
import 'package:rtracker/api/endpoint/master/sn_stock/get_sn_stock_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/strings.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class SnStockDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetSnStockResponse getSnStockResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<SnStock>();

      for (GetSnStockResponseDetail getSnStockResponseDetail in getSnStockResponse.data) {
        realm.add(
          SnStock(
            getSnStockResponseDetail.serialNumber,
            getSnStockResponseDetail.category,
            getSnStockResponseDetail.productId,
            getSnStockResponseDetail.productName,
            getSnStockResponseDetail.servicePointId,
            getSnStockResponseDetail.servicePointName,
            false,
          ),
        );
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: getSnStockResponse.version,
      );
    });
  }

  static Map<String, List<SpinnerItem>> categoryAndProducts({
    required String servicePointId,
  }) {
    List<SnStock> snStocks = List<SnStock>.from(
      Realms.get().all<SnStock>(),
    );

    Map<String, List<SpinnerItem>> map = {};

    for (SnStock snStock in snStocks) {
      if (!map.containsKey(snStock.category)) {
        map[snStock.category] = [];
      }

      bool found = false;

      for (SpinnerItem spinnerItem in map[snStock.category]!) {
        if (Strings.equals(spinnerItem.identity, snStock.productId)) {
          found = true;

          break;
        }
      }

      if (!found) {
        map[snStock.category]!.add(
          SpinnerItem(
            identity: snStock.productId,
            description: snStock.productName,
          ),
        );
      }
    }

    return map;
  }

  static void used(String serialNumber) {
    List<SnStock> snStocks = List<SnStock>.from(
      Realms.get().query<SnStock>(
        "serialNumber == \$0",
        [serialNumber],
      ),
    );

    if (snStocks.isNotEmpty) {
      SnStock snStock = snStocks.first;

      snStock.used = true;
    }
  }

  static void notUsed(String serialNumber) {
    List<SnStock> snStocks = List<SnStock>.from(
      Realms.get().query<SnStock>(
        "serialNumber == \$0",
        [serialNumber],
      ),
    );

    if (snStocks.isNotEmpty) {
      SnStock snStock = snStocks.first;

      snStock.used = false;
    }
  }

  static SnStock? find({
    required String serialNumber,
    required String servicePointId,
    required String category,
    String? product,
  }) {
    List<SnStock> snStocks;

    if (StringUtils.isNotNullOrEmpty(product)) {
      snStocks = List<SnStock>.from(
        Realms.get().query<SnStock>(
          "serialNumber == \$0 AND servicePointId == \$1 AND category == \$2 AND productId == \$3 AND used == FALSE",
          [serialNumber, servicePointId, category, product],
        ),
      );
    } else {
      snStocks = List<SnStock>.from(
        Realms.get().query<SnStock>(
          "serialNumber == \$0 AND servicePointId == \$1 AND category == \$2 AND used == FALSE",
          [serialNumber, servicePointId, category],
        ),
      );
    }

    if (snStocks.isNotEmpty) {
      return snStocks.first;
    }

    return null;
  }
}
