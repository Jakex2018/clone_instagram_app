import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.imageContent,
    required this.radius,
    this.height,
    this.width,
  });
  final String? imageContent;
  final double? radius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 30,
      width: width ?? 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: buildImage(imageContent, context),
    );
  }

  Widget buildImage(String? imageUrl, BuildContext context) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.error, color: Colors.red); // Si no hay imagen
    }

    // Verifica si la URL tiene el esquema 'http' o 'https'
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      // Si es una URL válida, utiliza Image.network con `loadingBuilder` y `errorBuilder`
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.5,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Cuando la imagen se ha cargado completamente
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ); // Mostrar el progreso de carga
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error,
                color: Colors.red); // Si la carga de la imagen falla
          },
        ),
      );
    } else {
      // Si la URL no es válida, intentamos cargarla desde el sistema de archivos
      return FutureBuilder<File>(
        future: _getFile(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Mientras cargamos el archivo
          }
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Uint8List>(
              future: snapshot.data?.readAsBytes(),
              builder: (context, byteSnapshot) {
                if (byteSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Mientras leemos los bytes
                }
                if (byteSnapshot.hasData && byteSnapshot.data != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(radius ?? 0),
                    child: Image.memory(
                      byteSnapshot.data!,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  );
                } else {
                  return const Icon(Icons.error,
                      color: Colors.red); // Si no puede leer los bytes
                }
              },
            );
          } else {
            return const Icon(Icons.error,
                color: Colors.red); // Si no encuentra el archivo
          }
        },
      );
    }
  }

  Future<File> _getFile(String? filePath) async {
    if (filePath == null || filePath.isEmpty) {
      throw Exception("Invalid file path");
    }
    final file = File(filePath.replaceFirst(
        'file://', '')); // Quitar 'file://' si es necesario
    return file;
  }
}

final String imageUser =
    'https://media.istockphoto.com/id/536988396/photo/confident-man-in-blue-sweater-portrait.jpg?s=612x612&w=0&k=20&c=Ww3dK11KMRuru6mqddVQ29u0XZxvq_dFghN2Ta6OCN4=';
