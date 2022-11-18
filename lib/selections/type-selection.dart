import 'package:flutter/material.dart';
import 'package:motor_scheme/colors/colors.dart';
import 'package:motor_scheme/main.dart';

import '../arguments/ExtractArgumentsScreen .dart';
import '../read-data/data-brand-model.dart';
import 'parts-selection.dart';

class TypeSelection extends StatefulWidget {
  const TypeSelection({super.key});

  @override
  State<TypeSelection> createState() => _SelectionState();
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class _SelectionState extends State<TypeSelection> {
  List<String> years = [
    '1994',
    '1995',
    '1996',
    '1997',
    '1998',
    '1999',
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
  ];
  String? selectecdYear = '2016';

  List<String> categorys = [
    'Enduro',
    'Cross',
    'Mini',
    'Adventure',
    'Naked',
  ];
  String? selectecdCategory = 'Enduro';

  List<String> models = [
    '300 EXC',
    '250 EXC',
    '125 EXC',
    '350 EXCF',
    '450 EXCF',
  ];
  String? selectecdModel = '300 EXC';

  @override
  Widget build(BuildContext context) {
    final todo =
        ModalRoute.of(context)!.settings.arguments as List<BrandDataModel>;
    print(todo);
    return MaterialApp(
        title: 'Navigation with Arguments',
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: AppColors.ktmColor,
              title: const Text("WYBÓR MODELU"),
              centerTitle: true,
            ),
            body: ListView(
              children: <Widget>[
                DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: '01. WYBIERZ ROCZNIK:'),
                    value: selectecdYear,
                    items: years
                        .map((year) => DropdownMenuItem<String>(
                              value: year,
                              child: Text(
                                year,
                                style: TextStyle(fontSize: 24),
                              ),
                            ))
                        .toList(),
                    onChanged: (item) => setState(
                          () => selectecdYear = item,
                        )),
                DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: '02. WYBIERZ TYP POJAZDU:',
                    ),
                    value: selectecdCategory,
                    items: categorys
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ))
                        .toList(),
                    onChanged: (category) => setState(
                          () => selectecdCategory = category,
                        )),
                DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: '03. WYBIERZ MODEL:',
                    ),
                    value: selectecdModel,
                    items: models
                        .map((model) => DropdownMenuItem<String>(
                              value: model,
                              child: Text(
                                model,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ))
                        .toList(),
                    onChanged: (model) => setState(
                          () => selectecdModel = model,
                        )),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 70.0,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        settings: const RouteSettings(name: '/form'),
                        builder: (context) => const PartsSelection(),
                      ),
                    );
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const PartsSelection()));
                  },
                ),
                Text(selectecdYear!),
                Text(selectecdModel!),
                Text(selectecdCategory!),
                for (var user in todo)
                  Card(
                    child: Text(user.name),
                  ),
                // Text(todo),
                // ignore: avoid_print
              ],
            )));
  }

  decoration(String s) {}
}
