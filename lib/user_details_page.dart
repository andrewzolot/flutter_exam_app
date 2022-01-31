import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_3/models/user_tasks.dart';

import 'widgets/custom_bottom_navigation.dart';
import 'models/user.dart';
import 'widgets/navigation_drawer.dart';
import 'consts.dart' as constants;

Future<List<UserTasks>> fetchUserTasks(int id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=' + id.toString()));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return (json.decode(response.body) as List)
        .map((data) => UserTasks.fromJson(data))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user tasks list');
  }
}


class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late Future<List<UserTasks>> futureUserTasks;


  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    futureUserTasks = fetchUserTasks(user.id);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(widget.title),
      ),
      bottomNavigationBar: MyBottomNavigationBar(bottomIndex: constants.BOTOM_NAV_INDEX_DETAILS),
      drawer: const MyNavigationDrawer(),
      body: Center(
        child: FutureBuilder<List<UserTasks>>(
          future: futureUserTasks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return const CircularProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text("name:" + user.name),
                      Text("username:" +  user.id.toString()),
                      Text("email:" + user.email),
                      Text("address:" + "city-" + user.address['city'].toString() + ", street-" + user.address['street'].toString()),
                      Text("phone:" + user.phone),
                      Text("website:" + user.website),
                      Text("Company:" + user.company['name'].toString())
                    ],
                  ),
                ),
                const Text("Задачи"),
                Expanded(
                    flex: 10,
                    child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(snapshot.data?.length.toString());
                      if (snapshot.data != null && snapshot.data![index] != null){
                        UserTasks userTasks = snapshot.data![index];
                        return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2.0, color: Colors.black),
                                bottom: BorderSide(width: 2.0, color: Colors.black),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Checkbox(value: userTasks.completed, onChanged: null),
                                Expanded(
                                  child: Text(
                                    userTasks.title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                      else {
                        return  const Icon(Icons.android);
                      }
                    }
                )
                )
              ],
            );
          },
        ),// This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }
}
