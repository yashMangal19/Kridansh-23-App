import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kridansh_23_app/Screens/leaderboard.dart';
import 'package:kridansh_23_app/Screens/splash_screen.dart';
import 'Screens/schedule.dart';
import 'Utils/constants.dart';
import 'gsheets_api/kridansh_sheet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialising all the sheets.
  await KridanshSheetApi.initYoutubeSheet();
  // await KridanshSheetApi.initMatchesDay1Sheet();
  // await KridanshSheetApi.initMatchesDay2Sheet();
  // await KridanshSheetApi.initMatchesDay3Sheet();
  await KridanshSheetApi.initMatchesSheet();
  await KridanshSheetApi.initLeaderboardSheet();

  runApp(
    MaterialApp(
      title: 'Kridansh 23',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    ),
  );
}

class KridanshApp extends StatefulWidget {
  const KridanshApp({Key? key}) : super(key: key);

  @override
  State<KridanshApp> createState() => _KridanshAppState();
}

/*
KridanshApp has three sections in a stack
1. The main page on the home that can be either of any widgets in the [page] list.
2. [bottomShadow] section which provides the bottom black shadow of height 200px.
3. [bottomNavBar] which is a custom container nav bar for changing the main page on screen.
 */
class _KridanshAppState extends State<KridanshApp> {
  // List of all the pages which needed to be navigated using bottom navbar.
  List<StatefulWidget> pages = [
    const HomePage(),
    const SchedulePage(),
    const LeaderboardPage(),
  ];

  // Index of the bottom navbar refers to the widget at an index in [pages].
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pages[index],
        bottomShadow(),
        bottomNavBar(),
      ],
    );
  }

  // bottomShadow is only a container of height 200 acting as a bottom black gradiant
  // NOTE : page is not scrollable on the bottom 200px height because of this.
  Widget bottomShadow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black,
              ],
              stops: const [
                0.0,
                1.0
              ]),
        ),
      ),
    );
  }

  /*
  Bottom Navbar has three containers clicking on which home of material app changes according to the index in the [page] list.
   */
  Widget bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding:
              const EdgeInsets.only(top: 10, right: 7, bottom: 10, left: 7),
          decoration: const BoxDecoration(
            color: secondaryColorDark,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 60,
                  decoration: BoxDecoration(
                    color: index == 0 ? secondaryColorLight : secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: index == 0
                        ? const AssetImage("assets/icons/home_active.png")
                        : const AssetImage("assets/icons/home_inactive.png"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 60,
                  decoration: BoxDecoration(
                    color: index == 1 ? secondaryColorLight : secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: index == 1
                        ? const AssetImage("assets/icons/schedule_active.png")
                        : const AssetImage(
                            "assets/icons/schedule_inactive.png"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 60,
                  decoration: BoxDecoration(
                    color: index == 2 ? secondaryColorLight : secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: index == 2
                        ? const AssetImage(
                            "assets/icons/leaderboard_active.png")
                        : const AssetImage(
                            "assets/icons/leaderboard_inactive.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
