import 'package:front_end_instagram/modules/reels/widget/video_app.dart';
import 'package:intl/intl.dart';
import 'package:front_end_instagram/modules/reels/widget/video_app_content.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class UtilsClass {
  String timeAgo(DateTime createdAt) {
    final difference = DateTime.now().difference(createdAt);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} segundos';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutos';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} horas';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} días';
    } else {
      // Si tiene más de un mes, mostramos la fecha en formato "dd MMM yyyy"
      return DateFormat('d MMM yyyy').format(createdAt);
    }
  }

  Widget buildImage(String? mediaUrl, context, bool isTrue, bool video) {
    if (mediaUrl == null || mediaUrl.isEmpty) {
      return const Icon(Icons.error);
    }

    if (mediaUrl.endsWith('.mp4')) {
      return video
          ? VideoApp(url: mediaUrl)
          : VideoAppContent(
              file: File(mediaUrl),
              autoPlay: isTrue ? true : false,
            );
    }

    // Verifica si la URL tiene el esquema 'http' o 'https'
    if (mediaUrl.startsWith('http://') || mediaUrl.startsWith('https://')) {
      // Si es una URL válida, utiliza Image.network
      return Image.network(
        mediaUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
      );
    } else {
      return FutureBuilder<File>(
        future: _getFile(mediaUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Uint8List>(
              future:
                  snapshot.data?.readAsBytes(), // Leer el archivo como bytes
              builder: (context, byteSnapshot) {
                if (byteSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (byteSnapshot.hasData && byteSnapshot.data != null) {
                  return Image.memory(
                    byteSnapshot.data!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                  );
                } else {
                  return const Icon(Icons.error);
                }
              },
            );
          } else {
            return const Icon(Icons.error);
          }
        },
      );
    }
  }

  Future<File> _getFile(String? filePath) async {
    if (filePath == null || filePath.isEmpty) {
      throw Exception("Invalid file path");
    }
    final file = File(filePath.replaceFirst('file://', ''));
    return file;
  }
}
