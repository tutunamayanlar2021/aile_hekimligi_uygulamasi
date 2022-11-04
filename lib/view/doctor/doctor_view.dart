import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
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
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: displayWidth / 20, top: displayWidth / 20),
            child: Text(
              "My Doctor",
              style: StyleConstants().sHeaderBrown,
            ),
          ),
          Container(
            margin: EdgeInsets.all(displayWidth * .05),
            height: displayWidth * .6000,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10)),
                ],
                borderRadius: BorderRadius.circular(30)),
            child: ListTile(
              leading: Container(
                height: 500,
                width: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://img.freepik.com/free-photo/woman-doctor-wearing-lab-coat-with-stethoscope-isolated_1303-29791.jpg?w=360",
                  ),
                ),
              ),
              contentPadding: EdgeInsets.all(20),
              title: doctorDetailColumn(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: displayWidth / 20, top: displayWidth / 20),
            child: Text(
              "Change Your Doctor",
              style: StyleConstants().sHeaderBrown,
            ),
          ),
        ],
      ),
      Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(displayWidth * .03),
              height: displayWidth * .3000,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10)),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000"),
                  ),
                  trailing: const Text(
                    "GFG",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text("List item $index")),
            );
          },
        ),
      ),
    ]);
  }

  Column doctorDetailColumn() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          " Dr.Derya Sarı",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.deepOrange.withOpacity(0.4),
          ),
          contentPadding: EdgeInsets.zero,
          title: Text.rich(
            TextSpan(
                text: "Sakarya Family Health Center",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.door_back_door_outlined,
            color: Colors.deepOrange.withOpacity(0.4),
          ),
          contentPadding: EdgeInsets.zero,
          title: Text.rich(
            TextSpan(
                text: "Family Medicine Unit No 003 in Sakarya",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.location_on,
            color: Colors.deepOrange.withOpacity(0.4),
          ),
          contentPadding: EdgeInsets.zero,
          title: Text.rich(
            TextSpan(
                text: "Kemalpasa Quarter University Street",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
        ),
      ],
    );
  }
}
