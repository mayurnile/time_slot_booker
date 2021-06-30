import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplayScreen extends StatelessWidget {
  final Future<File?> imageFile;

  const ImageDisplayScreen({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: FutureBuilder<File?>(
        future: imageFile,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final file = snapshot.data;
          if (file == null) return Container();
          return Image.file(file);
        },
      ),
    );
  }
}
