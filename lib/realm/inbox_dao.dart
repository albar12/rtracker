import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/inbox/get_inbox_response.dart';
import 'package:rtracker/api/endpoint/master/inbox/get_inbox_response_deleted.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';
import 'package:rtracker/api/endpoint/master/inbox/get_inbox_response_detail.dart';
import 'package:rtracker/constant.dart';

class InboxDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetInboxResponse getInboxResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      int latestVersion = 0;

      for (GetInboxResponseDetail getInboxResponseDetail in getInboxResponse.data) {
        Inbox? inbox = realm.find<Inbox>(getInboxResponseDetail.id);

        if (inbox != null) {
          inbox.title = getInboxResponseDetail.title;
          inbox.body = getInboxResponseDetail.body;
          inbox.date = getInboxResponseDetail.date;
          inbox.read = getInboxResponseDetail.read;
        } else {
          inbox = Inbox(
            getInboxResponseDetail.id,
            getInboxResponseDetail.title,
            getInboxResponseDetail.body,
            getInboxResponseDetail.date,
            getInboxResponseDetail.read,
            true,
            getInboxResponseDetail.version,
          );

          realm.add(inbox);
        }

        if (getInboxResponseDetail.version > latestVersion) {
          latestVersion = getInboxResponseDetail.version;
        }
      }

      for (GetInboxResponseDeleted getInboxResponseDeleted in getInboxResponse.deleted) {
        realm.write(() {
          Inbox? inbox = realm.find<Inbox>(getInboxResponseDeleted.id);

          if (inbox != null) {
            realm.delete<Inbox>(inbox);
          }
        });
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<Inbox> all() {
    return List<Inbox>.from(
      Realms.get().all<Inbox>(),
    );
  }

  static Inbox? find(String id) {
    return Realms.get().find(id);
  }

  static void markAsRead(Inbox inbox) {
    var realm = Realms.get();
    realm.write(() {
      inbox.read = true;
      inbox.sent = false;
    });
  }

  static List<Inbox> getNotSentInboxes() {
    return Realms.get().query<Inbox>('sent = \$0', [false]).toList();
  }
}
