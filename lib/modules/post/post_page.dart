import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/modules/application/application_page.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/providers/video_provider.dart';
import 'package:front_end_instagram/shared/button_one.dart';
import 'package:front_end_instagram/utils/utils_class.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PostPage extends StatefulWidget {
  final List<AssetEntity>? selectAssetList;

  const PostPage({super.key, this.selectAssetList});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final assets = widget.selectAssetList;
    return Scaffold(
      appBar: _buildAppBar(context,assets),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(child: _buildBody(assets)),
    );
  }

  Widget _buildBody(assets) {
    

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (assets == null || assets.isEmpty)
          const Text('No assets selected',
              style: TextStyle(color: Colors.white)),
        if (assets != null && assets.isNotEmpty) _buildPostImage(assets.first),
        SizedBox(
          height: 20,
        ), // Solo usamos el primer archivo
        _buildCommentInput(),
        SizedBox(height: 50),
        _buildPostButton(assets),
      ],
    );
  }

  Widget _buildPostImage(AssetEntity asset) {
    return FutureBuilder<File?>(
      future: asset.file,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Icon(Icons.error);
        }
        final file = snapshot.data!;
        return asset.type == AssetType.image
            ? Image.file(file,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * .5)
            : VideoAppContent(
                file: file,
                autoPlay: true,
                heightVideoY: MediaQuery.of(context).size.height);
      },
    );
  }

  Widget _buildCommentInput() {
    return TextField(
      controller: _commentController,
      maxLines: 5,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Escribe un comentario...',
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPostButton(List<AssetEntity>? assets) {
    return ButtonOne(
      radius: 10,
      widget: const Center(
          child: Text('Add Post', style: TextStyle(color: Colors.white))),
      width: MediaQuery.of(context).size.width * .7,
      height: 40,
      color: const Color(0xff1877F2),
      onTap: () async {
        await _addPost(assets);
      },
    );
  }

  Future<void> _addPost(List<AssetEntity>? assets) async {
    final userId =
        Provider.of<AuthProvider>(context, listen: false).currentUserId?.id;
    final uid = Uuid().v4();
    final postProvider = Provider.of<PostProvider>(context, listen: false);

    // Solo gestionamos el primer activo (imagen o video)
    final AssetEntity? asset = assets?.first;
    final file = await asset?.file;
    final imageUrl = file?.path ?? ''; // Solo una imagen o video

    // Comentario del usuario
    final List<String> comments = [];
    final userComment = _commentController.text.trim();
    if (userComment.isNotEmpty) {
      comments.add(userComment);
    }

    DateTime createdAt = DateTime.now();
    UtilsClass utils = UtilsClass();
    String formattedTime = utils.timeAgo(createdAt);

    // Aquí se almacena el post con una sola imagen/video
    postProvider.addPost(Postmodel(
      imageUrl: imageUrl, // Ahora solo tiene una URL
      id: uid,
      userId: userId!,
      createdAt: createdAt,
      timeAgo: formattedTime,
      likes: [],
      comments: [], // La lista de comentarios
    ));

    context.read<VideoProvider>().pause();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ApplicationPage()),
    );
  }

  AppBar _buildAppBar(BuildContext context,List<AssetEntity>? assets) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon:
            const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
      ),
      actions: [
        GestureDetector(
          onTap: ()async {
            context.read<VideoProvider>().pause();
            await _addPost(assets);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ApplicationPage()));
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text('Post',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17)),
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.black,
      title: const Text('Post', style: TextStyle(color: Colors.white)),
    );
  }
}
