class UserModel {
  final String name;
  final String username;
  final String? profileImage;
  final String? profileImagePath;

  UserModel({
    required this.name,
    required this.username,
    this.profileImage,
    this.profileImagePath,
  });
}
