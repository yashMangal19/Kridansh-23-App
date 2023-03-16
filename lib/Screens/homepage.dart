import 'package:flutter/material.dart';
import 'package:kridansh_23_app/commonWidgets/page_header.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Utils/constants.dart';
/*
@HomePage - Page has a column which contains.
1. The Kridansh Logo as an appbar
2. The Introduction text about Kridansh.
3. Then the highlight videos about Kridansh.
 */

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    // Youtube player controller definition and initialisation in inti function.
    YoutubePlayerController? _youtubeContoller;

    @override
    void initState() {
      // TODO: implement initState

      super.initState();
    }

    // String used in the body of the Homepage.
    String introSectionHeading = "Fuel Your Rivalry !!";
    String highlightSectionHeading = "Highlights";
    String introductionText =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.";

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(pageSize.height * 0.25),
          child: PageHeader(
            pageSize: pageSize,
            isTitled: false,
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 10, bottom: 0, left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                introSection(introSectionHeading, introductionText),
                const SizedBox(
                  height: 20,
                ),
                highlightSection(highlightSectionHeading)
              ], // @introductionText, @introSectionHeading initialised at beginning of class.
            ),
          ),
        ),
      ),
    );
  }

  /*
  Intro Section contains two texts Heading and the introduction text.
  @param {introSectionHeading} - Heading of the section.
  @param {introductionText} - main text in the section.
   */
  Widget introSection(String introSectionHeading, String introductionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          introSectionHeading,
          style: heading1Style,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          introductionText,
          style: regularTextStyle,
        ),
      ],
    );
  }

  /*
  Highlight Section contains two texts Heading and the introduction text.
  @param {highlightSectionHeading} - Heading of the section.
   */
  Widget highlightSection(String highlightSectionHeading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          highlightSectionHeading,
          style: heading1Style,
        ),
      ],
    );
  }
}
