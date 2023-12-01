import 'package:flutter/material.dart';
import 'package:google_ml_kit/utils/extensions.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ShowBarcodeDetailsWidget extends StatelessWidget {
  final List<Barcode> barcodes;

  const ShowBarcodeDetailsWidget(this.barcodes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: barcodes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _showBarcodeDetails(barcodes[index]);
      },
    );
  }

  Widget _showBarcodeDetails(barcode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fetched barcode details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        10.height(),
        Text(
          'Type :- ${barcode.type}',
          style: const TextStyle(fontSize: 16),
        ),
        10.height(),
        Text(
          'Display Value :- ${barcode.displayValue}',
          style: const TextStyle(fontSize: 16),
        ),
        10.height(),
        Text(
          'Id :- ${barcode.rawValue}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ).wrapPadding(const EdgeInsets.symmetric(horizontal: 10));
  }
}
