import 'package:sholt_waktu_app/model/results.dart';

class ResponseWaktu {
  int code;
  String status;
  Results results;

  ResponseWaktu.fromJsonMap(Map<String, dynamic> map)
      : code = map["code"],
        status = map["status"],
        results = Results.fromJsonMap(map["results"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['status'] = status;
    data['results'] = results == null ? null : results.toJson();
    return data;
  }
}
