import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kridansh_23_app/Utils/app_configs.dart';
import 'package:kridansh_23_app/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateAppPage extends StatefulWidget {
  const UpdateAppPage({Key? key}) : super(key: key);

  @override
  State<UpdateAppPage> createState() => _UpdateAppPageState();
}

class _UpdateAppPageState extends State<UpdateAppPage> {
  String updateUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    fetchUrl();
    super.initState();
  }

  Future<void> fetchUrl() async{
    AppConfigs appConfigs = AppConfigs();
    String url = await appConfigs.appUpdateUrl();

    setState(() {
      updateUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    height: pageSize.height * 0.08,
                    // width: pageSize.width * 0.25,
                    // color: Colors.black,
                    image: const AssetImage("assets/images/kridansh_logo.jpeg"),
                  ),
                ),
              ),
              Center(
                child: Image(
                  height: pageSize.height * 0.35,
                  width: pageSize.height * 0.70,
                  image: const AssetImage("assets/images/update_app.png"),
                ),
              ),
              SizedBox(
                height: pageSize.height * 0.10,
              ),
              Text(
                "Time to update!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: pageSize.height * 0.03,
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: pageSize.width * 0.10),
                child: Text(
                  "We have added a lot of features and fixed some bugs to make your experience better and as smooth as possible",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: pageSize.height * 0.06,
              ),
              GestureDetector(
                onTap: () async {
                  if (updateUrl.isEmpty){
                    context.showSnackBar(
                      message: "Fetching Update URL --- If it takes too much time, go to playstore and manually update",
                      backgroundColor: Colors.purple.shade700,
                    );
                  }
                  else {
                    debugPrint(updateUrl);
                    launchUrlString(
                        updateUrl,
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: Container(
                  height: pageSize.height * 0.05,
                  width: pageSize.width * 0.3,
                  decoration: const BoxDecoration(
                      color: Color(0xff6b63ff),
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Center(
                    child: Text(
                      "Update",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
