import 'package:basic_utils/basic_utils.dart';
import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/vendor/get_vendor_response.dart';
import 'package:rtracker/api/endpoint/master/vendor/get_vendor_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class VendorDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetVendorResponse getVendorResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<Vendor>();

      int latestVersion = 0;

      for (GetVendorResponseDetail getVendorResponseDetail
          in getVendorResponse.data) {
        realm.add(
          Vendor(
            getVendorResponseDetail.id,
            getVendorResponseDetail.name,
            getVendorResponseDetail.version,
          ),
        );

        if (getVendorResponseDetail.version > latestVersion) {
          latestVersion = getVendorResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<Vendor> all() {
    return List<Vendor>.from(
      Realms.get().all<Vendor>(),
    );
  }

  static Vendor? find(String id) {
    return Realms.get().find(id);
  }

  static String name(String? id) {
    if (StringUtils.isNotNullOrEmpty(id)) {
      Vendor? vendor = Realms.get().find<Vendor>(id);

      if (vendor != null) {
        return vendor.name;
      }
    }

    return "";
  }
}
