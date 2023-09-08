import 'package:rendu/models/user.dart';
import 'package:rendu/repositories/user_repository.dart';

class UserService {

  static Future<int> update(User user) async {
    return UserRepository.update(user);
  }

  static Future<User?> findById(int id) async {
    return UserRepository.findById(id);
  }

  static Future<User?> login(String username, String password) async {
    final user = await UserRepository.findByUsername(username);
    if (user != null) {
      if(user.userPassword == password) {
        return user;
      }
    }
    return null;
  }

  static Future<User?> register(String username, String password) async {
    final user = User(
        userId: await UserService.generateUserId(),
        userName: username,
        userPassword: password);
    await UserRepository.create(user);
    return UserRepository.findByUserId(user.userId);
  }

  static Future<String> generateUserId() async  {
    final totalUserCount = await UserRepository.count();
    final id = totalUserCount + 1;
    return 'generated-$id';
  }
}
