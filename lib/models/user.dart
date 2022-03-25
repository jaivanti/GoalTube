class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    this.photoUrl,
    required this.displayName,
  });

  final String uid;
  final String? email;
  final String? photoUrl;
  final String? displayName;
}
