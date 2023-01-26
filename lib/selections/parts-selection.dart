import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motor_scheme/colors/colors.dart';
import 'package:motor_scheme/read-data/data-brand-model.dart';

import '../models/partData.dart';
import '../parts-view/parts-view.dart';

class PartsSelection extends StatefulWidget {
  final String selectecdYear;
  final String selectecdModel;
  final String selectecdCategory;
  final String selectedBrand;

  const PartsSelection(
      {required this.selectedBrand,
      required this.selectecdYear,
      required this.selectecdModel,
      required this.selectecdCategory});

  @override
  State<PartsSelection> createState() => _PartsSelectionState();
}

class _PartsSelectionState extends State<PartsSelection> {
  // static List<String> parts = [
  //   'PRZÓD AMORTYZATORY, PÓŁKI ZAWIESZENIA',
  //   'PRZÓD AMORTYZATORY SPIS CZĘŚCI',
  //   'KIEROWNICA I OSPRZĘT',
  //   'STOPKI POSTOJOWE',
  //   'OSŁONA SILNIKA',
  //   'RAMA',
  //   'WAHACZ',
  //   'AMORTYZATOR TYŁ SPIS CZĘŚCI',
  //   'AMORTYZATOR TYŁ',
  //   'UKŁAD WYDECHOWY',
  //   'FILTR POWIETRZA',
  //   'ZBIORNIK PALIWA, SIEDZENIE, POKROWIEC',
  //   'CZASZA, BŁOTNIKI',
  //   'NAKLEJKI',
  //   'KOŁO PRZÓD',
  //   'KOŁO TYŁ',
  //   'WIĄZKA ELEKTRYCZNA WIĄZKA',
  //   'POMPA HAMULCA PRZEDNIEGO CYLINDER',
  //   'HAMULCE- ZACISK HAMULCOWY PRZÓD',
  //   'TYŁ HAMULEC - POMPA',
  //   'HAMULCE- ZACISK HAMULCOWY TYŁ',
  //   'OŚWIETLENIE SYSTEM',
  //   'SYSTEM ZABEZPIECZAJĄCY',
  // ];

  // static List imageUrl = [
  //   'assets/images/01.gif',
  //   'assets/images/02.gif',
  //   'assets/images/03.gif',
  //   'assets/images/04.gif',
  //   'assets/images/05.gif',
  //   'assets/images/06.gif',
  //   'assets/images/07.gif',
  //   'assets/images/08.gif',
  //   'assets/images/10.gif',
  //   'assets/images/11.gif',
  //   'assets/images/13.gif',
  //   'assets/images/14.gif',
  //   'assets/images/20.gif',
  //   'assets/images/30.gif',
  //   'assets/images/31.gif',
  //   'assets/images/32.gif',
  //   'assets/images/33.gif',
  //   'assets/images/34.gif',
  //   'assets/images/35.gif',
  //   'assets/images/37.gif',
  //   'assets/images/39.gif',
  //   'assets/images/40.gif',
  //   'assets/images/90.gif'
  // ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List allData = [];
  void _loadData() async {
    final selectecdYear = widget.selectecdYear;
    final selectecdModel = widget.selectecdModel;
    final selectecdCategory = widget.selectecdCategory;
    final selectedBrand = widget.selectedBrand;

    List<String> nameTypeParts = [];
    String xmlString = await rootBundle.loadString('data/data.json');
    dynamic parsedJson = json.decode(xmlString);
    List newAllData = [];
    for (var i = 0; i < parsedJson.length; i++) {
      if (parsedJson[i]['mark'] == selectedBrand &&
          parsedJson[i]['category'] == selectecdCategory &&
          parsedJson[i]['model'] == selectecdModel &&
          parsedJson[i]['year'] == selectecdYear) {
        newAllData = parsedJson[i]["part"];
        newAllData.forEach((element) {
          nameTypeParts.add(element["nameTypePart"]);
        });
      } else {}
    }

    setState(() {
      allData = newAllData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectecdYear = widget.selectecdYear;
    final selectecdModel = widget.selectecdModel;
    final selectecdCategory = widget.selectecdCategory;
    final selectedBrand = widget.selectedBrand;
    Text("Selected year: $selectecdYear");

    List<PartData> partData = [];
    for (var i = 0; i < allData.length; i++) {
      List parts = allData[i]['parts'];
      PartData part = PartData(
        id: allData[i]['id'],
        nameTypePart: allData[i]['nameTypePart'],
        imageUrl: allData[i]['imageUrl'],
        parts: parts,
      );
      partData.add(part);
    }

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            title: Text(
                'Wybór części dla:\n$selectedBrand $selectecdModel $selectecdYear'),
            centerTitle: true,
            backgroundColor: AppColors.ktmColor,
          ),
        ],
        body: ListView.builder(
            itemCount: partData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(partData[index].nameTypePart),
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(partData[index].imageUrl),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PartsView(parts: partData[index].parts),
                    ));
                  },
                ),
              );
            }),
      ),
    );
  }
}
