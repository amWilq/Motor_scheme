import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart';

class PartsView extends StatefulWidget {
  final Color colorBrand;
  final List parts;
  final String partsImageUrl;

  PartsView(
      {required this.colorBrand,
      required this.parts,
      required this.partsImageUrl});

  @override
  State<PartsView> createState() => _PartsViewState();
}

class _PartsViewState extends State<PartsView> {
  @override
  Widget build(BuildContext context) {
    final parts = widget.parts;
    final partsImageUrl = widget.partsImageUrl;
    final colorBrand = widget.colorBrand;
    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          backgroundColor: colorBrand,
          floating: true,
          title: const Text("WYBÓR SCHEMATU"),
          centerTitle: true,
        ),
      ],
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Center(
                    child: GestureDetector(
                  onTap: () {
                    showImageViewer(context, Image.network(partsImageUrl).image,
                        swipeDismissible: false);
                  },
                  child: Container(
                    height: 150,
                    child: Image.network(
                      partsImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
                for (var i = 0; i < parts.length; i++)
                  ListTile(
                    leading: Text(parts[i]['id'].toString()),
                    title: Text(parts[i]['namePart']),
                    subtitle: Text(parts[i]['partNumber']),
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
