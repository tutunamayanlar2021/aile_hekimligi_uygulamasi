import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
import 'package:aile_hekimligi_uygulamasi/view/home/home_view.dart';
import 'package:aile_hekimligi_uygulamasi/view/score.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

const TWO_PI = 3.14 * 2;

class _DoctorViewState extends State<DoctorView> {
  List<String> imageUrl = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsjHXK4Wv3Zw0MjUgzirseL5vqMkvil60O3Q&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ335UJpVYYCJ0aP9D1qP_ukOwFqyDDUMahCg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvKb4zVzNHKTf72shM2AIgQEArvwUPFnFXPg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwNOtFQ9kPfeZtR6AzDt1YMfKD9ZkxAXYKmw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4hhchozR9QbvQFVMfBR9r1haJXsO54SKvyw&usqp=CAU",
  ];
  List<String> name = [
    "Olivia Rasson",
    "Randy Thomas",
    "Johnny Miller",
    "Chad Hicks",
    "Linda Adams"
  ];
  List<List<int>> percent = [
    [80, 60, 90],
    [50, 90, 70],
    [80, 90, 70],
    [90, 100, 80],
    [80, 70, 60],
    [80, 70, 60]
  ];

  @override
  Widget build(BuildContext context) {
    final size = 50.0;
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
                      blurRadius: 2,
                      offset: const Offset(0, 0)),
                ],
                borderRadius: BorderRadius.circular(10)),
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
              height: displayWidth * .4000,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.instance.blackSkin.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 0)),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: doctorList(index, imageUrl[index], size),
            );
          },
        ),
      ),
    ]);
  }

  Padding doctorList(int index, String imageurl, final size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            maxRadius: 30,
            minRadius: 20,
            backgroundImage: NetworkImage(
              imageurl,
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(name[index]),
            ),
            Row(
              children: [
                Wrap(
                  spacing: 10,
                  children: [
                    scorAndTextColumn(percent[index][0], "Good Review"),
                    scorAndTextColumn(percent[index][1], "Total Score"),
                    scorAndTextColumn(percent[index][2], "Satisfaction")
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ColorConstants.instance.flower,
        ),
      ),
    );
  }

  Widget scorAndTextColumn(int percent, String type) => Column(
        children: [
          doctorScorCircular(percent),
          Text(
            type,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      );
  CircularPercentIndicator doctorScorCircular(int percent) {
    return CircularPercentIndicator(
      radius: 20,
      percent: percent / 100,
      progressColor: ColorConstants.instance.flower,
      animationDuration: 2000,
      animation: true,
      center: Text("%$percent"),
    );
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
