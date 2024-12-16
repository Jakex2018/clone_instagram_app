import 'package:front_end_instagram/shared/camera_widget.dart';
import 'package:front_end_instagram/shared/dropdown.dart';
import 'package:front_end_instagram/modules/post/widget/grid_post.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PublicWidget extends StatelessWidget {
  const PublicWidget({
    super.key,
    required List<AssetPathEntity> albumList,
    required AssetPathEntity? selectedAlbum,
    required List<AssetEntity> assetList,
    required this.selectAssetList,
    this.reel,
  })  : _albumList = albumList,
        _selectedAlbum = selectedAlbum,
        _assetList = assetList;

  final List<AssetPathEntity> _albumList;
  final AssetPathEntity? _selectedAlbum;
  final List<AssetEntity> _assetList;
  final List<AssetEntity> selectAssetList;
  final bool? reel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: reel != null && reel == true
              ? Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraWidget(),
                              ));
                        },
                        icon: Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.white,
                        )),
                    SizedBox(width: 10),
                    Dropdown(
                      albumList: _albumList,
                      selectedAlbum: _selectedAlbum,
                      assetList: _assetList,
                    ),
                  ],
                )
              : Dropdown(
                  albumList: _albumList,
                  selectedAlbum: _selectedAlbum,
                  assetList: _assetList,
                ),
        ),
        GridPost(
          assetList: _assetList,
          selectAssetList: selectAssetList,
        ),
      ],
    );
  }
}

List<String> link = ['PUBLICAR', 'HISTORIA', 'REEL', 'DIRECTO'];
