
import 'package:deflon/pages/home.dart';
import 'package:deflon/pages/login.dart';
import 'package:deflon/provider/app_state.dart';
import 'package:deflon/provider/user_provider.dart';
import 'package:deflon/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => UserProvider.initialize()),
          ChangeNotifierProvider.value(value: AppState()),
        ],
        child: MaterialApp(
            title: 'Deflon',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              drawer: DrawerMenu(),
              body: ScreenController(),
            )
        )
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();

      case  Status.Authenticated:
        return Home();
      default: return Login();
    }
  }
}

class SplashScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return CircularProgressIndicator();
}
}