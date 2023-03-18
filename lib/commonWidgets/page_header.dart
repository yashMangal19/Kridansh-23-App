import 'package:flutter/material.dart';
import 'package:kridansh_23_app/Utils/constants.dart';

/*
Page header consists of a rounder container taking 4 arguments ( 1 optional )
1. [pageSize] to remember the pageSize of parent widget.
2. [imagePath] - the image path in the assets for the background image of the container.
3. [isTitled] - boolean if the title is to be shown in the container.
4. [title] - if isTitled true then the title to be shown in the container.
 */
class PageHeader extends StatefulWidget {
  const PageHeader(
      {Key? key,
      required this.pageSize,
      this.title,
      required this.isTitled,
      required this.imagePath})
      : super(key: key);

  final Size pageSize;
  final String imagePath;
  final String? title;
  final bool isTitled;

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.pageSize.height * 0.25,
      margin: const EdgeInsets.only(top: 5, left: 0, bottom: 0, right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: widget.isTitled
          ? Container(
              padding:
                  const EdgeInsets.only(top: 0, right: 0, bottom: 15, left: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black.withOpacity(0.6),
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ]),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.title!,
                  style: pageHeaderStyle,
                ),
              ),
            )
          : Container(),
    );
  }
}

// ##################################################
// Previous Appbar version on PageHeader in which the appbar is not scrollable.

// AppBar(
// toolbarHeight: widget.pageSize.height * 0.25,
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.vertical(
// bottom: Radius.circular(25.0),
// ),
// ),
// flexibleSpace: Container(
// margin: const EdgeInsets.only(top: 5, left: 10, bottom: 0, right: 10),
// decoration: const BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.all(Radius.circular(25.0)),
// image: DecorationImage(
// image: AssetImage('assets/images/kridansh_logo.jpeg'),
// fit: BoxFit.contain,
// ),
// ),
// child: widget.isTitled
// ? Container(
// padding: const EdgeInsets.only(
// top: 0, right: 0, bottom: 15, left: 15),
// decoration: BoxDecoration(
// borderRadius: const BorderRadius.all(Radius.circular(25.0)),
// gradient: LinearGradient(
// begin: FractionalOffset.topCenter,
// end: FractionalOffset.bottomCenter,
// colors: [
// Colors.grey.withOpacity(0.0),
// Colors.grey.shade900,
// ],
// stops: const [
// 0.0,
// 1.0
// ]),
// ),
// child: Align(
// alignment: Alignment.bottomLeft,
// child: Text(
// widget.title!,
// style: pageHeaderStyle,
// ),
// ),
// )
//     : Container(),
// ),
// backgroundColor: Colors.transparent,
// );
