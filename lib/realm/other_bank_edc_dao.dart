import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/other_bank_edc/get_other_bank_edc_response.dart';
import 'package:rtracker/api/endpoint/master/other_bank_edc/get_other_bank_edc_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class OtherBankEdcDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetOtherBankEdcResponse getOtherBankEdcResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<OtherBankEdc>();

      int latestVersion = 0;

      for (GetOtherBankEdcResponseDetail getOtherBankEdcResponseDetail in getOtherBankEdcResponse.data) {
        realm.add(
          OtherBankEdc(
            getOtherBankEdcResponseDetail.id,
            getOtherBankEdcResponseDetail.name,
            getOtherBankEdcResponseDetail.version,
          ),
        );

        if (getOtherBankEdcResponseDetail.version > latestVersion) {
          latestVersion = getOtherBankEdcResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<OtherBankEdc> all() {
    return List<OtherBankEdc>.from(
      Realms.get().all<OtherBankEdc>(),
    );
  }

  static OtherBankEdc? find(String id) {
    return Realms.get().find(id);
  }
}
