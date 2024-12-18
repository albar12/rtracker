import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/qris_menu/get_qris_menu_response.dart';
import 'package:rtracker/api/endpoint/master/qris_menu/get_qris_menu_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class QrisMenuDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetQrisMenuResponse getQrisMenuResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<QrisMenu>();

      int latestVersion = 0;

      for (GetQrisMenuResponseDetail getQrisMenuResponseDetail in getQrisMenuResponse.data) {
        realm.add(
          QrisMenu(
            getQrisMenuResponseDetail.id,
            getQrisMenuResponseDetail.name,
            getQrisMenuResponseDetail.version,
          ),
        );

        if (getQrisMenuResponseDetail.version > latestVersion) {
          latestVersion = getQrisMenuResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<QrisMenu> all() {
    return List<QrisMenu>.from(
      Realms.get().all<QrisMenu>(),
    );
  }

  static QrisMenu? find(String id) {
    return Realms.get().find(id);
  }
}
