import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:attendance/Gui/showtable.dart';
import 'package:attendance/model/models.dart';
import 'package:attendance/shared/Services.dart';
import 'package:attendance/shared/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));
String payloadToJson(Payload data) => json.encode(data.toJson());

// ignore: camel_case_types
class approveLeave extends StatefulWidget {
  @override
  _approveLeaveState createState() => _approveLeaveState();
}

// ignore: camel_case_types
class _approveLeaveState extends State<approveLeave> {
  bool isInit = true;
  String ipaaddress;
  final double limit = 50.0;
  String _locationMessage = "";
  String time;
  // void getAttendData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey('attendData')) {
  //     setState(() {
  //       attendDateTime = DateTime.tryParse(prefs.getString('attendData'));
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getAttendData();
  // }

//show all widget
//   DateTime attendDateTime;

  // dynamic _macAdrres ="unknwon";
  String _imeinumber = "";
  Payload payload;
  Datum dropdownValue;

  Future<dynamic> getshift() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ipaaddress = prefs.getString("address");
    try {
      var response = await http.get(
          "http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20shift_id,shift_name%20from%20hr_att_shifts"
        );
      // debugPrint("shiftesss::"+ dropdownValue.shift_id);
      debugPrint(response.body);
      payload = payloadFromJson(response.body);
      return 'success';
    } catch (err) {
      debugPrint(err);
      throw err;
    }
  }

  initplatformstate() async {
    // dynamic macAdrres ;
    String imeinumber;
    try {
      // macAdrres=await GetMac.macAddress;
      imeinumber =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    } on PlatformException {
      // macAdrres="failed";
    }
    if (!mounted) return;
    setState(() {
      // _macAdrres=macAdrres;
      // print(_macAdrres);
      _imeinumber = imeinumber;
      debugPrint("im:: $_imeinumber");
    });
  }

  Future<void> getin() async {
    await initplatformstate();
    await _getCurrentLocationin();
  }

  Future<void> getout() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('attendData');
    // setState(() {
    //   attendDateTime = null;
    // });
    // debugPrint('Getting out ::$attendDateTime :::: ');
    await _getCurrentLocationout();
  }

  _getCurrentLocationin() async {
    debugPrint("showw:11:" + dropdownValue.shift_id);
    if (!(await Geolocator().isLocationServiceEnabled())) {
      AppSettings.openLocationSettings();
    }
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint("$position");
    if (position.latitude != null && position.longitude != null) {
      final distance = calculateDistance(
          // position.latitude, position.longitude, 30.0418050, 31.3718450);//location ahmed
          position.latitude,
          position.longitude,
          30.0482150,
          31.3686650); //loctain viewsoft
      // position.latitude,  position.longitude, 30.0352483, 31.2694267); //default Lat: 37.4219983, Long: -122.084
      debugPrint('Distsnce ::::::: $distance');
      if (distance <= limit) {
        //TODO

        await insertchekin();

        debugPrint('Can access !');
        // final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'ICan not access the distance is bigger than the limit $distance > $limit !',
                style: TextStyle(color: Colors.white))));
        debugPrint(
            'Can not access the distance is bigger than the limit $distance > $limit !');
      }
    }
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
      // _imeinumber= _imeinumber;
      // debugPrint("jjjj:$_imeinumber");
    });
  }

  _getCurrentLocationout() async {
    debugPrint("showw:ttt:" + dropdownValue.shift_id);

    if (!(await Geolocator().isLocationServiceEnabled())) {
      AppSettings.openLocationSettings();
    }
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint("$position");
    if (position.latitude != null && position.longitude != null) {
      final distance = calculateDistance(
          // position.latitude, position.longitude, 30.0418050, 31.3718450);//location ahmed
          position.latitude,
          position.longitude,
          30.0482150,
          31.3686650); //loctain viewsoft
      // position.latitude, position.longitude, 37.4219983, -122.084);//default Lat: 37.4219983, Long: -122.084
      // position.latitude, position.longitude,30.0352483,31.2694267);
      debugPrint('Distsnce ::::::: $distance');
      if (distance <= limit) {
        //TODO
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('success logout.',
                style: TextStyle(color: Colors.white))));
        await insertchekout();
        debugPrint('Can access !');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'ICan not access the distance is bigger than the limit $distance > $limit !',
                style: TextStyle(color: Colors.white))));
        debugPrint(
            'Can not access the distance is bigger than the limit $distance > $limit !');
      }
    }
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
      // debugPrint(_locationMessage);
    });
  }

  insertchekin() async {
    debugPrint("showwInsert:" + dropdownValue.shift_id);
    try {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: non_constant_identifier_names
      Map Start_date = await getstartdate();
      String startdate = Start_date["data"][0]["start_time"];
      var adress = prefs.getString("address");
      var name = prefs.getString("name");
      debugPrint("ip:" + adress);

      //get sysdate,start_date,end_date,work_type
      Map datamap = await getdata();
      Map datemap = await getsysdate();
      // ignore: non_constant_identifier_names
      Map end_date = await getenddate();
      // ignore: non_constant_identifier_names
      Map check_start_date = await chkstartdate();
      // ignore: unused_local_variable
      String check = datamap["data"][0]["count(*)"];
      String chkdate = datemap["data"][0]["sysdate"];
      // ignore: unused_local_variable, non_constant_identifier_names
      String Enddate = end_date["data"][0]["end_time"];
      String checkStartDate = check_start_date["data"][0]["cnt"];
      debugPrint("massage  $checkStartDate");
      final msg = json.encode(
          // [
          //   {
          //     "emp_id": 1,
          //     "work_date": "08-JUN-21",
          //     "work_type": 1,
          //     "start_time": "15:50"
          //   }
          // ]
          [
            // {
            {
              "emp_id": name,
              // 1,
              "work_date": chkdate,
              // "08-JUN-21",
              "work_type": 1,
              // 1,
              "start_time": startdate,

              "shift_id": dropdownValue.shift_id,
              // "15:50",
              // "end_time":
              // Enddate
              // "20:50"
            }
          ]);
      var url = Uri.parse(
          'http://$adress/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days'
          // 'http://41.32.222.242/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days'
          );

      http.Response response = await http
          .post(url, body: msg, headers: {"content-type": "application/json"});
      // if(startdate.isNotEmpty) {
      // popinfo(); dropdownValue.shift_id

      debugPrint("done" + response.body);

      // debugPrint("result"+jsonDecode(response.body)['name']);
      if (response.statusCode == 200) {
        if (response.body.contains('Successfully')) {
          //   setState(() {
          //     attendDateTime = DateTime.now();
          //   });
          //   final prefs = await SharedPreferences.getInstance();
          //   await prefs.setString('attendData', attendDateTime.toString());
          popinfo(context);
          return Album.fromJson(jsonDecode(response.body));
        } else {
          throw 'You Login Before.... !';
        }
      } else {
        throw 'Can not login !';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(), style: TextStyle(color: Colors.white))));
    }

    // }
    // pop();
  }

  insertchekout() async {
    //get emp_id  '$_counter',
    try {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var name = prefs.getString('name');
      var adress = prefs.getString("address");

      debugPrint("emp_id :" + name);
      debugPrint("ip:" + adress);
      debugPrint("shift:" + dropdownValue.shift_id);

      // userInfo = name;
      //get sysdate,start_date,end_date,work_type   var url="ddddsjdd'${name}'";
      // Map datamap = await getdata();
      Map datemap = await getsysdate();
      // ignore: non_constant_identifier_names
      // Map Start_date = await getstartdate();
      // ignore: non_constant_identifier_names
      Map end_date = await getenddate();
      // ignore: non_constant_identifier_names
      Map check_end_date = await chkenddate();
      // String check = datamap["data"][0]["count(*)"];
      String chkdate = datemap["data"][0]["sysdate"];
      // String startdate = Start_date["data"][0]["start_time"];
      // ignore: non_constant_identifier_names
      String Enddate = end_date["data"][0]["end_time"];
      String checkEndDate = check_end_date["data"][0]["cnt"];
      debugPrint("massage: $checkEndDate ...... $Enddate +++ $chkdate");
      if (checkEndDate != '0') {
        // popend();
        debugPrint("error");
      }
      debugPrint("scusess");
      final msg = json.encode({
        "end_time":
            // "20:51",
            Enddate,
      });
      debugPrint(
          "massage2:" + checkEndDate + "chkdate:" + chkdate + "emp_id:" + name);
      var url = Uri.parse(
          "http://$adress/php_rest_myblog/api/data/upd_tab.php?user=view&password=1&table=mob_work_days&where=emp_id=$name and work_date='$chkdate' and work_type=1");
      http.Response response = await http
          .put(url, body: msg, headers: {"content-type": "application/json"});
      debugPrint("done");
      popinfoend(context);
      if (response.statusCode == 200) {
        return Album.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create .' + response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(), style: TextStyle(color: Colors.white))));
    }
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      getshift().then((value) {
        debugPrint(value);
        setState(() {
          isInit = false;
          // dropdownValue.shift_id='0';
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> children = List.generate(length, (e) => myCosntainerList[e]);
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Main Page'),
      ),
      body: isInit
          ? Center(
              child:
                  // Text("errrorrr")
                  CircularProgressIndicator())
          : Center(
              child: Container(
                padding: EdgeInsets.all(50.50),
                margin: EdgeInsets.only(right: 40.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Image.asset(
                        'img/viewsoft.png',
                        // img/1.jpg  img/userbackground.png img/viewsoft.png
                        height: 100.0,
                        width: 100.0,
                      ),
                      FittedBox(
                          child: Center(
                              child: Text("Location is :$_locationMessage "))),
                      FittedBox(
                          child: Center(
                              child: Text(" imi:$_imeinumber",
                                  textAlign: TextAlign.start))),
                      Container(
                        child: DropdownButton<Datum>(
                          //isDense: true,
                          hint: Text('الورديـه'),
                          value: dropdownValue,
                          isExpanded: true,
                          icon: Icon(Icons.check_circle_outline),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.blue[300],
                          ),
                          // ignore: non_constant_identifier_names
                          onChanged: (Value) {
                            setState(() {
                              dropdownValue = Value;
                              debugPrint(dropdownValue.shift_id);
                            });
                          },
                          items: payload.data
                              .map<DropdownMenuItem<Datum>>((value) {
                            return DropdownMenuItem<Datum>(
                                value: value,
                                child: Text(' ${value.shift_name}'));
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                      ),
                       Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      // if (attendDateTime == null ||attendDateTime.difference(DateTime.now()).inHours > 12)
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed:
                              // initplatformstate,
                              getin,
                          // () {},
                          child: const Text("تسجيل الحضور"),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      // if (attendDateTime == null)
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed:
                              // () {},
                              () async => getout(),
                          // insertchekout,
                          // getprefrenc,
                          child: const Text("تسجيل الانصراف"),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => showtable()));
                          },
                          // () {},
                          //     () async =>
                          //        {},
                          // insertchekout,
                          // getprefrenc,
                          child: const Text("...الاسـتعـلام..."),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}


