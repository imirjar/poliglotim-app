import 'package:poliglotim/domain/models/user.dart';


class UserAPIMock {
  String login({
    required String email,
    required String password,
  }) {
    return "jwt";
  }
  
  void logout() {}

  User getUserData() {
    return User(id: "id", username: "username", email: "email");
  }
}