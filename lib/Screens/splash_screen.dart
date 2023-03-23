import 'package:flutter/material.dart';
import 'package:kridansh_23_app/Screens/authentication/login.dart';
import 'package:kridansh_23_app/Screens/homepage.dart';
import 'package:kridansh_23_app/Utils/app_configs.dart';
import 'package:kridansh_23_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'misc/update_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _redirectCalled = false;
  late SharedPreferences prefs;

  @override
  void didChangeDependencies() {
    // Checks whether user is Signed in or not
    super.didChangeDependencies();
    _redirect();
  }

  Future<void> _redirect() async {
    // redirects user to corresponding pages depending on Sign-In status
    await loadSharedPrefs();
    AppConfigs appConfigs = AppConfigs();
    bool isLatestVersion = await appConfigs.isLatestVersion();

    await Future.delayed(const Duration(seconds: 2));
    if (_redirectCalled || !mounted) {
      return;
    }

    _redirectCalled = true;
    final String? userName = prefs.getString('User_name');
    final bool invalidSignin = prefs.getBool('invalid_signin')??false;
    if(invalidSignin){
      /// todo : Signout user
      debugPrint("Invalid Signin, user might get signed out at a later time...");
    }
    if(!isLatestVersion){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>const UpdateAppPage())
      );
    }
    else if (userName==null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>const LoginScreen())
      );
    }
    else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>const KridanshApp())
      );
    }
  }

  Future<void> loadSharedPrefs() async{
    prefs = await SharedPreferences.getInstance();
    debugPrint("Shared prefs loaded...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/kridansh_logo.jpeg', height: 100,),
            const SizedBox(height: 20,),
            const CircularProgressIndicator(color: Colors.black,),
          ],
        ),
      ),
    );
  }
}