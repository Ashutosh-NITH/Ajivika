import 'package:ajivika/Homepage/homepage.dart';
import 'package:ajivika/Profilepage/ProfilePage.dart';
import 'package:ajivika/languagepage/language_page.dart';
import 'package:ajivika/loginpage/choosing_page.dart';
import 'package:ajivika/workersection/WorkerSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class bottom_navbar extends StatefulWidget {
  @override
  State<bottom_navbar> createState() => _bottom_navbarState();
}

class _bottom_navbarState extends State<bottom_navbar> {
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
        children: [WorkerSectionPage(), homepage(), ProfilePage()],
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
