import 'package:flutter/material.dart';
import '../components/room_item.dart';

class RoomsList extends StatefulWidget {
  const RoomsList({Key? key}) : super(key: key);

  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  final PageController _pageController = PageController(initialPage: 0);

  // Modelo simple para representar cada video
  final List<Map<String, String>> videos = [
    {
      'url':
          'https://cdn.coverr.co/videos/coverr-friends-getting-inside-a-car-6839/720p.mp4',
      'username': 'gymbro_dev',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'sound': 'Original sound - GymBro Beat',
      'description': '¡Entrena duro, vive fuerte! 💪🔥'
    },
    {
      'url':
          'https://cdn.coverr.co/videos/coverr-a-transparent-cup-with-a-hot-beverage-5270/1080p.mp4',
      'username': 'fit_maria',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'sound': 'Remix by DJ Flex',
      'description': 'Rutina rápida para abdomen en casa 🏡✨'
    },
    {
      'url':
          'https://cdn.coverr.co/videos/coverr-a-young-man-records-video-in-a-subway-station-8673/720p.mp4',
      'username': 'trainer_diego',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'sound': 'Original sound - DiegoMix',
      'description': 'Consejos de movilidad para principiantes 🤸‍♂️📌'
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return RoomItem(
            videoUrl: video['url']!,
            username: video['username']!,
            userAvatarUrl: video['avatar']!,
            soundName: video['sound']!,
            description: video['description']!,
          );
        },
      ),
    );
  }
}
