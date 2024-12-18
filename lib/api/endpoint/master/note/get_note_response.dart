import 'package:rtracker/api/endpoint/master/note/get_note_response_detail.dart';

class GetNoteResponse {
  final List<GetNoteResponseDetail> data;

  GetNoteResponse({
    required this.data,
  });

  factory GetNoteResponse.fromJson(Map<String, dynamic> json) {
    List<GetNoteResponseDetail> getNoteResponseDetails = [];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        getNoteResponseDetails.add(GetNoteResponseDetail.fromJson(v));
      });
    }

    return GetNoteResponse(data: getNoteResponseDetails);
  }
}
