import 'package:ajivika/Profilepage/ProfilePage.dart';
import 'package:ajivika/workersection/WorkerSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Homepage/homepage.dart';

class worker_bottom_navbar extends StatefulWidget {
  @override
  State<worker_bottom_navbar> createState() => _bottom_navbarState();
}

class _bottom_navbarState extends State<worker_bottom_navbar> {
  int selected_index = 1;
  PageController pageController = PageController();
  void changepage(int index) {
    setState(() {
      selected_index = index;
      pageController.jumpToPage(selected_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          selected_index = index;
          setState(() {});
        },
        controller: pageController,
        children: [JobAppliedHistoryPage(), homepage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bars),
            label: "Worker section",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.map),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: "Profile",
          ),
        ],
        currentIndex: selected_index,
        onTap: changepage,
      ),
    );
  }
}
