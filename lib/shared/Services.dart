import 'dart:convert';
import 'package:attendance/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> generateProductList(var flag) async {
  // var flag = Provider.of(context);
  debugPrint(flag);
  String ipaaddress;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ipaaddress = prefs.getString("address");
  // debugPrint(flag);
  // ignore: non_constant_identifier_names
  var stk_id = prefs.getString('stk_id');
  // ignore: non_constant_identifier_names
  var sal_tr_type_id = prefs.getString('sal_tr_type_id');
  // ignore: non_constant_identifier_names
  var curr_code = prefs.getString('curr_code');
  var name = prefs.getString('name');
  debugPrint(
      "stk: $stk_id ,sal_tr_type_id:$sal_tr_type_id,curr_code:$curr_code,name:$name");
  var response = await http.get(Uri.parse(
    // 'http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20*%20from%20mob_work_days%20where%20emp_id%20=59'
      'http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20emp_id%20,to_char%20(work_date,%27dd-mm-yyyy%27)work_date,work_type,start_time,end_time,shift_id%20from%20mob_work_days%20where%20emp_id%20=$name%20order%20by%20to_date(work_date,%27dd-mm-yyyy%27)desc'));
  var decodedProducts = json.decode(response.body);
  debugPrint('REsponse ::::: ${response.body}');
  List<Product> productList = [];
  try {
    decodedProducts['data'].forEach((e) {
      productList.add(Product.fromJson(e));
    });
    // debugPrint('Out REsponse ::::: ${productList.length}');
  } catch (e) {
    debugPrint('error ::::: ${e.toString()}');
  }
  //
  return productList;
}


getparam() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var adress = prefs.getString("address");
  // ignore: non_constant_identifier_names
  var stk_id = prefs.getString('stk_id');
  String url =
      'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)';
  http.Response response = await http.get(url);
  debugPrint(url);
  debugPrint(response.body);
  return json.decode(response.body);
}

getdata() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var name = prefs.getString('name');
  var adress = prefs.getString("address");
  var pass = prefs.getString("password");
  String url =
  // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select count(*) from hr_emp where emp_id=2 and v_flex10=123';
      'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select count(*) from hr_emp where emp_id=$name and v_flex10=$pass';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

getsysdate() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var adress = prefs.getString("address");
  String date =
      'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20sysdate%20from%20dual';
  http.Response response = await http.get(date);
  return json.decode(response.body);
}

getenddate() async {
  // WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // var name = prefs.getString('name');
  var adress = prefs.getString("address");
  String date =
  // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20end_time%20from%20dual';
      'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20end_time%20from%20dual';
  http.Response response = await http.get(date);
  return json.decode(response.body);
}

getstartdate() async {
  // WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // var name = prefs.getString('name');
  var adress = prefs.getString("address");

  String date =
  // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20start_time%20from%20dual';
      'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20start_time%20from%20dual';
  http.Response response = await http.get(date);
  return json.decode(response.body);
}

chkenddate() async {
  // WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // var name = prefs.getString('name');
  var adress = prefs.getString("address");
  String url =
      "http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%203%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1%20and%20end_time%20is%20not%20null";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

chkstartdate() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var name = prefs.getString('name');
  var adress = prefs.getString("address");
  Map datemap = await getsysdate();
  String chkdate = datemap["data"][0]["sysdate"];
  String url =
  // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%202%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1';
  //     'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%20$name%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1';
      'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%20$name%20and%20work_date%20=%20%27$chkdate%27%20and%20work_type=1';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

