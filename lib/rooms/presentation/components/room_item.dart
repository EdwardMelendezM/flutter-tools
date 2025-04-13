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
  late VideoPlayerController _videoController;
  bool _isInitialized = false;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _videoController = widget.isAsset
        ? VideoPlayerController.asset(widget.videoUrl)
        : VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _videoController.initialize().then((_) {
      setState(() {
        _isInitialized = true;
        _isPlaying = true;
      });
      _videoController.setLooping(true);
      _videoController.play();
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  double _calculateProgress() {
    if (!_videoController.value.isInitialized) return 0.0;
    final duration = _videoController.value.duration.inMilliseconds;
    final position = _videoController.value.position.inMilliseconds;
    return (duration == 0) ? 0.0 : position / duration;
  }

  void _seekVideo(BuildContext context, TapDownDetails details,
      BoxConstraints constraints) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final tapX = details.localPosition.dx;
    final barWidth = constraints.maxWidth;
    final relative = tapX / barWidth;
    final newPosition = _videoController.value.duration * relative;
    _videoController.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // 🎥 Video
            Positioned.fill(
              child: VideoDisplay(
                controller: _videoController,
                isInitialized: _isInitialized,
              ),
            ),

            // 🧭 Acciones flotantes
            Positioned(
              right: 12,
              bottom: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionIcon(icon: Icons.favorite, label: '123K', onTap: () {}),
                  const SizedBox(height: 20),
                  ActionIcon(
                      icon: Icons.chat_bubble_outline,
                      label: '2K',
                      onTap: () {}),
                  const SizedBox(height: 20),
                  ActionIcon(icon: Icons.share, label: 'Share', onTap: () {}),
                  const SizedBox(height: 20),
                  ActionIcon(
                      icon: Icons.bookmark_border, label: 'Save', onTap: () {}),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.userAvatarUrl),
                    radius: 24,
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
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.music_note,
                          color: Colors.white, size: 16),
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

            // 📈 Línea de tiempo interactiva
            if (_isInitialized)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (details) =>
                          _seekVideo(context, details, constraints),
                      child: Container(
                        height: 6,
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Container(
                              height: 4,
                              width: double.infinity,
                              color: Colors.white24,
                            ),
                            ValueListenableBuilder<VideoPlayerValue>(
                              valueListenable: _videoController,
                              builder: (context, value, child) {
                                return FractionallySizedBox(
                                  widthFactor: _calculateProgress(),
                                  child: Container(
                                    height: 4,
                                    color: Colors.redAccent,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
