import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foose_gsc/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Widget logoutButton;

  @override
  void initState() {
    super.initState();
    // Do any non-dependent initialization here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This method will be called when dependencies change
    logoutButton = _buildLogoutButton();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: logoutButton,
    );
  }

  // logout function
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Logout Success");
    if (!context.mounted) return;

    prefs.remove('uid');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Widget _buildLogoutButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: AppColors.accentColor,
      child: MaterialButton(
        onPressed: () {
          logout(context);
        },
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          'Logout',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
