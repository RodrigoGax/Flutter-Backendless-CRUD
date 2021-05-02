import 'package:CWCFlutter/controller/user_controller.dart';
import 'package:CWCFlutter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:CWCFlutter/widget/cheetah_button.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Home extends StatelessWidget {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  final UserController controller = UserController.to;

  onItemPressed(User user) {
    nameController.text = user.name;
    ageController.text = user.age;
    emailController.text = user.email;
    controller.setSelected(user);
  }

  onAddPressed() {
    User user = new User(
        name: nameController.text,
        age: ageController.text,
        email: emailController.text);
    onClearPressed();
    controller.addUser(user);
  }

  onDeletePressed(String id) {
    onClearPressed();
    controller.deleteUser(id);
  }

  onClearPressed() {
    nameController.clear();
    ageController.clear();
    emailController.clear();
    controller.clearSelected();
  }

  onUpdatePressed(String id) {
    User user = new User(
        name: nameController.text,
        age: ageController.text,
        email: emailController.text);
    onClearPressed();
    controller.updateUser(id, user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Just testing REST API (Backendless)')),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GetBuilder<UserController>(
              builder: (controller) => Text(controller.selectedUser == null
                  ? ''
                  : controller.selectedUser.objectId),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(hintText: "Age"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetBuilder<UserController>(
                  builder: (controller) => CheetahButton(
                    onPressed: controller.selectedUser == null
                        ? () => onAddPressed()
                        : null,
                    text: "Add",
                  ),
                ),
                GetBuilder<UserController>(
                  builder: (controller) => CheetahButton(
                    onPressed: controller.selectedUser == null
                        ? null
                        : () =>
                            onUpdatePressed(controller.selectedUser.objectId),
                    text: "Update",
                  ),
                ),
                CheetahButton(
                  onPressed: () => onClearPressed(),
                  text: "Clear",
                )
              ],
            ),
            SizedBox(height: 16),
            //Consumer in provider
            GetBuilder<UserController>(
              builder: (controller) => Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: InkWell(
                                onTap: () =>
                                    onItemPressed(controller.users[index]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    Text(controller.users[index].name),
                                    SizedBox(height: 4),
                                    Text(controller.users[index].age),
                                    SizedBox(height: 4),
                                    Text(controller.users[index].email),
                                    SizedBox(height: 8)
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => onDeletePressed(
                                  controller.users[index].objectId),
                            ),
                          ],
                        ),
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.black),
                    itemCount: controller.users.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
