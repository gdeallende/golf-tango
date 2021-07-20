import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceAssistant {
  static String sPUserLoggedInKey = "ISLOGGEDIN";
  static String userIdKey = "USERKEY";
  static String lastNameKey = "LASTNAMEKEY";
  static String firstNameKey = "FIRSTNAMEKEY";
  static String displayNameKey = "USERDISPLAYNAME";
  static String userEmailKey = "USEREMAILKEY";
  static String profilePicKey = "USERPROFILEPICKEY";

  //saving the information

  static saveFirstName(String inputUserName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(firstNameKey, inputUserName);
  }

  static saveLastName(String inputUserName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(lastNameKey, inputUserName);
  }

  static saveUserId(String inputUserId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userIdKey, inputUserId);
  }

  static saveDisplayName(String inputDisplayName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(displayNameKey, inputDisplayName);
  }

  static saveEmail(String inputEmail) async {
    print("email : $inputEmail");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userEmailKey, inputEmail);
    // print("get stored email : ${preferences.getString(userEmailKey)}");
  }

  static saveProfilePic(String inputProfilePic) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(profilePicKey, inputProfilePic);
  }

  // getters

  static Future<bool> getUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sPUserLoggedInKey);
  }

  static Future<String> getFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(firstNameKey);
  }

  static Future<String> getLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(lastNameKey);
  }

  static Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userIdKey);
  }

  static Future<String> getDisplayName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(displayNameKey);
  }

  static Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString(userEmailKey);
    print("get email $email");
    return preferences.getString(userEmailKey);
  }

  static Future<String> getProfilePic() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(profilePicKey);
  }
}
