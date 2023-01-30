import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor_scheme/colors/colors.dart';
import '../cubits/fav_cubit.dart';
import '../models/vehicle_model.dart';
import 'parts-selection.dart';

class TypeSelection extends StatefulWidget {
  final String selectedBrand;
  const TypeSelection({
    required this.selectedBrand,
  });

  @override
  State<TypeSelection> createState() => _SelectionState();
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class _SelectionState extends State<TypeSelection> {
  String? selectecdModel;
  String? selectecdCategory;
  String? selectecdYear;
  dynamic parsedJson;
  List<dynamic> modelsList = [];
  List<dynamic> typesList = [];
  List<dynamic> yearsList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<dynamic> _loadData() async {
    String xmlString = await rootBundle.loadString('data/brand-data.json');
    dynamic parsedJson = json.decode(xmlString);
    return parsedJson;
  }

  findAllModelsForSelectedOptions(
      selectecdYear, selectecdCategory, selectedBrand) async {
    dynamic parsedJson = await _loadData();
    for (var i = 0; i < parsedJson.length; i++) {
      if (parsedJson[i]["marka"] == selectedBrand) {
        var brandModel = parsedJson[i]["modele"].where((model) =>
            model["year"].contains(selectecdYear) &&
            model["typ"] == selectecdCategory);
        modelsList = brandModel.map((model) => model["model"]).toList();
        return modelsList;
      }
    }
  }

  findAllTypesForSelectedBrand(selectedBrand) async {
    dynamic parsedJson = await _loadData();
    for (var i = 0; i < parsedJson.length; i++) {
      if (parsedJson[i]["marka"] == selectedBrand) {
        typesList = parsedJson[i]["typ"].toList();
        return typesList;
      }
    }
  }

  Future<List<dynamic>?> findAllYearsForSelectedBrand(selectedBrand) async {
    dynamic parsedJson = await _loadData();
    for (var i = 0; i < parsedJson.length; i++) {
      if (parsedJson[i]["marka"] == selectedBrand) {
        yearsList = parsedJson[i]["years"].toList();
        return yearsList;
      }
    }
    return null;
  }

  Color getBackgroundColor(String brand) {
    if (brand == 'KTM') {
      return AppColors.ktmColor;
    } else if (brand == 'Suzuki') {
      return AppColors.suzukiColor;
    } else if (brand == 'Honda') {
      return AppColors.hondaColor;
    } else if (brand == 'Yamaha') {
      return AppColors.yamahaColor;
    } else if (brand == 'Kawasaki') {
      return AppColors.kawasakiColor;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedBrand = widget.selectedBrand;
    getBackgroundColor(selectedBrand);
    findAllTypesForSelectedBrand(selectedBrand);
    findAllYearsForSelectedBrand(selectedBrand);

    return FutureBuilder<List<dynamic>?>(
      future: findAllYearsForSelectedBrand(selectedBrand),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          yearsList = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: getBackgroundColor(selectedBrand),
                title: Text('WYBÓR MODELU'),
                centerTitle: true,
              ),
              body: ListView(
                children: <Widget>[
                  Center(
                    child: DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: '01. ROCZNIK:'),
                        value: null,
                        items: yearsList
                            .map((year) => DropdownMenuItem<String>(
                                  value: year,
                                  child: Text(
                                    year,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ))
                            .toList(),
                        onChanged: (item) =>
                            {setState(() => selectecdYear = item)}),
                  ),
                  Center(
                    child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: '02. RODZAJ:',
                        ),
                        value: null,
                        items: typesList
                            .map((typesList) => DropdownMenuItem<String>(
                                  value: typesList,
                                  enabled: selectecdYear != null,
                                  child: Text(
                                    typesList,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ))
                            .toList(),
                        onChanged: (category) => setState(() {
                              selectecdCategory = category;
                              findAllModelsForSelectedOptions(selectecdYear,
                                  selectecdCategory, selectedBrand);
                            })),
                  ),
                  Center(
                      child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: '03. MODEL: ',
                    ),
                    value: null,
                    items: modelsList
                        .map((model) => DropdownMenuItem<String>(
                            value: model,
                            enabled: selectecdYear != null,
                            child: Text(
                              model,
                              style: const TextStyle(fontSize: 24),
                            )))
                        .toList(),
                    onChanged: (model) => setState(
                      () => selectecdModel = model!,
                    ),
                  )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_forward_ios,
                          size: 70.0,
                          color: selectecdModel == null
                              ? Colors.grey
                              : getBackgroundColor(selectedBrand)),
                      onPressed: (selectecdYear != null &&
                              selectecdModel != null &&
                              selectecdCategory != null)
                          ? () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => PartsSelection(
                                      selectedBrand: selectedBrand,
                                      selectecdYear: selectecdYear!,
                                      selectecdModel: selectecdModel!,
                                      selectecdCategory: selectecdCategory!,
                                      colorBrand:
                                          getBackgroundColor(selectedBrand)),
                                ),
                              );
                            }
                          : null,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.favorite,
                        size: 70.0,
                        color: selectecdModel == null
                            ? Colors.grey
                            : getBackgroundColor(selectedBrand),
                      ),
                      onPressed: (selectecdYear != null &&
                              selectecdModel != null &&
                              selectecdCategory != null)
                          ? () {
                              context
                                  .read<FavCubit>()
                                  .addFavorites(VehicleModel(
                                    brand: selectedBrand,
                                    type: selectecdCategory!,
                                    year: selectecdYear!,
                                    model: selectecdModel!,
                                  ));
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Ulubiony!'),
                                  content: const Text(
                                      'Twój model został dodany do ulubionych!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                    ),
                  ])
                ],
              ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  decoration(String s) {}
}
