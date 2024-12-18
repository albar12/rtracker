import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/request_type/get_request_type_response.dart';
import 'package:rtracker/api/endpoint/master/request_type/get_request_type_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class RequestTypeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetRequestTypeResponse getRequestTypeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<RequestType>();

      int latestVersion = 0;

      for (GetRequestTypeResponseDetail getRequestTypeResponseDetail in getRequestTypeResponse.data) {
        realm.add(
          RequestType(
            getRequestTypeResponseDetail.id,
            getRequestTypeResponseDetail.name,
            getRequestTypeResponseDetail.version,
          ),
        );

        if (getRequestTypeResponseDetail.version > latestVersion) {
          latestVersion = getRequestTypeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<RequestType> all() {
    return List<RequestType>.from(
      Realms.get().all<RequestType>(),
    );
  }

  static RequestType? find(String id) {
    return Realms.get().find(id);
  }
}
