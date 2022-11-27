import 'package:aile_hekimligi_uygulamasi/view/appointment/appointment_view.dart';
import 'package:aile_hekimligi_uygulamasi/view/doctor/doctor_view.dart';
import 'package:aile_hekimligi_uygulamasi/view/news_view.dart';
import 'package:aile_hekimligi_uygulamasi/view/vaccine/vaccine_view.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';
import '../user/navbar_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
      const NewsView(),
      const DoctorView(),
      const ApponintmentView(),
      const Vaccine(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hekimim"),
        elevation: 0,
        backgroundColor: ColorConstants.instance.flower,
      ),
      drawer: const NavBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavBarWidget(),
    );
  }

  BottomNavigationBar bottomNavBarWidget() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Doctor',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month,
          ),
          label: 'Appointment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.vaccines),
          label: 'Vaccine',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.deepOrange.withOpacity(0.5),
      unselectedItemColor: Colors.black38,
      onTap: _onItemTapped,
    );
  }
}
