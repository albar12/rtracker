import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/fitur_edc_bni_mti/get_fitur_edc_bni_mti_response.dart';
import 'package:rtracker/api/endpoint/master/fitur_edc_bni_mti/get_fitur_edc_bni_mti_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class BniMtiEdcFeatureDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetFiturEdcBniMtiResponse response,
  }){
    Realm realm = Realms.get();

    realm.write(() {
      int latestVersion = 0;
      for (GetFiturEdcBniMtiResponseDetail detail in response.data){
        EdcBniMtiFeature? obj = realm.find<EdcBniMtiFeature>(detail.id);

        if (obj != null){
          // Update
          obj.name = detail.name;
        } else {
          // Insert
          obj = EdcBniMtiFeature(
            detail.id, detail.name, false,
          );
          realm.add(obj);
        }

        if (detail.version > latestVersion){
          latestVersion = detail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<EdcBniMtiFeature> all() {
    return List<EdcBniMtiFeature>.from(
      Realms.get().all<EdcBniMtiFeature>(),
    );
  }
}