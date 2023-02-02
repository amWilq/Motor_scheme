import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor_scheme/provider/dark_theme_provider.dart';
import 'package:motor_scheme/provider/screen-index-provider.dart';
import 'package:motor_scheme/selections/parts-selection.dart';
import 'package:motor_scheme/selections/type-selection.dart';
import 'package:motor_scheme/widget/theme_data.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'cubits/fav_cubit.dart';
import 'fav_page/fav_page.dart';
import 'selections/brand-selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  final screens = [
    BrandSelection(),
    FavouritePage(),
  ];

  int currentIndex = 0;

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    initState();
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

//Screens for each nav items.
  List<Widget> _NavScreens() {
    return [BrandSelection(), FavouritePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: ("OFFERS"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_pin),
        title: ("Help"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.local_activity),
        title: ("ProfileScreen"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.abc_sharp),
        title: ("Cart"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (context) => screenIndexProvider())
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return Center(
          child: MaterialApp(
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: BlocProvider<FavCubit>(
              create: (context) => FavCubit(),
              child: Scaffold(
                body: IndexedStack(
                  index: currentIndex,
                  children: screens,
                ),
                bottomNavigationBar: BottomNavigationBar(
                    iconSize: 32,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    onTap: (index) {
                      currentIndex = index;
                      (() {});
                    },
                    currentIndex: currentIndex,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Feed',
                      ),
                    ]),
              ),
            ),
          ),
        );
      }),
    );
  }
}
