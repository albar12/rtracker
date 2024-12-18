import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/job_status/get_job_status_response.dart';
import 'package:rtracker/api/endpoint/master/job_status/get_job_status_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class JobStatusDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetJobStatusResponse getJobStatusResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<JobStatus>();

      int latestVersion = 0;

      for (GetJobStatusResponseDetail getJobStatusResponseDetail in getJobStatusResponse.data) {
        realm.add(
          JobStatus(
            getJobStatusResponseDetail.id,
            getJobStatusResponseDetail.aliasId,
            getJobStatusResponseDetail.vendorId,
            getJobStatusResponseDetail.name,
            getJobStatusResponseDetail.version,
          ),
        );

        if (getJobStatusResponseDetail.version > latestVersion) {
          latestVersion = getJobStatusResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<JobStatus> all({
    required String vendorId,
  }) {
    return List<JobStatus>.from(
      Realms.get().query<JobStatus>(
        'vendorId == \$0',
        [vendorId],
      ),
    );
  }

  static JobStatus? find(String id) {
    return Realms.get().find(id);
  }
}
