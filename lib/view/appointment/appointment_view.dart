import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
import 'package:flutter/material.dart';

class ApponintmentView extends StatefulWidget {
  const ApponintmentView({super.key});

  @override
  State<ApponintmentView> createState() => _ApponintmentViewState();
}

class _ApponintmentViewState extends State<ApponintmentView> {
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022, DateTime.now().day),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //display chose date
        /*Text("chosen day"),
        Text("${_dateTime.day}.${_dateTime.month}.${_dateTime.year}"),
        MaterialButton(
          onPressed: (() {
            _showDatePicker();
          }),
          child: Text("Choose Day"),
        ),*/
        Expanded(
          child: ListView(
            ///shrinkWrap: true,
            children: [
              ExpansionTile(
                //iconColor: Colors.red,
                collapsedBackgroundColor:
                    ColorConstants.instance.skin.withOpacity(.2),
                backgroundColor: ColorConstants.instance.skin.withOpacity(.2),
                leading: Icon(
                  Icons.close_sharp,
                  color: ColorConstants.instance.red,
                  size: 30,
                ),
                title: Text(
                  'Past Appointment',
                  style: StyleConstants().sHeaderBrownA,
                ),
                trailing: Icon(Icons.arrow_drop_down),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(displayWidth * .05),
                    height: displayWidth * .500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10)),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            color: ColorConstants.instance.flower,
                          ),
                          title: Text("Sakarya Family Health Center"),
                          //  trailing: Text("Sakarya Family Health Center"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: ColorConstants.instance.flower,
                          ),
                          title: Text("Dr.Sevgi Yılmaz"),
                          //  trailing: Text("Sakarya Family Health Center"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.query_builder_outlined,
                            color: ColorConstants.instance.flower,
                          ),
                          title: Text("14.09.2021"),
                          //  trailing: Text("Sakarya Family Health Center"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
