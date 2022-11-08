import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class PinchZoomImage extends StatefulWidget {
  const PinchZoomImage({super.key});

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage> {
  @override
  Widget build(BuildContext context) => Center(
          child: GestureDetector(
        onTap: () {
          showImageViewer(
              context,
              Image.network(
                      "https://ktmsklep.pl/image/scheme/24e45b8935f0c0889c39f14a7308d60395322f43313635343830323130.png")
                  .image,
              swipeDismissible: false);
        },
        child: Container(
          height: 150,
          child: Image.network(
            'https://ktmsklep.pl/image/scheme/24e45b8935f0c0889c39f14a7308d60395322f43313635343830323130.png',
            fit: BoxFit.cover,
          ),
        ),
      ));
}
