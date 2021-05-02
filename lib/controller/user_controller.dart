import 'package:CWCFlutter/model/user.dart';
import 'package:CWCFlutter/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class UserController extends GetxController {
  List<User> users = [];
  User selectedUser;
  UserRepository repository = UserRepository();

  static UserController get to => Get.find<UserController>();

  fecthAllUsers() async {
    users = await repository.fetchAllUsers();
    update(); //NotifyListeners
  }

  Future<User> fecthUser(String id) async {
    return await repository.fetchUser(id);
  }

  addUser(User user) async {
    users.add(await repository.addUser(user));
    update(); //NotifyListeners
  }

  deleteUser(String objectId) async {
    Response response = await repository.deleteUser(objectId);
    if (response.data['code'] == null) {
      users.removeWhere((element) => element.objectId == objectId);
      update(); //NotifyListeners
    }
  }

  updateUser(String objectId, User user) async {
    Response response = await repository.updateUser(objectId, user);
    if (response.data['code'] == null) {
      //Need to know which item in our list to update so we need index
      int index = users.indexWhere((element) => element.objectId == objectId);
      //Add to that user from Api user
      users[index] = User.fromJson(response.data);
      update(); //NotifyListeners
    }
  }

  setSelected(User user) {
    selectedUser = user;
    update();
  }

  clearSelected() {
    selectedUser = null;
    update();
  }
}
