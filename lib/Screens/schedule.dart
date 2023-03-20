import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  // Previous code for getting 3 sheets for matches of each day.

  // List of match schedule of day 1 , day 2 and day 3 to be fetched from @Matches_day1, @Matches_day2, @Matches_day3 google sheets respectively.
  // List<Match> matchListDay1 = [];
  // List<Match> matchListDay2 = [];
  // List<Match> matchListDay3 = [];

  // Function that fetches all the matches of each day and stores them in [matchListDay1], [matchListDay2], [matchListDay3] respectively.
  // Future getMatchesList() async {
  //   final fetchedMatchListDay1 = await KridanshSheetApi.getAllMatchesDay1();
  //   final fetchedMatchListDay2 = await KridanshSheetApi.getAllMatchesDay2();
  //   final fetchedMatchListDay3 = await KridanshSheetApi.getAllMatchesDay3();
  //   setState(() {
  //     matchListDay1 = fetchedMatchListDay1;
  //     matchListDay2 = fetchedMatchListDay2;
  //     matchListDay3 = fetchedMatchListDay3;
  //     selectedDayList = matchListDay1;
  //   });
  // }

  // Index of the day tab bar refers to the day selected.
  // int day = 1;

  //List used in Listview Builder when a particular day is chosen.
  // List<Match> selectedDayList = [];

  // List of match schedule for all days to be fetched from @Matches google sheets.
  List<Match> matchList = [];

  // It gets initialised by first initial day fetched from [getInitialDay] into the function [getMatchesByDay] when the whole list is fetched.
  List<Match> selectedDayMatchList = [];

  // Function to get the list of matches according to the day selected.
  List<Match> getMatchesByDay(String day) {
    List<Match> result = [];

    result = matchList.where((match) => match.day == day).toList();

    return result;
  }

  // Function that fetches all the matches of each day and stores  in [matchList].
  Future getMatchesList() async {
    final fetchedMatchList = await KridanshSheetApi.getAllMatches();
    setState(() {
      matchList = fetchedMatchList;
      selectedDayMatchList = getMatchesByDay(getInitialDay());
    });
  }

  @override
  void initState() {
    // Used another function to fetch match list of each day as init function cannot be async.
    getMatchesList();

    super.initState();
  }

  // String used in the body of the Homepage.
  String matchListHeading = "Mark Your Calendars!";

  // List of 7 days as the event is of 7 days
  List<String> daysList = [
    "27th March",
    "28th March",
    "29th March",
    "30th March",
    "31st March",
    "1st April",
    "2nd April"
  ];

  // Controller which contains the selected value when day is changed.
  TextEditingController dayController = TextEditingController();

  // Function to get the initial day if before 27th march then initial day is 27th March else it is current date.
  String getInitialDay() {
    DateTime now = DateTime.now();
    String initialDay = "27th March";
    if (now.year == 2023 && now.month >= 3 && now.day > 27) {
      initialDay =
          "${now.day}th ${DateFormat('MMMM').format(DateTime(0, now.month))}";
    } else {
      initialDay = "27th March";
    }

    return initialDay;
  }

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
                  height: 30,
                ),
                CustomDropDownBox(
                  pageSize: pageSize,
                  title: 'Select a Day',
                  items: daysList,
                  initialItem: getInitialDay(),
                  initialValue: getInitialDay(),
                  controller: dayController,
                  onChange: () {
                    selectedDayMatchList = getMatchesByDay(dayController.text);
                    setState(() {
                      debugPrint(dayController.text);
                    });
                  },
                ),
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

  // Previous code for 3 day tab bar
  /*
  A Tab bar to select the day for which scheduled matches user wants to see.
  Contains a row of containers with each container wrapped under gesture detector to change state.
   */
  // Widget dayTabBar() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 20),
  //     child: Align(
  //       alignment: Alignment.bottomCenter,
  //       child: Container(
  //         padding:
  //             const EdgeInsets.only(top: 10, right: 7, bottom: 10, left: 7),
  //         decoration: const BoxDecoration(
  //           color: secondaryColorDark,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(30),
  //           ),
  //         ),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   day = 1;
  //                   selectedDayList = matchListDay1;
  //                 });
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 15),
  //                 margin: const EdgeInsets.symmetric(horizontal: 7),
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                     color: day == 1 ? secondaryColorLight : secondaryColor,
  //                     borderRadius:
  //                         const BorderRadius.all(Radius.circular(25))),
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       "Day",
  //                       style: mediumTextStyle.copyWith(
  //                         color: day == 1 ? Colors.black : Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 4,
  //                     ),
  //                     Image(
  //                       height: 28,
  //                       image: day == 1
  //                           ? const AssetImage("assets/icons/day1_active.png")
  //                           : const AssetImage(
  //                               "assets/icons/day1_inactive.png"),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   day = 2;
  //                   selectedDayList = matchListDay2;
  //                 });
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 15),
  //                 margin: const EdgeInsets.symmetric(horizontal: 7),
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                     color: day == 2 ? secondaryColorLight : secondaryColor,
  //                     borderRadius:
  //                         const BorderRadius.all(Radius.circular(25))),
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       "Day",
  //                       style: mediumTextStyle.copyWith(
  //                         color: day == 2 ? Colors.black : Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 4,
  //                     ),
  //                     Image(
  //                       height: 28,
  //                       image: day == 2
  //                           ? const AssetImage("assets/icons/day2_active.png")
  //                           : const AssetImage(
  //                               "assets/icons/day2_inactive.png"),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   day = 3;
  //                   selectedDayList = matchListDay3;
  //                 });
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 15),
  //                 margin: const EdgeInsets.symmetric(horizontal: 7),
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                     color: day == 3 ? secondaryColorLight : secondaryColor,
  //                     borderRadius:
  //                         const BorderRadius.all(Radius.circular(25))),
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       "Day",
  //                       style: mediumTextStyle.copyWith(
  //                         color: day == 3 ? Colors.black : Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 4,
  //                     ),
  //                     Image(
  //                       height: 28,
  //                       image: day == 3
  //                           ? const AssetImage("assets/icons/day3_active.png")
  //                           : const AssetImage(
  //                               "assets/icons/day3_inactive.png"),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
            itemCount: selectedDayMatchList.length,
            itemBuilder: (context, index) => MatchTile(
                team1: selectedDayMatchList[index].team1,
                team2: selectedDayMatchList[index].team2,
                location: selectedDayMatchList[index].location,
                time: selectedDayMatchList[index].time,
                sport: selectedDayMatchList[index].sport),
          ),
        ),
      ],
    );
  }
}

/*
A Dropdown box for selecting from 7 days of event from 27th March to 2nd April.
Takes input
[title] - which is the text displayed above the drop down box.
[items] - The list of days from which one is to be selected.
[initialValue] - initial value that goes to the controller for fetching the matches.
[initialItem] - initial item to be selected on the dropdown box.
[controller] - controller that stores the value selected in the dropdown box.
 */
class CustomDropDownBox extends StatefulWidget {
  const CustomDropDownBox({
    Key? key,
    required this.pageSize,
    required this.title,
    required this.items,
    this.initialValue,
    required this.controller,
    this.itemValues,
    this.initialItem,
    required this.onChange,
  }) : super(key: key);

  final Size pageSize;
  final String title;
  final List items;
  final List? itemValues;
  final String? initialValue;
  final String? initialItem;
  final VoidCallback onChange;
  final TextEditingController controller;

  @override
  State<CustomDropDownBox> createState() => _CustomDropDownBoxState();
}

class _CustomDropDownBoxState extends State<CustomDropDownBox> {
  List itemValues = [];
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    widget.controller.text = widget.initialValue ?? "";
    selectedItem = widget.initialItem;
    if (widget.itemValues == null) {
      itemValues = widget.items;
    } else {
      itemValues = widget.itemValues!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: mediumTextStyle),
        const SizedBox(
          height: 4.0,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: DropdownButton(
            dropdownColor: secondaryColor,
            items: widget.items.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(
                  valueItem,
                  style: regularTextStyle,
                ),
              );
            }).toList(),
            value: selectedItem,
            isExpanded: true,
            underline: const SizedBox(),
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.white,
            onChanged: (Object? value) async {
              setState(() {
                int idx = widget.items.indexOf(value);
                widget.controller.text = itemValues[idx].toString();
                widget.onChange();
                selectedItem = value?.toString();
                // debugPrint(widget.controller.text);
              });
            },
          ),
        ),
        SizedBox(
          height: widget.pageSize.height * 0.03,
        ),
      ],
    );
  }
}

String? nullValidator(dynamic value) {
  if (value == null || value!.isEmpty) {
    return "Some value is required";
  }
  return null;
}
