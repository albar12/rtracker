import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/training_material/get_training_material_response.dart';
import 'package:rtracker/api/endpoint/master/training_material/get_training_material_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class TrainingMaterialDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetTrainingMaterialResponse getTrainingMaterialResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<TrainingMaterial>();

      int latestVersion = 0;

      for (GetTrainingMaterialResponseDetail getTrainingMaterialResponseDetail in getTrainingMaterialResponse.data) {
        realm.add(
          TrainingMaterial(
            getTrainingMaterialResponseDetail.id,
            getTrainingMaterialResponseDetail.name,
            getTrainingMaterialResponseDetail.version,
          ),
        );

        if (getTrainingMaterialResponseDetail.version > latestVersion) {
          latestVersion = getTrainingMaterialResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<TrainingMaterial> all() {
    return List<TrainingMaterial>.from(
      Realms.get().all<TrainingMaterial>(),
    );
  }

  static TrainingMaterial? find(String id) {
    return Realms.get().find(id);
  }
}
