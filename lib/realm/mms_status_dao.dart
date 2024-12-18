import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/mms_status/get_mms_status_response.dart';
import 'package:rtracker/api/endpoint/master/mms_status/get_mms_status_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class MmsStatusDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetMmsStatusResponse getMmsStatusResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<MmsStatus>();

      int latestVersion = 0;

      for (GetMmsStatusResponseDetail getMmsStatusResponseDetail in getMmsStatusResponse.data) {
        realm.add(
          MmsStatus(
            getMmsStatusResponseDetail.id,
            getMmsStatusResponseDetail.name,
            getMmsStatusResponseDetail.version,
          ),
        );

        if (getMmsStatusResponseDetail.version > latestVersion) {
          latestVersion = getMmsStatusResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<MmsStatus> all() {
    return List<MmsStatus>.from(
      Realms.get().all<MmsStatus>(),
    );
  }

  static MmsStatus? find(String id) {
    return Realms.get().find(id);
  }
}
