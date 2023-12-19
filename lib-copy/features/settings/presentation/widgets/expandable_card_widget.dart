import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableCardWidget extends StatelessWidget {
  final String header;
  final Widget collapsed;
  final Widget expanded;
  const ExpandableCardWidget({
    super.key,
    required this.header,
    required this.collapsed,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ExpandablePanel(
          header: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Text(header, style: TextStyle(fontSize: 20.sp)),
          ),
          collapsed: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: collapsed,
          ),
          expanded: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: expanded,
          ),
        ),
      ),
    );
  }
}
