import 'package:flutter/material.dart';
import 'package:google_ml_kit/enum/page_type.dart';
import 'package:google_ml_kit/ui/detection_page.dart';
import 'package:google_ml_kit/utils/extensions.dart';

class GoogleMLOptionsPage extends StatelessWidget {
  final List<String> list = [
    'Barcode reader',
    'Text detection',
    'Image Labeling'
  ];

  GoogleMLOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Google ML Kit'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.height(),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _buildListViewItem(index, context);
              },
            ),
          )
        ],
      ).wrapPadding(const EdgeInsets.symmetric(horizontal: 10)),
    );
  }

  Widget _buildListViewItem(int index, BuildContext context) {
    return Column(
      children: [
        Text(
          list[index],
          style: const TextStyle(fontSize: 20),
        ).addGestureDetection(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetectionPage(pageType: _getPageType(index))),
          );
        }),
        1.divider(),
      ],
    );
  }

  PageType _getPageType(int index) {
    switch (index) {
      case 0:
        return PageType.barcodeReader;
      case 1:
        return PageType.textDetection;
      case 2:
        return PageType.imageLabeling;
    }
    return PageType.barcodeReader;
  }
}
