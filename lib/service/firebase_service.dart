import 'dart:async';

import 'package:aile_hekimligi_uygulamasi/view/login/forgot_password.dart';
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

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black12, Colors.black87],
              begin: Alignment.center,
              end: Alignment.bottomCenter),
          image: DecorationImage(
              image: NetworkImage(
                  "https://previews.123rf.com/images/leoedition/leoedition1710/leoedition171000645/88767567-medical-background-medical-care-health-care-vector-medicine-illustration.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(pageWidth / 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SING UP",
                    style: StyleConstants().mTitle,
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
                            primary: Theme.of(context).scaffoldBackgroundColor),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
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
            )),
      ),
    );
  }

  Future<void> createUser() async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint(userCredential.toString());
    } catch (e) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_email);

      if (!emailValid) {
        showError("lütfen geçerli bir mail adresi giriniz");
      }

      if (e.toString().contains(
          "The email address is already in use by another account.")) {
        showError(
            "E-posta adresi zaten başka bir hesap tarafından kullanılıyor.");
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    } catch (e) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_email);

      if (!emailValid) {
        showError("lütfen geçerli bir mail adresi giriniz");
      }
      debugPrint(e.toString());
      if (e.toString().contains("password is invalid")) {
        showError("şifre yanlış");
      }
      if (e.toString().contains("has not been initialized.")) {
        showError("lütfen e mail ve şifrenizi giriniz");
      }

      if (e.toString().contains("blocked")) {
        showError(
            "Olağandışı etkinlik nedeniyle bu cihazdan gelen tüm istekleri engelledik. Daha sonra tekrar deneyin.");
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
      validator: (value) {
        return (value ?? '').length > 5 ? null : 'şifre 6dan kucuk olamaz';
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
      validator: (value) =>
          (value ?? '').isNotEmpty ? null : 'email alanı boş bırakılamaz!',
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
