import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/job_status_category/get_job_status_category_response.dart';
import 'package:rtracker/api/endpoint/master/job_status_category/get_job_status_category_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class JobStatusCategoryDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetJobStatusCategoryResponse getJobStatusCategoryResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<JobStatusCategory>();

      int latestVersion = 0;

      for (GetJobStatusCategoryResponseDetail getJobStatusCategoryResponseDetail
          in getJobStatusCategoryResponse.data) {
        JobStatusCategory? jobStatusCategory = realm
            .find<JobStatusCategory>(getJobStatusCategoryResponseDetail.id);

        if (jobStatusCategory != null) {
          jobStatusCategory.jobStatusId =
              getJobStatusCategoryResponseDetail.jobStatusId;
          jobStatusCategory.jobStatusAliasId =
              getJobStatusCategoryResponseDetail.jobStatusAliasId;
          jobStatusCategory.vendorId =
              getJobStatusCategoryResponseDetail.vendorId;
          jobStatusCategory.jobTypeId =
              getJobStatusCategoryResponseDetail.jobTypeId;
          jobStatusCategory.name = getJobStatusCategoryResponseDetail.name;
          jobStatusCategory.version =
              getJobStatusCategoryResponseDetail.version;
        } else {
          jobStatusCategory = JobStatusCategory(
            getJobStatusCategoryResponseDetail.id,
            getJobStatusCategoryResponseDetail.jobStatusId,
            getJobStatusCategoryResponseDetail.jobStatusAliasId,
            getJobStatusCategoryResponseDetail.vendorId,
            getJobStatusCategoryResponseDetail.name,
            getJobStatusCategoryResponseDetail.version,
            jobTypeId: getJobStatusCategoryResponseDetail.jobTypeId,
          );

          realm.add(jobStatusCategory);
        }

        if (getJobStatusCategoryResponseDetail.version > latestVersion) {
          latestVersion = getJobStatusCategoryResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<JobStatusCategory> all({
    required String jobStatusId,
    required String vendorId,
    String? jobTypeId,
  }) {
    print("alif jobTypeId");
    print(jobTypeId);
    if (jobTypeId != null) {
      return List<JobStatusCategory>.from(
        Realms.get().query<JobStatusCategory>(
          'jobStatusId == \$0 AND vendorId == \$1 AND jobTypeId == \$2',
          [jobStatusId, vendorId, jobTypeId],
        ),
      );
    } else {
      return List<JobStatusCategory>.from(
        Realms.get().query<JobStatusCategory>(
          'jobStatusId == \$0 AND vendorId == \$1 AND jobTypeId == NULL',
          [jobStatusId, vendorId, jobTypeId],
        ),
      );
    }
  }

  static JobStatusCategory? find(String id) {
    return Realms.get().find(id);
  }
}
