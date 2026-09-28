class User {
  String username;
  String password;
  String name;

  User({
    required this.username,
    required this.password,
    required this.name,
  });
}

List<User> users = [
  User(
    username: 'a',
    password: 'a',
    name: 'azzaky',
  ),
];