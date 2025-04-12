import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  final String videoUrl;
  final String username;
  final String userAvatarUrl;
  final String soundName;
  final String description;

  const RoomItem({
    Key? key,
    required this.videoUrl,
    required this.username,
    required this.userAvatarUrl,
    required this.soundName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🎥 Placeholder del video
        Container(
          color: Colors.black,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              'Video: $videoUrl',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),

        // 🧭 Botones flotantes estilo TikTok
        Positioned(
          right: 12,
          bottom: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionIcon(
                icon: Icons.favorite,
                label: '123K',
                onTap: () {
                  // TODO: Handle like
                },
              ),
              const SizedBox(height: 20),
              _ActionIcon(
                icon: Icons.chat_bubble_outline,
                label: '2K',
                onTap: () {
                  // TODO: Show comments modal
                },
              ),
              const SizedBox(height: 20),
              _ActionIcon(
                icon: Icons.share,
                label: 'Share',
                onTap: () {
                  // TODO: Share functionality
                },
              ),
              const SizedBox(height: 20),
              _ActionIcon(
                icon: Icons.bookmark_border,
                label: 'Save',
                onTap: () {
                  // TODO: Save to favorites
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // TODO: Go to profile
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userAvatarUrl),
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
                '@$username',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      soundName,
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
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
