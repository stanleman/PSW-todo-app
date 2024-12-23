import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/pages/authentication/signIn.dart';
import 'package:todo_app/pages/authentication/signUp.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  bool isLogin = true;

  void changeMode(bool mode) {
    setState(() {
      isLogin = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Signin(
        setMode: changeMode,
      );
    } else {
      return Signup(setMode: changeMode);
    }
  }
}
