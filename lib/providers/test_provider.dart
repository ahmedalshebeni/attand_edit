
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



class TestProvider with ChangeNotifier{

  String _ipaaddress;
  String _username;
  String _password;


  String  get ipaaddress{
    return _ipaaddress;
  }

  String get username{
    return _username;
  }

  String  get password{
    return _password;
  }





  Future<void> getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('address')){
     return;
    }
    _ipaaddress= prefs.getString("address");
    notifyListeners();
    debugPrint ("addres :" + _ipaaddress);

     if(!prefs.containsKey('name')){
return;
    }
    _username = prefs.getString('name');
    debugPrint("user :" +_username);
    notifyListeners();

    if(!prefs.containsKey('password')){
      return;
    }
    _password= prefs.getString("password");
    notifyListeners();
    debugPrint ("password :" + _password);
  }


 Future<void> setpref(String address,String name,String password)async {
   _ipaaddress=address;
   _username=name;
   _password=password;
   notifyListeners();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('address', address);
   sharedPreferences.setString('name', name);
   sharedPreferences.setString('password', password);
}


Future<void>logout()async{
  _ipaaddress = null;
  _username = null;
  _password=null;
  notifyListeners();
  final pref = await SharedPreferences.getInstance();
  pref.clear();

}


getdata(String  adress, String name,String password) async {
      String url =
          'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select count(*) from hr_emp where emp_id=$name and v_flex10=$password';
      http.Response response = await http.get(url);
      debugPrint (password);
      return json.decode(response.body);
    }


getsysdate(String adress) async {
      String date =
           'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20sysdate%20from%20dual';
      http.Response response = await http.get(date);
      return json.decode(response.body);
    }

// ignore: missing_return
Future<String> onLogin(String name, String address,String password,BuildContext context ) async {
      Map datamap = await getdata(address, name,password);
      Map datemap = await getsysdate(address);
      String check = datamap["data"][0]["count(*)"];
      String chkdate = datemap["data"][0]["sysdate"];
      debugPrint(check);
      debugPrint(chkdate);
          if (check != '0' ) {
             await setpref(address, name,password);
          // Navigator.of(context).pushNamed('/main');
          // Navigator.pushReplacementNamed(context, '/Second');
        }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid Id or Password..', style: TextStyle(color: Colors.white))));

          }

    }



  getparam()async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var adress= prefs.getString("address");
    // ignore: non_constant_identifier_names
    var stk_id = prefs.getString('stk_id');
    String url=
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)';
    http.Response response = await http.get(url);
    debugPrint(url);
    debugPrint(response.body);
    return json.decode(response.body);
  }

  getyear()async{
    // WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var adress= prefs.getString("address");
    Map stk = await getparam();
    String org = stk["data"][0]["org_id"];
    String comp = stk["data"][0]["comp_code"];
    // String branch = stk["data"][0]["branch_code"];
    String year=
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20PERIOD_YEAR%20from%20period_detail%20where%20PERIOD_CODE=(select%20period_code%20from%20company%20where%20org_id=$org%20and%20comp_code=$comp)%20and%20to_date(to_char(sysdate,%27dd-MON-yyyy%27))%20between%20START_DATE%20and%20END_DATE';
   // 'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20max(PERIOD_YEAR)period_year%20from%20period_detail%20where%20PERIOD_CODE=(select%20period_code%20from%20company%20where%20org_id=$org%20and%20comp_code=$comp)';
    http.Response response = await http.get(year);
    debugPrint(response.body);
    return json.decode(response.body);
  }

  // ignore: missing_return
  // Future<Map<String, dynamic>> getMoreData() async {
  //
  //   try{
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //     // ignore: non_constant_identifier_names
  //     var stk_id = prefs.getString('stk_id');
  //
  //     Map<String, dynamic> _data = {
  //       'org_id' : 0,
  //       'comp_code' : 0,
  //       'branch_code' : 0,
  //       'tr_id' : 0,
  //     };
  //
  //     http.Response _moreData = await http.get('http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)');
  //
  //     Map<String, dynamic> _moreDecoedData = json.decode(_moreData.body);
  //
  //     http.Response _trId = await http.get('http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20create_id(%27sal_ord_d %27,%27tr_id%27)%20tr_id%20from%20dual');
  //
  //     _data['org_id'] = _moreDecoedData['data'][0]['org_id'];
  //     _data['comp_code'] = _moreDecoedData['data'][0]['comp_code'];
  //     _data['branch_code'] = _moreDecoedData['data'][0]['branch_code'];
  //     _data['tr_id'] =  json.decode(_trId.body)['data'][0]['tr_id'];
  //     return _data;
  //   }catch(e) {
  //     debugPrint(e);
  //   }
  // }


  


}
