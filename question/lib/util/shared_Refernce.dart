
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil{
   static SharedPreferences? _preferences;

  static void initPreference() async{
    if(_preferences == null){
      _preferences =  await SharedPreferences.getInstance();
    }
  }

  SharedPreferencesUtil(){
    initPreference();
  }
  setUserName(String? userName){
    _preferences!.setString("userName", userName!);

  }
  setEmail(String? email){
      _preferences!.setString("email", email!);


  }

  setPassword(String? password){
    _preferences!.setString("password", password!);
  }

setUsertype(String? userType){
    _preferences!.setString("userType", userType!);
  }
  
  String getUserName(){
    if(_preferences != null){
      return _preferences!.getString('userName') ?? "";
    }
    return "";

  }
  String getEmail(){
    if(_preferences != null){
      return  _preferences!.getString('email') ?? "";
    }
    return "";

  }
 String getPassword(){
    if(_preferences != null){
      return  _preferences!.getString('userType') ?? "";
    }
    return "";

  }

String getUserType(){
    if(_preferences != null){
      return  _preferences!.getString('password') ?? "";
    }
    return "";

  }


}