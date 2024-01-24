import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyC--wetJRll1gUfTBQDivSUp0J9X_k5HgQ',
              appId: '1:751418874363:android:27fd1497436f9ab146d35e',
              messagingSenderId: '751418874363',
              projectId: 'foose-food-stock-management'),
        )
      : await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primaryColor: AppColors.primaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const LoginPage());
  }
}
