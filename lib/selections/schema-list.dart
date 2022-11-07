import 'package:flutter/material.dart';
import 'package:motor_scheme/read-data/data-brand-model.dart';

import '../parts-view/parts-view.dart';

class SchemaList extends StatefulWidget {
  const SchemaList({super.key});

  @override
  State<SchemaList> createState() => _SchemaListState();
}

class _SchemaListState extends State<SchemaList> {
  static List<String> parts = [
    'PRZÓD AMORTYZATORY, PÓŁKI ZAWIESZENIA',
    'PRZÓD AMORTYZATORY SPIS CZĘŚCI',
    'KIEROWNICA I OSPRZĘT',
    'STOPKI POSTOJOWE',
    'OSŁONA SILNIKA',
    'RAMA',
    'WAHACZ',
    'AMORTYZATOR TYŁ SPIS CZĘŚCI',
    'AMORTYZATOR TYŁ',
    'UKŁAD WYDECHOWY',
    'FILTR POWIETRZA',
    'ZBIORNIK PALIWA, SIEDZENIE, POKROWIEC',
    'CZASZA, BŁOTNIKI',
    'NAKLEJKI',
    'KOŁO PRZÓD',
    'KOŁO TYŁ',
    'WIĄZKA ELEKTRYCZNA WIĄZKA',
    'POMPA HAMULCA PRZEDNIEGO CYLINDER',
    'HAMULCE- ZACISK HAMULCOWY PRZÓD',
    'TYŁ HAMULEC - POMPA',
    'HAMULCE- ZACISK HAMULCOWY TYŁ',
    'OŚWIETLENIE SYSTEM',
    'SYSTEM ZABEZPIECZAJĄCY',
  ];

  static List imageUrl = [
    'assets/images/01.gif',
    'assets/images/02.gif',
    'assets/images/03.gif',
    'assets/images/04.gif',
    'assets/images/05.gif',
    'assets/images/06.gif',
    'assets/images/07.gif',
    'assets/images/08.gif',
    'assets/images/10.gif',
    'assets/images/11.gif',
    'assets/images/13.gif',
    'assets/images/14.gif',
    'assets/images/20.gif',
    'assets/images/30.gif',
    'assets/images/31.gif',
    'assets/images/32.gif',
    'assets/images/33.gif',
    'assets/images/34.gif',
    'assets/images/35.gif',
    'assets/images/37.gif',
    'assets/images/39.gif',
    'assets/images/40.gif',
    'assets/images/90.gif'
  ];

  final List<BrandDataModel> partData = List.generate(
      parts.length,
      (index) =>
          BrandDataModel(parts[index], '${imageUrl[index]}', parts[index]));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            floating: true,
            title: Text("WYBÓR SCHEMATU"),
            centerTitle: true,
          ),
        ],
        body: ListView.builder(
            itemCount: partData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(partData[index].name),
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(partData[index].imageUtl),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PartsView()));
                  },
                ),
              );
            }),
      ),
    );
  }
}
