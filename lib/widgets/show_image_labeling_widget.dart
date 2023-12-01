import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/utils/extensions.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ShowImageLabelingWidget extends StatelessWidget {
  List<ImageLabel> imageLabels;

  ShowImageLabelingWidget({required this.imageLabels, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: imageLabels.length,
      itemBuilder: (context, index) {
        return _buildListViewItem(imageLabels[index]);
      },
    ).wrapPadding(const EdgeInsets.symmetric(horizontal: 10));
  }

  Widget _buildListViewItem(ImageLabel imageLabel) {
    return Row(
      children: [
        const Text(
          'Description : ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(imageLabel.label, style: const TextStyle(fontSize: 16)),
        const Text(' , '),
        const Text(
          'Confidence : ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(imageLabel.confidence.toStringAsFixed(3),
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
