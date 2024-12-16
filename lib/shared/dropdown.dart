import 'package:flutter/material.dart';
import 'package:front_end_instagram/modules/application/services/media_services.dart';
import 'package:photo_manager/photo_manager.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  Dropdown(
      {super.key,
      required this.albumList,
      required this.selectedAlbum,
      required this.assetList});
  List<AssetPathEntity> albumList = [];
  AssetPathEntity? selectedAlbum;
  List<AssetEntity> assetList = [];
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<AssetPathEntity>(
      items: widget.albumList.map<DropdownMenuItem<AssetPathEntity>>(
        (AssetPathEntity album) {
          return DropdownMenuItem<AssetPathEntity>(
            value: album,
            child: Text(
              album.name,
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          );
        },
      ).toList(),
      onChanged: (AssetPathEntity? value) {
        setState(() {
          widget.selectedAlbum = value;
        });
        MediaServices().loadAssets(widget.selectedAlbum!).then(
          (value) {
            setState(() {
              widget.assetList = value;
            });
          },
        );
      },
      value: widget.selectedAlbum,
    );
  }
}
