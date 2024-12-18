import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/note/get_note_response.dart';
import 'package:rtracker/api/endpoint/master/note/get_note_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class NoteDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetNoteResponse getNoteResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<Note>();

      int latestVersion = 0;

      for (GetNoteResponseDetail getNoteResponseDetail in getNoteResponse.data) {
        realm.add(
          Note(
            getNoteResponseDetail.id,
            getNoteResponseDetail.name,
            getNoteResponseDetail.version,
          ),
        );

        if (getNoteResponseDetail.version > latestVersion) {
          latestVersion = getNoteResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<Note> all() {
    return List<Note>.from(
      Realms.get().all<Note>(),
    );
  }

  static Note? find(String id) {
    return Realms.get().find(id);
  }
}
