import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end_instagram/models/history_model.dart';
import 'package:front_end_instagram/models/user_model.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'package:front_end_instagram/providers/history_provider.dart';
import 'package:front_end_instagram/providers/user_provider.dart';
import 'package:front_end_instagram/shared/story_bar.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  final List<Storymodel> stories;

  const HistoryScreen({
    super.key,
    required this.stories,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _onStoryComplete() {
    final historyProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    if (historyProvider.currentStoryIndex < widget.stories.length - 1) {
      historyProvider.currentStoryIndex++;
    } else {
      historyProvider.currentStoryIndex = 0;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // No es seguro manipular el estado aquí. Evita modificar el state en dispose()
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context, listen: true);
    final currentStoryIndex = historyProvider.currentStoryIndex;

    // Verifica si el índice actual está dentro de los límites y actualízalo si es necesario
    if (currentStoryIndex >= widget.stories.length) {
      historyProvider.currentStoryIndex = widget.stories.length - 1;
    }

    final story = widget.stories[currentStoryIndex];
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUserById(story.userId);

    return Scaffold(
      backgroundColor: Colors.black,
      body: historyBody(context, story, user, currentStoryIndex),
      bottomNavigationBar: builtBottomNav(context),
    );
  }

  SingleChildScrollView historyBody(BuildContext context, Storymodel? story,
      UserModel? user, currentStoryIndex) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Aquí se maneja la visualización del video de la historia actual
            VideoAppContent(
                key: ValueKey(currentStoryIndex),
                file: File(story!.videoPath),
                autoPlay: true),

            Positioned(
              top: 10,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 23,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.stories.length,
                          itemBuilder: (context, index) {
                            final story = widget.stories[index];
                            return StoryBar(
                              user: user,
                              story: story,
                              isFirstStoryCompleted: index == currentStoryIndex,
                              onStoryComplete: _onStoryComplete,
                            );
                          },
                        ),
                      ),
                      if (user != null) ...[
                        // Mostrar los datos del usuario aquí
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUser),
                                radius: 20,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.username,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.description,
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builtBottomNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width * .7,
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Enviar Mensaje',
                hintText: 'Enviar Mensaje'),
            style: TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: Colors.white,
            )),
      ],
    );
  }
}





/*
class HistoryScreen extends StatefulWidget {
  final List<Storymodel> stories;

  const HistoryScreen({
    super.key,
    required this.stories,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
void _onStoryComplete() {
  final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
  if (historyProvider.currentStoryIndex < widget.stories.length - 1) {
    historyProvider.currentStoryIndex++;
  } else {
    Navigator.pop(context);
  }
}
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context,listen:false);
    final currentStoryIndex = historyProvider.currentStoryIndex;
    final story = widget.stories[currentStoryIndex];

    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUserById(story.userId);

    return Scaffold(
      backgroundColor: Colors.black,
      body: historyBody(context, story, user,currentStoryIndex),
      bottomNavigationBar: builtBottomNav(context),
    );
  }

  SingleChildScrollView historyBody(
      BuildContext context, Storymodel? story, UserModel? user,currentStoryIndex) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Aquí se maneja la visualización del video de la historia actual
            VideoAppContent(file: File(story!.videoPath), autoPlay: true),

            Positioned(
              top: 10,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 23,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.stories.length,
                          itemBuilder: (context, index) {
                            final story = widget.stories[index];
                            return StoryBar(
                              user: user,
                              story: story,
                              isFirstStoryCompleted: index == currentStoryIndex,
                              onStoryComplete: _onStoryComplete,
                            );
                          },
                        ),
                      ),
                      if (user != null) ...[
                        // Mostrar los datos del usuario aquí
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUser),
                                radius: 20,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.username,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.description,
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builtBottomNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width * .7,
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Enviar Mensaje',
                hintText: 'Enviar Mensaje'),
            style: TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: Colors.white,
            )),
      ],
    );
  }
}





 */