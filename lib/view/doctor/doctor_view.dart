import 'package:aile_hekimligi_uygulamasi/view/home/bottom_navbar.dart';
import 'package:aile_hekimligi_uygulamasi/view/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("doktor")),
    );
  }
}
