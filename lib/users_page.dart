import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_3/user_details_page.dart';

import 'widgets/custom_bottom_navigation.dart';
import 'models/user.dart';
import 'widgets/navigation_drawer.dart';
import 'consts.dart' as constants;

Future<List<User>> fetchUsers() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return (json.decode(response.body) as List)
        .map((data) => User.fromJson(data))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load users list');
  }
}


class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<List<User>> futureUsers;
  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(widget.title),
      ),
      bottomNavigationBar: MyBottomNavigationBar(bottomIndex: constants.BOTOM_NAV_INDEX_USERS),
      drawer: const MyNavigationDrawer(),
      body: Center(
        child: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data?.length.toString());
                if (snapshot.data != null && snapshot.data![index] != null){
                  User user = snapshot.data![index];
                  return GestureDetector(
                    child:  Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          Text("id:" +  user.id.toString()),
                          Text("name:" + user.name),
                          Text("email:" + user.email),
                        ],
                      )
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(title: user.name,),
                        // Pass the arguments as part of the RouteSettings. The
                        // DetailScreen reads the arguments from these settings.
                        settings: RouteSettings(
                          arguments: user,
                        ),
                      ),
                    ),
                  );
                }
                else {
                  return  const Icon(Icons.android);
                }
              }
          );
    },
    ),// This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }
}
