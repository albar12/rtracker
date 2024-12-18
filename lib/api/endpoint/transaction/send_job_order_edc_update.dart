class SendJobOrderEdcUpdate {
  final String? dorMenuId;
  final String? marcollUpdateStatusId;
  final String? eosUpdateStatusId;
  final String? appVersion;
  final String? osPatch;
  final String? stickerBank;
  final String? cleaningEdc;

  SendJobOrderEdcUpdate({
    required this.dorMenuId,
    required this.marcollUpdateStatusId,
    required this.eosUpdateStatusId,
    required this.appVersion,
    required this.osPatch,
    required this.stickerBank,
    required this.cleaningEdc,
  });

  Map<String, dynamic> toJson() => {
        "dorMenuId": dorMenuId,
        "marcollUpdateStatusId": marcollUpdateStatusId,
        "eosUpdateStatusId": eosUpdateStatusId,
        "appVersion": appVersion,
        "osPatch": osPatch,
        "stickerBank": stickerBank,
        "cleaningEdc": cleaningEdc,
      };
}
