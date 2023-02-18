import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motor_scheme/colors/colors.dart';
import '../models/partData.dart';
import '../parts-view/parts-view.dart';
import 'package:http/http.dart' as http;

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

  bool _isLoading = true;
  List allData = [];
  String partsImageUrl = "";
  void _loadData() async {
    final selectecdYear = widget.selectecdYear;
    final selectecdModel = widget.selectecdModel;
    final selectecdCategory = widget.selectecdCategory;
    final selectedBrand = widget.selectedBrand;

    List<String> nameTypeParts = [];

    String url =
        "https://raw.githubusercontent.com/amWilq/Motor_scheme/master/data/data.json";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      dynamic parsedJson = json.decode(data);

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
        _isLoading = false;
      });
    } else {
      print("Error getting data");
    }
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
                child: partData.length == 0
                    ? Text(
                        'Brak danych dla $selectedBrand $selectecdModel $selectecdYear')
                    : CircularProgressIndicator(),
              )
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
