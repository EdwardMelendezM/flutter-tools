import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RoomItem extends StatefulWidget {
  final String videoUrl;
  final String username;
  final String userAvatarUrl;
  final String soundName;
  final String description;

  const RoomItem({
    super.key,
    required this.videoUrl,
    required this.username,
    required this.userAvatarUrl,
    required this.soundName,
    required this.description,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Fondo general
      child: Stack(
        children: [
          // 🎥 Video con loader propio
          Positioned.fill(
            child: _VideoDisplay(
              controller: _controller,
              isInitialized: _isInitialized,
            ),
          ),

          // 🧭 Botones flotantes estilo TikTok
          Positioned(
            right: 12,
            bottom: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ActionIcon(icon: Icons.favorite, label: '123K', onTap: () {}),
                const SizedBox(height: 20),
                _ActionIcon(
                    icon: Icons.chat_bubble_outline, label: '2K', onTap: () {}),
                const SizedBox(height: 20),
                _ActionIcon(icon: Icons.share, label: 'Share', onTap: () {}),
                const SizedBox(height: 20),
                _ActionIcon(
                    icon: Icons.bookmark_border, label: 'Save', onTap: () {}),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // TODO: Go to profile
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.userAvatarUrl),
                    radius: 24,
                  ),
                ),
              ],
            ),
          ),

          // 👤 Usuario + sonido + descripción
          Positioned(
            left: 12,
            bottom: 24,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.username}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(widget.description,
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.soundName,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎥 Video con loader en overlay
class _VideoDisplay extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isInitialized;

  const _VideoDisplay({
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

/// 🧭 Widget reusable para íconos flotantes
class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
