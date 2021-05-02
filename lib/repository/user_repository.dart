import 'package:CWCFlutter/api/client.dart';
import 'package:CWCFlutter/api/users_api.dart';
import 'package:CWCFlutter/model/user.dart';
import 'package:dio/dio.dart';

class UserRepository {
  Dio apiClient;
  //or Database
  //or SharedPreference, etc
  UserRepository() {
    apiClient = client();
    //initialize other sources if needed
  }
  Future<List<User>> fetchAllUsers() async {
    Response response = await fetchAll(apiClient);
    return List<User>.from((response.data).map((json) => User.fromJson(json)));
  }

  Future<User> fetchUser(String objectId) async {
    Response response = await fetch(apiClient, objectId);
    return User.fromJson(response.data);
    // TODO:
    // return List<User>.from(response.data);
    // return List<User>.from((response.data).map((json) => User.fromJson(json)));
  }

  Future<User> addUser(User user) async {
    Response response = await add(apiClient, user.toJson());
    return User.fromJson(response.data);
    //TODO: Need to add error handling
  }

  Future<Response> deleteUser(String objectId) async {
    return await delete(apiClient, objectId);
  }

  Future<Response> updateUser(String objectId, User user) async {
    return await update(apiClient, objectId, user.toJson());
  }
}
