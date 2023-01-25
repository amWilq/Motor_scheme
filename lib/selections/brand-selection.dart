import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motor_scheme/colors/colors.dart';
import '../read-data/data-brand-model.dart';
import 'type-selection.dart';

class BrandSelection extends StatefulWidget {
  const BrandSelection({super.key});

  @override
  State<BrandSelection> createState() => _BrandSelectionState();
}

class _BrandSelectionState extends State<BrandSelection> {
  static List<String> brand = ['Honda', 'Yamaha', 'Kawasaki', 'Suzuki', 'KTM'];
  static List url = [
    'assets/images/honda.jpg',
    'assets/images/yamaha.png',
    'assets/images/Kawasaki.png',
    'assets/images/suzuki.png',
    'assets/images/ktm.png',
  ];

  final List<BrandDataModel> brandData = List.generate(brand.length,
      (index) => BrandDataModel(brand[index], '${url[index]}', brand[index]));
  final String todos = 'test';
  List<String> nameTypeParts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    // czytanie pliku JSON
    String xmlString = await rootBundle.loadString('data/data.json');
    // String jsonString = await File('data/data.json').readAsString();

    // parsowanie pliku JSON
    dynamic parsedJson = json.decode(xmlString);
    List allData =
        parsedJson[0]["part"]; // dodawanie nazwy typu części do listy
    allData.forEach((element) {
      nameTypeParts.add(element["nameTypePart"]);
    });
    print(nameTypeParts);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey,
          title: const Text('WYBIERZ TWOJA MARKĘ!'),
        ),
        body: ListView.builder(
            itemCount: brandData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(brandData[index].name),
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(brandData[index].imageUtl),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TypeSelection(selectedBrand: brandData[index].name),
                      settings: RouteSettings(
                        arguments: brandData,
                      ),
                    ));
                  },
                ),
              );
            }),
      ),
    );
  }
}
