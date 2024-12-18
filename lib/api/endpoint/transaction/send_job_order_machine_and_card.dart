class SendJobOrderMachineAndCard {
  final String? simCard;
  final String? providerId;
  final String? sam;
  final String? sam2;
  final String? sam3;
  final String? sam4;
  final String? sam5;
  final String? sam6;
  final String? sam7;
  final String? edcTypeId;
  final String? edcCommunicationTypeId;

  SendJobOrderMachineAndCard({
    this.simCard,
    this.providerId,
    this.sam,
    this.sam2,
    this.sam3,
    this.sam4,
    this.sam5,
    this.sam6,
    this.sam7,
    this.edcTypeId,
    this.edcCommunicationTypeId,
  });

  Map<String, dynamic> toJson() => {
        "simCard": simCard,
        "providerId": providerId,
        "sam": sam,
        "sam2": sam2,
        "sam3": sam3,
        "sam4": sam4,
        "sam5": sam5,
        "sam6": sam6,
        "sam7": sam7,
        "edcTypeId": edcTypeId,
        "edcCommunicationTypeId": edcCommunicationTypeId
      };
}
