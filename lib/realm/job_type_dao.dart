import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/job_type/get_job_type_response.dart';
import 'package:rtracker/api/endpoint/master/job_type/get_job_type_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class JobTypeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetJobTypeResponse getJobTypeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<JobType>();

      int latestVersion = 0;

      for (GetJobTypeResponseDetail getJobTypeResponseDetail in getJobTypeResponse.data) {
        realm.add(
          JobType(
            getJobTypeResponseDetail.id,
            getJobTypeResponseDetail.vendorId,
            getJobTypeResponseDetail.name,
            getJobTypeResponseDetail.description,
            getJobTypeResponseDetail.version,
          ),
        );

        if (getJobTypeResponseDetail.version > latestVersion) {
          latestVersion = getJobTypeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<JobType> all({
    required String vendorId,
  }) {
    return List<JobType>.from(
      Realms.get().query<JobType>(
        'vendorId == \$0',
        [vendorId],
      ),
    );
  }

  static JobType? find(String id) {
    return Realms.get().find(id);
  }
}
