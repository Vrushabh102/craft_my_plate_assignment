import 'package:flutter/material.dart';

class FillDetailsHeader extends StatelessWidget {
  const FillDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // back arrow and wedding text
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Fill Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
