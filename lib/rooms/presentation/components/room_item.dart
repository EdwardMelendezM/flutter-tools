import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  final String videoUrl; // URL del video o identificador del room

  const RoomItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder: en una implementación real aquí integrarías un reproductor de video.
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Video: $videoUrl',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
