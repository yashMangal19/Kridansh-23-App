import 'package:flutter/material.dart';
import 'package:kridansh_23_app/commonWidgets/match_tile.dart';

import '../Utils/constants.dart';
import '../commonWidgets/page_header.dart';
import '../gsheets_api/kridansh_sheet.dart';
import '../models/match.dart';

/*
@SchedulePage - Page has a column which contains.
1. [PageHeader] - The Title Image as an appbar but a container.
2. [dayTabBar] - The toggle bar for toggling the day for the schedule of the matches.
3. [matchesScheduleList] - Then the list of matches scheduled for the selected day.
 */
class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // List of match schedule of day 1 , day 2 and day 3 to be fetched from @Matches_day1, @Matches_day2, @Matches_day3 google sheets respectively.
  List<Match> matchListDay1 = [];
  List<Match> matchListDay2 = [];
  List<Match> matchListDay3 = [];

  // Function that fetches all the matches of each day and stores them in [matchListDay1], [matchListDay2], [matchListDay3] respectively.
  Future getMatchesList() async {
    final fetchedMatchListDay1 = await KridanshSheetApi.getAllMatchesDay1();
    final fetchedMatchListDay2 = await KridanshSheetApi.getAllMatchesDay2();
    final fetchedMatchListDay3 = await KridanshSheetApi.getAllMatchesDay3();
    setState(() {
      matchListDay1 = fetchedMatchListDay1;
      matchListDay2 = fetchedMatchListDay2;
      matchListDay3 = fetchedMatchListDay3;
      selectedDayList = matchListDay1;
    });
  }

  @override
  void initState() {
    // Used another function to fetch match list of each day as init function cannot be async.
    getMatchesList();

    super.initState();
  }

  // Index of the day tab bar refers to the day selected.
  int day = 1;

  //List used in Listview Builder when a particular day is chosen.
  List<Match> selectedDayList = [];

  // String used in the body of the Homepage.
  String matchListHeading = "Mark Your Calendars!";

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 0, right: 10, bottom: 0, left: 10),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                PageHeader(
                  pageSize: pageSize,
                  isTitled: true,
                  title: 'Matches',
                  imagePath: 'assets/images/schedule.jpg',
                ),
                const SizedBox(
                  height: 25,
                ),
                dayTabBar(),
                const SizedBox(
                  height: 20,
                ),
                matchesScheduleList(matchListHeading),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  A Tab bar to select the day for which scheduled matches user wants to see.
  Contains a row of containers with each container wrapped under gesture detector to change state.
   */
  Widget dayTabBar() {
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
                    day = 1;
                    selectedDayList = matchListDay1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: 50,
                  decoration: BoxDecoration(
                      color: day == 1 ? secondaryColorLight : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    children: [
                      Text(
                        "Day",
                        style: mediumTextStyle.copyWith(
                          color: day == 1 ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Image(
                        height: 28,
                        image: day == 1
                            ? const AssetImage("assets/icons/day1_active.png")
                            : const AssetImage(
                                "assets/icons/day1_inactive.png"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    day = 2;
                    selectedDayList = matchListDay2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: 50,
                  decoration: BoxDecoration(
                      color: day == 2 ? secondaryColorLight : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    children: [
                      Text(
                        "Day",
                        style: mediumTextStyle.copyWith(
                          color: day == 2 ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Image(
                        height: 28,
                        image: day == 2
                            ? const AssetImage("assets/icons/day2_active.png")
                            : const AssetImage(
                                "assets/icons/day2_inactive.png"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    day = 3;
                    selectedDayList = matchListDay3;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: 50,
                  decoration: BoxDecoration(
                      color: day == 3 ? secondaryColorLight : secondaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    children: [
                      Text(
                        "Day",
                        style: mediumTextStyle.copyWith(
                          color: day == 3 ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Image(
                        height: 28,
                        image: day == 3
                            ? const AssetImage("assets/icons/day3_active.png")
                            : const AssetImage(
                                "assets/icons/day3_inactive.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget matchesScheduleList(String matchListHeading) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          matchListHeading,
          style: heading1Style,
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          // As ListView is not placed inside column therefore need to be wrapped in Flexible widget.
          child: ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // So that the ListView does not scroll separately.
            itemCount: selectedDayList.length,
            itemBuilder: (context, index) => MatchTile(
                team1: selectedDayList[index].team1,
                team2: selectedDayList[index].team2,
                location: selectedDayList[index].location,
                time: selectedDayList[index].time,
                sport: selectedDayList[index].sport),
          ),
        ),
      ],
    );
  }
}
