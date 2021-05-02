class User {
  String name;
  String age;
  String email;
  String objectId;

  User({this.name, this.age, this.email});

  //Named constructor to call more constructors
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    //TODO: check it
    age = json['age'];
    email = json['email'];
    objectId = json['objectId'];
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'email': email,
      };
}
