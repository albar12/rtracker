import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/base_office/get_base_office_response.dart';
import 'package:rtracker/api/endpoint/master/base_office/get_base_office_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class BaseOfficeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetBaseOfficeResponse getBaseOfficeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<BaseOffice>();

      int latestVersion = 0;

      for (GetBaseOfficeResponseDetail getBaseOfficeResponseDetail in getBaseOfficeResponse.data) {
        realm.add(
          BaseOffice(
            getBaseOfficeResponseDetail.id,
            getBaseOfficeResponseDetail.name,
            getBaseOfficeResponseDetail.version,
          ),
        );

        if (getBaseOfficeResponseDetail.version > latestVersion) {
          latestVersion = getBaseOfficeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<BaseOffice> all() {
    return List<BaseOffice>.from(
      Realms.get().all<BaseOffice>(),
    );
  }

  static BaseOffice? find(String id) {
    return Realms.get().find(id);
  }
}
