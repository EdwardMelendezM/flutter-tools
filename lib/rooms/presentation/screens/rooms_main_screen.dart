import 'package:flutter/material.dart';
import '../components/room_item.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  // Lista de URLs o identificadores de videos. Puedes modificarla o integrarla con tu backend.
  final List<String> videoUrls = [
    'https://example.com/video1.mp4',
    'https://example.com/video2.mp4',
    'https://example.com/video3.mp4',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Generalmente en este tipo de pantalla se omite el AppBar para un look full screen.
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return RoomItem(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}
