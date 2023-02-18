import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motor_scheme/main.dart';
import 'package:motor_scheme/selections/type-selection.dart';
import 'package:provider/provider.dart';

import '../fav_page/fav_page.dart';
import '../models/brandData.dart';
import '../provider/dark_theme_provider.dart';

class BrandSelection extends StatelessWidget {
  BrandSelection({super.key});

  int currentIndex = 0;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WYBIERZ TWOJA MARKĘ!'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
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
                  ));
                },
              ),
            );
          }),
      drawer: NavigationDrawer(),
    );
  }
}
