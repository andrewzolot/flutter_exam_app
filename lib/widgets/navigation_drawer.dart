import 'package:flutter/material.dart';
import 'package:test_3/user_details_page.dart';
import 'package:test_3/users_page.dart';

import '../main.dart';
import '../strings.dart' as strings;
import '../models/user.dart';

class MyNavigationDrawer extends StatefulWidget{
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_MyNavigationDrawerState();

}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                  child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: Text("Навигация"),
                  )
              ),
              ListTile(
                leading: const Text(strings.users),
                trailing: Icon(Icons.supervised_user_circle_sharp),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UsersPage(title: strings.users)),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Text(strings.profile),
                trailing: Icon(Icons.person),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(title: "Я",),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments:   User(1, "Я", "Я", "myemail", Map(), "123456",
                            "www.leningrad.spb.ru", Map()),
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    const MyHomePage(title: strings.zolotuev)), (Route<dynamic> route) => false);
              },
              child: const Text(
                "выйти",
                style: TextStyle(
                  color: Colors.red,
                ),
              )
          )
        ],
      )
    );
  }
}