import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'user.dart';

class PartsView extends StatefulWidget {
  const PartsView({super.key});

  @override
  State<PartsView> createState() => _PartsViewState();
}

class _PartsViewState extends State<PartsView> {
  bool isVisible = true;
  List<User> users = getUsers();

  static List<User> getUsers() {
    const data = [
      {"lp": "1", "nameOfPart": "FLASHER SWITCH", "partNumber": "78111029000"},
      {
        "lp": "2",
        "nameOfPart": "MASTER CYLINDER CPL.",
        "partNumber": "54802030144"
      },
      {
        "lp": "3",
        "nameOfPart": "CLUTCH LEVER CPL. BREMBO 06",
        "partNumber": "54802030144"
      },
      {
        "lp": "4",
        "nameOfPart": "REP. KIT PISTON 06",
        "partNumber": "54802030144"
      },
      {
        "lp": "5",
        "nameOfPart": "COVER HYD. CLUTCH CPL. 2014",
        "partNumber": "54802030144"
      },
      {"lp": "6", "nameOfPart": "VALVE", "partNumber": "54802030144"},
      {"lp": "7", "nameOfPart": "BOLT KPL.", "partNumber": "54802030144"},
      {
        "lp": "8",
        "nameOfPart": "PŁYN HAMULCOWY DOT5.1, 0,25L.",
        "partNumber": "54802030144"
      },
      {
        "lp": "9",
        "nameOfPart": "PROTECTION CAP 06",
        "partNumber": "54802030144"
      },
      {
        "lp": "10",
        "nameOfPart": "LEVER SCREW CPL. 06",
        "partNumber": "54802030144"
      },
      {"lp": "11", "nameOfPart": "PUSH ROD CPL.", "partNumber": "54802030144"},
      {
        "lp": "12",
        "nameOfPart": "REAR MIRROR R/S",
        "partNumber": "54802030144"
      },
      {
        "lp": "13",
        "nameOfPart": "REAR MIRROR L/S.",
        "partNumber": "54802030144"
      },
      {"lp": "14", "nameOfPart": "MIRROR R/S 98.", "partNumber": "54802030144"},
      {"lp": "15", "nameOfPart": "MIRROR L/S 98", "partNumber": "54802030144"},
      {
        "lp": "16",
        "nameOfPart": "SUPPORT FOR MIRROR LC4 '98",
        "partNumber": "54802030144"
      },
    ];

    return data.map<User>(User.fromJson).toList();
  }

  final ScrollController scrollcontroller = new ScrollController();

  bool scroll_visibility = true;

  @override
  void initState() {
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels > 0 ||
          scrollcontroller.position.pixels <
              scrollcontroller.position.maxScrollExtent)
        scroll_visibility = false;
      else
        scroll_visibility = true;

      setState(() {});
    });
    super.initState();
  }

  bool _isShow = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            floating: true,
            title: Text('test'),
            centerTitle: true,
          ),
        ],
        body: CustomScrollView(
          slivers: <Widget>[
            //2
            SliverAppBar(
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Goa', textScaleFactor: 1),
                background: Image.asset(
                  'assets/images/beach.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                setState(
                  () {
                    _isShow = !_isShow;
                  },
                );
              },
              child: Text(
                _isShow ? 'Hide' : 'Show',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: bulidUsers(users),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulidUsers(List<User> users) => ListView.builder(
        itemBuilder: ((context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              leading: Text(user.lp),
              title: Text(user.nameOfPart),
              subtitle: Text(user.partNumber),
            ),
          );
        }),
        itemCount: users.length,
      );
}
