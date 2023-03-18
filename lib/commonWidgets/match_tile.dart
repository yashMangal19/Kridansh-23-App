import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kridansh_23_app/Utils/constants.dart';

/*
@MatchTile has mainly two sections separated by a [divider] widget.
1. [teamDisplay] section which displays the logos of the two teams.
2. matchDetails section contains 3 [matchDetail] widgets displaying location, time, sport of the match.
 */
class MatchTile extends StatefulWidget {
  const MatchTile(
      {Key? key,
      required this.team1,
      required this.team2,
      required this.location,
      required this.time,
      required this.sport})
      : super(key: key);

  final String team1;
  final String team2;
  final String location;
  final String time;
  final String sport;

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 0, bottom: 15, left: 0),
      margin: const EdgeInsets.only(top: 0, right: 0, bottom: 15, left: 0),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          teamsDisplay(),
          const SizedBox(
            height: 16,
          ),
          divider(),
          const SizedBox(
            height: 8,
          ),
          matchDetail("assets/icons/location.png", "Location", widget.location),
          const SizedBox(
            height: 6,
          ),
          matchDetail("assets/icons/time.png", "Time", widget.time),
          const SizedBox(
            height: 6,
          ),
          matchDetail("assets/icons/match_type.png", "Sport", widget.sport),
        ],
      ),
    );
  }

  /*
  @teamDisplay section displays the two logos if logo present in [logos] Map in Utils/constants.dart file else displays the name as logo.
   */
  Widget teamsDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: lightGrey,
                shape: BoxShape.circle,
              ),
              child: logos[widget.team1] == ""
                  ? Center(
                      child: Text(
                        widget.team1,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : Image(
                      image: AssetImage(logos[widget.team1]),
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Hostel ${widget.team2}",
              style: regularTextStyle,
            ),
          ],
        ),
        const Image(
          height: 32,
          image: AssetImage('assets/icons/versus.png'),
        ),
        Column(
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: lightGrey,
                shape: BoxShape.circle,
              ),
              child: logos[widget.team2] == ""
                  ? Center(
                      child: Text(
                        widget.team2,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : Image(
                      image: AssetImage(logos[widget.team2]),
                    ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Hostel ${widget.team2}",
              style: regularTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  // Just a container with height 2px of white color.
  Widget divider() {
    return Container(
      height: 2,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  // Takes in the details about the match and displays using image and text in row.
  Widget matchDetail(String imagePath, String detailType, String detail) {
    return Padding(
      padding: const EdgeInsets.only(left: 28),
      child: Row(
        children: [
          Image(
            height: 16,
            image: AssetImage(imagePath),
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "$detailType - ",
            style: regularTextStyle,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(detail, style: regularTextStyle),
        ],
      ),
    );
  }
}
