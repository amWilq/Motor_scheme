import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 400.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text("WYBÓR CZĘSCI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    'https://ktmsklep.pl/image/scheme/24e45b8935f0c0889c39f14a7308d60395322f43313635343830323130.png',
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: bulidUsers(users),
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
