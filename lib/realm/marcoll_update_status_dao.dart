import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/marcoll_update_status/get_marcoll_update_status_response.dart';
import 'package:rtracker/api/endpoint/master/marcoll_update_status/get_marcoll_update_status_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class MarcollUpdateStatusDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetMarcollUpdateStatusResponse getMarcollUpdateStatusResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<MarcollUpdateStatus>();

      int latestVersion = 0;

      for (GetMarcollUpdateStatusResponseDetail getMarcollUpdateStatusResponseDetail in getMarcollUpdateStatusResponse.data) {
        realm.add(
          MarcollUpdateStatus(
            getMarcollUpdateStatusResponseDetail.id,
            getMarcollUpdateStatusResponseDetail.name,
            getMarcollUpdateStatusResponseDetail.version,
          ),
        );

        if (getMarcollUpdateStatusResponseDetail.version > latestVersion) {
          latestVersion = getMarcollUpdateStatusResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<MarcollUpdateStatus> all() {
    return List<MarcollUpdateStatus>.from(
      Realms.get().all<MarcollUpdateStatus>(),
    );
  }

  static MarcollUpdateStatus? find(String id) {
    return Realms.get().find(id);
  }
}
