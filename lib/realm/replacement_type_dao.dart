import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/replacement_type/get_replacement_type_response.dart';
import 'package:rtracker/api/endpoint/master/replacement_type/get_replacement_type_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class ReplacementTypeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetReplacementTypeResponse getReplacementTypeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<ReplacementType>();

      int latestVersion = 0;

      for (GetReplacementTypeResponseDetail getReplacementTypeResponseDetail in getReplacementTypeResponse.data) {
        realm.add(
          ReplacementType(
            getReplacementTypeResponseDetail.id,
            getReplacementTypeResponseDetail.name,
            getReplacementTypeResponseDetail.version,
          ),
        );

        if (getReplacementTypeResponseDetail.version > latestVersion) {
          latestVersion = getReplacementTypeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<ReplacementType> all() {
    return List<ReplacementType>.from(
      Realms.get().all<ReplacementType>(),
    );
  }

  static ReplacementType? find(String id) {
    return Realms.get().find(id);
  }
}
