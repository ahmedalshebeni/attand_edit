import 'package:attendance/providers/test_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveRequest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: LeaveRequest(),
    );
  }
}

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  // String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple, title: const Text('Main Page')),
      body: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              // child: Text(
              //   'Side menu',
              //   style: TextStyle(color: Colors.white, fontSize: 25),
              // ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('img/viewsoft.png'))),
              child: null,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Main Page'),
              onTap: () {
                // context.read<TestProvider>().getItems();
                // context.read<TestProvider>().getItemsUnit();
                // context.read<TestProvider>().getitem_group();
                // context.read<TestProvider>().getbatch_no();
                Navigator.of(context).pushNamed('/main');
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: const Text('LogOut'),
                onTap: () {
                  Provider.of<TestProvider>(context, listen: false).logout();
                }),
          ],
        ),
      ),
    );
  }
}
