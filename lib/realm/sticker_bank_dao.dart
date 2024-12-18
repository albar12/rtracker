import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/sticker_bank/get_sticker_bank_response.dart';
import 'package:rtracker/api/endpoint/master/sticker_bank/get_sticker_bank_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class StickerBankDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetStickerBankResponse getOsPatchResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<StickerBank>();

      int latestVersion = 0;

      for (GetStickerBankResponseDetail getStickerBankResponseDetail
          in getOsPatchResponse.data) {
        realm.add(
          StickerBank(
              getStickerBankResponseDetail.idx,
              getStickerBankResponseDetail.nama_sticker_bank,
              getStickerBankResponseDetail.vendor_id,
              getStickerBankResponseDetail.version),
        );

        if (getStickerBankResponseDetail.version > latestVersion) {
          latestVersion = getStickerBankResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<StickerBank> all({
    required String vendorId,
  }) {
    return List<StickerBank>.from(
      Realms.get().query<StickerBank>(
        'vendor_id == \$0',
        [int.parse(vendorId)],
      ),
    );
  }

  static StickerBank? find(String id) {
    return Realms.get().find(id);
  }
}
