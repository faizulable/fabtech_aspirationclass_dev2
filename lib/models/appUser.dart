class AppUser {
  final String uid;
  AppUser({this.uid});

  factory AppUser.initialData() {
    return AppUser(uid: '');
  }
}