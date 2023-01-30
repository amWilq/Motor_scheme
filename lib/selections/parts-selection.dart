import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motor_scheme/colors/colors.dart';
import '../models/partData.dart';
import '../parts-view/parts-view.dart';

class PartsSelection extends StatefulWidget {
  final Color colorBrand;
  final String selectecdYear;
  final String selectecdModel;
  final String selectecdCategory;
  final String selectedBrand;

  const PartsSelection(
      {required this.colorBrand,
      required this.selectedBrand,
      required this.selectecdYear,
      required this.selectecdModel,
      required this.selectecdCategory});

  @override
  State<PartsSelection> createState() => _PartsSelectionState();
}

class _PartsSelectionState extends State<PartsSelection> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List allData = [];
  String partsImageUrl = "";
  void _loadData() async {
    final selectecdYear = widget.selectecdYear;
    final selectecdModel = widget.selectecdModel;
    final selectecdCategory = widget.selectecdCategory;
    final selectedBrand = widget.selectedBrand;

    List<String> nameTypeParts = [];
    String xmlString = await rootBundle.loadString('data/data.json');
    dynamic parsedJson = json.decode(xmlString);
    List newAllData = [];
    String newPartsImageUrl = "";

    for (var i = 0; i < parsedJson.length; i++) {
      if (parsedJson[i]['mark'] == selectedBrand &&
          parsedJson[i]['category'] == selectecdCategory &&
          parsedJson[i]['model'] == selectecdModel &&
          parsedJson[i]['year'] == selectecdYear) {
        newAllData = parsedJson[i]["part"];
        if (parsedJson[i]["partsImageUrl"] != null) {
          newPartsImageUrl = parsedJson[i]["partsImageUrl"];
        }
        for (var element in newAllData) {
          nameTypeParts.add(element["nameTypePart"]);
        }
      } else {}
    }

    setState(() {
      allData = newAllData;
      partsImageUrl = newPartsImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectecdYear = widget.selectecdYear;
    final selectecdModel = widget.selectecdModel;
    final selectedBrand = widget.selectedBrand;
    final colorBrand = widget.colorBrand;
    List<PartData> partData = [];
    for (var i = 0; i < allData.length; i++) {
      List parts = allData[i]['parts'];
      PartData part = PartData(
        id: allData[i]['id'],
        nameTypePart: allData[i]['nameTypePart'],
        imageUrl: allData[i]['imageUrl'],
        partsImageUrl: allData[i]['partsImageUrl'],
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
            backgroundColor: colorBrand,
          ),
        ],
        body: partData.isEmpty
            ? Center(
                child: Text(
                    'Brak danych dla $selectedBrand $selectecdModel $selectecdYear'))
            : ListView.builder(
                itemCount: partData.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(partData[index].nameTypePart),
                    leading: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(partData[index].imageUrl),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PartsView(
                            parts: partData[index].parts,
                            partsImageUrl: partData[index].partsImageUrl,
                            colorBrand: colorBrand),
                      ));
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
