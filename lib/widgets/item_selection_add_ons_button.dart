import 'package:flutter/material.dart';

class AddOnsButton extends StatelessWidget {
  const AddOnsButton({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: height * 0.06,
          width: width * 0.26,
          child: Stack(
            children: [
              Container(
                height: height * 0.05,
                width: width * 0.24,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Add Ons',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: -1,
                right: 1,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.pink,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 80)
      ],
    );
  }
}
