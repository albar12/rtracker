import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/job_category/get_job_category_response.dart';
import 'package:rtracker/api/endpoint/master/job_category/get_job_category_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class JobCategoryDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetJobCategoryResponse getJobCategoryResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<JobCategory>();

      int latestVersion = 0;

      for (GetJobCategoryResponseDetail getJobCategoryResponseDetail in getJobCategoryResponse.data) {
        realm.add(
          JobCategory(
            getJobCategoryResponseDetail.id,
            getJobCategoryResponseDetail.vendorId,
            getJobCategoryResponseDetail.name,
            getJobCategoryResponseDetail.version,
          ),
        );

        if (getJobCategoryResponseDetail.version > latestVersion) {
          latestVersion = getJobCategoryResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<JobCategory> all({
    required String vendorId,
  }) {
    return List<JobCategory>.from(
      Realms.get().query<JobCategory>(
        'vendorId == \$0',
        [vendorId],
      ),
    );
  }

  static JobCategory? find(String id) {
    return Realms.get().find(id);
  }
}
