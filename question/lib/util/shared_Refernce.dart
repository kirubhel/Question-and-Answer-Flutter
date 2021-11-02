
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

   setId(int? id){
    _preferences!.setInt("id", id!);

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
  
    int getId(){
    if(_preferences != null){
      return _preferences!.getInt('id') ?? 0;
    }
    return 0;

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
      return  _preferences!.getString('userType') ?? "";
    }
    return "";

  }


}