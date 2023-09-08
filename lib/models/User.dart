class User {
  int id;
  final String userId;
  final String userName;
  final String userPassword;

  User({required this.userId, required this.userName, required this.userPassword, this.id = 0});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'password': userPassword,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      userPassword: map['password'],
    );
  }
}