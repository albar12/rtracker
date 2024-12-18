import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/provider/get_provider_response.dart';
import 'package:rtracker/api/endpoint/master/provider/get_provider_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class ProviderDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetProviderResponse getProviderResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<Provider>();

      int latestVersion = 0;

      for (GetProviderResponseDetail getProviderResponseDetail in getProviderResponse.data) {
        realm.add(
          Provider(
            getProviderResponseDetail.id,
            getProviderResponseDetail.vendorId,
            getProviderResponseDetail.name,
            getProviderResponseDetail.version,
          ),
        );

        if (getProviderResponseDetail.version > latestVersion) {
          latestVersion = getProviderResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<Provider> all({
    required String vendorId,
  }) {
    return List<Provider>.from(
      Realms.get().query<Provider>(
        'vendorId == \$0',
        [vendorId],
      ),
    );
  }

  static Provider? find(String id) {
    return Realms.get().find(id);
  }
}
