import 'package:aile_hekimligi_uygulamasi/constants/color_constant.dart';
import 'package:aile_hekimligi_uygulamasi/service/firebase_service.dart';
import 'package:aile_hekimligi_uygulamasi/view/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///not in document
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
// Define a widget
    Widget firstWidget;

// Assign widget based on availability of currentUser
    if (FirebaseAuth.instance.currentUser == null) {
      firstWidget = const FirebaseService();
    } else {
      firstWidget = const HomeView();
    }

    return MaterialApp(
        title: 'Material App',
        home: firstWidget,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ));
  }
}
