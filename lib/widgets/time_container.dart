import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.gap,
  });

  final String startTime;
  final String endTime;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffE1E1E1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/clock.png'),
          SizedBox(width: gap),
          Text("$startTime - $endTime"),
        ],
      ),
    );
  }
}
