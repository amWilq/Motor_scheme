import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.ktmColor,
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
                      builder: (context) => const TypeSelection(),
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
