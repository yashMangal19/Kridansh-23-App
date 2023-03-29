import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kridansh_23_app/Utils/firebase_functions.dart';
import 'package:kridansh_23_app/commonWidgets/form_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  bool onceSubmitted = false;
  TextEditingController nameController = TextEditingController();
  String hostelName = "";
  FirebaseService authService = FirebaseService();
  bool processing = false;

  List<String> hostels = [
    "G1",
    "G2",
    "G3",
    "G4",
    "G5",
    "G6",
    "B1",
    "B2",
    "B3",
    "B4",
    "B5",
    "B6",
    "I2",
    "I3",
    "Y4",
    "Not a hostel Resident",
    "Outside IITJ",
  ];

  String? get selectedHostel{
    if(hostels.contains(hostelName)){
      return hostelName;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: pageSize.height,
            width: pageSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/auth_signup.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Colors.black,
                    // Colors.black26,
                    Colors.black12,
                    Colors.black12,
                    Colors.black26,
                    Colors.black45,
                  ],
                )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: pageSize.height,
            width: pageSize.width,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: (onceSubmitted) ? AutovalidateMode.onUserInteraction : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/kridansh_logo.jpeg', height: 100,),
                      const SizedBox(height: 20.0),
                      KridanshFormField(
                        textEditingController: nameController,
                        labelText: "Your Name",
                        validator: nullValidator,
                      ),
                      hostelSelectorDropDown,
                      const SizedBox(height: 20.0),
                      FormButton(
                        onPressed: () async{
                          onceSubmitted= true;
                          if(processing){
                            return;
                          }
                          if(formKey.currentState!.validate()) {
                            setState(() {
                              processing = true;
                            });
                            try {
                              bool authSuccess = await authService.signInwithGoogle(nameController.text, hostelName);
                              debugPrint("=====================================\n\n\n");
                              if(authSuccess){
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setString('User_name', nameController.text);
                                await prefs.setString('User_hostel', hostelName);
                                if(mounted){
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen()));
                                }
                              }
                            } on Exception catch (error) {
                              debugPrint("=====================================\n\n\n");
                              debugPrint("===============Error======================\n\n\n");
                              debugPrint(error.toString());
                            }
                            finally{
                              setState(() {
                                processing = false;
                              });
                            }
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // await prefs.setString('User_name', nameController.text);
                            // await prefs.setString('User_hostel', hostelName);
                            // await prefs.setBool('invalid_signin', true);
                            // if(mounted){
                            //   Navigator.of(context).pushReplacement(
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //           const SplashScreen()));
                            // }
                          }
                        },
                        pageSize: pageSize,
                        text: 'Sign-In with Google',
                        bgColor: Colors.greenAccent.shade700,
                        textColor: Colors.white,
                        fontSize: 14,
                        widthScale: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          (processing)
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget get hostelSelectorDropDown{
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      child: DropdownButtonFormField(
        isDense: true,
        value: selectedHostel,
        items: List.generate(hostels.length, (index) => DropdownMenuItem(
          value: hostels[index],
          child: Text(hostels[index]),
        )),
        onChanged: (val) {
          if(val!=null) {
            setState(() {
              hostelName = val;
            });
          }
        },
        decoration: kridanshInputDecoration(
            labelText: 'Hostel Name',
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        ),
        validator: nullValidator,
        menuMaxHeight: pageSize.height*0.6,
      ),
    );
  }

  Size get pageSize{
    return MediaQuery.of(context).size;
  }

  String? nullValidator(dynamic value) {
    if(value==null || value!.isEmpty){
      return "Some value is required";
    }
    return null;
  }
}