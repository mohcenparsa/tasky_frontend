import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThumbnailImage extends StatelessWidget {
  final String imageUrl;
  final double thumbnailSize; // Optional: Specify desired thumbnail size

  const ThumbnailImage({
    super.key,
    required this.imageUrl,
    this.thumbnailSize = 100.0, // Default thumbnail size
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          // FadeInImage for smooth loading (optional)
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: thumbnailSize, // Set desired thumbnail height
          ),
        ],
      ),
    );
  }
}
