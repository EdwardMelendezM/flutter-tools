import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isInitialized;

  const VideoDisplay({
    super.key,
    required this.controller,
    required this.isInitialized,
  });

  bool _isVertical(Size size) {
    final aspectRatio = size.height / size.width;
    // Detectamos formato 9:16 (como 1920x1080 o similar)
    return aspectRatio > 1.7;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isInitialized)
          LayoutBuilder(
            builder: (context, constraints) {
              final size = controller.value.size;
              final isVertical = _isVertical(size);

              return Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: isVertical ? BoxFit.cover : BoxFit.contain,
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              );
            },
          )
        else
          Container(color: Colors.black),
        if (!isInitialized)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
      ],
    );
  }
}
