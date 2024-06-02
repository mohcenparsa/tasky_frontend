import 'package:flutter/material.dart';

class TaskImage extends StatelessWidget {
  final double radius;
  final String imageUrl;
  const TaskImage({
    super.key,
    required this.radius,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/task_placeholder.jpg',
          image: imageUrl,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/task_placeholder.jpg',
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
            );
          },
        ),
      ),
    );
  }
}
