

import 'package:attendance/providers/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}
TextEditingController ipaddress =  TextEditingController();
TextEditingController _passwordController =  TextEditingController();
TextEditingController _userController = TextEditingController();

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Setting Page')
      ),
      body:  Container(
          child:Column (
            children: [
               TextField(
                style: const TextStyle(fontSize: 18.0, color: Colors.deepPurple),
                controller: ipaddress,
                decoration: const InputDecoration(
                    icon:  Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                      size: 20.0,
                    ),
                    hintText: 'Your Ip address:'),
                keyboardType: TextInputType.number,
              ),
               TextField(
                style: const TextStyle(fontSize: 18.0, color: Colors.deepPurple),
                controller: _userController,
                decoration: const InputDecoration(
                    icon:  Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                      size: 20.0,
                    ),
                    hintText: 'Your ID:'),
                keyboardType: TextInputType.number,
              ),
               TextField(
                style:const TextStyle(fontSize: 18.0, color: Colors.deepPurple),
                controller: _passwordController,
                decoration: const InputDecoration(
                    icon:  Icon(
                      Icons.lock,
                      color: Colors.deepPurple,
                      size: 20.0,
                    ),
                    hintText: 'Your Password:'),
                obscureText: true,
              ),

              Container(
                // ignore: deprecated_member_use
                  child:   RaisedButton(
                    onPressed: (){
                      Provider.of<TestProvider>(context,listen: false).onLogin(_userController.text,ipaddress.text,_passwordController.text,context);
                    },
                    child:  const Text('login' ),
                    color: Colors.deepPurple,
                    textColor: Colors.white,)
              ),
            ],
          )

      ),
    );
  }
}




