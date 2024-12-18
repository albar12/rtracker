import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/os_patch/get_os_patch_response.dart';
import 'package:rtracker/api/endpoint/master/os_patch/get_os_patch_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class OsPatchDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetOsPatchResponse getOsPatchResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<OsPatch>();

      int latestVersion = 0;

      for (GetOsPatchResponseDetail getOsPatchResponseDetail
          in getOsPatchResponse.data) {
        realm.add(
          OsPatch(
              getOsPatchResponseDetail.id_os_patch,
              getOsPatchResponseDetail.os_patch_name,
              getOsPatchResponseDetail.id_versi_aplikasi,
              getOsPatchResponseDetail.id_tipe_edc,
              getOsPatchResponseDetail.vendor_id,
              getOsPatchResponseDetail.version),
        );

        if (getOsPatchResponseDetail.version > latestVersion) {
          latestVersion = getOsPatchResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<OsPatch> all({
    required String vendorId,
  }) {
    return List<OsPatch>.from(
      Realms.get().query<OsPatch>(
        'vendor_id == \$0',
        [int.parse(vendorId)],
      ),
    );
  }

  static OsPatch? find(String id) {
    return Realms.get().find(id);
  }
}
