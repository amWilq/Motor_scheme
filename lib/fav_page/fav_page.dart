import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor_scheme/cubits/fav_cubit.dart';
import 'package:motor_scheme/selections/parts-selection.dart';

import '../main.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp())),
          ),
          backgroundColor: Colors.black,
          title: Text('Ulubione'),
          centerTitle: true,
        ),
        body: BlocBuilder<FavCubit, FavInitial>(
          builder: (context, state) {
            if (state.vehicleData!.isEmpty) {
              return const Center(
                child: Text('Brak ulubionych'),
              );
            }
            return ListView.builder(
                itemCount: state.vehicleData!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text("ROCZNIK : ${state.vehicleData![index].year}"),
                      Text("TYP POJAZDU : ${state.vehicleData![index].type}"),
                      Text("MODEL : ${state.vehicleData![index].model}"),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                settings: const RouteSettings(name: '/form'),
                                builder: (context) => PartsSelection(
                                  selectedBrand:
                                      state.vehicleData![index].brand,
                                  selectecdYear: state.vehicleData![index].year,
                                  selectecdModel:
                                      state.vehicleData![index].model,
                                  selectecdCategory:
                                      state.vehicleData![index].type,
                                  colorBrand: Colors.black,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 50,
                          ))
                    ],
                  );
                });
          },
        ));
  }
}
