import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key, required this.date, required this.gap});

  final String date;
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
          Image.asset('assets/icons/calander.png'),
          SizedBox(width: gap),
          Text(date),
        ],
      ),
    );
  }
}
