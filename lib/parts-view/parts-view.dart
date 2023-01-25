import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:motor_scheme/widgets/pinch-zoom-image.dart';

import '../colors/colors.dart';
import '../selections/parts-selection.dart';

class PartsView extends StatefulWidget {
  const PartsView({super.key});

  @override
  State<PartsView> createState() => _PartsViewState();
}

class _PartsViewState extends State<PartsView> {
  @override
  Widget build(BuildContext context) {
    String data = '''{
"1": {
  "part": {
    "nameOfPart": "FLASHER SWITCH",
    "partNumber": "78111029000"
}
},
"2": {
  "part": {
    "nameOfPart": "MASTER CYLINDER CPL.",
    "partNumber": "54802030144"
}
},
"3": {
  "part": {
      "nameOfPart": "CLUTCH LEVER CPL. BREMBO 06",
      "partNumber": "54802030144"
}
},

"4": {
  "part": {
    "nameOfPart": "REP. KIT PISTON 06",
    "partNumber": "54802030144"
}
},

"5": {
  "part": {
      "nameOfPart": "COVER HYD. CLUTCH CPL. 2014",
      "partNumber": "54802030144"
}
},

"6": {
  "part": {
    "nameOfPart": "SUPPORT FOR MIRROR LC4 '98",
    "partNumber": "54802030144"
}
},

"7": {
  "part": {
    "nameOfPart": "PŁYN HAMULCOWY DOT5.1, 0,25L.",
    "partNumber": "54802030144"
}
},

"8": {
  "part": {
    "nameOfPart": "REAR MIRROR L/S.",
    "partNumber": "54802030144"
}
},

"9": {
  "part": {
    "nameOfPart": "SUPPORT FOR MIRROR LC4 '98",
    "partNumber": "54802030144"
}
},

"10": {
  "part": {
   "nameOfPart": "PROTECTION CAP 06",
        "partNumber": "54802030144"
}
},

"11": {
  "part": {
    "nameOfPart": "SUPPORT FOR MIRROR LC4 '98",
    "partNumber": "54802030144"
}
}
} ''';

    Map<dynamic, dynamic> json = jsonDecode(data);

    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          backgroundColor: AppColors.ktmColor,
          floating: true,
          title: const Text("WYBÓR SCHEMATU"),
          centerTitle: true,
        ),
      ],
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    InkWell(child: PinchZoomImage()),
                  ],
                ),
                for (var i = 1; i < json.length + 1; i++)
                  ListTile(
                    leading: Text(i.toString()),
                    title: Text(json[i.toString()]['part']['nameOfPart']),
                    subtitle: Text(json[i.toString()]['part']['partNumber']),
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
