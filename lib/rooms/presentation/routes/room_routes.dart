import 'package:flutter/material.dart';
import 'package:testapp/rooms/presentation/screens/rooms_main_screen.dart';

class RoomRoutes {
  static const String rooms = '/rooms';

  static Map<String, WidgetBuilder> get routes {
    return {
      rooms: (context) => const RoomsMainScreen(),
    };
  }
}
