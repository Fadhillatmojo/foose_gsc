import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foose_gsc/shared/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // ini untuk mengecek platformnya itu android atau bukan, kalau iya maka inisialisasikan Firebase dengan atribut nya sebagai di bawah
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

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var auth = FirebaseAuth.instance;
  String? uid;

  Future<String?> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    return uid;
  }

  @override
  void initState() {
    // getUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          uid = snapshot.data;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.backgroundColor,
              primaryColor: AppColors.primaryColor,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: uid != null ? const NavbarPage() : const LoginPage(),
          );
        } else {
          // Tampilkan indikator loading jika proses asinkron belum selesai
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.backgroundColor,
              primaryColor: AppColors.primaryColor,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
