import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

String email = "";

class _ForgotPageState extends State<ForgotPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Receive an email to reset your password",
                  style: StyleConstants().mTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: pageHeight / 10),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => (value ?? '').isNotEmpty
                      ? null
                      : 'Email alanı boş bırakılamaz!',
                  onChanged: (value) => setState(() {
                    email = value;
                  }),
                ),
                SizedBox(
                  height: pageHeight / 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(pageHeight / 15),
                        primary: ColorConstants.instance.blackSkin),
                    onPressed: (() {
                      resetPassword();
                    }),
                    icon: Icon(Icons.email),
                    label: Text("Reset Password"))
              ],
            )),
      ),
    );
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

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password Reset Email Sent")));
    } catch (e) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (!emailValid) {
        showError("lütfen geçerli bir mail adresi giriniz");
      }
      if (EmailValidator.validate(email)) {
        showError("No such user found");
      }
    }
  }
}
