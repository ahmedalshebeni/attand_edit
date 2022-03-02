import 'dart:math';
import 'package:attendance/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
var ipaaddress;
var adress;
// ignore: non_constant_identifier_names
var stk_id;
var name;
var pass;
Payload payload;

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a)) * 1000;
}

popinfo(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('تم تسجيل الحضور'),
    action: SnackBarAction(
      label: 'ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

pop(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('تم تسجيل الحضورمن قبل'),
    action: SnackBarAction(
      label: 'ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

popinfoend(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('تم تسجيل الانصراف'),
    action: SnackBarAction(
      label: 'ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
