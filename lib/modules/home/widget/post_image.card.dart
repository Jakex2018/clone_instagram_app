import 'package:flutter/material.dart';
import 'package:front_end_instagram/models/comment_model.dart';
import 'package:front_end_instagram/models/post_model.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/profile/profile_page.dart';
import 'package:front_end_instagram/providers/auth_provider.dart';
import 'package:front_end_instagram/providers/post_provider.dart';
import 'package:front_end_instagram/providers/profile_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/shared/button_image.dart';
import 'package:front_end_instagram/shared/image_container.dart';
import 'package:front_end_instagram/utils/utils_class.dart';
import 'package:provider/provider.dart';

class PostImageCard extends StatefulWidget {
  const PostImageCard({super.key, this.post});
  final Postmodel? post;

  @override
  State<PostImageCard> createState() => _PostImageCardState();
}

class _PostImageCardState extends State<PostImageCard> {
  bool _isCommentExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Consumer<PostProvider>(builder: (context, postProvider, child) {
        final user = Provider.of<UserProvider>(context, listen: false)
            .getUserById(widget.post!.userId);
        List<Comment> comments = widget.post?.comments ?? [];
        // Tomamos el primer comentario si existe, de lo contrario, mostramos un string vacío
        String comment = comments.isNotEmpty ? comments.first.text : '';
        final userId =
            Provider.of<AuthProvider>(context, listen: false).currentUserId?.id;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostCardHeader(context, user!),
            UtilsClass().buildImage(widget.post?.imageUrl, context,true,false),
            _buildPostCardFooter(context, userId),
            _buildCommentSection(comment),
            _buildTimeAgoSection(),
            if (comment.length > 50) _buildShowMoreButton(comment),
          ],
        );
      }),
    );
  }

  Widget _buildPostCardHeader(BuildContext context, UserModel user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<ProfileProvider>(context, listen: false)
                  .selectUser(user.id);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
            child: Row(
              children: [
                ImageContainer(radius: 13, imageContent: user.photoUser),
                SizedBox(width: 10),
                Text(
                  user.username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildPostActions(),
        ],
      ),
    );
  }

  Widget _buildPostActions() {
    final userId = Provider.of<AuthProvider>(context).currentUserId?.id;
    final postProvider = Provider.of<PostProvider>(context);

    final myPost = userId == widget.post!.userId;

    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'delete-post') {
          if (myPost) {
            postProvider.deletePostId(widget.post!.id);
          }
        } else if (value == 'report-post') {}
      },
      icon: const Icon(Icons.more_vert_outlined, color: Colors.white, size: 30),
      itemBuilder: (_) => [
        myPost
            ? PopupMenuItem<String>(
                value: 'delete-post',
                child: Text('Delete Post'),
              )
            : PopupMenuItem<String>(
                value: 'report-post',
                child: Text('Report Post'),
              ),
      ],
    );
  }

  Widget _buildPostCardFooter(BuildContext context, String? userId) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostActionsRow(userId),
          Padding(
            padding: const EdgeInsets.only(right: 28, top: 10),
            child: ButtonImage(),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActionsRow(String? userId) {
    final postProvider = Provider.of<PostProvider>(context);
    final postId = widget.post!.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                postProvider.toggleLike(postId, userId!);
              },
              icon: Icon(
                widget.post?.likes?.contains(userId) ?? false
                    ? Icons.favorite
                    : Icons.favorite_outline_rounded,
                color: widget.post?.likes?.contains(userId) ?? false
                    ? Colors.red
                    : Colors.white,
              ),
            ),
            if (widget.post?.likes?.isNotEmpty ?? false)
              Text(
                widget.post?.likes?.length.toString() ?? '',
                style: TextStyle(color: Colors.white),
              ),
            IconButton(
              onPressed: () {
                _openCommentsBottomSheet(
                    context, postId); // Abre el BottomSheet
              },
              icon: Icon(Icons.comment_rounded, color: Colors.white),
            ),
            IconButton(
              onPressed: () => _showUserListDialog(context, postProvider),
              icon: Icon(Icons.share_rounded, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentSection(String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        '${Provider.of<UserProvider>(context, listen: false).getUserById(widget.post!.userId)?.username}: ${_isCommentExpanded ? comment : comment.length > 50 ? '${comment.substring(0, 50)}...' : comment}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTimeAgoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        widget.post?.timeAgo ?? '',
        style: TextStyle(
            color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildShowMoreButton(String comment) {
    return TextButton(
      onPressed: () {
        setState(() {
          _isCommentExpanded = !_isCommentExpanded;
        });
      },
      child: Text(
        _isCommentExpanded ? 'Ver menos' : 'Ver más',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  void _showUserListDialog(BuildContext context, PostProvider postProvider) {
    showDialog(
      context: context,
      builder: (context) {
        final user = Provider.of<UserProvider>(context, listen: false)
            .getUserById(Provider.of<AuthProvider>(context, listen: false)
                .currentUserId!
                .id);

        return AlertDialog(
          title: Text('Selecciona un usuario para compartir'),
          content: SizedBox(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: user?.following.length ?? 0,
              itemBuilder: (context, index) {
                String userId = user!.following[index];
                final userFollowing =
                    Provider.of<UserProvider>(context).getUserById(userId);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userFollowing!.photoUser),
                  ),
                  title: Text(userFollowing.username),
                  onTap: () {
                    _sharePostToUser(userFollowing.id, postProvider);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _sharePostToUser(String userId, PostProvider postProvider) {
    postProvider.sharePost(widget.post!.id);
  }

  void _openCommentsBottomSheet(BuildContext context, String postId) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);

    final currentUser =
        Provider.of<AuthProvider>(context, listen: false).currentUserId;
    TextEditingController commentController = TextEditingController();

    // Abre el BottomSheet
    showModalBottomSheet(
      backgroundColor: Colors.grey[800],
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Usamos StatefulBuilder para manejar el estado dentro del BottomSheet
          builder: (context, setState) {
            // Obtener los comentarios del post
            final comments = postProvider.getComments(postId);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título del BottomSheet
                  Text(
                    'Comentarios',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // Lista de comentarios
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            comment.userName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            comment.text,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),

                  // Campo de texto para escribir un comentario
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un comentario...',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          String newCommentText = commentController.text.trim();
                          if (newCommentText.isNotEmpty) {
                            // Crear un nuevo comentario
                            final newComment = Comment(
                              userId: currentUser?.id ?? '',
                              timestamp: DateTime.now(),
                              userName: currentUser?.username ??
                                  'Anónimo', // O el nombre del usuario autenticado
                              text: newCommentText,
                            );

                            // Agregar el comentario al post
                            postProvider.addComment(postId, newComment);

                            // Limpiar el campo de texto
                            commentController.clear();

                            // Cerrar el BottomSheet
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
