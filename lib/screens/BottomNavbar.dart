import 'package:everymove/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:everymove/screens/about.dart';
import 'package:everymove/screens/about_us.dart';
import 'package:everymove/constants.dart';
import 'package:everymove/screens/nutrition.dart';
import 'package:everymove/screens/showRecipes.dart';


class BottomNavBar extends StatefulWidget {
  static const String id= '/nav';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller=PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        hideNavigationBar: false,
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 10,

            ),
          ],
          colorBehindNavBar: Colors.white,
             // navBarStyle: NavBarStyle.style1
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bars items animation properties
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.bounceIn,
          duration: Duration(milliseconds: 50),
        ),
        navBarStyle: NavBarStyle.style9,
        navBarHeight: 60,
      ),
    );

  }
  final homePage = HomePage();
  final userAbout = about();
  final nutrition = Nutrition();
  final Recipe = showRecipes();

//list of screens
  List<Widget> _buildScreens() {
    print("REBUILD?");
    return [

      homePage,
      Recipe,
      nutrition,
      userAbout

    ];
  }
  // list of icons and colors to be used
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          activeColorPrimary: kinActiveColour,
          inactiveColorPrimary: Colors.grey[400],
          title:'Home',
          textStyle: TextStyle(color:Colors.black,
              fontSize:10)
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.search,
        ),
          activeColorPrimary: kinActiveColour,
          inactiveColorPrimary: Colors.grey[400],
          title:'Search Recipes',
          textStyle: TextStyle(color:Colors.black,fontSize:10)
      ),
      PersistentBottomNavBarItem(
          icon:Icon(Icons.fitness_center),
          activeColorPrimary: kinActiveColour,
          inactiveColorPrimary: Colors.grey[400],
          title:'nutrition',
          textStyle: TextStyle(color:Colors.black,fontSize:10)


      ),

      PersistentBottomNavBarItem(
          icon:Icon(Icons.person),
          activeColorPrimary: kinActiveColour,
          inactiveColorPrimary: Colors.grey[400],
          title:'Profile',
          textStyle: TextStyle(color:Colors.black,fontSize:10)


      ),


    ];
  }
}