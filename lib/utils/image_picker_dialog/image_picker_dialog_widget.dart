import 'package:flutter/material.dart';
import 'package:google_ml_kit/utils/extensions.dart';

class ImagePickerDialogWidget extends StatelessWidget {
  final Function(ImagePickerOptions options) callback;

  const ImagePickerDialogWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose option',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          10.height(),
          const Text(
            'Camera',
            style: TextStyle(fontSize: 20),
          ).addGestureDetection(() {
            callback(ImagePickerOptions.camera);
          }),
          5.height(),
          const Text(
            'Gallery',
            style: TextStyle(fontSize: 20),
          ).addGestureDetection(() {
            callback(ImagePickerOptions.gallery);
          }),
          30.height(),
        ],
      ),
    );
  }
}

enum ImagePickerOptions { camera, gallery }
