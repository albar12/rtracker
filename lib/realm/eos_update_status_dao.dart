import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/eos_update_status/get_eos_update_status_response.dart';
import 'package:rtracker/api/endpoint/master/eos_update_status/get_eos_update_status_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class EosUpdateStatusDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetEosUpdateStatusResponse getEosUpdateStatusResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<EosUpdateStatus>();

      int latestVersion = 0;

      for (GetEosUpdateStatusResponseDetail getEosUpdateStatusResponseDetail in getEosUpdateStatusResponse.data) {
        realm.add(
          EosUpdateStatus(
            getEosUpdateStatusResponseDetail.id,
            getEosUpdateStatusResponseDetail.name,
            getEosUpdateStatusResponseDetail.version,
          ),
        );

        if (getEosUpdateStatusResponseDetail.version > latestVersion) {
          latestVersion = getEosUpdateStatusResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<EosUpdateStatus> all() {
    return List<EosUpdateStatus>.from(
      Realms.get().all<EosUpdateStatus>(),
    );
  }

  static EosUpdateStatus? find(String id) {
    return Realms.get().find(id);
  }
}
