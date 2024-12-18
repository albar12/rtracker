import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/dor_menu/get_dor_menu_response.dart';
import 'package:rtracker/api/endpoint/master/dor_menu/get_dor_menu_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class DorMenuDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetDorMenuResponse getDorMenuResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<DorMenu>();

      int latestVersion = 0;

      for (GetDorMenuResponseDetail getDorMenuResponseDetail
          in getDorMenuResponse.data) {
        realm.add(
          DorMenu(
            getDorMenuResponseDetail.id,
            getDorMenuResponseDetail.name,
            getDorMenuResponseDetail.version,
          ),
        );

        if (getDorMenuResponseDetail.version > latestVersion) {
          latestVersion = getDorMenuResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<DorMenu> all() {
    return List<DorMenu>.from(
      Realms.get().all<DorMenu>(),
    );
  }

  static DorMenu? find(String id) {
    return Realms.get().find(id);
  }
}
