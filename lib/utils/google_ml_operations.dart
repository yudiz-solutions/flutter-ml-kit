import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/utils/image_picker_dialog/image_picker_dialog_widget.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class GoogleMlOperations {
  Future<String?> fetchTextFromImage(String? filePath) async {
    if (filePath == null) return '';

    final InputImage inputImage = InputImage.fromFile(File(filePath));

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;

    String lang = '';

    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      lang = languages.firstOrNull ?? lang;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }

    textRecognizer.close();
    return text;
  }

  Future<List<ImageLabel>> fetchImageLabeling(String? filePath) async {
    if (filePath == null) return [];

    final InputImage inputImage = InputImage.fromFile(File(filePath));

    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);

    final imageLabeler = ImageLabeler(options: options);

    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      debugPrint('${label.index} ${label.label} ${label.confidence}');
    }

    imageLabeler.close();

    return labels;
  }

  Future<List<Barcode>> fetchBarcodeDetails(String? filePath) async {
    if (filePath == null) return [];

    final InputImage inputImage = InputImage.fromFile(File(filePath));
    final List<BarcodeFormat> formats = [BarcodeFormat.all];
    final barcodeScanner = BarcodeScanner(formats: formats);

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    return barcodes;
  }

  Future<String?> showImagePickerDialog(BuildContext context) async {
    final String? path = await showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return ImagePickerDialogWidget(
          callback: (ImagePickerOptions options) async {
            ImageSource? source;
            if (options == ImagePickerOptions.gallery) {
              source = ImageSource.gallery;
            } else if (options == ImagePickerOptions.camera) {
              source = ImageSource.camera;
            }

            if (source != null) {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: source);

              Navigator.pop(context, image?.path);
            }
          },
        );
      },
    );
    return path;
  }
}
