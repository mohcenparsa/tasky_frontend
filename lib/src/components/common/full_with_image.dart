import 'package:flutter/material.dart';

class FullWidthImage extends StatelessWidget {
  final String imageUrl;
  const FullWidthImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    print(imageUrl);

    return SizedBox(
      height: 150,
      child: Center(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/task_placeholder.jpg',
          image: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
