import 'package:ajivika/Profilepage/ProfilePage.dart';
import 'package:ajivika/workersection/WorkerSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Homepage/homepage.dart';

class worker_bottom_navbar extends StatefulWidget {
  final double currlat;
  final double currlong;
  worker_bottom_navbar({required this.currlat, required this.currlong});

  @override
  State<worker_bottom_navbar> createState() => _bottom_navbarState();
}

int selected_index = 0;
PageController pageController = PageController();

class _bottom_navbarState extends State<worker_bottom_navbar> {
  void changepage(int index) {
    setState(() {
      selected_index = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          homepage(currlat: widget.currlat, currlong: widget.currlong),
          WorkerSection(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.map),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bars),
            label: "Worker section",
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
