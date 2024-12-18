import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/damage_type/get_damage_type_response.dart';
import 'package:rtracker/api/endpoint/master/damage_type/get_damage_type_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class DamageTypeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetDamageTypeResponse getDamageTypeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<DamageType>();

      int latestVersion = 0;

      for (GetDamageTypeResponseDetail getDamageTypeResponseDetail in getDamageTypeResponse.data) {
        realm.add(
          DamageType(
            getDamageTypeResponseDetail.id,
            getDamageTypeResponseDetail.name,
            getDamageTypeResponseDetail.version,
          ),
        );

        if (getDamageTypeResponseDetail.version > latestVersion) {
          latestVersion = getDamageTypeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<DamageType> all() {
    return List<DamageType>.from(
      Realms.get().all<DamageType>(),
    );
  }

  static DamageType? find(String id) {
    return Realms.get().find(id);
  }
}
