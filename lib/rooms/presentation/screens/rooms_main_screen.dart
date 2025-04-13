import 'package:flutter/material.dart';
import 'package:testapp/rooms/presentation/components/keep_alive_rooms_list.dart';

class RoomsMainScreen extends StatefulWidget {
  const RoomsMainScreen({super.key});

  @override
  State<RoomsMainScreen> createState() => _RoomsMainScreenState();
}

class _RoomsMainScreenState extends State<RoomsMainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const KeepAliveRoomsList(),
    const Center(child: Text('Buscar')),
    const Center(child: Text('Subir Video')),
    const Center(child: Text('Inbox')),
    const Center(child: Text('Perfil')),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  BottomNavigationBarItem _buildTab(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
        physics:
            const BouncingScrollPhysics(), // se siente más natural como TikTok
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildTab(Icons.home, 'Inicio'),
          _buildTab(Icons.search, 'Buscar'),
          _buildTab(Icons.add_box, 'Subir'),
          _buildTab(Icons.message, 'Inbox'),
          _buildTab(Icons.person, 'Perfil'),
        ],
      ),
    );
  }
}
