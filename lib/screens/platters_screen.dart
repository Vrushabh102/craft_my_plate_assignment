import 'package:assignment_craft_my_plate/widgets/platters_body.dart';
import 'package:assignment_craft_my_plate/widgets/platters_header.dart';
import 'package:flutter/material.dart';

class PlattersScreen extends StatefulWidget {
  const PlattersScreen({super.key});

  @override
  State<PlattersScreen> createState() => _PlattersScreenState();
}

class _PlattersScreenState extends State<PlattersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {

    // initializing the tabcontroller to control the tabs
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffE4E6E7),
      body: Column(
        children: [

          // HEADER ...
          // includes wedding image, tabs for navigation
          PlattersHeader(height: height, tabController: _tabController),

          // BODY
          // Food Item List
          const Expanded(
            child: PlattersBody(),
          ),
        ],
      ),
    );
  }
}




