import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    this.radius,
    this.name,
    this.photoImg,
  });

  final double? radius;
  final String? name;
  final String? photoImg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color.fromARGB(255, 157, 25, 69),
                  const Color.fromARGB(255, 212, 36, 23),
                  Colors.yellow,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Container(
              height: 75,
              width: 75,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: buildImage(photoImg, context)),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          name ?? '',
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget buildImage(
    String? imageUrl,
    BuildContext context,
  ) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.error);
    }

    // Verifica si la URL tiene el esquema 'http' o 'https'
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      // Si es una URL válida, utiliza Image.network con un placeholder y un error
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;  // Cuando la imagen se ha cargado completamente
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            ); // Mostrar el progreso de carga
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red); // Mostrar un ícono si falla la carga
        },
      );
    } else {
      // Si no es una URL de red, intentamos cargar la imagen desde el almacenamiento local
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
                  return Image.memory(
                    byteSnapshot.data!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.5,
                  );
                } else {
                  return const Icon(Icons.error, color: Colors.red); // Si no puede leer los bytes
                }
              },
            );
          } else {
            return const Icon(Icons.error, color: Colors.red); // Si no encuentra el archivo
          }
        },
      );
    }
  }

  Future<File> _getFile(String? filePath) async {
    if (filePath == null || filePath.isEmpty) {
      throw Exception("Invalid file path");
    }
    final file = File(filePath.replaceFirst('file://', '')); // Quitar 'file://' si es necesario
    return file;
  }
}
