import 'dart:ui';

import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.deepOrange.withOpacity(.3), width: 2),
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.person,
              size: 100,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            auth.currentUser!.displayName.toString().toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Sakarya",
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Wrap(
                spacing: 5,
                children: [
                  userFeaturesContainer("assets/images/card.png", "22 year"),
                  userFeaturesContainer("assets/images/ruler3.jpg", "160 cm"),
                  userFeaturesContainer("assets/images/scale.png", "48 kg"),
                  userFeaturesContainer("assets/images/blood-drop.jpg", "A Rh+")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Container userFeaturesContainer(String url, String title) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          //alignment: Alignment.center,
          scale: 10,
          image: AssetImage(
            url,
          ),
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.deepOrange.withOpacity(.3),
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Text(
            title,
          ),
        ]),
      ),
    );
  }
}
