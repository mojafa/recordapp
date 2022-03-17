import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/screens/Favourites/FavouritesScreen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:record_app/screens/Settings/settings__screen.dart';
import 'album/AlbumsScreen.dart';

class MyBottomNav extends StatefulWidget {
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions = <Widget>[
    AlbumsScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Provider.of<MediaProvider>(context).getAllTracks();

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
            child: GNav(
              rippleColor: secondary,
              hoverColor: secondary,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: secondary,
              color: secondary,
              tabs: [
                GButton(
                  icon: Octicons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: AntDesign.hearto,
                  text: 'Favorites',
                ),
                GButton(
                  icon: Octicons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
