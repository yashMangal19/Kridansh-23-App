import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kridansh_23_app/Utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/*
@YoutubeVideo - Widget has a column which contains.
1. Thumbnail of the youtube video clicking on which a dialog box will open to which has the player of the video.
2. The Title of the video clicking on which video opens in youtube.
*/
class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({
    Key? key,
    required this.link,
    required this.title,
    required this.pageSize,
  }) : super(key: key);

  final Size pageSize;
  final String link;
  final String title;

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  /*
  @getThumbnail to get the youtube thumbnail from the url of the video.
  @param - [link] = url of the video.
  @param - [thumbnailLink] = link of the thumbnail of the video.
   */
  String getThumbnail(String link) {
    String id = link.substring(link.length - 11);

    String thumbnailLink = "https://img.youtube.com/vi/$id/0.jpg";

    return thumbnailLink;
  }

  /*
  Contains two sections.
  1. [thumbnailSection] - For showing the the thumbnail of the video clicking on which video will play in a dialog box.
  2. [videoTitleSection] - For displaying the title of the video clicking on which video will play in youtube app.
   */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, bottom: 20, left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          thumbnailSection(),
          const SizedBox(
            height: 10,
          ),
          videoTitleSection(),
        ],
      ),
    );
  }

  /*
  [thumbnailSection] - Contains a container with thumbnail as the background image.
  Clicking on it opens the [YoutubeVideoDialog] dialog box to play the video.
   */
  Widget thumbnailSection() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return YoutubeVideoDialog(
                link: widget.link,
                pageSize: widget.pageSize,
              );
            });
      },
      child: Container(
        height: widget.pageSize.height * 0.25,
        width: double.infinity,
        padding: EdgeInsets.all(widget.pageSize.height * 0.075),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          image: DecorationImage(
            image: NetworkImage(
              getThumbnail(widget.link),
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Container(
          padding: EdgeInsets.all(widget.pageSize.height * 0.03),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Image(
              image: AssetImage("assets/icons/play_triangle.png"),
            ),
          ),
        ),
      ),
    );
  }

  /*
  [videoTitleSection] - Contains the Heading of the video.
  Click on the video opens the link in the youtube app.
   */
  Widget videoTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(
          height: 36.0,
          width: 36.0,
          image: AssetImage("assets/icons/youtube.png"),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: mediumTextStyle,
          ),
        )
      ],
    );
  }
}

class YoutubeVideoDialog extends StatefulWidget {
  const YoutubeVideoDialog(
      {Key? key, required this.pageSize, required this.link})
      : super(key: key);

  final Size pageSize;
  final String link;
  @override
  State<YoutubeVideoDialog> createState() => _YoutubeVideoDialogState();
}

class _YoutubeVideoDialogState extends State<YoutubeVideoDialog> {
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    // TODO: implement initState

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link).toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        isLive: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.white,
        ),
        builder: (context, player) {
          return Padding(
            padding: EdgeInsets.only(
                top: widget.pageSize.height * 0.2,
                right: 15,
                bottom: widget.pageSize.height * 0.2,
                left: 15),
            child: Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                          alignment: Alignment.topLeft,
                          child: Image(
                            height: 32,
                            image: AssetImage("assets/icons/back_button.png"),
                          )),
                    ),
                  ),
                  Expanded(child: player),
                ],
              ),
            ),
          );
        });
  }
}
