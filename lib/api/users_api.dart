import 'package:dio/dio.dart';

Future<Response> fetchAll(Dio dio) {
  return dio.get("/data/Person");
}

Future<Response> fetch(Dio dio, String objectId) {
  return dio.get("/data/Person/$objectId");
}

Future<Response> add(Dio dio, Map<String, dynamic> data) {
  return dio.post("/data/Person", data: data);
}

Future<Response> delete(Dio dio, String objectId) {
  return dio.delete("/data/Person/$objectId");
}

Future<Response> update(Dio dio, String objectId, Map<String, dynamic> data) {
  return dio.put("/data/Person/$objectId", data: data);
}
