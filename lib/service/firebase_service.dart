import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/color_constant.dart';
import '../constants/style_constant.dart';
import '../view/home/home_view.dart';
import '../view/login/login_view.dart';

class FirebaseService extends StatefulWidget {
  const FirebaseService({super.key});

  @override
  State<FirebaseService> createState() => _FirebaseServiceState();
}

class _FirebaseServiceState extends State<FirebaseService> {
  late FirebaseAuth auth;
  late String _email = "";
  late String _password = "";
  late String _name = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;

    /// other way there is no user logged.
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/s.webp",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: pageWidth / 1.3,
              height: pageHeight / 1.8,
              child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(pageWidth / 30),
                    child: ListView(children: [
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SING UP",
                            style: StyleConstants().mTitle,
                          ),
                          SizedBox(
                            height: pageHeight / 30,
                          ),
                          userNameTextfield(),
                          SizedBox(
                            height: pageHeight / 50,
                          ),
                          userEmailTextField(),
                          SizedBox(
                            height: pageHeight / 50,
                          ),
                          userPasswordTextfield(),
                          SizedBox(
                            height: pageHeight / 50,
                          ),
                          SizedBox(
                            width: pageWidth,
                            height: pageHeight / 16,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: ColorConstants.instance.flower),
                              onPressed: () {
                                createUser();
                              },
                              child: const Text("SIGN UP"),
                            ),
                          ),
                          SizedBox(
                            height: pageHeight / 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already a user?"),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginView()));
                                  //login();
                                },
                                child: Text(
                                  "LOGIN",
                                  style: StyleConstants().sbTitle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  )),
            ),
          ),
        ));
  }

  Future<void> createUser() async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      auth.currentUser!.updateDisplayName(_name);
      debugPrint(userCredential.toString());
      if (mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      }
    } catch (e) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_email);

      if (!emailValid) {
        showError("Please enter valid email and password!");
      }

      if (e.toString().contains(
          "The email address is already in use by another account.")) {
        showError("Email address is already in use by another account.");
      }
      debugPrint(e.toString());
    }
  }

  Future<void> login() async {
    final formState = _formkey.currentState;

    try {
      var userCredential = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint(userCredential.toString());
      if (mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      }
    } catch (e) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_email);

      if (!emailValid) {
        showError("Please enter valid email");
      }
      debugPrint(e.toString());
      if (e.toString().contains("password is invalid")) {
        showError("Wrong password!");
      }
      if (e.toString().contains("has not been initialized.")) {
        showError("Please enter your e-mail and password!");
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

  TextFormField userNameTextfield() {
    return TextFormField(
      validator: (value) {
        return (value ?? '').length > 5
            ? null
            : 'password cannot be less than 6 characters';
      },
      onChanged: (value) => setState(() {
        _name = value;
      }),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
    );
  }

  TextFormField userPasswordTextfield() {
    return TextFormField(
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

  TextFormField userEmailTextField() {
    return TextFormField(
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
