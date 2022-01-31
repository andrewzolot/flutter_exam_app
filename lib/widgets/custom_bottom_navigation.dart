import 'package:flutter/material.dart';
import 'package:test_3/user_details_page.dart';
import 'package:test_3/users_page.dart';

import '../strings.dart' as strings;
import '../models/user.dart';

class MyBottomNavigationBar extends StatefulWidget{
  int bottomIndex = 0;
  MyBottomNavigationBar({Key? key, required this.bottomIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.bottomIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: strings.users,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: strings.profile,
          ),
        ],
      onTap: (int index) {
        setState(() {
          widget.bottomIndex = index;
          if (index == 1){
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
          }
          else{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UsersPage(title: strings.users)),
            );
          }
        });
      },
    );
  }
}