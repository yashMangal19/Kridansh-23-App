import 'package:flutter/material.dart';
import 'package:kridansh_23_app/Utils/constants.dart';

class PageHeader extends StatefulWidget {
  const PageHeader(
      {Key? key, required this.pageSize, this.title, required this.isTitled})
      : super(key: key);

  final Size pageSize;
  final String? title;
  final bool isTitled;

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.pageSize.height * 0.25,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
      ),
      flexibleSpace: Container(
        margin: const EdgeInsets.only(top: 5, left: 10, bottom: 0, right: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          image: DecorationImage(
            image: AssetImage('assets/images/kridansh_logo.jpeg'),
            fit: BoxFit.contain,
          ),
        ),
        child: widget.isTitled
            ? Container(
                padding: const EdgeInsets.only(
                    top: 0, right: 0, bottom: 15, left: 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.0),
                        Colors.grey.shade900,
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
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
