import 'package:realm/realm.dart';
import 'package:rtracker/api/endpoint/master/transaction_test_case/get_transaction_test_case_response.dart';
import 'package:rtracker/api/endpoint/master/transaction_test_case/get_transaction_test_case_response_detail.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/realm/realms.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/version_dao.dart';

class TransactionTestCaseDao {
  static void insertOrUpdate({
    required VersionKey versionKey,
    required GetTransactionTestCaseResponse getTransactionTestCaseResponse,
  }) {
    Realm realm = Realms.get();

    realm.write(() {
      realm.deleteAll<TransactionTestCase>();

      int latestVersion = 0;

      for (GetTransactionTestCaseResponseDetail getTransactionTestCaseResponseDetail in getTransactionTestCaseResponse.data) {
        realm.add(
          TransactionTestCase(
            getTransactionTestCaseResponseDetail.id,
            getTransactionTestCaseResponseDetail.jobTypeId,
            getTransactionTestCaseResponseDetail.name,
            getTransactionTestCaseResponseDetail.amount,
            getTransactionTestCaseResponseDetail.version,
          ),
        );

        if (getTransactionTestCaseResponseDetail.version > latestVersion) {
          latestVersion = getTransactionTestCaseResponseDetail.version;
        }
      }

      VersionDao.updateVersion(
        realm: realm,
        versionKey: versionKey,
        lastVersion: latestVersion,
      );
    });
  }

  static List<TransactionTestCase> all({
    required String jobTypeId,
  }) {
    return List<TransactionTestCase>.from(
      Realms.get().query<TransactionTestCase>(
        'jobTypeId == \$0',
        [jobTypeId],
      ),
    );
  }

  static TransactionTestCase? find(String id) {
    return Realms.get().find(id);
  }
}
