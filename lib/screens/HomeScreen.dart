import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/providers/media_provider.dart';
import 'package:record_app/screens/Auth/UserAccountPage.dart';
import 'package:record_app/screens/Favourites/FavouritesScreen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:record_app/screens/podcast/PodcastScreen.dart';
import 'album/AlbumsScreen.dart';
import 'ExploreScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).colorScheme.surface,
        child: TabBar(
            controller: tabController,
            indicatorColor: Colors.green,
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.green,
            labelStyle: TextStyle(fontSize: 12),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon: Icon(Octicons.telescope),
              ),
              // Tab(
              //   icon: Icon(SimpleLineIcons.book_open),
              // ),
              // Tab(
              //   icon: Icon(Zocial.podcast),
              // ),
              Tab(
                icon: Icon(AntDesign.hearto),
              ),
              Tab(
                icon: Icon(Octicons.settings),
              ),
            ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  // ExploreScreen(),
                  AlbumsScreen(),
                  // PodcastScreen(),
                  FavouritesScreen(),
                  UserAccountPage(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyBottomNav extends StatefulWidget {
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions = <Widget>[
    // ExploreScreen(),
    AlbumsScreen(),
    // PodcastScreen(),
    FavouritesScreen(),
    UserAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<MediaProvider>(context).getAllTracks();

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
              rippleColor: Colors.green,
              hoverColor: Colors.green,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: primary,
              color: primary,
              tabs: [
                GButton(
                  icon: Octicons.telescope,
                  text: 'Home',
                ),
                GButton(
                  icon: AntDesign.hearto,
                  text: 'Likes',
                ),
                GButton(
                  icon: Octicons.settings,
                  text: 'Search',
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
