import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/check_version/check_version_request.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';

class VersionDao {
  static List<CheckVersionRequestDetail> check() {
    Realm realm = Realms.get();

    realm.write(() {
      for (var versionKey in VersionKey.values) {
        if (!(realm.dynamic.find(Version.schema.name, versionKey.name)?.isValid ?? false)) {
          realm.add(
            Version(
              versionKey.name,
              0,
            ),
          );
        }
      }
    });

    RealmResults<Version> versions = realm.all<Version>();

    List<CheckVersionRequestDetail> checkVersionRequestDetails = [];

    for (var version in versions) {
      checkVersionRequestDetails.add(
        CheckVersionRequestDetail(
          key: version.key,
          value: version.value,
        ),
      );
    }

    return checkVersionRequestDetails;
  }

  static int last(VersionKey versionKey) {
    Realm realm = Realms.get();

    Version? version = realm.find<Version>(versionKey.name);

    if (version != null) {
      return version.value;
    } else {
      return 0;
    }
  }

  static void updateVersion({
    required Realm realm,
    required VersionKey versionKey,
    required int lastVersion,
  }) {
    if (realm.isInTransaction) {
      Version? version = realm.find<Version>(versionKey.name);

      if (version != null) {
        if (versionKey == VersionKey.JOB_ORDER || versionKey == VersionKey.INBOX) {
          if (lastVersion > version.value) {
            version.value = lastVersion;
          }
        } else {
          version.value = lastVersion;
        }
      }
    }
  }
}
