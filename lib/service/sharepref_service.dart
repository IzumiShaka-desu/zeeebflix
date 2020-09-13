import 'package:shared_preferences/shared_preferences.dart';

class SFService {
  SharedPreferences sf;

  isLogin() async {
    sf = await SharedPreferences.getInstance();
    return sf.getBool('isLogin') ?? false;
  }

 Future< Map<String,dynamic>> getLoginDetails() async {
    sf = await SharedPreferences.getInstance();
    if (await isLogin()) {
      return {'name': sf.getString("name"), 'email': sf.getString("email")};
    }
    return null;
  }

  Future<String> getEmail() async {
    sf = await SharedPreferences.getInstance();

    return sf.getString("email");
  }

  saveLoginDetails(String email, String name) async {
    sf = await SharedPreferences.getInstance();
    sf.setBool('isLogin', true);
    sf.setString('name', name);
    sf.setString('email', email);
  }

  removeSaveLogin() async {
    sf = await SharedPreferences.getInstance();
    sf.clear();
  }
}
