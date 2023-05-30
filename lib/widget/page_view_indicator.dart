import 'package:flutter/material.dart';

class pageViewIndicator extends StatelessWidget {
  const pageViewIndicator(
      {Key? key, required this.isCurrentPage, this.endMargin = 0})
      : super(key: key);

  final bool isCurrentPage;
  final double endMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: endMargin),
      height: 4,
      width: 17.8,
      decoration: BoxDecoration(
          color: isCurrentPage == true
              ? const Color(0XFF6A90F2)
              : const Color(0XFFDDDDDD),
          borderRadius: BorderRadius.circular(2)),
    );
  }
}
