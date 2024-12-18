import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/edc_communication_type/get_edc_communication_type_response.dart';
import 'package:rtracker/api/endpoint/master/edc_communication_type/get_edc_communication_type_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class EdcCommunicationTypeDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetEdcCommunicationTypeResponse getEdcCommunicationTypeResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<EdcCommunicationType>();

      int latestVersion = 0;

      for (GetEdcCommunicationTypeResponseDetail getEdcCommunicationTypeResponseDetail in getEdcCommunicationTypeResponse.data) {
        realm.add(
          EdcCommunicationType(
            getEdcCommunicationTypeResponseDetail.id,
            getEdcCommunicationTypeResponseDetail.name,
            getEdcCommunicationTypeResponseDetail.version,
          ),
        );

        if (getEdcCommunicationTypeResponseDetail.version > latestVersion) {
          latestVersion = getEdcCommunicationTypeResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<EdcCommunicationType> all() {
    return List<EdcCommunicationType>.from(
      Realms.get().all<EdcCommunicationType>(),
    );
  }

  static EdcCommunicationType? find(String id) {
    return Realms.get().find(id);
  }
}
