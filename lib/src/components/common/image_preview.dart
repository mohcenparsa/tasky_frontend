import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ImagePreviewWidget extends StatelessWidget {
  final List<XFile>? mediaFileList;
  final dynamic pickImageError;
  final String? retrieveDataError;

  const ImagePreviewWidget({
    super.key,
    required this.mediaFileList,
    this.pickImageError,
    this.retrieveDataError,
  });

  Text? _getRetrieveErrorWidget() {
    if (retrieveDataError != null) {
      final Text result = Text(retrieveDataError!);
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (mediaFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            final String? mime = lookupMimeType(mediaFileList![index].path);

            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(mediaFileList![index].path)
                  : (mime == null || mime.startsWith('image/')
                      ? Image.file(
                          File(mediaFileList![index].path),
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Center(
                                child:
                                    Text('This image type is not supported'));
                          },
                        )
                      : const Center(
                          child: Text('This media type is not supported'))),
            );
          },
          itemCount: mediaFileList!.length,
        ),
      );
    } else if (pickImageError != null) {
      return Text(
        'Pick image error: $pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }
}
