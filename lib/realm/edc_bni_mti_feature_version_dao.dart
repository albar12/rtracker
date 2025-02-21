import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/fitur_edc_bni_mti/get_fitur_edc_bni_mti_response.dart';
import 'package:rtracker/api/endpoint/master/fitur_edc_bni_mti/get_fitur_edc_bni_mti_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class EdcBniMtiFeatureVersionDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetFiturEdcBniMtiResponse response,
  }){
    Realm realm = Realms.get();

    realm.write(() {
      int latestVersion = 0;
      for (GetFiturEdcBniMtiResponseDetail detail in response.data){
        EdcBniMtiFeatureVersion? obj = realm.find<EdcBniMtiFeatureVersion>(detail.id);

        if (obj != null){
          // Update
          obj.name = detail.name;
        } else {
          // Insert
          obj = EdcBniMtiFeatureVersion(
            detail.id, detail.name, detail.version,
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

  static List<EdcBniMtiFeatureVersion> all() {
    return List<EdcBniMtiFeatureVersion>.from(
      Realms.get().all<EdcBniMtiFeatureVersion>(),
    );
  }
}