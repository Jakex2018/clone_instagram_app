// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/reels_model.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/application/services/media_services.dart';
import 'package:front_end_instagram/modules/post/post_page.dart';
import 'package:front_end_instagram/modules/reels/widget/reel_widget.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/reels_provider.dart';
import 'package:front_end_instagram/providers/select_option_provider.dart';
import 'package:front_end_instagram/shared/camera_widget.dart';
import 'package:front_end_instagram/shared/public_widget.dart';
import 'package:front_end_instagram/shared/select_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CustomGallery extends StatefulWidget {
  const CustomGallery(
      {super.key, required this.maxCount, required this.requestType});
  final int maxCount;
  final RequestType requestType;

  @override
  State<CustomGallery> createState() => _CustomGalleryState();
}

class _CustomGalleryState extends State<CustomGallery> {
  AssetPathEntity? _selectedAlbum;
  List<AssetPathEntity> _albumList = [];
  List<AssetEntity> _assetList = [];
  final List<AssetEntity> selectAssetList = [];

  @override
  void initState() {
    super.initState();

    MediaServices().loadAlbums(widget.requestType).then(
      (value) {
        setState(() {
          _albumList = value;
          _selectedAlbum = value[0];
        });
        MediaServices().loadAssets(_selectedAlbum!).then(
          (value) {
            setState(() {
              _assetList = value;
            });
          },
        );
      },
    );
  }

  Widget _getSelectedWidget(BuildContext context, String selectOption) {
    final selectedOption =
        Provider.of<SelectOptionProvider>(context, listen: false)
            .selectedOption;
    switch (selectedOption) {
      case 'HISTORIA':
        return CameraWidget();
      case 'REEL':
        return ReelWidget(
            albumList: _albumList,
            selectedAlbum: _selectedAlbum,
            assetList: _assetList,
            selectAssetList: selectAssetList);
      case 'DIRECTO':
        return LiveStreamWidget();

      default:
        return PublicWidget(
            albumList: _albumList,
            selectedAlbum: _selectedAlbum,
            assetList: _assetList,
            selectAssetList: selectAssetList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption =
        Provider.of<SelectOptionProvider>(context, listen: false);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Consumer<SelectOptionProvider>(
        builder: (context, selectedProvider, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: customGalleryAppBar(context, selectedOption.selectedOption),
            body: _assetList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Stack(children: [
                    _getSelectedWidget(
                        context, selectedProvider.selectedOption),
                    Positioned(
                      bottom: 0,
                      child: customGalleryBottomNav(context),
                    )
                  ]),
          );
        },
      ),
    );
  }

  Widget customGalleryBottomNav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final textLink = link[index];
            return GestureDetector(
              onTap: () {
                Provider.of<SelectOptionProvider>(context, listen: false)
                    .setSelectedOption(textLink);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    textLink,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 0),
          itemCount: link.length,
        ),
      ),
    );
  }

  AppBar customGalleryAppBar(BuildContext context, String selectOption) {
    String appBarTitle = 'Nueva Publicación';
    final selectedOption =
        Provider.of<SelectOptionProvider>(context, listen: false)
            .selectedOption;

    if (selectedOption == 'HISTORIA') {
      appBarTitle = 'Nueva Historia';
    } else if (selectedOption == 'REEL') {
      appBarTitle = 'Nuevo Reel';
    } else if (selectedOption == 'DIRECTO') {
      appBarTitle = 'Nuevo Directo';
    }
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApplicationPage(),
              ));
        },
        icon: Icon(
          Icons.highlight_remove_rounded,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      title: Text(
        appBarTitle,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final selectedProvider =
                Provider.of<SelectOptionProvider>(context, listen: false);
            final reelsProvider =
                Provider.of<ReelsProvider>(context, listen: false);

            final userId = Provider.of<AuthProvider>(context, listen: false)
                .currentUserId
                ?.id;

            if (selectedProvider.selectedOption == 'PUBLICAR') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostPage(
                            selectAssetList: selectAssetList,
                          )));
            } else if (selectedProvider.selectedOption == 'REEL') {
              if (selectAssetList.isEmpty) return;
              final asset = selectAssetList.first;
              final file = await asset.file;
              final videoPath = file?.path ?? '';
              if (videoPath.isEmpty) return;

              final isVideo = asset.type == AssetType.video;
              final isImage = asset.type == AssetType.image;

              final duration = isVideo ? await _getVideoDuration(videoPath) : 0;
              if (isVideo) {
                reelsProvider.addReel(Reelsmodel(
                    videoPath: videoPath, duration: duration, userId: userId));
              } else if (isImage) {
                reelsProvider.addReel(Reelsmodel(
                    videoPath: videoPath, duration: 0, userId: userId));
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationPage(),
                  ));
            }
          },
          child: Text(
            'Next',
            style: TextStyle(
              color: Color(0xff1877F2),
            ),
          ),
        ),
      ],
    );
  }
}

Future<int> _getVideoDuration(String videoPath) async {
  final controller = VideoPlayerController.file(File(videoPath));
  await controller.initialize();
  final duration = controller.value.duration.inSeconds;
  controller.dispose();
  return duration;
}

