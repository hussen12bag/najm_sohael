import 'package:flutter/material.dart';

class list extends StatefulWidget {
  final Widget? icon;
  final Widget title;
  final Widget? subtitle;
  final Color color;
  list(
      {super.key,
      this.icon,
      required this.title,
      this.subtitle,
      required this.color});
  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          widget.icon != null ? widget.icon! : Text(''),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title,
              widget.subtitle != null ? widget.subtitle! : Text('')
            ],
          )
        ],
      ),
    );
  }
}
