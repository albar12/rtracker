import 'package:basic_utils/basic_utils.dart';
import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/service_point/get_service_point_response.dart';
import 'package:rtracker/api/endpoint/master/service_point/get_service_point_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class ServicePointDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetServicePointResponse getServicePointResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<ServicePoint>();

      int latestVersion = 0;

      for (GetServicePointResponseDetail getServicePointResponseDetail in getServicePointResponse.data) {
        realm.add(
          ServicePoint(
            getServicePointResponseDetail.id,
            getServicePointResponseDetail.vendorId,
            getServicePointResponseDetail.baseOfficeId,
            getServicePointResponseDetail.name,
            getServicePointResponseDetail.version,
          ),
        );

        if (getServicePointResponseDetail.version > latestVersion) {
          latestVersion = getServicePointResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<ServicePoint> all({
    required String vendorId,
    String? baseOfficeId,
  }) {
    List<Object> parameters = [];

    String query = "vendorId == \$${parameters.length}";

    parameters.add(vendorId);

    if (baseOfficeId != null) {
      query += " AND baseOfficeId == \$${parameters.length}";

      parameters.add(baseOfficeId);
    }

    return List<ServicePoint>.from(
      Realms.get().query<ServicePoint>(
        query,
        parameters,
      ),
    );
  }

  static ServicePoint? find(String id) {
    return Realms.get().find(id);
  }

  static String name(String? id) {
    if (StringUtils.isNotNullOrEmpty(id)) {
      ServicePoint? servicePoint = Realms.get().find<ServicePoint>(id);

      if (servicePoint != null) {
        return servicePoint.name;
      }
    }

    return "";
  }
}
