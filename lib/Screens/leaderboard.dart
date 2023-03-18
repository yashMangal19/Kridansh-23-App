import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/constants.dart';
import '../commonWidgets/page_header.dart';
import '../gsheets_api/kridansh_sheet.dart';
import '../models/team.dart';

/*
@LeaderboardPage - Page has a column which displays the rank of each hostel.
1. [PageHeader] - The Title Image as an appbar but a container.
2. [topThreeTeamsDisplay] section - Main container which displays the top 3 hostels.
3. Then the list of rest teams in the ranked order from 4th place.

Useful lines to change if bug on different mobile (find below comments)
1. // Responsible for the lift in the frame of 1st place holder.
2. // Responsible for fix team logo into image behind in the top three teams display.
3. // Responsible for images size in top three teams display.
 */
class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  //If [waitKey] = 1 a loading widget is returned in Build function until data is fetched from google sheet else [waitKey] == 0 returns the normal page.
  int waitKey = 1;

  // List of teams in ranked order to be fetched from @Leaderboard google sheet.
  // Initialising with 3 dummy teams as calling top three teams as indexes and it takes some time to fetch the data.
  List<Team> leaderboardList = [
    const Team(id: 1, team: "", points: 0),
    const Team(id: 2, team: "", points: 0),
    const Team(id: 3, team: "", points: 0)
  ];

  // Function that fetches all the teams points in ranked order and stores them in [leaderboardList] list.
  Future getLeaderboardList() async {
    final fetchedLeaderboardList = await KridanshSheetApi.getAllTeams();

    setState(() {
      leaderboardList = fetchedLeaderboardList;
      waitKey = 0;
    });
  }

  @override
  void initState() {
    // Used another function to fetch leaderboard list as init function cannot be async.
    getLeaderboardList();

    super.initState();
  }

  // String used in the body of the LeaderboardPage.
  String topThreeTeamsDisplayHeading = " is Raising the Trophy !!";

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: waitKey == 1
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(
                    top: 0, right: 10, bottom: 0, left: 10),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      PageHeader(
                        pageSize: pageSize,
                        isTitled: true,
                        title: 'Leaderboard',
                        imagePath: 'assets/images/leaderboard_1.jpg',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      topThreeTeamsDisplay(topThreeTeamsDisplayHeading),
                      const SizedBox(
                        height: 15,
                      ),
                      restTeamsDisplay(),
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
  @topThreeTeamsDisplay has a heading for the top hostels.
  And it also has a container to display the top 3 hostels.
  It used the widget [topThreeTeam] which returns a column of for a top 3 team depending on the rank.
   */
  Widget topThreeTeamsDisplay(String heading) {
    return Column(
      children: [
        Row(
          children: [
            const Image(
              height: 24,
              image: AssetImage("assets/icons/trophy.png"),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              leaderboardList[0].team + heading,
              style: heading1Style,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              topThreeTeam(
                  2, leaderboardList[1].team, leaderboardList[1].points),
              topThreeTeam(
                  1, leaderboardList[0].team, leaderboardList[0].points),
              topThreeTeam(
                  3, leaderboardList[2].team, leaderboardList[2].points),
            ],
          ),
        ),
      ],
    );
  }

  /*
  @restTeamsDisplay has a listview builder that has a base widget of [normalTeamDisplay] which displays all hostels from position 4.
   */
  Widget restTeamsDisplay() {
    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // So that the ListView does not scroll separately.
      itemCount: leaderboardList.length - 3,
      itemBuilder: (context, index) => normalTeamDisplay(
        leaderboardList[index + 3].id!,
        leaderboardList[index + 3].team,
        leaderboardList[index + 3].points,
      ),
    );
  }

  /*
  Is a widget used in [topThreeTeamsDisplay] for displaying the images, logo, name and points of a hostel.
  NOTE - It has a lot of hardcoded sized images therefore may not look appropriate on all devices.
   */
  Widget topThreeTeam(int rank, String team, int points) {
    return Column(
      children: [
        rank == 1
            ? const Text("")
            : rank == 2
                ? Text(
                    "2nd",
                    style: mediumTextStyle,
                  )
                : Text(
                    "3rd",
                    style: mediumTextStyle,
                  ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: rank == 1
              ? 120
              : 100, // Responsible for images size in top three teams display.
          width: rank == 1 ? 120 : 100,
          padding: rank == 1
              ? const EdgeInsets.only(
                  top: 28,
                  right: 24,
                  bottom: 0,
                  left:
                      24) // Responsible for fix team logo into image behind in the top three teams display.
              : const EdgeInsets.all(18),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: rank == 1
                  ? const AssetImage("assets/images/1st_place_frame.png")
                  : const AssetImage("assets/images/2nd_3rd_place_frame.png"),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: lightGrey,
              shape: BoxShape.circle,
            ),
            child: logos[team] == ""
                ? Center(
                    child: Text(
                      team,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Image(
                    image: AssetImage(logos[team]),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Hostel $team",
          style: mediumTextStyle,
        ),
        Row(
          children: [
            const Image(
              height: 18,
              image: AssetImage("assets/icons/points.png"),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              points.toString(),
              style: thinTextStyle,
            )
          ],
        ),
        SizedBox(
          height: rank == 1
              ? 32
              : 0, // Responsible for the lift in the frame of 1st place holder.
        )
      ],
    );
  }

  /*
  @normalTeamDisplay is a custom list tile made from container to display logo, name and points of a hostel from position 4.
   */
  Widget normalTeamDisplay(int rank, String team, int points) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 10),
      margin: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 15),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
              color: lightGrey,
              shape: BoxShape.circle,
            ),
            child: logos[team] == ""
                ? Center(
                    child: Text(
                      team,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Image(
                    image: AssetImage(logos[team]),
                    fit: BoxFit.cover,
                  ),
          ),
          Text(
            "Hostel $team",
            style: regularTextStyle.copyWith(fontSize: 18),
          ),
          Row(
            children: [
              const Image(
                height: 18,
                image: AssetImage("assets/icons/points.png"),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                points.toString(),
                style: thinTextStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}
