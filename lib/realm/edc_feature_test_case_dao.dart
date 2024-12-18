import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/edc_feature_test_case/get_edc_feature_test_case_response.dart';
import 'package:rtracker/api/endpoint/master/edc_feature_test_case/get_edc_feature_test_case_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class EdcFeatureTestCaseDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetEdcFeatureTestCaseResponse getEdcFeatureTestCaseResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<EdcFeatureTestCase>();

      int latestVersion = 0;

      for (GetEdcFeatureTestCaseResponseDetail getEdcFeatureTestCaseResponseDetail in getEdcFeatureTestCaseResponse.data) {
        realm.add(
          EdcFeatureTestCase(
            getEdcFeatureTestCaseResponseDetail.id,
            getEdcFeatureTestCaseResponseDetail.name,
            getEdcFeatureTestCaseResponseDetail.type,
            getEdcFeatureTestCaseResponseDetail.version,
          ),
        );

        if (getEdcFeatureTestCaseResponseDetail.version > latestVersion) {
          latestVersion = getEdcFeatureTestCaseResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<EdcFeatureTestCase> all() {
    return List<EdcFeatureTestCase>.from(
      Realms.get().all<EdcFeatureTestCase>(),
    );
  }

  static EdcFeatureTestCase? find(String id) {
    return Realms.get().find(id);
  }
}
