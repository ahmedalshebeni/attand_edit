import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Gui/Setting.dart';
import 'Gui/LeaveRequest.dart';
import 'Gui/approve Leave.dart';
import 'package:splashscreen/splashscreen.dart';
import 'providers/test_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TestProvider(),
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/First': (BuildContext context) => LeaveRequest(),
          // '/Third': (BuildContext context) =>  LeaveHistory(),
          '/four': (BuildContext context) => Setting(),
          // '/Five': (BuildContext context) =>  BasicData(),
          // '/home': (BuildContext context) => Home(),
          '/main': (BuildContext context) => approveLeave(),
        },

        home:
            // Splash(),
            // DemoPage(),
            splash2(),
        // home: Setting(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// ignore: camel_case_types
class splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: SecondScreen(),
      title: const Text(
        'Welcome...',
        textScaleFactor: 2,
      ),
      image: Image.network(
          'https://i.vimeocdn.com/portrait/26270325_120x120.jpg'
          // 'https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'
          ),
      loadingText: const Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(
      builder: (ctx, testProvider, _) => testProvider.ipaaddress != null &&
              testProvider.username != null &&
              testProvider.password != null
          ? LeaveRequest()
          : FutureBuilder(
              future:
                  Provider.of<TestProvider>(context, listen: false).getData(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Scaffold(
                          body: Center(
                            child: const Text('Loading...'),
                          ),
                        )
                      : Setting()),
    );
  }
}
