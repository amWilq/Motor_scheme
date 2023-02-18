import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor_scheme/fav_page/fav_page.dart';
import 'package:motor_scheme/provider/dark_theme_provider.dart';
import 'package:motor_scheme/provider/screen-index-provider.dart';
import 'package:motor_scheme/selections/brand-selection.dart';
import 'package:motor_scheme/selections/test.dart';
import 'package:motor_scheme/widget/theme_data.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'cubits/fav_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    initState();
  }

  int currentIndex = 0;

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return Center(
          child: MaterialApp(
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: BlocProvider<FavCubit>(
                create: (context) => FavCubit(), child: MainPage()),
          ),
        );
      }),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        screens: [BrandSelection(), FavouritePage(), NotesPage()],
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style5,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: ("Home"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite_border_outlined),
        title: ("Favorite"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite_border_outlined),
        title: ("Favorite"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            bulidHeader(context),
            bulidMenuItems(context),
          ],
        ),
      );
}

Widget bulidHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
Widget bulidMenuItems(BuildContext context) {
  final themeState = Provider.of<DarkThemeProvider>(context);

  return (Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.language_outlined),
          title: const Text('Język'),
          onTap: (() {}),
        ),
        SwitchListTile(
            title: const Text('Ciemny motyw'),
            value: themeState.getDarkTheme,
            secondary: Icon(themeState.getDarkTheme
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onChanged: (bool value) {
              themeState.setDarkTheme = value;
            }),
      ],
    ),
  ));
}
