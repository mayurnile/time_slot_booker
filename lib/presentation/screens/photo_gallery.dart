import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../widgets/widgets.dart';

class PhotoGalleryScreen extends StatefulWidget {
  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  List<AssetEntity> assets = [];

  late Size screenSize;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _fetchAssets();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Photos',
          style: textTheme.headline1,
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: assets.length,
        itemBuilder: (_, index) {
          return PhotoThumbnail(asset: assets[index]);
        },
      ),
    );
  }

  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 50,
    );

    setState(() => assets = recentAssets);
  }
}
