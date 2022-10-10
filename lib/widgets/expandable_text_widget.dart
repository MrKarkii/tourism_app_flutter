import 'package:flutter/material.dart';
import 'package:tourism_app/misc/colors.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = 150;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            )
          : Column(
              children: [
                Text(
                  hiddenText ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.8,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      hiddenText
                          ? const Text(
                              "Show more",
                              style: TextStyle(color: Colors.black),
                            )
                          : const Text(
                              "Show Less",
                              style: TextStyle(color: Colors.black),
                            ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                        size: 40,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
