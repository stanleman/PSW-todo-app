import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';

class Signup extends StatefulWidget {
  Signup({super.key, required this.setMode});

  final Function setMode;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorText = "";

  void localSetMode() {
    widget.setMode(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 253, 253),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
                    ),
                    Text(
                      "Join us on our journey.",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _emailAddress(),
                    const SizedBox(
                      height: 15,
                    ),
                    _password(),
                    if (errorText != "")
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            errorText,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    _signup(context),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _signin(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email Address',
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: _emailController,
          onChanged: (value) => setState(() {
            errorText = "";
          }),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffCBF1F5),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          obscureText: true,
          onChanged: (value) => setState(() {
            errorText = "";
          }),
          controller: _passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffCBF1F5),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        String tempResult = await AuthService().signup(
            email: _emailController.text,
            password: _passwordController.text,
            context: context);
        setState(() {
          errorText = tempResult;
        });
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _signin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
              text: "Already have an account? ",
              style: TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            TextSpan(
                text: "Log In",
                style: const TextStyle(
                    color: Color(0xff1A1D1E),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    localSetMode();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Login()),
                    // );
                  }),
          ])),
    );
  }
}
