import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/enum/page_type.dart';
import 'package:google_ml_kit/utils/extensions.dart';
import 'package:google_ml_kit/utils/google_ml_operations.dart';
import 'package:google_ml_kit/widgets/show_barcode_details.dart';
import 'package:google_ml_kit/widgets/show_image_labeling_widget.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class DetectionPage extends StatefulWidget {
  final PageType pageType;

  const DetectionPage({required this.pageType, super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final _googleMlOperations = GoogleMlOperations();

  List<Barcode> barcode = [];

  String content = '';
  String? imagePath;

  List<ImageLabel> imageLabels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_getPageTitle()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.height(),
            _getImageView(),
            10.height(),
            Center(
                child: FilledButton(
              onPressed: _onPressedInsertImage,
              child: Text(
                imagePath == null ? 'Add Image' : 'Add new image',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            )),
            10.height(),
            _buildFetchDetailsView(),
          ],
        ),
      ),
    );
  }

  Widget _buildFetchDetailsView() {
    switch (widget.pageType) {
      case PageType.barcodeReader:
        return ShowBarcodeDetailsWidget(barcode);
      case PageType.textDetection:
        return Text(
          content,
          style: const TextStyle(fontSize: 16),
        ).wrapPadding(const EdgeInsets.symmetric(horizontal: 15));
      case PageType.imageLabeling:
        return ShowImageLabelingWidget(
          imageLabels: imageLabels,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _getImageView() {
    return imagePath == null
        ? const SizedBox()
        : Image.file(File(imagePath ?? ''));
  }

  Future<void> _onPressedInsertImage() async {
    String? filePath = await _googleMlOperations.showImagePickerDialog(context);
    if (filePath == null) return;
    imagePath = filePath;
    switch (widget.pageType) {
      case PageType.barcodeReader:
        barcode = await _googleMlOperations.fetchBarcodeDetails(filePath);
        setState(() {});
        break;
      case PageType.textDetection:
        content = (await _googleMlOperations.fetchTextFromImage(filePath)) ?? '';
        setState(() {});
        break;
      case PageType.imageLabeling:
        imageLabels = await _googleMlOperations.fetchImageLabeling(filePath);
        setState(() {});
        break;
      default:
        debugPrint('Not found');
    }
  }

  String _getPageTitle() {
    switch (widget.pageType) {
      case PageType.barcodeReader:
        return 'Barcode Reader';
      case PageType.textDetection:
        return 'Text Detection';
      case PageType.imageLabeling:
        return 'Image labeling';
      default:
        return 'Barcode Reader';
    }
  }
}
