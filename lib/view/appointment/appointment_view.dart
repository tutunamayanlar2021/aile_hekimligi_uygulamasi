import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/constants/style_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApponintmentView extends StatefulWidget {
  const ApponintmentView({super.key});

  @override
  State<ApponintmentView> createState() => _ApponintmentViewState();
}

class _ApponintmentViewState extends State<ApponintmentView> {
  /*void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020, DateTime.now().day),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }*/

  DateTime _dateTime = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    ColorConstants.instance;
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
              pastAppointmentWidget(
                  displayWidth,
                  Icons.event_available,
                  ColorConstants.instance.flower,
                  'Current Appointment',
                  'Sakarya Family Health Center',
                  'Dr.Sevgi Yılmaz',
                  '01.09.2022 ',
                  ColorConstants.instance.flower.withOpacity(.2),
                  "15:00",
                  true),
              pastAppointmentWidget(
                  displayWidth,
                  Icons.close,
                  ColorConstants.instance.red,
                  'Past Appointment',
                  'Sakarya Family Health Center',
                  'Dr.Ali Yıldız',
                  '14.07.2021 ',
                  ColorConstants.instance.skin.withOpacity(.2),
                  '11:00',
                  false),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: displayHeight / 20,
                  ),
                  Text(
                    " New Appointment",
                    style: StyleConstants().sHeaderBrown,
                  ),
                  SizedBox(
                    height: displayHeight / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: displayWidth,
                      height: 100,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.instance.flower
                                  .withOpacity(.1),
                              //blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(2, -1),
                            )
                          ]),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/mydocs.jpg",
                          ),
                        ),
                        /* trailing: MaterialButton(
                          elevation: 0,
                          color: Colors.white,
                          onPressed: (() {
                            //  selectedTimeRTL;
                          }),
                          child: Text(
                            "Choose Day",
                            style: StyleConstants().sbTitle,
                          ),
                        ),*/
                        title: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dr.Derya Sarı",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Nearest date",
                                        style: StyleConstants().sbTitle,
                                      ),
                                      //SizedBox(),
                                      Text(
                                          "${_dateTime.day + 1}.${_dateTime.month}.${_dateTime.year} "),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "furthest date",
                                        style: StyleConstants().sbTitle,
                                      ),
                                      Text(
                                          "${_dateTime.add(Duration(days: 15 + _dateTime.day)).day}.${_dateTime.month.toInt() < 15 ? _dateTime.month : _dateTime.month + 1}.${_dateTime.year} "),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020, DateTime.now().day),
                    lastDate: DateTime(2050),
                    onDateChanged: ((value) => {
                          _dateTime = value,
                          showTimePicker(
                                  context: context, initialTime: selectedTime)
                              .then((value) {
                            setState(() {
                              selectedTime = value!;

                              showError(
                                  "Do you confirm the appointment on ${_dateTime.day}.${_dateTime.month}.${_dateTime.year}  ${selectedTime.toString().replaceAll("TimeOfDay", "")} ? ");
                            });
                          })
                        }),
                  ),

                  //   Text("${_dateTime.day}.${_dateTime.month}.${_dateTime.year}"),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }

  Future<dynamic> showError(String message) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Appointment successfully made")));
                    },
                    child: Text(
                      "Yes",
                      style: StyleConstants().sbTitle,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: StyleConstants().sbTitle,
                    ))
              ],
              title: const Text("Message"),
              // contentPadding: EdgeInsets.all(10),
              content: Text(message),
            ));
  }

  ExpansionTile pastAppointmentWidget(
      double displayWidth,
      IconData icon,
      Color color,
      String headerTitle,
      String centerTitle,
      String doctorTitle,
      String date,
      Color backgroundColor,
      String hour,
      bool isOnline) {
    return ExpansionTile(
      // collapsedIconColor: Colors.black,
      iconColor: Colors.black,
      //iconColor: Colors.red,
      collapsedBackgroundColor: backgroundColor,
      backgroundColor: backgroundColor,
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        headerTitle,
        style: StyleConstants().sHeaderBrownA,
      ),
      trailing: const Icon(Icons.arrow_drop_down),
      children: <Widget>[
        appointmentDetailContainer(
            displayWidth, centerTitle, doctorTitle, date, hour, isOnline),
      ],
    );
  }

  Container appointmentDetailContainer(double displayWidth, String centerTitle,
      String doctorTitle, String date, String hour, bool isOnline) {
    return Container(
      margin: EdgeInsets.all(displayWidth * .05),
      height: displayWidth * .600,
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
            title: Text(centerTitle),
            //  trailing: Text("Sakarya Family Health Center"),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: ColorConstants.instance.flower,
            ),
            title: Text(doctorTitle),
            //  trailing: Text("Sakarya Family Health Center"),
          ),
          ListTile(
            leading: Icon(
              Icons.date_range,
              color: ColorConstants.instance.flower,
            ),
            title: Text(date),
            //  trailing: Text("Sakarya Family Health Center"),
          ),
          ListTile(
              leading: Icon(
                Icons.query_builder_outlined,
                color: ColorConstants.instance.flower,
              ),
              title: Text(hour),
              trailing: isOnline
                  ? Column(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: ColorConstants.instance.flower,
                        ),
                        Text("Online")
                      ],
                    )
                  : null),
        ],
      ),
    );
  }
}
