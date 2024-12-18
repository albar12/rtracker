import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/edc_equipment/get_edc_equipment_response.dart';
import 'package:rtracker/api/endpoint/master/edc_equipment/get_edc_equipment_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class EdcEquipmentDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetEdcEquipmentResponse getEdcEquipmentResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<EdcEquipment>();

      for (GetEdcEquipmentResponseDetail getEdcEquipmentResponseDetail in getEdcEquipmentResponse.data) {
        realm.add(
          EdcEquipment(
            getEdcEquipmentResponseDetail.name,
            getEdcEquipmentResponseDetail.vendorId,
          ),
        );
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: getEdcEquipmentResponse.version,
      );
    });
  }

  static List<EdcEquipment> all({
    required String vendorId,
  }) {
    return List<EdcEquipment>.from(
      Realms.get().query<EdcEquipment>(
        'vendorId == \$0',
        [vendorId],
      ),
    );
  }

  static EdcEquipment? find(String id) {
    return Realms.get().find(id);
  }
}
