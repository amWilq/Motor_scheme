import 'package:flutter/material.dart';

import 'schema-list.dart';

class Selection extends StatefulWidget {
  const Selection({super.key});

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
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
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
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
                    size: 50.0,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SchemaList()));
                  },
                ),
              ],
            )));
  }

  decoration(String s) {}
}
