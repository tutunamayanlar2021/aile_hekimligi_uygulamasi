import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../home/home_view.dart';
import 'forgot_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late FirebaseAuth auth;
  late String _email = "";
  late String _password = "";
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    auth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: ListView(children: [
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(pageWidth / 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: pageWidth / 2,
                    height: pageHeight / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/images.jpg"),
                        )),
                  ),
                ),
                SizedBox(
                  height: pageHeight / 20,
                ),
                Center(
                  child: Text(
                    "LOGIN",
                    style: StyleConstants().mTitle,
                  ),
                ),
                SizedBox(
                  height: pageHeight / 30,
                ),
                userNameTextField(),
                SizedBox(
                  height: pageHeight / 50,
                ),
                userPasswordTextfield(),
                SizedBox(
                  height: pageHeight / 50,
                ),
                SizedBox(
                  width: pageWidth,
                  height: pageHeight / 15,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, primary: ColorConstants.instance.flower),
                    onPressed: () {
                      login();
                    },
                    child: const Text("LOGIN"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: pageWidth / 1.5, top: pageHeight / 90),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).scaffoldBackgroundColor),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPage()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: StyleConstants().sbTitleBrown,
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> login() async {
    // final formState = _formkey.currentState;

    try {
      var userCredential = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint(userCredential.toString());
      if (mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      }
    } catch (e) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_email);

      if (!emailValid) {
        showError("Please enter valid email and password!");
      }

      debugPrint(e.toString());
      /* if (e.toString().contains("The password is invalid or the user does not have a password")) {
        showError("Wrong password");
      }*/
      if (e.toString().contains("password is invalid")) {
        showError("Wrong password");
      }
      if (e.toString().contains("has not been initialized.")) {
        showError("Please enter your e-mail and password");
      }
      if (e.toString().contains("blocked")) {
        showError(
            "All requests from this device have been blocked due to Unusual activity. Try again later.");
      }
    }
  }

  Future<dynamic> showError(String message) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: StyleConstants().sbTitle,
                    ))
              ],
              title: const Text("Hata!"),
              // contentPadding: EdgeInsets.all(10),
              content: Text(message),
            ));
  }

  TextFormField userPasswordTextfield() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        return (value ?? '').length > 5
            ? null
            : 'password cannot be less than 6 characters';
      },
      onChanged: (value) => setState(() {
        _password = value;
      }),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
    );
  }

  TextFormField userNameTextField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) => (value ?? '').isNotEmpty
          ? null
          : 'e-mail field cannot be left blank!',
      onChanged: (value) => setState(() {
        _email = value;
      }),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
      ),
    );
  }
}
