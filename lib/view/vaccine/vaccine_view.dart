import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Vaccine extends StatefulWidget {
  const Vaccine({super.key});

  @override
  State<Vaccine> createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Make a Covid-19 vaccine appointment",
          style: StyleConstants().sHeaderBrown,
        ),
        SizedBox(height: 10),
        Center(
          child: Container(
            height: 300,
            width: displayWidth / 1.1,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.instance.flower.withOpacity(.2),
                    //blurRadius: 10,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You can choose a type of vaccine",
                      style: StyleConstants().sHeaderBlack),
                  SizedBox(height: 10),
                  Text(
                    "Earliest date you can be vaccinated: ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                    style: StyleConstants().sHeaderBlack,
                  ),
                  SizedBox(height: 10),
                  vaccineButtonWidget("Biontech"),
                  vaccineButtonWidget("Sinovac"),
                  vaccineButtonWidget("Turkovac"),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  MaterialButton vaccineButtonWidget(String vaccineName) {
    return MaterialButton(
      elevation: 2,
      color: Colors.white,
      shape: Border.all(color: Colors.orange),
      onPressed: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          vaccineName,
          style: StyleConstants().sbTitle,
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: ColorConstants.instance.flower,
        )
      ]),
    );
  }
}
