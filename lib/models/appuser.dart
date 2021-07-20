class Appuser {
  final String uid;

  Appuser({this.uid});
}

class UserDetails {
  String uid;
  String firstName;
  String lastName;
  String email;
  String profilePic;
  String displayName;

  UserDetails(
      {this.uid,
      this.firstName,
      this.lastName,
      this.email,
      this.profilePic,
      this.displayName});

  Future<String> getDisplayName() async {
    return displayName;
  }

  Future<String> getEmail() async {
    return email;
  }

  Future<String> getProfilePic() async {
    return profilePic;
  }
}
