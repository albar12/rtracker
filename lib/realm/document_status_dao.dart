import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/document_status/get_document_status_response.dart';
import 'package:rtracker/api/endpoint/master/document_status/get_document_status_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class DocumentStatusDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetDocumentStatusResponse getDocumentStatusResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<DocumentStatus>();

      int latestVersion = 0;

      for (GetDocumentStatusResponseDetail getDocumentStatusResponseDetail in getDocumentStatusResponse.data) {
        realm.add(
          DocumentStatus(
            getDocumentStatusResponseDetail.id,
            getDocumentStatusResponseDetail.name,
            getDocumentStatusResponseDetail.version,
          ),
        );

        if (getDocumentStatusResponseDetail.version > latestVersion) {
          latestVersion = getDocumentStatusResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<DocumentStatus> all() {
    return List<DocumentStatus>.from(
      Realms.get().all<DocumentStatus>(),
    );
  }

  static DocumentStatus? find(String id) {
    return Realms.get().find(id);
  }
}
