class User {
  final String token;
  final String username;
  final bool isAdmin;
  final int id;
  User({
    required this.token,
    required this.username,
    required this.isAdmin,
    required this.id,
  });
}