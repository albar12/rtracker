import 'package:rtracker/constant.dart';

class ImageMandatory {
  static String getImageMandatory(String data, ImageMandatoryKey key) {
    Map<String, String> mandatory = {
      ImageMandatoryKey.signature.name : _getStatus(data, 0),
      ImageMandatoryKey.merchant.name : _getStatus(data, 1),
      ImageMandatoryKey.machine.name : _getStatus(data, 2),
      ImageMandatoryKey.serialNumber.name : _getStatus(data, 3),
      ImageMandatoryKey.picMerchant.name : _getStatus(data, 7),
      ImageMandatoryKey.rollSalesDraft.name : _getStatus(data, 8),
      ImageMandatoryKey.trainingStatementLetter.name : _getStatus(data, 9),
      ImageMandatoryKey.edcApp.name : _getStatus(data, 10),
      ImageMandatoryKey.other.name : _getStatus(data, 11),
      ImageMandatoryKey.struck.name : _getStatus(data, 4),
      ImageMandatoryKey.struckQris.name : _getStatus(data, 5),
      ImageMandatoryKey.struckBrizzi.name : _getStatus(data, 6),
    };
    if (mandatory.containsKey(key.name)){
      return mandatory[key.name]!;
    }
    return "1";
  }

  static String _getStatus(String data, int i) {
    try {
      return data[i];
    } catch (_){
      return "1";
    }
  }
}