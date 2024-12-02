import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final String? imageUrl;

  const ImagePreviewWidget({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageUrl != null && imageUrl != ''
            ? Image.network(
                imageUrl!,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              )
            : null);
  }
}
