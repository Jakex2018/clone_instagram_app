import 'package:photo_manager/photo_manager.dart';

class MediaServices {
  Future loadAlbums(RequestType requestType) async {
    var permissions = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];
    if (permissions.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(
        type: requestType,
      );
    } else {
      PhotoManager.openSetting();
    }
    return albumList;
  }

  Future loadAssets(AssetPathEntity selectAlbum) async {
    List<AssetEntity> assetList = await selectAlbum.getAssetListRange(
      start: 0,
      end: 100,
    );
    return assetList;
  }
}
