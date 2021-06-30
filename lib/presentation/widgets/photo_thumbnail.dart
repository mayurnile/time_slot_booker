import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../core/core.dart';
import '../../di/locator.dart';

class PhotoThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const PhotoThumbnail({
    Key? key,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;

        if (bytes == null)
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: CircularProgressIndicator(),
          );
        return InkWell(
          onTap: () {
            if (asset.type == AssetType.image) {
              locator.get<NavigationService>().navigateToNamed(
                IMAGE_DISPLAY_ROUTE,
                arguments: {'image_file': asset.file},
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.memory(bytes, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
