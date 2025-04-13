import 'package:flutter/material.dart';
import 'package:testapp/rooms/presentation/components/room_list.dart';

class KeepAliveRoomsList extends StatefulWidget {
  const KeepAliveRoomsList({super.key});

  @override
  State<KeepAliveRoomsList> createState() => _KeepAliveRoomsListState();
}

class _KeepAliveRoomsListState extends State<KeepAliveRoomsList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // necesario para AutomaticKeepAliveClientMixin
    return const RoomsList();
  }

  @override
  bool get wantKeepAlive => true;
}
