import 'package:flutter/material.dart';
import 'package:test_3/users_page.dart';

import '../strings.dart' as strings;

const String login = "andrey";
const String password = "123";

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();


}

class _LoginWidgetState extends State<LoginWidget> {

  var controllerLogin = TextEditingController();
  var controllerPass = TextEditingController();
  bool _passwordVisible = true;

  void checkLoginAndPass(){
    bool error = false;
    var message = "";
    if (controllerLogin.text.isEmpty) {
      message = "Введите логин";
      error = true;
    } else{
      if (controllerPass.text.isEmpty) {
        message = "Введите пароль";
        error = true;
      } else{
        if (controllerLogin.text == login){
          if (controllerPass.text == password){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UsersPage(title: strings.users)),
            );
          }
          else {
            message = "Неверный пароль";
            error = true;
          }
        }
        else {
          message = "Неверный логин";
          error = true;
        }
      }
    }
    if (error) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 300,
          child: Align(
              alignment: Alignment.center,
              child:Column(
                  children:[
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(236, 239, 241, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(36.0)),
                              borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(36.0)),
                              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                            ),
                            hintText: 'Логин',
                          ),
                          controller: controllerLogin,
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(236, 239, 241, 1),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                          ),
                          hintText: 'Пароль',
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        controller: controllerPass,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          checkLoginAndPass();
                        },
                        child: const Text("войти"))
                  ]
              )
          ),
        )
      )
    );
  }

  @override
  void dispose() {
    controllerLogin.dispose();
    controllerPass.dispose();
    super.dispose();
  }
}
