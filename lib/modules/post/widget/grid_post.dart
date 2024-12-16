import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class GridPost extends StatefulWidget {
  const GridPost({
    super.key,
    required List<AssetEntity> assetList,
    required this.selectAssetList,
  }) : _assetList = assetList;

  final List<AssetEntity> _assetList;
  final List<AssetEntity> selectAssetList;

  @override
  State<GridPost> createState() => _GridPostState();
}

class _GridPostState extends State<GridPost> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget._assetList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          AssetEntity asset = widget._assetList[index];
          return Padding(
            padding: const EdgeInsets.all(2),
            child: assetWidget(asset),
          );
        },
      ),
    );
  }

  Widget assetWidget(AssetEntity asset) {
    bool isSelected = widget.selectAssetList.contains(asset);
    return Stack(
      children: [
        Positioned.fill(
            child: GestureDetector(
          onTap: () {
            selectAsset(asset);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.black12, // Optional: add a background color
              border: isSelected
                  ? Border.all(
                      color: Colors.blue, width: 3) // Blue border when selected
                  : null,
              borderRadius:
                  BorderRadius.circular(8), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.all(
                widget.selectAssetList.contains(asset) == true ? 15 : 0,
              ),
              child: AssetEntityImage(
                asset,
                isOriginal: false,
                thumbnailSize: ThumbnailSize.square(250),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        ))
      ],
    );
  }

  void selectAsset(AssetEntity asset) {
    setState(() {
      if (widget.selectAssetList.contains(asset) == true) {
        widget.selectAssetList.remove(asset);
      } else {
        widget.selectAssetList.add(asset);
      }
    });
  }
}
