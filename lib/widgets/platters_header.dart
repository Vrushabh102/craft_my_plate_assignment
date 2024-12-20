import 'package:assignment_craft_my_plate/constants/colors.dart';
import 'package:flutter/material.dart';

class PlattersHeader extends StatelessWidget {
  const PlattersHeader({
    super.key,
    required this.height,
    required TabController tabController,
  }) : _tabController = tabController;

  final double height;
  final TabController _tabController;

  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: [
  //       Image.asset(
  //         'assets/bride_groom.png',
  //         fit: BoxFit.cover,
  //         height: height * 0.3,
  //       ),
  //       SizedBox(
  //         height: height * 0.3,
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 48),

  //             // back arrow and wedding text
  //             const Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: Stack(
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: Icon(
  //                       Icons.arrow_back,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       'Wedding',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),

  //             const Spacer(),
  //             TabBarSection(height: height),
  //             // Tab Bar
  //             Container(
  //               height: height * 0.05,
  //               color: Colors.white,
  //               child: TabBar(
  //                 controller: _tabController,
  //                 labelColor: CustomColors.selectedTabItem,
  //                 unselectedLabelColor: Colors.black,
  //                 indicatorColor: CustomColors.selectedTabItem,
  //                 indicatorWeight: 3,
  //                 isScrollable: true,
  //                 padding: EdgeInsets.zero,
  //                 tabAlignment: TabAlignment.start,
  //                 tabs: const [
  //                   Tab(text: "ALL (8)"),
  //                   Tab(text: "Breakfast"),
  //                   Tab(text: "Lunch & Dinner"),
  //                   Tab(text: "Snacks"),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Image.asset(
          'assets/bride_groom.png',
          fit: BoxFit.cover,
          height: height * 0.3,
        ),
        // Black shadow overlay
        Positioned.fill(
          child: Container(
            height: height * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(1),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),
        ),
        // Header content
        SizedBox(
          height: height * 0.3,
          child: Column(
            children: [
              const SizedBox(height: 48),
              // Back arrow and "Wedding" text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Wedding',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Tab Bar Section
              TabBarSection(height: height),
              Container(
                height: height * 0.05,
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: CustomColors.selectedTabItem,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: CustomColors.selectedTabItem,
                  indicatorWeight: 3,
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,
                  tabs: const [
                    Tab(text: "ALL (8)"),
                    Tab(text: "Breakfast"),
                    Tab(text: "Lunch & Dinner"),
                    Tab(text: "Snacks"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key, required this.height});

  final double height;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tabButton(
            "Bulk Food Delivery",
            isSelected: true,
          ),
          _tabButton("Catering Service"),
        ],
      ),
    );
  }

  Widget _tabButton(String text, {bool isSelected = false}) {
    return isSelected
        ? Column(
            children: [
              Container(
                width: 170,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.purple : Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 5.5,
                width: 170,
                color: Colors.white,
              ),
            ],
          )
        : Container(
            width: 170,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.purple : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}
