import 'package:flutter/material.dart';
import 'package:kridansh_23_app/commonWidgets/page_header.dart';
import 'package:kridansh_23_app/commonWidgets/youtube_video.dart';
import 'package:kridansh_23_app/models/youtube.dart';
import '../gsheets_api/kridansh_sheet.dart';
import '../Utils/constants.dart';

/*
@HomePage - Page has a column which contains.
1. [PageHeaderThe] - Kridansh Logo as an appbar but a container.
2. [introSection] - The Introduction text about Kridansh.
3. [highlightSection] - Then the highlight videos about Kridansh.
 */
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of all the youtube videos to be fetched from @Youtube_Links google sheet.
  List<Youtube> youtubeVideos = [];

  // Function that fetches all the youtube links with their titles and stores them in a list [youtubeVideos] of [Youtube] model.
  Future getYoutubeVideos() async {
    final fetchedYoutubeVideos = await KridanshSheetApi.getAllYoutube();
    setState(() {
      youtubeVideos = fetchedYoutubeVideos;
    });
  }

  @override
  void initState() {
    // Used another function to fetch youtube links as init function cannot be async.
    getYoutubeVideos();

    super.initState();
  }

  // String used in the body of the Homepage.
  String introSectionHeading = "Fuel Your Rivalry !!";
  String highlightSectionHeading = "Highlights";
  String introductionText = "The much-awaited Inter Hostel Sports Fest of IIT Jodhpur, "
      "KRIDANSH !!  is finally here.\nFrom basketball to badminton, football to table "
      "tennis, Kridansh promises to be a thrilling showcase of talent, skill, and team "
      "spirit. The air will be filled with cheers and applause, the competition will be "
      "tough, with each hostel vying for the top spot. Rivalry will be at an all-time high"
      " as the athletes put their best foot forward to bring glory to their respective "
      "hostels.\nOnly the best will lift the coveted trophy.";

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        // Previous Appbar version on PageHeader in which the appbar is not scrollable.

        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(pageSize.height * 0.25),
        //   child: PageHeader(
        //                   pageSize: pageSize,
        //                   isTitled: false,
        //          ),
        // ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 0, right: 10, bottom: 0, left: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  pageSize: pageSize,
                  isTitled: false,
                  imagePath: 'assets/images/kridansh_logo.jpeg',
                ),
                const SizedBox(
                  height: 20,
                ),
                introSection(introSectionHeading, introductionText),
                const SizedBox(
                  height: 20,
                ),
                highlightSection(highlightSectionHeading, pageSize),
                const SizedBox(
                  height: 100,
                ),
              ], // [introductionText], [introSectionHeading] initialised at beginning of class.
            ),
          ),
        ),
      ),
    );
  }

  /*
  Intro Section contains two texts Heading and the introduction text.
  @param [introSectionHeading] - Heading of the section.
  @param [introductionText] - main text in the section.
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
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  /*
  Highlight Section contains the youtube videos
  @param [highlightSectionHeading] - Heading of the section.
  @param [pageSize] - for passing pageSize to [YoutubeVideo] widget.
   */
  Widget highlightSection(String highlightSectionHeading, Size pageSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          highlightSectionHeading,
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
            itemCount: youtubeVideos.length,
            itemBuilder: (context, index) => YoutubeVideo(
              pageSize: pageSize,
              link: youtubeVideos[index].link,
              title: youtubeVideos[index].title,
            ),
          ),
        ),
      ],
    );
  }
}
