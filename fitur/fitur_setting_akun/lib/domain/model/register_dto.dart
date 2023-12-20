class RegisterDto {
  final String username;
  final String password;
  final bool isAdmin;
  RegisterDto({
    required this.username,
    required this.password,
    required this.isAdmin
  });
}