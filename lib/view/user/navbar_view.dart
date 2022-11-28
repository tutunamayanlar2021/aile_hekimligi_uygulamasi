import 'dart:io';

import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constant.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late FirebaseAuth auth;
  late String _email = "";
  late String _password = "";

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(auth.currentUser!.displayName);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              auth.currentUser!.displayName.toString().toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              auth.currentUser!.email.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            currentAccountPicture: const Icon(
              Icons.account_circle_rounded,
              size: 70,
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bpp.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: Text("Exit"),
            onTap: () {
              showExitPopup(context);
              /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirebaseService()));*/
            },
          ),
        ],
      ),
    );
  }

  Future showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirebaseService()));
                          },
                          child: Text("Yes"),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.instance.flower,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
