import 'package:deflon/pages/home.dart';
import 'package:deflon/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key key}) : super(key: key);

  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return  Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60.0, color: Colors.grey,),
              ),
            ),
            accountName: Text('${user.user.displayName}', style: TextStyle(fontSize: 18.0, color: Colors.black),),
            accountEmail: Text('${user.user.email}'),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5)
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home()));
            },
            child: ListTile(
              title: Text('Home', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.home, color: Colors.lightBlue),
            ),
          ),
          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text('Rides', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.watch_later, color: Colors.lightBlue),
            ),
          ),
          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text('Profile', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.person_outline, color: Colors.lightBlue),
            ),
          ),
          Divider(
            color: Colors.red,
          ),
          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text('Settings', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.settings, color: Colors.lightBlue),
            ),
          ),
          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text('Support', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.message, color: Colors.lightBlue),
            ),
          ),
          InkWell(
            onTap: (){
              user.signOut();
            },
            child: ListTile(
              title: Text('Log out', style: TextStyle(color: Colors.black54)),
              leading: Icon(Icons.message, color: Colors.lightBlue),
            ),
          ),
        ],
      ),
    );
  }
}