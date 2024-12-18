import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/edc_type/get_edc_type_response.dart';
import 'package:rtracker/api/endpoint/master/edc_type/get_edc_type_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class EdcTypeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetEdcTypeResponse getEdcTypeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<EdcType>();

      int latestVersion = 0;

      for (GetEdcTypeResponseDetail getEdcTypeResponseDetail
          in getEdcTypeResponse.data) {
        realm.add(
          EdcType(
            getEdcTypeResponseDetail.id,
            getEdcTypeResponseDetail.vendorId,
            getEdcTypeResponseDetail.name,
            getEdcTypeResponseDetail.version,
            getEdcTypeResponseDetail.flag_android,
          ),
        );

        if (getEdcTypeResponseDetail.version > latestVersion) {
          latestVersion = getEdcTypeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<EdcType> all({
    required String vendorId,
  }) {
    return List<EdcType>.from(
      Realms.get().query<EdcType>(
        'vendorId == \$0',
        [vendorId],
      ),
    );
  }

  static EdcType? find(String id) {
    return Realms.get().find(id);
  }
}
