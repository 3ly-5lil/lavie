import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavie/ui/screens/navigation_screens/main_screen.dart';
import 'package:lavie/ui/screens/navigation_screens/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: CurvedNavBar(
        activeColor: Colors.white,
        navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.transparent,
        actionButton: CurvedActionBar(
          onTab: (value) {
            if (kDebugMode) {
              print(value);
            }
          },
          activeIcon: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color(0xff1ABC00), shape: BoxShape.circle),
            child: SvgPicture.asset('assets/icons/home.svg'),
          ),
          inActiveIcon: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color(0xff1ABC00), shape: BoxShape.circle),
            child: SvgPicture.asset('assets/icons/home.svg'),
          ),
        ),
        actionBarView: Container(
          color: Colors.pink,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: SvgPicture.asset('assets/icons/leaf.svg'),
              inActiveIcon: SvgPicture.asset('assets/icons/leaf.svg'),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: SvgPicture.asset('assets/icons/qr_scan.svg'),
              inActiveIcon: SvgPicture.asset('assets/icons/qr_scan.svg'),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: SvgPicture.asset('assets/icons/notfication.svg'),
              inActiveIcon: SvgPicture.asset('assets/icons/notfication.svg'),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: SvgPicture.asset('assets/icons/profile.svg'),
              inActiveIcon: SvgPicture.asset('assets/icons/profile.svg'),
              text: ''),
        ],
        bodyItems: [
          MainScreen(),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.yellow,
          ),
          NotificationScreen(),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
