import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/app_version/get_app_version_response.dart';
import 'package:rtracker/api/endpoint/master/app_version/get_app_version_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class AppVersionDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetAppVersionResponse getAppVersionResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<AppVersion>();

      int latestVersion = 0;

      for (GetAppVersionResponseDetail getAppVersionResponseDetail
          in getAppVersionResponse.data) {
        realm.add(
          AppVersion(
            getAppVersionResponseDetail.id_primary,
            getAppVersionResponseDetail.id_versi_aplikasi,
            getAppVersionResponseDetail.versi_aplikasi,
            getAppVersionResponseDetail.id_tipe_edc,
            getAppVersionResponseDetail.android,
            getAppVersionResponseDetail.vendor_id,
            getAppVersionResponseDetail.version,
          ),
        );

        if (getAppVersionResponseDetail.version > latestVersion) {
          latestVersion = getAppVersionResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<AppVersion> all({
    required String vendorId,
  }) {
    return List<AppVersion>.from(
      Realms.get().query<AppVersion>(
        'vendor_id == \$0',
        [int.parse(vendorId)],
      ),
    );
  }

  static AppVersion? find(String id) {
    return Realms.get().find(id);
  }
}
