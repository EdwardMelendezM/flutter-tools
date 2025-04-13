import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:testapp/rooms/presentation/components/video_display.dart';
import 'package:testapp/rooms/presentation/components/action_icon.dart';

class RoomItem extends StatefulWidget {
  final String videoUrl;
  final String username;
  final String userAvatarUrl;
  final String soundName;
  final String description;
  final bool isAsset;

  const RoomItem({
    super.key,
    required this.videoUrl,
    required this.username,
    required this.userAvatarUrl,
    required this.soundName,
    required this.description,
    required this.isAsset,
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
    _controller = widget.isAsset
        ? VideoPlayerController.asset(widget.videoUrl)
        : VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _controller.initialize().then((_) {
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
            child: VideoDisplay(
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
                ActionIcon(icon: Icons.favorite, label: '123K', onTap: () {}),
                const SizedBox(height: 20),
                ActionIcon(
                    icon: Icons.chat_bubble_outline, label: '2K', onTap: () {}),
                const SizedBox(height: 20),
                ActionIcon(icon: Icons.share, label: 'Share', onTap: () {}),
                const SizedBox(height: 20),
                ActionIcon(
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
